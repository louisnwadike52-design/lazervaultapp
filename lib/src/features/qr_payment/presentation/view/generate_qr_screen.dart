import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class GenerateQRScreen extends StatefulWidget {
  const GenerateQRScreen({super.key});

  @override
  State<GenerateQRScreen> createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final String _selectedCurrency = 'NGN';
  QRPaymentType _selectedType = QRPaymentType.dynamic;
  // 'one_time' | 'reusable' — static codes only; dynamic is always reusable.
  String _usageMode = 'one_time';
  // 0 = no expiry (the default for every type). Editable later from history.
  int _validityMinutes = 0;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<QRPaymentCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            'Generate QR Code',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<QRPaymentCubit, QRPaymentState>(
          listener: (context, state) {
            if (state is QRGenerated) {
              Get.toNamed(
                AppRoutes.qrDisplay,
                arguments: {
                  'qrCode': state.qrCode,
                  'qrData': state.qrData,
                },
              );
            } else if (state is QRPaymentError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTypeSelector(),
                    const SizedBox(height: 24),
                    if (_selectedType == QRPaymentType.static) ...[
                      _buildAmountInput(),
                      const SizedBox(height: 16),
                      _buildQuickAmounts(),
                      const SizedBox(height: 24),
                    ],
                    _buildDescriptionInput(),
                    const SizedBox(height: 24),
                    if (_selectedType == QRPaymentType.static) ...[
                      _buildUsageModeSelector(),
                      const SizedBox(height: 24),
                    ],
                    _buildValiditySelector(),
                    const SizedBox(height: 32),
                    _buildGenerateButton(context, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QR Type',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildTypeOption(
                'Dynamic',
                'Reusable, payer enters amount',
                QRPaymentType.dynamic,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTypeOption(
                'Static',
                'Fixed amount set by you',
                QRPaymentType.static,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeOption(String title, String subtitle, QRPaymentType type) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amount',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixText: '$_selectedCurrency ',
              prefixStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: '0.00',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    final amounts = [500, 1000, 2000, 5000, 10000];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: amounts.map((amount) {
        return GestureDetector(
          onTap: () {
            _amountController.text = amount.toString();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text(
              '$_selectedCurrency ${amount.toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description (optional)',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _descriptionController,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintText: 'What is this payment for?',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsageModeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usage',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildUsageOption(
                'One-time',
                'Deactivates after the first payment',
                'one_time',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildUsageOption(
                'Reusable',
                'Anyone can scan and pay, again and again — like a menu item',
                'reusable',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUsageOption(String title, String subtitle, String mode) {
    final isSelected = _usageMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _usageMode = mode),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: const TextStyle(
                    color: Color(0xFF9CA3AF), fontSize: 11, height: 1.3)),
          ],
        ),
      ),
    );
  }

  Widget _buildValiditySelector() {
    final options = [
      {'label': 'None', 'value': 0},
      {'label': '30 min', 'value': 30},
      {'label': '1 hour', 'value': 60},
      {'label': '24 hours', 'value': 1440},
      {'label': '7 days', 'value': 10080},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Expiry (optional — you can change it later)',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: options.map((opt) {
            final isSelected = _validityMinutes == opt['value'];
            return Expanded(
              child: GestureDetector(
                onTap: () =>
                    setState(() => _validityMinutes = opt['value'] as int),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF2D2D2D),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      opt['label'] as String,
                      style: TextStyle(
                        color:
                            isSelected ? const Color(0xFF3B82F6) : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGenerateButton(BuildContext context, QRPaymentState state) {
    final isLoading = state is QRPaymentLoading;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : () => _generate(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? LazerVaultLoader.small()
            : const Text(
                'Generate QR Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  void _generate(BuildContext context) {
    double amount = 0;
    if (_selectedType == QRPaymentType.static) {
      final parsed = double.tryParse(_amountController.text);
      if (parsed == null || parsed <= 0) {
        Get.snackbar(
          'Invalid Amount',
          'Please enter a valid amount',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
        );
        return;
      }
      amount = parsed;
    }

    context.read<QRPaymentCubit>().generateQR(
          amount: amount,
          currency: _selectedCurrency,
          description: _descriptionController.text.trim(),
          qrType: _selectedType,
          validityMinutes: _validityMinutes,
          usageMode:
              _selectedType == QRPaymentType.static ? _usageMode : 'reusable',
        );
  }
}
