import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/invoice_model.dart';
import '../../domain/entities/invoice_entity.dart';

abstract class InvoiceLocalDataSource {
  Future<List<InvoiceModel>> getAllInvoices();
  Future<InvoiceModel?> getInvoiceById(String id);
  Future<void> saveInvoice(InvoiceModel invoice);
  Future<void> deleteInvoice(String id);
  Future<void> saveInvoices(List<InvoiceModel> invoices);
  Future<void> clearAllInvoices();
}

class InvoiceLocalDataSourceImpl implements InvoiceLocalDataSource {
  static const String _invoicesKey = 'cached_invoices';
  final SharedPreferences sharedPreferences;

  InvoiceLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<InvoiceModel>> getAllInvoices() async {
    try {
      final jsonString = sharedPreferences.getString(_invoicesKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => InvoiceModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<InvoiceModel?> getInvoiceById(String id) async {
    final invoices = await getAllInvoices();
    try {
      return invoices.firstWhere((invoice) => invoice.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveInvoice(InvoiceModel invoice) async {
    final invoices = await getAllInvoices();
    final existingIndex = invoices.indexWhere((i) => i.id == invoice.id);
    
    if (existingIndex != -1) {
      invoices[existingIndex] = invoice;
    } else {
      invoices.add(invoice);
    }
    
    await saveInvoices(invoices);
  }

  @override
  Future<void> deleteInvoice(String id) async {
    final invoices = await getAllInvoices();
    invoices.removeWhere((invoice) => invoice.id == id);
    await saveInvoices(invoices);
  }

  @override
  Future<void> saveInvoices(List<InvoiceModel> invoices) async {
    final jsonString = json.encode(invoices.map((invoice) => invoice.toJson()).toList());
    await sharedPreferences.setString(_invoicesKey, jsonString);
  }

  @override
  Future<void> clearAllInvoices() async {
    await sharedPreferences.remove(_invoicesKey);
  }

  // Helper method to generate mock data for development
  Future<void> generateMockInvoices() async {
    final mockInvoices = _generateMockInvoiceData();
    await saveInvoices(mockInvoices);
  }

  List<InvoiceModel> _generateMockInvoiceData() {
    final random = Random();
    final now = DateTime.now();
    
    return List.generate(15, (index) {
      final isOverdue = random.nextBool();
      final isPaid = random.nextBool();
      final createdDaysAgo = random.nextInt(60);
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
      final taxAmount = subtotal * 0.1; // 10% tax
      final totalAmount = subtotal + taxAmount;

      return InvoiceModel(
        id: 'invoice_$index',
        title: 'Invoice #${1000 + index}',
        description: _getRandomInvoiceDescription(),
        amount: subtotal,
        currency: 'USD',
        status: status,
        type: InvoiceType.values[random.nextInt(InvoiceType.values.length)],
        createdAt: createdAt,
        dueDate: status != InvoiceStatus.draft ? dueDate : null,
        paidAt: status == InvoiceStatus.paid ? dueDate.subtract(Duration(days: random.nextInt(5))) : null,
        fromUserId: 'current_user_id',
        toEmail: 'client${index}@example.com',
        toName: _getRandomClientName(index),
        items: items,
        taxAmount: taxAmount,
        totalAmount: totalAmount,
        notes: index % 3 == 0 ? 'Payment due within 30 days' : null,
        paymentMethod: status == InvoiceStatus.paid 
          ? PaymentMethod.values[random.nextInt(PaymentMethod.values.length)]
          : null,
        paymentReference: status == InvoiceStatus.paid ? 'PAY_${random.nextInt(999999)}' : null,
        qrCodeData: 'invoice_payment_${index}',
      );
    });
  }

  String _getRandomItemName(int index) {
    final items = [
      'Website Design',
      'Mobile App Development',
      'Logo Design',
      'Content Writing',
      'SEO Optimization',
      'Social Media Management',
      'Photography Session',
      'Video Editing',
      'Consulting Services',
      'Technical Support',
    ];
    return items[index % items.length];
  }

  String _getRandomCategory() {
    final categories = [
      'Design',
      'Development',
      'Marketing',
      'Consulting',
      'Support',
    ];
    return categories[Random().nextInt(categories.length)];
  }

  String _getRandomInvoiceDescription() {
    final descriptions = [
      'Professional services rendered',
      'Website development project',
      'Marketing campaign execution',
      'Design and branding services',
      'Technical consulting work',
      'Monthly retainer services',
      'One-time project delivery',
      'Ongoing support services',
    ];
    return descriptions[Random().nextInt(descriptions.length)];
  }

  String _getRandomClientName(int index) {
    final names = [
      'John Doe',
      'Jane Smith',
      'Tech Corp Inc.',
      'Creative Agency',
      'Startup Ventures',
      'Marketing Solutions',
      'Digital Innovations',
      'Business Consulting',
      'E-commerce Store',
      'Media Company',
    ];
    return names[index % names.length];
  }
} 