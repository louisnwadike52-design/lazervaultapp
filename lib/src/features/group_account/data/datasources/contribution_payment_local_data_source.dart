import 'package:hive_flutter/hive_flutter.dart';
import '../models/group_account_models.dart';
import '../../domain/entities/group_entities.dart';

abstract class ContributionPaymentLocalDataSource {
  Future<void> savePayment(ContributionPaymentModel payment);
  Future<List<ContributionPaymentModel>> getPaymentsByContribution(String contributionId);
  Future<List<ContributionPaymentModel>> getPaymentsByUser(String userId);
  Future<ContributionPaymentModel?> getPaymentById(String paymentId);
  Future<void> deletePayment(String paymentId);
  Future<void> clearAllPayments();
}

class ContributionPaymentLocalDataSourceImpl implements ContributionPaymentLocalDataSource {
  static const String _boxName = 'contribution_payments';
  static Box<Map<dynamic, dynamic>>? _staticBox;
  static bool _hiveInitialized = false;
  
  Box<Map<dynamic, dynamic>> get _box {
    if (_staticBox == null) {
      throw Exception('ContributionPaymentLocalDataSource not initialized. Call initializeGlobally() first.');
    }
    return _staticBox!;
  }

  static Future<void> initializeGlobally() async {
    try {
      // Initialize Hive if not already done
      if (!_hiveInitialized) {
        print('🔧 Initializing Hive Flutter...');
        await Hive.initFlutter();
        _hiveInitialized = true;
        print('✅ Hive Flutter initialized');
      }

      if (_staticBox == null) {
        print('📦 Opening Hive box: $_boxName');
        _staticBox = await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
        print('✅ Hive box opened successfully');
      } else {
        print('ℹ️ Hive box already initialized');
      }
    } catch (e) {
      print('❌ Failed to initialize Hive box: $e');
      // Try to delete and recreate the box
      try {
        if (_hiveInitialized) {
          print('🔄 Attempting to recreate Hive box...');
          await Hive.deleteBoxFromDisk(_boxName);
          _staticBox = await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
          print('✅ Hive box recreated successfully');
        } else {
          throw Exception('Hive not initialized, cannot recreate box');
        }
      } catch (e2) {
        print('❌ Failed to recreate Hive box: $e2');
        rethrow;
      }
    }
  }

  Future<void> init() async {
    try {
      await initializeGlobally();
    } catch (e) {
      print('❌ ContributionPaymentLocalDataSource init failed: $e');
      // Don't rethrow here, let the calling code handle it
      rethrow;
    }
  }

  @override
  Future<void> savePayment(ContributionPaymentModel payment) async {
    await _box.put(payment.id, payment.toJson());
  }

  @override
  Future<List<ContributionPaymentModel>> getPaymentsByContribution(String contributionId) async {
    final allPayments = await _getAllPayments();
    return allPayments.where((payment) => payment.contributionId == contributionId).toList();
  }

  @override
  Future<List<ContributionPaymentModel>> getPaymentsByUser(String userId) async {
    final allPayments = await _getAllPayments();
    return allPayments.where((payment) => payment.userId == userId).toList();
  }

  @override
  Future<ContributionPaymentModel?> getPaymentById(String paymentId) async {
    final paymentData = _box.get(paymentId);
    if (paymentData == null) return null;
    
    return ContributionPaymentModel.fromJson(Map<String, dynamic>.from(paymentData));
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    await _box.delete(paymentId);
  }

  @override
  Future<void> clearAllPayments() async {
    await _box.clear();
  }

  Future<List<ContributionPaymentModel>> _getAllPayments() async {
    final List<ContributionPaymentModel> payments = [];
    
    for (final paymentData in _box.values) {
      try {
        final payment = ContributionPaymentModel.fromJson(Map<String, dynamic>.from(paymentData));
        payments.add(payment);
      } catch (e) {
        // Skip invalid payment data
        print('Error parsing payment data: $e');
      }
    }
    
    // Sort by payment date, newest first
    payments.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));
    
    return payments;
  }
} 