import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'nfc_broadcast_screen.dart';

class CreatePaymentSessionScreen extends StatelessWidget {
  const CreatePaymentSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: const _CreatePaymentSessionView(),
    );
  }
}

class _CreatePaymentSessionView extends StatefulWidget {
  const _CreatePaymentSessionView();

  @override
  State<_CreatePaymentSessionView> createState() =>
      _CreatePaymentSessionViewState();
}

class _CreatePaymentSessionViewState extends State<_CreatePaymentSessionView> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCurrency = 'USD';
  String? _selectedCategory;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'NGN'];
  final List<Map<String, dynamic>> _categories = [
    {'value': 'food', 'label': 'Food & Drinks', 'icon': Icons.restaurant},
    {'value': 'transport', 'label': 'Transport', 'icon': Icons.directions_car},
    {'value': 'shopping', 'label': 'Shopping', 'icon': Icons.shopping_bag},
    {'value': 'services', 'label': 'Services', 'icon': Icons.build},
    {'value': 'other', 'label': 'Other', 'icon': Icons.more_horiz},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Receive Payment'),
        centerTitle: true,
      ),
      body: BlocConsumer<ContactlessPaymentCubit, ContactlessPaymentState>(
        listener: (context, state) {
          if (state is PaymentSessionCreated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NfcBroadcastScreen(
                  session: state.session,
                  nfcPayload: state.nfcPayload,
                ),
              ),
            );
          } else if (state is ContactlessPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ContactlessPaymentLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Amount Input
                  Text(
                    'Amount',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Currency selector
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorScheme.outline),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCurrency,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            items: _currencies.map((currency) {
                              return DropdownMenuItem(
                                value: currency,
                                child: Text(
                                  currency,
                                  style: theme.textTheme.titleMedium,
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedCurrency = value);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Amount field
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'),
                            ),
                          ],
                          style: theme.textTheme.headlineSmall,
                          decoration: InputDecoration(
                            hintText: '0.00',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter an amount';
                            }
                            final amount = double.tryParse(value);
                            if (amount == null || amount <= 0) {
                              return 'Enter a valid amount';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Category Selection
                  Text(
                    'Category (optional)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((category) {
                      final isSelected =
                          _selectedCategory == category['value'];
                      return FilterChip(
                        selected: isSelected,
                        showCheckmark: false,
                        avatar: Icon(
                          category['icon'] as IconData,
                          size: 18,
                          color: isSelected
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                        ),
                        label: Text(category['label'] as String),
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory =
                                selected ? category['value'] as String : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description (optional)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 2,
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'What is this payment for?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Info box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'The payment session will be valid for 2 minutes. Hold your phones close together for the payer to tap.',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Create Session Button
                  FilledButton.icon(
                    onPressed: isLoading ? null : _createSession,
                    icon: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.contactless),
                    label: Text(
                      isLoading ? 'Creating...' : 'Create Payment Request',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _createSession() {
    if (_formKey.currentState?.validate() != true) return;

    final amount = double.parse(_amountController.text);

    context.read<ContactlessPaymentCubit>().createPaymentSession(
          amount: amount,
          currency: _selectedCurrency,
          category: _selectedCategory,
          description: _descriptionController.text.isNotEmpty
              ? _descriptionController.text
              : null,
        );
  }
}
