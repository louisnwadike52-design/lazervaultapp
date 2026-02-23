import 'package:flutter/material.dart';
import 'package:lazervault/src/features/funds/domain/entities/recurring_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';

class RecurringTransferModal extends StatefulWidget {
  final RecurringTransferConfig? initialConfig;
  final ValueChanged<RecurringTransferConfig> onConfigured;

  const RecurringTransferModal({
    super.key,
    this.initialConfig,
    required this.onConfigured,
  });

  @override
  State<RecurringTransferModal> createState() => _RecurringTransferModalState();
}

class _RecurringTransferModalState extends State<RecurringTransferModal> {
  late RecurringFrequency _frequency;
  late int _scheduleDay;
  late TimeOfDay _scheduleTime;
  bool _hasEndDate = false;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final config = widget.initialConfig;
    _frequency = config?.frequency ?? RecurringFrequency.weekly;
    _scheduleDay = config?.scheduleDay ?? 1; // Monday
    _scheduleTime = config?.scheduleTime ?? const TimeOfDay(hour: 9, minute: 0);
    _hasEndDate = config?.endDate != null;
    _endDate = config?.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.85,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0A0A0A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recurring Payment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Frequency selector
                    const Text(
                      'Frequency',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    _buildFrequencySelector(),
                    const SizedBox(height: 20),

                    // Day selector (conditional)
                    if (_frequency == RecurringFrequency.weekly ||
                        _frequency == RecurringFrequency.biweekly) ...[
                      const Text(
                        'Day of Week',
                        style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      _buildWeekDaySelector(),
                      const SizedBox(height: 20),
                    ],

                    if (_frequency == RecurringFrequency.monthly) ...[
                      const Text(
                        'Day of Month',
                        style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      _buildMonthDaySelector(),
                      const SizedBox(height: 20),
                    ],

                    // Time picker
                    const Text(
                      'Time',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    _buildTimePicker(),
                    const SizedBox(height: 20),

                    // End date
                    const Text(
                      'Duration',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    _buildEndDateSelector(),
                    const SizedBox(height: 24),

                    // Summary
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.repeat, color: Color(0xFF3B82F6), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _buildSummary(),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              // Set button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onSetRecurring,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Set Recurring',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFrequencySelector() {
    return Row(
      children: RecurringFrequency.values.map((freq) {
        final isSelected = _frequency == freq;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: GestureDetector(
              onTap: () => setState(() {
                _frequency = freq;
                if (freq == RecurringFrequency.monthly && _scheduleDay == 0) {
                  _scheduleDay = 1;
                }
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  freq.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeekDaySelector() {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: List.generate(7, (index) {
        final isSelected = _scheduleDay == index;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: GestureDetector(
              onTap: () => setState(() => _scheduleDay = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  days[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMonthDaySelector() {
    final days = List.generate(28, (i) => i + 1)..add(0); // 0 = "Last day"
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: days.map((day) {
        // "Last" (day==0) maps to scheduleDay 31; match it correctly on reopen
        final isSelected = day == 0 ? _scheduleDay == 31 : _scheduleDay == day;
        final label = day == 0 ? 'Last' : '$day';
        return GestureDetector(
          onTap: () => setState(() => _scheduleDay = day == 0 ? 31 : day),
          child: Container(
            width: 44,
            height: 36,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: _scheduleTime,
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF3B82F6),
                  surface: Color(0xFF1F1F1F),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() => _scheduleTime = picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Color(0xFF3B82F6), size: 20),
            const SizedBox(width: 12),
            Text(
              _scheduleTime.format(context),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }

  Widget _buildEndDateSelector() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() {
                  _hasEndDate = false;
                  _endDate = null;
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: !_hasEndDate ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Until I cancel',
                    style: TextStyle(
                      color: !_hasEndDate ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: !_hasEndDate ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 30)),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: Color(0xFF3B82F6),
                            surface: Color(0xFF1F1F1F),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _hasEndDate = true;
                      _endDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _hasEndDate ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _hasEndDate && _endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Set end date',
                    style: TextStyle(
                      color: _hasEndDate ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: _hasEndDate ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _buildSummary() {
    final config = RecurringTransferConfig(
      frequency: _frequency,
      scheduleDay: _scheduleDay,
      scheduleTime: _scheduleTime,
      endDate: _endDate,
    );
    return config.summary;
  }

  void _onSetRecurring() {
    final config = RecurringTransferConfig(
      frequency: _frequency,
      scheduleDay: _scheduleDay,
      scheduleTime: _scheduleTime,
      endDate: _endDate,
    );
    widget.onConfigured(config);
    Navigator.pop(context);
  }
}
