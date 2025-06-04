import 'dart:convert';
import 'dart:math' as math;
import 'package:hive_flutter/hive_flutter.dart';
import '../models/invoice_model.dart';
import '../models/pagination_model.dart';
import '../../domain/entities/invoice_entity.dart';

abstract class InvoiceLocalDataSource {
  Future<PaginatedInvoiceResult> getAllInvoices({
    int page = 1,
    int limit = 20,
    InvoiceSearchFilter? filter,
  });
  Future<InvoiceModel?> getInvoiceById(String id);
  Future<void> saveInvoice(InvoiceModel invoice);
  Future<void> deleteInvoice(String id);
  Future<void> saveInvoices(List<InvoiceModel> invoices);
  Future<void> clearAllInvoices();
  Future<PaginatedInvoiceResult> searchInvoices({
    required String query,
    int page = 1,
    int limit = 20,
    InvoiceSearchFilter? filter,
  });
  Future<List<InvoiceModel>> getInvoicesByStatus(InvoiceStatus status);
  Future<List<InvoiceModel>> getInvoicesByUserId(String userId);
  Future<List<InvoiceModel>> getOverdueInvoices();
  Future<void> initializeHive();
}

class InvoiceLocalDataSourceImpl implements InvoiceLocalDataSource {
  static const String _invoicesBoxName = 'invoices';
  late Box<InvoiceModel> _invoicesBox;
  bool _isInitialized = false;

  @override
  Future<void> initializeHive() async {
    if (_isInitialized) return;
    
    // Initialize Hive
    await Hive.initFlutter();
    
    // Register Hive adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(InvoiceModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(InvoiceItemModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(AddressDetailsModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(InvoiceStatusAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(InvoiceTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(PaymentMethodAdapter());
    }
    
    // Open the invoices box
    _invoicesBox = await Hive.openBox<InvoiceModel>(_invoicesBoxName);
    _isInitialized = true;

