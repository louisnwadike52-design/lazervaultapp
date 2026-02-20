import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';

class RequestPhysicalCardScreen extends StatefulWidget {
  const RequestPhysicalCardScreen({super.key});

  @override
  State<RequestPhysicalCardScreen> createState() => _RequestPhysicalCardScreenState();
}

class _RequestPhysicalCardScreenState extends State<RequestPhysicalCardScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _countryController = TextEditingController(text: 'Nigeria');

  int? _accountId;
  String? _currency;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _accountId = args?['accountId'] as int?;
    _currency = args?['currency'] as String? ?? 'NGN';
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  String get _shippingAddress {
    return [
      _streetController.text.trim(),
      _cityController.text.trim(),
      _stateController.text.trim(),
      _postalCodeController.text.trim(),
      _countryController.text.trim(),
    ].where((s) => s.isNotEmpty).join(', ');
  }

  void _submitRequest() {
    if (_accountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account not selected'), backgroundColor: Color(0xFFEF4444)),
      );
      return;
    }

    context.read<CardCubit>().requestPhysicalCard(
      accountId: _accountId!,
      nickname: _nicknameController.text.trim().isNotEmpty ? _nicknameController.text.trim() : null,
      currency: _currency,
      shippingAddress: _shippingAddress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCubit, CardState>(
      listener: (context, state) {
        if (state is CardCreated) {
          Get.offNamed(AppRoutes.cardCreationReceipt, arguments: state.card);
        } else if (state is CardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: const Color(0xFFEF4444)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: const Text('Request Physical Card', style: TextStyle(color: Colors.white)),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep == 0) {
                  setState(() => _currentStep = 1);
                } else if (_currentStep == 1) {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() => _currentStep = 2);
                  }
                } else {
                  _submitRequest();
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                } else {
                  Get.back();
                }
              },
              controlsBuilder: (context, details) {
                final isLastStep = _currentStep == 2;
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state is CardCreating ? null : details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: state is CardCreating
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : Text(isLastStep ? 'Confirm Request' : 'Continue'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (_currentStep > 0)
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back', style: TextStyle(color: Color(0xFF9CA3AF))),
                        ),
                    ],
                  ),
                );
              },
              steps: [
                Step(
                  title: const Text('Card Details', style: TextStyle(color: Colors.white)),
                  content: Column(
                    children: [
                      TextField(
                        controller: _nicknameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Card Nickname (optional)', 'e.g. My ATM Card'),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Card Type', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                            const SizedBox(height: 4),
                            const Text('Physical Debit Card', style: TextStyle(color: Colors.white, fontSize: 16)),
                            const SizedBox(height: 8),
                            Text('Currency: $_currency', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text('Shipping Address', style: TextStyle(color: Colors.white)),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _streetController,
                          style: const TextStyle(color: Colors.white),
                          decoration: _inputDecoration('Street Address', '123 Main Street'),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _cityController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration('City', 'Lagos'),
                                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _stateController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration('State', 'Lagos'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _postalCodeController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration('Postal Code', '100001'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _countryController,
                                style: const TextStyle(color: Colors.white),
                                decoration: _inputDecoration('Country', 'Nigeria'),
                                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text('Review', style: TextStyle(color: Colors.white)),
                  content: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Order Summary', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _reviewRow('Card Type', 'Physical Debit Card'),
                        if (_nicknameController.text.trim().isNotEmpty)
                          _reviewRow('Nickname', _nicknameController.text.trim()),
                        _reviewRow('Currency', _currency ?? 'NGN'),
                        const Divider(color: Color(0xFF2D2D2D), height: 24),
                        const Text('Shipping To', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(_shippingAddress, style: const TextStyle(color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 16),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Delivery typically takes 5-10 business days.',
                                  style: TextStyle(color: Color(0xFF3B82F6), fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  isActive: _currentStep >= 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _reviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
      ),
    );
  }
}
