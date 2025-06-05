import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../models/insurance_hive_model.dart';
import '../models/insurance_payment_hive_model.dart';

abstract class InsuranceLocalDataSource {
  Future<void> initializeHive();
  
  // Insurance operations
  Future<List<Insurance>> getUserInsurances(String userId);
  Future<Insurance?> getInsuranceById(String id);
  Future<Insurance> saveInsurance(Insurance insurance);
  Future<Insurance> updateInsurance(Insurance insurance);
  Future<void> deleteInsurance(String id);
  Future<List<Insurance>> searchInsurances(String query, String userId);
  
  // Payment operations
  Future<List<InsurancePayment>> getInsurancePayments(String insuranceId);
  Future<List<InsurancePayment>> getUserPayments(String userId);
  Future<InsurancePayment?> getPaymentById(String id);
  Future<InsurancePayment> savePayment(InsurancePayment payment);
  Future<InsurancePayment> updatePayment(InsurancePayment payment);
  Future<List<InsurancePayment>> getOverduePayments(String userId);
  
  // Statistics
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId);
  Future<Map<String, dynamic>> getPaymentStatistics(String userId, {DateTime? startDate, DateTime? endDate});
}

class InsuranceLocalDataSourceImpl implements InsuranceLocalDataSource {
  static const String _insuranceBoxName = 'insurance_box';
  static const String _paymentBoxName = 'insurance_payment_box';

  Box<InsuranceHiveModel>? _insuranceBox;
  Box<InsurancePaymentHiveModel>? _paymentBox;
  bool _isInitialized = false;

