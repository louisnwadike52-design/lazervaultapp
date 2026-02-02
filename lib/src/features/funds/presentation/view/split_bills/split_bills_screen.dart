import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:intl/intl.dart';

/// Split Bills Screen for dividing payments among multiple participants
///
/// Allows users to:
/// - Enter total bill amount
/// - Select multiple participants
/// - Choose split method (Equal, Custom, Percentage)
/// - Initiate batch transfers to all participants
class SplitBillsScreen extends StatefulWidget {
  const SplitBillsScreen({super.key});

  @override
  State<SplitBillsScreen> createState() => _SplitBillsScreenState();
}

class _SplitBillsScreenState extends State<SplitBillsScreen> {
  static const int _maxParticipants = 20;

  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<RecipientModel> _selectedParticipants = [];
  final Map<String, double> _customAmounts = {};
  final Map<String, double> _percentages = {};
  SplitMethod _splitMethod = SplitMethod.equal;

  bool _includeMyself = true;
  double _myShare = 0.0;

  String get _currency {
    final acctDetails = GetIt.I<AccountManager>().activeAccountDetails;
    return acctDetails?.currency ?? 'NGN';
  }

  String get _currencySymbol {
    switch (_currency.toUpperCase()) {
      case 'NGN': return '\u20a6';
      case 'GBP': return '\u00a3';
      case 'EUR': return '\u20ac';
      case 'USD': return '\$';
      case 'ZAR': return 'R';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      default: return '\u20a6';
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch recipients when screen loads
    final recipientCubit = context.read<RecipientCubit>();
    if (recipientCubit.state is RecipientInitial) {
      // Get access token from arguments or auth cubit
      // For now, we'll trigger the fetch in build method
    }
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  double get _totalAmount {
    final value = double.tryParse(_totalAmountController.text) ?? 0.0;
    return value;
  }

  int get _totalParticipants {
    return _selectedParticipants.length + (_includeMyself ? 1 : 0);
  }

  void _calculateSplits() {
    if (_totalAmount <= 0 || _totalParticipants == 0) {
      setState(() {
        _myShare = 0.0;
        _customAmounts.clear();
        _percentages.clear();
      });
      return;
    }

    switch (_splitMethod) {
      case SplitMethod.equal:
        // Use cent-level precision to avoid rounding errors
        final totalCents = (_totalAmount * 100).round();
        final baseCents = totalCents ~/ _totalParticipants;
        var remainderCents = totalCents - (baseCents * _totalParticipants);
        setState(() {
          if (_includeMyself) {
            // First share (myself) gets the remainder
            _myShare = (baseCents + remainderCents) / 100.0;
            remainderCents = 0;
          } else {
            _myShare = 0.0;
          }
          for (var i = 0; i < _selectedParticipants.length; i++) {
            final extra = (i == 0 && remainderCents > 0) ? remainderCents : 0;
            _customAmounts[_selectedParticipants[i].id] = (baseCents + extra) / 100.0;
          }
        });
        break;

      case SplitMethod.custom:
        // Custom amounts are set manually by user
        // Calculate my share as remainder
        double totalAssigned = _customAmounts.values.fold(0.0, (sum, amt) => sum + amt);
        setState(() {
          _myShare = _includeMyself ? (_totalAmount - totalAssigned).clamp(0.0, _totalAmount) : 0.0;
        });
        break;

      case SplitMethod.percentage:
        // Calculate amounts from percentages
        setState(() {
          for (var participant in _selectedParticipants) {
            final percentage = _percentages[participant.id] ?? 0.0;
            _customAmounts[participant.id] = _totalAmount * (percentage / 100.0);
          }

          double totalAssigned = _customAmounts.values.fold(0.0, (sum, amt) => sum + amt);
          _myShare = _includeMyself ? (_totalAmount - totalAssigned).clamp(0.0, _totalAmount) : 0.0;
        });
        break;
    }
  }

  void _addParticipant(RecipientModel recipient) {
    if (_selectedParticipants.length >= _maxParticipants) {
      Get.snackbar(
        'Limit Reached',
        'Maximum $_maxParticipants participants allowed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }
    if (!_selectedParticipants.any((p) => p.id == recipient.id)) {
      setState(() {
        _selectedParticipants.add(recipient);
        if (_totalAmount > 0) {
          _customAmounts[recipient.id] = _totalAmount / (_selectedParticipants.length + (_includeMyself ? 1 : 0));
        }
        _percentages[recipient.id] = 100.0 / (_selectedParticipants.length + (_includeMyself ? 1 : 0));
      });
      _calculateSplits();
    }
  }

  void _removeParticipant(String participantId) {
    setState(() {
      _selectedParticipants.removeWhere((p) => p.id == participantId);
      _customAmounts.remove(participantId);
      _percentages.remove(participantId);
    });
    _calculateSplits();
  }

  void _proceedToPayment() {
    // Validation
    if (_totalAmount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid total amount',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    if (_selectedParticipants.isEmpty) {
      Get.snackbar(
        'No Participants',
        'Please select at least one participant',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // Verify total splits equal total amount
    double totalSplits = _customAmounts.values.fold(0.0, (sum, amt) => sum + amt) + _myShare;
    if ((totalSplits - _totalAmount).abs() > 0.01) { // Allow 1 cent tolerance
      Get.snackbar(
        'Split Error',
        'Total splits ($_currencySymbol${NumberFormat('#,##0.00').format(totalSplits)}) do not equal total amount ($_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount)})',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Convert amounts to minor units (kobo/cents) for batch transfer
    final amountsInMinorUnits = _customAmounts.map(
      (key, value) => MapEntry(key, (value * 100).round()),
    );

    // Navigate to confirmation screen with split details
    Get.toNamed(
      AppRoutes.batchTransfer,
      arguments: {
        'participants': _selectedParticipants,
        'amounts': amountsInMinorUnits,
        'amounts_display': _customAmounts,
        'totalAmount': _totalAmount,
        'totalAmountMinorUnits': (_totalAmount * 100).round(),
        'description': _descriptionController.text.isEmpty
            ? 'Split Bill'
            : _descriptionController.text,
        'myShare': _myShare,
        'split_type': _splitMethod.name,
        'currency': _currency,
        'currencySymbol': _currencySymbol,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Split Bills',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
      ),
      body: BlocBuilder<RecipientCubit, RecipientState>(
        builder: (context, recipientState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 78, 3, 208),
                        Color.fromARGB(255, 95, 20, 225),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _totalAmountController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          prefixText: _currencySymbol,
                          prefixStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => _calculateSplits(),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: _descriptionController,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'Description (optional)',
                          hintStyle: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                          prefixIcon: Icon(Icons.description_outlined, color: Colors.white.withValues(alpha: 0.8)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Split Method Selection
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Split Method',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSplitMethodChip(SplitMethod.equal, 'Equal'),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _buildSplitMethodChip(SplitMethod.custom, 'Custom'),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: _buildSplitMethodChip(SplitMethod.percentage, 'Percentage'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Include Myself Toggle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, color: Color.fromARGB(255, 78, 3, 208)),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Include Myself',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (_includeMyself && _myShare > 0)
                                  Text(
                                    'My share: $_currencySymbol${NumberFormat('#,##0.00').format(_myShare)}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        Switch(
                          value: _includeMyself,
                          onChanged: (value) {
                            setState(() {
                              _includeMyself = value;
                            });
                            _calculateSplits();
                          },
                          activeTrackColor: Color.fromARGB(255, 78, 3, 208),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Participants Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Participants (${_selectedParticipants.length})',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => _showAddParticipantBottomSheet(context),
                        icon: Icon(Icons.add, size: 20),
                        label: Text('Add'),
                        style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 78, 3, 208),
                        ),
                      ),
                    ],
                  ),
                ),

                // Participants List
                if (_selectedParticipants.isEmpty)
                  Padding(
                    padding: EdgeInsets.all(32.w),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 64.sp,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No participants added yet',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: () => _showAddParticipantBottomSheet(context),
                            child: Text('Add Participants'),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _selectedParticipants.length,
                    itemBuilder: (context, index) {
                      final participant = _selectedParticipants[index];
                      return _buildParticipantCard(participant);
                    },
                  ),

                SizedBox(height: 24.h),

                // Summary Section
                if (_selectedParticipants.isNotEmpty && _totalAmount > 0)
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount:', style: TextStyle(fontSize: 14.sp)),
                              Text(
                                '$_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount)}',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Participants:', style: TextStyle(fontSize: 14.sp)),
                              Text(
                                '$_totalParticipants',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (_splitMethod == SplitMethod.equal)
                            Column(
                              children: [
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Per Person:', style: TextStyle(fontSize: 14.sp)),
                                    Text(
                                      '$_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount / _totalParticipants)}',
                                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 100.h), // Space for bottom button
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _selectedParticipants.isNotEmpty && _totalAmount > 0
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _proceedToPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 78, 3, 208),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Review & Send Payments',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildSplitMethodChip(SplitMethod method, String label) {
    final isSelected = _splitMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _splitMethod = method;
        });
        _calculateSplits();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 78, 3, 208)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantCard(RecipientModel participant) {
    final amount = _customAmounts[participant.id] ?? 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
            child: Text(
              participant.name[0].toUpperCase(),
              style: TextStyle(
                color: Color.fromARGB(255, 78, 3, 208),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Participant Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participant.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (participant.accountNumber.isNotEmpty)
                  Text(
                    participant.accountNumber,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),

          // Amount Display/Input
          if (_splitMethod == SplitMethod.equal)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$_currencySymbol${NumberFormat('#,##0.00').format(amount)}',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else if (_splitMethod == SplitMethod.custom)
            SizedBox(
              width: 100.w,
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '0.00',
                  prefixText: _currencySymbol,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _customAmounts[participant.id] = double.tryParse(value) ?? 0.0;
                  });
                  _calculateSplits();
                },
              ),
            )
          else if (_splitMethod == SplitMethod.percentage)
            SizedBox(
              width: 100.w,
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: '0',
                  suffixText: '%',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _percentages[participant.id] = double.tryParse(value) ?? 0.0;
                  });
                  _calculateSplits();
                },
              ),
            ),

          SizedBox(width: 8.w),

          // Remove Button
          IconButton(
            icon: Icon(Icons.close, color: Colors.red, size: 20),
            onPressed: () => _removeParticipant(participant.id),
            constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  void _showAddParticipantBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    'Select Participants',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                // Recipients List
                Expanded(
                  child: BlocBuilder<RecipientCubit, RecipientState>(
                    builder: (context, state) {
                      if (state is RecipientLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (state is RecipientError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }

                      if (state is RecipientLoaded) {
                        final availableRecipients = state.recipients
                            .where((r) => !_selectedParticipants.any((p) => p.id == r.id))
                            .toList();

                        if (availableRecipients.isEmpty) {
                          return Center(
                            child: Text('All recipients have been added'),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: availableRecipients.length,
                          itemBuilder: (context, index) {
                            final recipient = availableRecipients[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                                child: Text(
                                  recipient.name[0].toUpperCase(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 78, 3, 208),
                                  ),
                                ),
                              ),
                              title: Text(recipient.name),
                              subtitle: Text(recipient.accountNumber),
                              trailing: Icon(Icons.add_circle_outline, color: Color.fromARGB(255, 78, 3, 208)),
                              onTap: () {
                                _addParticipant(recipient);
                                Navigator.pop(bottomSheetContext);
                              },
                            );
                          },
                        );
                      }

                      return Center(child: Text('No recipients available'));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

enum SplitMethod {
  equal,
  custom,
  percentage,
}