    // Generate mock data if box is empty
    if (_invoicesBox.isEmpty) {
      await generateMockInvoices();
    }
  }

  @override
  Future<PaginatedInvoiceResult> getAllInvoices({
    int page = 1,
    int limit = 20,
    InvoiceSearchFilter? filter,
  }) async {
    await _ensureInitialized();
    
    List<InvoiceModel> allInvoices = _invoicesBox.values.toList();
    
    // Apply filters
    if (filter != null) {
      allInvoices = _applyFilters(allInvoices, filter);
    }
    
    // Apply sorting
    final sortBy = filter?.sortBy ?? 'createdAt';
    final sortOrder = filter?.sortOrder ?? SortOrder.desc;
    allInvoices = _applySorting(allInvoices, sortBy, sortOrder);
    
    // Calculate pagination
    final total = allInvoices.length;
    final startIndex = (page - 1) * limit;
    final endIndex = math.min(startIndex + limit, total);
    
    final paginatedInvoices = startIndex < total 
        ? allInvoices.sublist(startIndex, endIndex)
        : <InvoiceModel>[];
    
    final pagination = PaginationModel.fromData(
      page: page,
      limit: limit,
      total: total,
    );
    
    return PaginatedInvoiceResult(
      invoices: paginatedInvoices,
      pagination: pagination,
      filter: filter,
    );
  }

  @override
  Future<InvoiceModel?> getInvoiceById(String id) async {
    await _ensureInitialized();
    return _invoicesBox.get(id);
  }

  @override
  Future<void> saveInvoice(InvoiceModel invoice) async {
    await _ensureInitialized();
    await _invoicesBox.put(invoice.id, invoice);
  }

  @override
  Future<void> deleteInvoice(String id) async {
    await _ensureInitialized();
    await _invoicesBox.delete(id);
  }

  @override
  Future<void> saveInvoices(List<InvoiceModel> invoices) async {
    await _ensureInitialized();
    final invoiceMap = {for (var invoice in invoices) invoice.id: invoice};
    await _invoicesBox.putAll(invoiceMap);
  }

  @override
  Future<void> clearAllInvoices() async {
    await _ensureInitialized();
    await _invoicesBox.clear();
  }

  @override
  Future<PaginatedInvoiceResult> searchInvoices({
    required String query,
    int page = 1,
    int limit = 20,
    InvoiceSearchFilter? filter,
  }) async {
    await _ensureInitialized();
    
    final searchFilter = (filter ?? const InvoiceSearchFilter()).copyWith(query: query);
    return getAllInvoices(page: page, limit: limit, filter: searchFilter);
  }

  @override
  Future<List<InvoiceModel>> getInvoicesByStatus(InvoiceStatus status) async {
    await _ensureInitialized();
    return _invoicesBox.values.where((invoice) => invoice.status == status).toList();
  }

  @override
  Future<List<InvoiceModel>> getInvoicesByUserId(String userId) async {
    await _ensureInitialized();
    return _invoicesBox.values.where((invoice) => invoice.fromUserId == userId).toList();
  }

  @override
  Future<List<InvoiceModel>> getOverdueInvoices() async {
    await _ensureInitialized();
    final now = DateTime.now();
    return _invoicesBox.values.where((invoice) {
      return invoice.dueDate != null &&
          invoice.dueDate!.isBefore(now) &&
          invoice.status != InvoiceStatus.paid &&
          invoice.status != InvoiceStatus.cancelled;
    }).toList();
  }

  // Private helper methods
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initializeHive();
    }
  }

  List<InvoiceModel> _applyFilters(List<InvoiceModel> invoices, InvoiceSearchFilter filter) {
    return invoices.where((invoice) {
      // Text search
      if (filter.query?.isNotEmpty == true) {
        final query = filter.query!.toLowerCase();
        final matchesText = invoice.title.toLowerCase().contains(query) ||
            invoice.description.toLowerCase().contains(query) ||
            invoice.id.toLowerCase().contains(query) ||
            (invoice.toName?.toLowerCase().contains(query) ?? false) ||
            (invoice.toEmail?.toLowerCase().contains(query) ?? false) ||
            (invoice.notes?.toLowerCase().contains(query) ?? false);
        
        if (!matchesText) return false;
      }
      
      // Status filter
      if (filter.statuses?.isNotEmpty == true) {
        if (!filter.statuses!.contains(invoice.status.name)) return false;
      }
      
      // Type filter
      if (filter.types?.isNotEmpty == true) {
        if (!filter.types!.contains(invoice.type.name)) return false;
      }
      
      // Date range filter
      if (filter.fromDate != null && invoice.createdAt.isBefore(filter.fromDate!)) {
        return false;
      }
      if (filter.toDate != null && invoice.createdAt.isAfter(filter.toDate!)) {
        return false;
      }
      
      // Amount range filter
      if (filter.minAmount != null && invoice.totalAmount < filter.minAmount!) {
        return false;
      }
      if (filter.maxAmount != null && invoice.totalAmount > filter.maxAmount!) {
        return false;
      }
      
      // Currency filter
      if (filter.currency?.isNotEmpty == true && invoice.currency != filter.currency) {
        return false;
      }
      
      // Overdue filter
      if (filter.isOverdue != null) {
        final isOverdue = invoice.dueDate != null &&
            invoice.dueDate!.isBefore(DateTime.now()) &&
            invoice.status != InvoiceStatus.paid &&
            invoice.status != InvoiceStatus.cancelled;
        
        if (filter.isOverdue! != isOverdue) return false;
      }
      
      return true;
    }).toList();
  }

  List<InvoiceModel> _applySorting(List<InvoiceModel> invoices, String sortBy, SortOrder sortOrder) {
    invoices.sort((a, b) {
      int comparison = 0;
      
      switch (sortBy) {
        case 'title':
          comparison = a.title.compareTo(b.title);
          break;
        case 'amount':
          comparison = a.totalAmount.compareTo(b.totalAmount);
          break;
        case 'status':
          comparison = a.status.name.compareTo(b.status.name);
          break;
        case 'dueDate':
          if (a.dueDate == null && b.dueDate == null) {
            comparison = 0;
          } else if (a.dueDate == null) {
            comparison = 1;
          } else if (b.dueDate == null) {
            comparison = -1;
          } else {
            comparison = a.dueDate!.compareTo(b.dueDate!);
          }
          break;
        case 'createdAt':
        default:
          comparison = a.createdAt.compareTo(b.createdAt);
          break;
      }
      
      return sortOrder == SortOrder.asc ? comparison : -comparison;
    });
    
    return invoices;
  }

  // Helper method to generate mock data for development
  Future<void> generateMockInvoices() async {
    final mockInvoices = _generateMockInvoiceData();
    await saveInvoices(mockInvoices);
  }

  List<InvoiceModel> _generateMockInvoiceData() {
    final random = math.Random();
    final now = DateTime.now();
    
    return List.generate(50, (index) {
      final isOverdue = random.nextBool();
      final isPaid = random.nextBool();
      final createdDaysAgo = random.nextInt(365);
      final createdAt = now.subtract(Duration(days: createdDaysAgo));
      final dueDate = createdAt.add(Duration(days: random.nextInt(30) + 1));
      
      InvoiceStatus status;
      if (isPaid) {
        status = InvoiceStatus.paid;
      } else if (isOverdue && now.isAfter(dueDate)) {
        status = InvoiceStatus.expired;
      } else if (index % 5 == 0) {
        status = InvoiceStatus.draft;
      } else if (index % 8 == 0) {
        status = InvoiceStatus.cancelled;
      } else {
        status = InvoiceStatus.pending;
      }

      final items = List.generate(random.nextInt(3) + 1, (itemIndex) {
        final quantity = random.nextDouble() * 10 + 1;
        final unitPrice = random.nextDouble() * 100 + 10;
        return InvoiceItemModel(
          id: 'item_${index}_$itemIndex',
          name: _getRandomItemName(itemIndex),
          description: 'Description for ${_getRandomItemName(itemIndex)}',
          quantity: quantity,
          unitPrice: unitPrice,
          totalPrice: quantity * unitPrice,
          category: _getRandomCategory(),
        );
      });

      final subtotal = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
      final taxRate = random.nextDouble() * 0.2; // 0-20% tax
      final taxAmount = subtotal * taxRate;
      final discountAmount = random.nextBool() ? subtotal * 0.1 : 0.0; // 10% discount sometimes
      final totalAmount = subtotal + taxAmount - discountAmount;

      return InvoiceModel(
        id: 'inv_${DateTime.now().millisecondsSinceEpoch}_$index',
        title: _getRandomInvoiceTitle(index),
        description: _getRandomDescription(index),
        amount: subtotal,
        currency: _getRandomCurrency(),
        status: status,
        type: InvoiceType.values[random.nextInt(InvoiceType.values.length)],
        createdAt: createdAt,
        dueDate: status != InvoiceStatus.draft ? dueDate : null,
        paidAt: status == InvoiceStatus.paid ? dueDate.add(Duration(days: random.nextInt(5))) : null,
        fromUserId: 'current_user_id',
        toUserId: random.nextBool() ? 'user_${random.nextInt(10)}' : null,
        toEmail: _getRandomEmail(index),
        toName: _getRandomClientName(index),
        items: items,
        taxAmount: taxAmount,
        discountAmount: discountAmount > 0 ? discountAmount : null,
        totalAmount: totalAmount,
        notes: random.nextBool() ? _getRandomNotes(index) : null,
        paymentMethod: status == InvoiceStatus.paid 
            ? PaymentMethod.values[random.nextInt(PaymentMethod.values.length)]
            : null,
        paymentReference: status == InvoiceStatus.paid ? 'PAY_${random.nextInt(999999)}' : null,
        qrCodeData: 'invoice://pay?id=inv_${DateTime.now().millisecondsSinceEpoch}_$index&amount=$totalAmount',
      );
    });
  }

  String _getRandomInvoiceTitle(int index) {
    final titles = [
      'Website Development Services',
      'Mobile App Development',
      'UI/UX Design Project',
      'Digital Marketing Campaign',
      'Software Maintenance',
      'Cloud Infrastructure Setup',
      'Database Migration',
      'Security Audit',
      'Training Services',
      'Consulting Services',
    ];
    return '${titles[index % titles.length]} #${index + 1}';
  }

  String _getRandomDescription(int index) {
    final descriptions = [
      'Professional services as agreed in the contract',
      'Monthly subscription services',
      'Project milestone payment',
      'Hourly consultation services',
      'Custom development work',
      'Maintenance and support services',
      'Design and development services',
      'Strategic consulting engagement',
      'Technical implementation services',
      'Business process optimization',
    ];
    return descriptions[index % descriptions.length];
  }

  String _getRandomItemName(int index) {
    final items = [
      'Development Hours',
      'Design Work',
      'Project Management',
      'Testing Services',
      'Deployment',
      'Documentation',
      'Training Session',
      'Consultation',
      'Support Services',
      'Maintenance',
    ];
    return items[index % items.length];
  }

  String _getRandomCategory() {
    final categories = [
      'Development',
      'Design',
      'Consulting',
      'Support',
      'Training',
      'Maintenance',
    ];
    return categories[math.Random().nextInt(categories.length)];
  }

  String _getRandomCurrency() {
    final currencies = ['USD', 'EUR', 'GBP', 'CAD', 'AUD'];
    return currencies[math.Random().nextInt(currencies.length)];
  }

  String _getRandomClientName(int index) {
    final names = [
      'Acme Corp',
      'TechStart Inc',
      'Global Solutions Ltd',
      'Innovation Hub',
      'Digital Dynamics',
      'Future Systems',
      'Creative Agency',
      'Business Solutions',
      'Enterprise Co',
      'Startup Ventures',
    ];
    return names[index % names.length];
  }

  String _getRandomEmail(int index) {
    final domains = ['example.com', 'business.org', 'company.net', 'enterprise.io'];
    final names = ['john', 'sarah', 'mike', 'lisa', 'david', 'emma', 'alex', 'maria'];
    final name = names[index % names.length];
    final domain = domains[index % domains.length];
    return '$name@$domain';
  }

  String _getRandomNotes(int index) {
    final notes = [
      'Payment due within 30 days of invoice date.',
      'Please reference invoice number in payment details.',
      'Thank you for your business!',
      'Contact us for any questions regarding this invoice.',
      'This invoice includes all agreed-upon services.',
      'Late payment fees may apply after due date.',
      'Payment can be made via bank transfer or card.',
      'Please confirm receipt of this invoice.',
    ];
    return notes[index % notes.length];
  }
} 