  @override
  Future<void> initializeHive() async {
    if (_isInitialized) return;

    try {
      // Initialize Hive Flutter if not already initialized
      if (!Hive.isBoxOpen(_insuranceBoxName) || !Hive.isBoxOpen(_paymentBoxName)) {
        await Hive.initFlutter();
      }
      
      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(20)) {
        Hive.registerAdapter(InsuranceHiveModelAdapter());
      }
      
      if (!Hive.isAdapterRegistered(21)) {
        Hive.registerAdapter(InsurancePaymentHiveModelAdapter());
      }

      // Open boxes
      _insuranceBox = await Hive.openBox<InsuranceHiveModel>(_insuranceBoxName);
      _paymentBox = await Hive.openBox<InsurancePaymentHiveModel>(_paymentBoxName);
      
      _isInitialized = true;
      
      // Generate some mock data if boxes are empty
      if (_insuranceBox!.isEmpty) {
        await _generateMockInsuranceData();
      }
    } catch (e) {
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  @override
  Future<List<Insurance>> getUserInsurances(String userId) async {
    await initializeHive();
    final insurances = _insuranceBox!.values
        .where((insurance) => insurance.userId == userId)
        .map((insurance) => insurance.toEntity())
        .toList();
    
    // Sort by created date (newest first)
    insurances.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return insurances;
  }

  @override
  Future<Insurance?> getInsuranceById(String id) async {
    await initializeHive();
    final insuranceModel = _insuranceBox!.get(id);
    return insuranceModel?.toEntity();
  }

  @override
  Future<Insurance> saveInsurance(Insurance insurance) async {
    await initializeHive();
    final model = InsuranceHiveModel.fromEntity(insurance);
    await _insuranceBox!.put(insurance.id, model);
    return insurance;
  }

  @override
  Future<Insurance> updateInsurance(Insurance insurance) async {
    await initializeHive();
    final updatedInsurance = insurance.copyWith(updatedAt: DateTime.now());
    final model = InsuranceHiveModel.fromEntity(updatedInsurance);
    await _insuranceBox!.put(insurance.id, model);
    return updatedInsurance;
  }

  @override
  Future<void> deleteInsurance(String id) async {
    await initializeHive();
    await _insuranceBox!.delete(id);
    
    // Also delete related payments
    final paymentsToDelete = _paymentBox!.values
        .where((payment) => payment.insuranceId == id)
        .map((payment) => payment.key)
        .toList();
    
    for (final key in paymentsToDelete) {
      await _paymentBox!.delete(key);
    }
  }

  @override
  Future<List<Insurance>> searchInsurances(String query, String userId) async {
    await initializeHive();
    final lowercaseQuery = query.toLowerCase();
    
    final insurances = _insuranceBox!.values
        .where((insurance) => 
            insurance.userId == userId &&
            (insurance.policyNumber.toLowerCase().contains(lowercaseQuery) ||
             insurance.provider.toLowerCase().contains(lowercaseQuery) ||
             insurance.policyHolderName.toLowerCase().contains(lowercaseQuery)))
        .map((insurance) => insurance.toEntity())
        .toList();
    
    insurances.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return insurances;
  }

  @override
  Future<List<InsurancePayment>> getInsurancePayments(String insuranceId) async {
    await initializeHive();
    final payments = _paymentBox!.values
        .where((payment) => payment.insuranceId == insuranceId)
        .map((payment) => payment.toEntity())
        .toList();
    
    payments.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
    return payments;
  }

  @override
  Future<List<InsurancePayment>> getUserPayments(String userId) async {
    await initializeHive();
    final payments = _paymentBox!.values
        .where((payment) => payment.userId == userId)
        .map((payment) => payment.toEntity())
        .toList();
    
    payments.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
    return payments;
  }

  @override
  Future<InsurancePayment?> getPaymentById(String id) async {
    await initializeHive();
    final paymentModel = _paymentBox!.get(id);
    return paymentModel?.toEntity();
  }

  @override
  Future<InsurancePayment> savePayment(InsurancePayment payment) async {
    await initializeHive();
    final model = InsurancePaymentHiveModel.fromEntity(payment);
    await _paymentBox!.put(payment.id, model);
    return payment;
  }

  @override
  Future<InsurancePayment> updatePayment(InsurancePayment payment) async {
    await initializeHive();
    final updatedPayment = payment.copyWith(updatedAt: DateTime.now());
    final model = InsurancePaymentHiveModel.fromEntity(updatedPayment);
    await _paymentBox!.put(payment.id, model);
    return updatedPayment;
  }

  @override
  Future<List<InsurancePayment>> getOverduePayments(String userId) async {
    await initializeHive();
    final now = DateTime.now();
    final payments = _paymentBox!.values
        .where((payment) => 
            payment.userId == userId &&
            payment.status != PaymentStatus.completed.name &&
            DateTime.parse(payment.dueDate.toIso8601String()).isBefore(now))
        .map((payment) => payment.toEntity())
        .toList();
    
    payments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return payments;
  }

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics(String userId) async {
    await initializeHive();
    final insurances = await getUserInsurances(userId);
    
    final stats = <String, dynamic>{
      'totalPolicies': insurances.length,
      'activePolicies': insurances.where((i) => i.isActive).length,
      'expiredPolicies': insurances.where((i) => i.isExpired).length,
      'totalCoverageAmount': insurances.fold(0.0, (sum, i) => sum + i.coverageAmount),
      'totalPremiumAmount': insurances.fold(0.0, (sum, i) => sum + i.premiumAmount),
      'policiesByType': <String, int>{},
    };
    
    for (final insurance in insurances) {
      final type = insurance.type.displayName;
      stats['policiesByType'][type] = (stats['policiesByType'][type] ?? 0) + 1;
    }
    
    return stats;
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics(String userId, {DateTime? startDate, DateTime? endDate}) async {
    await initializeHive();
    var payments = await getUserPayments(userId);
    
    if (startDate != null) {
      payments = payments.where((p) => p.paymentDate.isAfter(startDate)).toList();
    }
    if (endDate != null) {
      payments = payments.where((p) => p.paymentDate.isBefore(endDate)).toList();
    }
    
    final stats = <String, dynamic>{
      'totalPayments': payments.length,
      'completedPayments': payments.where((p) => p.isCompleted).length,
      'pendingPayments': payments.where((p) => p.isPending).length,
      'failedPayments': payments.where((p) => p.isFailed).length,
      'totalAmount': payments.fold(0.0, (sum, p) => sum + p.amount),
      'completedAmount': payments.where((p) => p.isCompleted).fold(0.0, (sum, p) => sum + p.amount),
      'paymentsByMethod': <String, int>{},
    };
    
    for (final payment in payments) {
      final method = payment.paymentMethod.displayName;
      stats['paymentsByMethod'][method] = (stats['paymentsByMethod'][method] ?? 0) + 1;
    }
    
    return stats;
  }

  // Generate mock insurance data for demonstration
  Future<void> _generateMockInsuranceData() async {
    final mockInsurances = [
      Insurance(
        id: '1',
        policyNumber: 'POL-2024-001',
        policyHolderName: 'John Doe',
        policyHolderEmail: 'john.doe@example.com',
        policyHolderPhone: '+1234567890',
        type: InsuranceType.health,
        provider: 'Health First Insurance',
        providerLogo: 'https://via.placeholder.com/100x50',
        premiumAmount: 299.99,
        coverageAmount: 50000.00,
        currency: 'USD',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 335)),
        nextPaymentDate: DateTime.now().add(const Duration(days: 25)),
        status: InsuranceStatus.active,
        beneficiaries: ['Jane Doe', 'Mike Doe'],
        coverageDetails: {
          'medical_coverage': 50000,
          'dental_coverage': 5000,
          'vision_coverage': 2000,
        },
        description: 'Comprehensive health insurance with dental and vision coverage',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
        userId: 'guest_user',
      ),
      Insurance(
        id: '2',
        policyNumber: 'POL-2024-002',
        policyHolderName: 'John Doe',
        policyHolderEmail: 'john.doe@example.com',
        policyHolderPhone: '+1234567890',
        type: InsuranceType.auto,
        provider: 'Auto Shield Insurance',
        providerLogo: 'https://via.placeholder.com/100x50',
        premiumAmount: 899.99,
        coverageAmount: 25000.00,
        currency: 'USD',
        startDate: DateTime.now().subtract(const Duration(days: 60)),
        endDate: DateTime.now().add(const Duration(days: 305)),
        nextPaymentDate: DateTime.now().add(const Duration(days: 55)),
        status: InsuranceStatus.active,
        beneficiaries: ['Jane Doe'],
        coverageDetails: {
          'liability_coverage': 25000,
          'collision_coverage': 15000,
          'comprehensive_coverage': 10000,
        },
        description: 'Full coverage auto insurance for vehicle protection',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        updatedAt: DateTime.now(),
        userId: 'guest_user',
      ),
    ];

    for (final insurance in mockInsurances) {
      await saveInsurance(insurance);
    }
  }
} 