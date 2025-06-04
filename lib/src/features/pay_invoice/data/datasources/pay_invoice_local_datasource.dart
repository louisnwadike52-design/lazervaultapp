import 'dart:math';
import '../models/tagged_invoice_model.dart';
import '../../domain/entities/tagged_invoice_entity.dart';

abstract class PayInvoiceLocalDataSource {
  Future<List<TaggedInvoiceModel>> getTaggedInvoices(String userId);
  Future<List<TaggedInvoiceModel>> getTaggedInvoicesByStatus(String userId, PaymentStatus status);
  Future<TaggedInvoiceModel?> getTaggedInvoiceById(String invoiceId);
  Future<bool> saveTaggedInvoice(TaggedInvoiceModel invoice);
  Future<bool> updateInvoiceStatus(String invoiceId, PaymentStatus status);
  Future<bool> deleteTaggedInvoice(String invoiceId);
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId);
  Future<Map<String, dynamic>> getUserAccountBalance(String userId);
  Future<List<Map<String, dynamic>>> getUserPaymentMethods(String userId);
}

class PayInvoiceLocalDataSourceImpl implements PayInvoiceLocalDataSource {
  // Mock data storage - in real app, this would be SharedPreferences/Hive/SQLite
  static final List<TaggedInvoiceModel> _mockInvoices = [];
  static final Map<String, List<Map<String, dynamic>>> _mockPaymentHistory = {};
  static final Map<String, Map<String, dynamic>> _mockAccountBalances = {};
  static final Map<String, List<Map<String, dynamic>>> _mockPaymentMethods = {};

  // Initialize with mock data on first access
  static bool _initialized = false;

  PayInvoiceLocalDataSourceImpl() {
    if (!_initialized) {
      _initializeMockData();
      _initialized = true;
    }
  }

  @override
  Future<List<TaggedInvoiceModel>> getTaggedInvoices(String userId) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    return _mockInvoices.where((invoice) => invoice.toUserId == userId).toList();
  }

  @override
  Future<List<TaggedInvoiceModel>> getTaggedInvoicesByStatus(String userId, PaymentStatus status) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _mockInvoices
        .where((invoice) => invoice.toUserId == userId && invoice.paymentStatus == status)
        .toList();
  }

  @override
  Future<TaggedInvoiceModel?> getTaggedInvoiceById(String invoiceId) async {
    await Future.delayed(Duration(milliseconds: 200));
    try {
      return _mockInvoices.firstWhere((invoice) => invoice.id == invoiceId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> saveTaggedInvoice(TaggedInvoiceModel invoice) async {
    await Future.delayed(Duration(milliseconds: 300));
    _mockInvoices.add(invoice);
    return true;
  }

  @override
  Future<bool> updateInvoiceStatus(String invoiceId, PaymentStatus status) async {
    await Future.delayed(Duration(milliseconds: 400));
    
    final index = _mockInvoices.indexWhere((invoice) => invoice.id == invoiceId);
    if (index != -1) {
      final invoice = _mockInvoices[index];
      _mockInvoices[index] = invoice.copyWith(
        paymentStatus: status,
        paidAt: status == PaymentStatus.completed ? DateTime.now() : null,
      );
      return true;
    }
    return false;
  }

  @override
  Future<bool> deleteTaggedInvoice(String invoiceId) async {
    await Future.delayed(Duration(milliseconds: 200));
    _mockInvoices.removeWhere((invoice) => invoice.id == invoiceId);
    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> getPaymentHistory(String invoiceId) async {
    await Future.delayed(Duration(milliseconds: 300));
    return _mockPaymentHistory[invoiceId] ?? [];
  }

  @override
  Future<Map<String, dynamic>> getUserAccountBalance(String userId) async {
    await Future.delayed(Duration(milliseconds: 200));
    return _mockAccountBalances[userId] ?? _getDefaultAccountBalance();
  }

  @override
  Future<List<Map<String, dynamic>>> getUserPaymentMethods(String userId) async {
    await Future.delayed(Duration(milliseconds: 250));
    return _mockPaymentMethods[userId] ?? _getDefaultPaymentMethods();
  }

  // Private methods for mock data initialization
  void _initializeMockData() {
    final currentUserId = 'current_user_123'; // Mock current user ID
    
    // Generate mock tagged invoices
    _mockInvoices.addAll([
      _generateMockInvoice(
        id: 'inv_001',
        toUserId: currentUserId,
        title: 'Website Development Services',
        amount: 2500.00,
        status: PaymentStatus.pending,
        priority: InvoicePriority.high,
        daysUntilDue: 3,
        fromCompany: 'TechCorp Solutions',
        fromUser: 'John Smith',
      ),
      _generateMockInvoice(
        id: 'inv_002',
        toUserId: currentUserId,
        title: 'Monthly Consulting Fee',
        amount: 800.00,
        status: PaymentStatus.pending,
        priority: InvoicePriority.medium,
        daysUntilDue: 7,
        fromCompany: 'Strategic Advisors Inc',
        fromUser: 'Sarah Johnson',
      ),
      _generateMockInvoice(
        id: 'inv_003',
        toUserId: currentUserId,
        title: 'Logo Design Project',
        amount: 450.00,
        status: PaymentStatus.completed,
        priority: InvoicePriority.low,
        daysUntilDue: -5,
        fromCompany: 'Creative Studio',
        fromUser: 'Mike Davis',
        isPaid: true,
      ),
      _generateMockInvoice(
        id: 'inv_004',
        toUserId: currentUserId,
        title: 'Server Hosting - Q1',
        amount: 1200.00,
        status: PaymentStatus.pending,
        priority: InvoicePriority.urgent,
        daysUntilDue: -2,
        fromCompany: 'CloudHost Pro',
        fromUser: 'Emma Wilson',
        isOverdue: true,
      ),
      _generateMockInvoice(
        id: 'inv_005',
        toUserId: currentUserId,
        title: 'Mobile App Development',
        amount: 4800.00,
        status: PaymentStatus.processing,
        priority: InvoicePriority.high,
        daysUntilDue: 14,
        fromCompany: 'AppBuilders Ltd',
        fromUser: 'Alex Chen',
      ),
    ]);

    // Initialize payment history for some invoices
    _mockPaymentHistory['inv_003'] = [
      {
        'id': 'pay_001',
        'amount': 450.00,
        'method': 'Account Balance',
        'reference': 'PAY-1698765432-123',
        'date': DateTime.now().subtract(Duration(days: 5)).toIso8601String(),
        'status': 'completed',
      }
    ];

    // Initialize account balance
    _mockAccountBalances[currentUserId] = {
      'accounts': [
        {
          'id': 'acc_001',
          'name': 'Personal Account',
          'currency': 'GBP',
          'balance': 12450.00,
          'accountNumber': '•••• 7890',
          'type': 'personal',
        },
        {
          'id': 'acc_002', 
          'name': 'Savings Account',
          'currency': 'GBP',
          'balance': 5430.00,
          'accountNumber': '•••• 5678',
          'type': 'savings',
        },
        {
          'id': 'acc_003',
          'name': 'Investment Account',
          'currency': 'GBP',
          'balance': 8750.00,
          'accountNumber': '•••• 9012',
          'type': 'investment',
        },
      ],
      'totalBalance': 26630.00,
    };

    // Initialize payment methods
    _mockPaymentMethods[currentUserId] = [
      {
        'id': 'pm_001',
        'type': 'card',
        'name': 'Visa **** 4242',
        'last4': '4242',
        'brand': 'visa',
        'isDefault': true,
      },
      {
        'id': 'pm_002',
        'type': 'card',
        'name': 'Mastercard **** 5555',
        'last4': '5555',
        'brand': 'mastercard',
        'isDefault': false,
      },
      {
        'id': 'pm_003',
        'type': 'paypal',
        'name': 'PayPal',
        'email': 'user@example.com',
        'isDefault': false,
      },
    ];
  }

  TaggedInvoiceModel _generateMockInvoice({
    required String id,
    required String toUserId,
    required String title,
    required double amount,
    required PaymentStatus status,
    required InvoicePriority priority,
    required int daysUntilDue,
    required String fromCompany,
    required String fromUser,
    bool isOverdue = false,
    bool isPaid = false,
  }) {
    final now = DateTime.now();
    final dueDate = now.add(Duration(days: daysUntilDue));
    final items = [
      InvoiceItemModel(
        id: '${id}_item_1',
        name: title,
        description: 'Professional services as per agreement',
        quantity: 1,
        unitPrice: amount,
        totalPrice: amount,
      ),
    ];

    return TaggedInvoiceModel(
      id: id,
      invoiceNumber: 'INV-${Random().nextInt(99999).toString().padLeft(5, '0')}',
      title: title,
      description: 'Professional services invoice',
      amount: amount,
      currency: 'GBP',
      createdAt: now.subtract(Duration(days: Random().nextInt(30) + 1)),
      dueDate: dueDate,
      paidAt: isPaid ? now.subtract(Duration(days: daysUntilDue.abs())) : null,
      paymentStatus: status,
      priority: priority,
      fromUserId: 'user_${Random().nextInt(1000)}',
      fromUserName: fromUser,
      fromUserEmail: '${fromUser.toLowerCase().replaceAll(' ', '.')}@${fromCompany.toLowerCase().replaceAll(' ', '')}.com',
      fromCompanyName: fromCompany,
      fromCompanyLogo: 'https://ui-avatars.com/api/?name=${fromCompany[0]}&background=random',
      toUserId: toUserId,
      toUserName: 'Current User',
      toUserEmail: 'current.user@example.com',
      items: items,
      totalAmount: amount,
      isOverdue: isOverdue || (daysUntilDue < 0 && status != PaymentStatus.completed),
      daysUntilDue: daysUntilDue,
    );
  }

  Map<String, dynamic> _getDefaultAccountBalance() {
    return {
      'accounts': [
        {
          'id': 'acc_default',
          'name': 'Main Account',
          'currency': 'GBP',
          'balance': 1000.00,
          'accountNumber': '•••• 0000',
          'type': 'personal',
        },
      ],
      'totalBalance': 1000.00,
    };
  }

  List<Map<String, dynamic>> _getDefaultPaymentMethods() {
    return [
      {
        'id': 'pm_default',
        'type': 'card',
        'name': 'Default Card',
        'last4': '0000',
        'brand': 'visa',
        'isDefault': true,
      },
    ];
  }
} 