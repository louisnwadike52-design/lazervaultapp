// Create Auto-Save Rule — multi-step wizard.
//
// Replaces the original 1000-line single-page form with a paged flow
// so each decision lives on its own screen and the validation copy
// can localise next to the input it complains about. The wizard
// steps map 1:1 to the rule's mental model:
//
//   1. Basics                 — name + description
//   2. Trigger Type           — On Deposit / Scheduled / Round Up cards
//   3. Trigger Configuration  — only the knobs the picked trigger needs
//                                 - Scheduled: frequency + day + time
//                                 - Round Up:  round_up_to chips
//                                 - On Deposit: explainer (% / fixed of incoming)
//   4. Amount                 — fixed or percentage + value
//   5. Accounts               — source + destination (same currency)
//   6. Limits (optional)      — target / minimum / maximum
//
// On step 6 the user lands on the existing review screen which then
// fires AutoSaveCubit.createRule. The wizard itself doesn't talk to
// the cubit — it just collects and validates.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';

// ─── Theme constants ─────────────────────────────────────────────────
const _bg = Color(0xFF0A0A0A);
const _surface = Color(0xFF1F1F1F);
const _border = Color(0xFF2D2D2D);
const _accent = Color.fromARGB(255, 78, 3, 208);
const _accentSoft = Color.fromARGB(255, 98, 33, 224);
const _textMuted = Color(0xFF9CA3AF);
const _success = Color(0xFF10B981);
const _danger = Color(0xFFEF4444);

class CreateAutoSaveRuleScreen extends StatefulWidget {
  const CreateAutoSaveRuleScreen({super.key});

  @override
  State<CreateAutoSaveRuleScreen> createState() =>
      _CreateAutoSaveRuleScreenState();
}

class _CreateAutoSaveRuleScreenState extends State<CreateAutoSaveRuleScreen> {
  // ─── Wizard state ──────────────────────────────────────────────────
  static const int _totalSteps = 6;
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // ─── Form state ───────────────────────────────────────────────────
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _minimumBalanceController = TextEditingController();
  final _maximumPerSaveController = TextEditingController();
  final _customRoundUpController = TextEditingController();

  TriggerType _selectedTriggerType = TriggerType.onDeposit;
  AmountType _selectedAmountType = AmountType.fixed;
  ScheduleFrequency? _selectedFrequency;
  int? _selectedScheduleDay;
  // Time defaults to 00:00 — explicit so the worker has *something*
  // to arm even if the user blows past the picker.
  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);
  int? _selectedRoundUpTo;
  String? _selectedSourceAccountId;
  String? _selectedDestinationAccountId;

  // Per-step validation messages so the bottom action bar can show
  // why "Continue" is disabled without throwing a snackbar at the user.
  String? _stepError;

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthenticationCubit>().userId ?? '';
    context
        .read<AccountCardsSummaryCubit>()
        .fetchAccountSummaries(userId: userId, accessToken: null);

    // Duplicate-from path (existing feature). Pre-fill, jump to review.
    final args = Get.arguments;
    if (args is Map && args.containsKey('duplicateFrom')) {
      _populateFromDuplicate(args['duplicateFrom'] as AutoSaveRuleEntity);
    }
  }

  void _populateFromDuplicate(AutoSaveRuleEntity rule) {
    _nameController.text = 'Copy of ${rule.name}';
    _descriptionController.text = rule.description;
    _amountController.text = rule.amountValue.toString();
    _selectedAmountType = rule.amountType;
    _selectedTriggerType = rule.triggerType;
    _selectedSourceAccountId = rule.sourceAccountId;
    _selectedDestinationAccountId = rule.destinationAccountId;
    if (rule.targetAmount != null) {
      _targetAmountController.text = rule.targetAmount.toString();
    }
    if (rule.minimumBalance != null) {
      _minimumBalanceController.text = rule.minimumBalance.toString();
    }
    if (rule.maximumPerSave != null) {
      _maximumPerSaveController.text = rule.maximumPerSave.toString();
    }
    if (rule.triggerType == TriggerType.scheduled) {
      _selectedFrequency = rule.frequency;
      _selectedScheduleDay = rule.scheduleDay;
      if (rule.scheduleTime != null && rule.scheduleTime!.length >= 4) {
        final parts = rule.scheduleTime!.split(':');
        if (parts.length == 2) {
          _selectedTime = TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 0,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }
      }
    }
    if (rule.triggerType == TriggerType.roundUp && rule.roundUpTo != null) {
      _selectedRoundUpTo = rule.roundUpTo;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _targetAmountController.dispose();
    _minimumBalanceController.dispose();
    _maximumPerSaveController.dispose();
    _customRoundUpController.dispose();
    super.dispose();
  }

  // ─── Step orchestration ────────────────────────────────────────────

  String? _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (_nameController.text.trim().length < 3) {
          return 'Give your rule a name (3+ characters)';
        }
        return null;
      case 1:
        return null; // trigger card always picks one
      case 2:
        if (_selectedTriggerType == TriggerType.scheduled) {
          if (_selectedFrequency == null) return 'Pick how often it should run';
          if (_needsScheduleDay(_selectedFrequency!) &&
              _selectedScheduleDay == null) {
            return 'Pick a day';
          }
        }
        if (_selectedTriggerType == TriggerType.roundUp) {
          final val = _resolvedRoundUpTo();
          if (val == null || val < 10) return 'Pick a round-up amount (≥ 10)';
        }
        return null;
      case 3:
        final amt = double.tryParse(_amountController.text.trim());
        if (amt == null || amt <= 0) return 'Enter a valid amount';
        if (_selectedAmountType == AmountType.percentage && amt > 100) {
          return 'Percentage must be 1-100';
        }
        return null;
      case 4:
        if (_selectedSourceAccountId == null) return 'Pick a source account';
        if (_selectedDestinationAccountId == null) {
          return 'Pick a destination account';
        }
        if (_selectedSourceAccountId == _selectedDestinationAccountId) {
          return 'Source and destination must differ';
        }
        return null;
      case 5:
        // Optional limits; cross-validate.
        if (_maximumPerSaveController.text.isNotEmpty) {
          final maxPer = double.tryParse(_maximumPerSaveController.text);
          if (maxPer == null || maxPer <= 0) return 'Max per save must be > 0';
          final amount = double.tryParse(_amountController.text) ?? 0;
          if (_selectedAmountType == AmountType.fixed && maxPer < amount) {
            return 'Max per save can\'t be smaller than the save amount';
          }
        }
        if (_targetAmountController.text.isNotEmpty) {
          final t = double.tryParse(_targetAmountController.text);
          if (t == null || t <= 0) return 'Target must be > 0';
        }
        if (_minimumBalanceController.text.isNotEmpty) {
          final m = double.tryParse(_minimumBalanceController.text);
          if (m == null || m < 0) return 'Min balance can\'t be negative';
        }
        return null;
    }
    return null;
  }

  void _goNext() {
    final err = _validateCurrentStep();
    if (err != null) {
      setState(() => _stepError = err);
      return;
    }
    setState(() => _stepError = null);
    if (_currentStep == _totalSteps - 1) {
      _submit();
      return;
    }
    setState(() => _currentStep++);
    _pageController.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
    FocusScope.of(context).unfocus();
  }

  void _goBack() {
    if (_currentStep == 0) {
      Get.back();
      return;
    }
    setState(() {
      _currentStep--;
      _stepError = null;
    });
    _pageController.animateToPage(
      _currentStep,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
    FocusScope.of(context).unfocus();
  }

  void _submit() {
    final accountsState = context.read<AccountCardsSummaryCubit>().state;
    String sourceName = 'Source';
    String destName = 'Destination';
    if (accountsState is AccountCardsSummaryLoaded) {
      final summaries = accountsState.accountSummaries;
      final src = summaries.firstWhere(
        (a) => a.id.toString() == _selectedSourceAccountId,
        orElse: () => summaries.first,
      );
      final dst = summaries.firstWhere(
        (a) => a.id.toString() == _selectedDestinationAccountId,
        orElse: () => summaries.first,
      );
      sourceName = '${src.accountType} (****${src.accountNumberLast4})';
      destName = '${dst.accountType} (****${dst.accountNumberLast4})';
    }

    // Strip trigger-specific state that doesn't apply to the picked
    // trigger. The user could have configured a frequency, then gone
    // back and switched to Round Up — without this the review screen
    // (and the cubit / proto) would carry orphaned state forward.
    final isScheduled = _selectedTriggerType == TriggerType.scheduled;
    final isRoundUp = _selectedTriggerType == TriggerType.roundUp;

    Get.toNamed(
      AppRoutes.autoSaveRuleReview,
      arguments: {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'triggerType': _selectedTriggerType,
        'amountType': _selectedAmountType,
        'amountValue': double.parse(_amountController.text),
        'sourceAccountId': _selectedSourceAccountId!,
        'destinationAccountId': _selectedDestinationAccountId!,
        'sourceAccountName': sourceName,
        'destinationAccountName': destName,
        'frequency': isScheduled ? _selectedFrequency : null,
        'scheduleTime': isScheduled ? _formatTime(_selectedTime) : null,
        'scheduleDay': isScheduled ? _selectedScheduleDay : null,
        'roundUpTo': isRoundUp ? _resolvedRoundUpTo() : null,
        'targetAmount': _targetAmountController.text.isEmpty
            ? null
            : double.parse(_targetAmountController.text),
        'minimumBalance': _minimumBalanceController.text.isEmpty
            ? null
            : double.parse(_minimumBalanceController.text),
        'maximumPerSave': _maximumPerSaveController.text.isEmpty
            ? null
            : double.parse(_maximumPerSaveController.text),
      },
    );
  }

  // ─── Build ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              currentStep: _currentStep,
              totalSteps: _totalSteps,
              stepLabel: _stepLabel(_currentStep),
              onBack: _goBack,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStep = i),
                children: [
                  _stepBasics(),
                  _stepTriggerType(),
                  _stepTriggerConfig(),
                  _stepAmount(),
                  _stepAccounts(),
                  _stepLimits(),
                ],
              ),
            ),
            _BottomActionBar(
              currentStep: _currentStep,
              totalSteps: _totalSteps,
              error: _stepError,
              onBack: _goBack,
              onNext: _goNext,
            ),
          ],
        ),
      ),
    );
  }

  String _stepLabel(int step) {
    switch (step) {
      case 0:
        return 'Name your rule';
      case 1:
        return 'Pick a trigger';
      case 2:
        return _triggerConfigLabel();
      case 3:
        return 'Choose amount';
      case 4:
        return 'Pick accounts';
      case 5:
        return 'Optional limits';
    }
    return '';
  }

  String _triggerConfigLabel() {
    switch (_selectedTriggerType) {
      case TriggerType.scheduled:
        return 'When should it run?';
      case TriggerType.roundUp:
        return 'Round up to…';
      case TriggerType.onDeposit:
        return 'On every deposit';
      case TriggerType.unknown:
        return 'Configure trigger';
    }
  }

  // ─── Step 1: Basics ───────────────────────────────────────────────

  Widget _stepBasics() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LabeledField(
            label: 'Rule name',
            child: _TextInput(
              controller: _nameController,
              hint: 'e.g. Save on Paycheck',
              autofocus: true,
              maxLength: 60,
              onChanged: (_) {
                if (_stepError != null) setState(() => _stepError = null);
              },
            ),
          ),
          SizedBox(height: 20.h),
          _LabeledField(
            label: 'Description',
            optional: true,
            child: _TextInput(
              controller: _descriptionController,
              hint: 'A short note for yourself',
              maxLines: 3,
              maxLength: 200,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Step 2: Trigger type ─────────────────────────────────────────

  Widget _stepTriggerType() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TriggerCard(
            icon: Icons.south_rounded,
            title: 'On Deposit',
            description:
                'Save automatically every time money lands in your account.',
            selected: _selectedTriggerType == TriggerType.onDeposit,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.onDeposit;
              _stepError = null;
            }),
          ),
          SizedBox(height: 12.h),
          _TriggerCard(
            icon: Icons.schedule_rounded,
            title: 'Scheduled',
            description:
                'Save a fixed amount on a recurring cadence (daily, weekly, monthly).',
            selected: _selectedTriggerType == TriggerType.scheduled,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.scheduled;
              _stepError = null;
            }),
          ),
          SizedBox(height: 12.h),
          _TriggerCard(
            icon: Icons.trending_up_rounded,
            title: 'Round Up',
            description:
                'Round every spend up to the nearest unit and pocket the change.',
            selected: _selectedTriggerType == TriggerType.roundUp,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.roundUp;
              _stepError = null;
            }),
          ),
        ],
      ),
    );
  }

  // ─── Step 3: Trigger config (varies by trigger) ───────────────────

  Widget _stepTriggerConfig() {
    switch (_selectedTriggerType) {
      case TriggerType.scheduled:
        return _scheduledConfig();
      case TriggerType.roundUp:
        return _roundUpConfig();
      case TriggerType.onDeposit:
        return _onDepositConfig();
      case TriggerType.unknown:
        return const SizedBox.shrink();
    }
  }

  Widget _scheduledConfig() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Frequency',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 2.4,
            children: [
              _FrequencyTile(
                label: 'Daily',
                hint: 'Every day',
                icon: Icons.today_rounded,
                selected: _selectedFrequency == ScheduleFrequency.daily,
                onTap: () => setState(() {
                  _selectedFrequency = ScheduleFrequency.daily;
                  _selectedScheduleDay = null;
                  _stepError = null;
                }),
              ),
              _FrequencyTile(
                label: 'Weekly',
                hint: 'Once a week',
                icon: Icons.view_week_rounded,
                selected: _selectedFrequency == ScheduleFrequency.weekly,
                onTap: () => setState(() {
                  _selectedFrequency = ScheduleFrequency.weekly;
                  _selectedScheduleDay = 1; // default Mon
                  _stepError = null;
                }),
              ),
              _FrequencyTile(
                label: 'Bi-weekly',
                hint: 'Every 2 weeks',
                icon: Icons.event_repeat_rounded,
                selected: _selectedFrequency == ScheduleFrequency.biweekly,
                onTap: () => setState(() {
                  _selectedFrequency = ScheduleFrequency.biweekly;
                  _selectedScheduleDay = 1;
                  _stepError = null;
                }),
              ),
              _FrequencyTile(
                label: 'Monthly',
                hint: 'Once a month',
                icon: Icons.calendar_month_rounded,
                selected: _selectedFrequency == ScheduleFrequency.monthly,
                onTap: () => setState(() {
                  _selectedFrequency = ScheduleFrequency.monthly;
                  _selectedScheduleDay = 1; // default 1st
                  _stepError = null;
                }),
              ),
            ],
          ),
          if (_selectedFrequency != null &&
              _needsScheduleDay(_selectedFrequency!)) ...[
            SizedBox(height: 24.h),
            Text(
              _selectedFrequency == ScheduleFrequency.monthly
                  ? 'Day of month'
                  : 'Day of week',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            if (_selectedFrequency == ScheduleFrequency.monthly)
              _MonthDayPicker(
                selectedDay: _selectedScheduleDay ?? 1,
                onChanged: (d) => setState(() {
                  _selectedScheduleDay = d;
                  _stepError = null;
                }),
              )
            else
              _WeekDayPicker(
                selectedDay: _selectedScheduleDay ?? 1,
                onChanged: (d) => setState(() {
                  _selectedScheduleDay = d;
                  _stepError = null;
                }),
              ),
          ],
          SizedBox(height: 24.h),
          Text(
            'Time of day',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Defaults to 00:00 — tap to change.',
            style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
          ),
          SizedBox(height: 12.h),
          _TimePickerTile(
            time: _selectedTime,
            onPick: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
                builder: (ctx, child) => Theme(
                  data: Theme.of(ctx).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: _accent,
                      onPrimary: Colors.white,
                      surface: _surface,
                      onSurface: Colors.white,
                    ),
                  ),
                  child: child ?? const SizedBox.shrink(),
                ),
              );
              if (picked != null) setState(() => _selectedTime = picked);
            },
          ),
        ],
      ),
    );
  }

  Widget _roundUpConfig() {
    final presets = const [50, 100, 500, 1000];
    final isCustom = _selectedRoundUpTo != null && !presets.contains(_selectedRoundUpTo);
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pick a round-up unit',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Every spend rounds up to the nearest multiple. The change is saved.',
            style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              for (final p in presets)
                _RoundUpChip(
                  label: _currencyLabel(p.toDouble()),
                  selected: _selectedRoundUpTo == p && !isCustom,
                  onTap: () => setState(() {
                    _selectedRoundUpTo = p;
                    _customRoundUpController.clear();
                    _stepError = null;
                  }),
                ),
              _RoundUpChip(
                label: 'Custom',
                selected: isCustom,
                onTap: () => setState(() {
                  _selectedRoundUpTo =
                      int.tryParse(_customRoundUpController.text);
                  _stepError = null;
                }),
              ),
            ],
          ),
          if (isCustom) ...[
            SizedBox(height: 16.h),
            _LabeledField(
              label: 'Custom amount',
              child: _TextInput(
                controller: _customRoundUpController,
                hint: 'e.g. 250',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (v) => setState(() {
                  _selectedRoundUpTo = int.tryParse(v);
                  _stepError = null;
                }),
              ),
            ),
          ],
          SizedBox(height: 20.h),
          _InfoCallout(
            icon: Icons.lightbulb_outline_rounded,
            text: _selectedRoundUpTo == null
                ? 'Example: spend 870 with round-up 100 → save 30.'
                : 'Example: spend 870 with round-up '
                    '${_currencyLabel(_selectedRoundUpTo!.toDouble())} → save '
                    '${_currencyLabel(((_selectedRoundUpTo! - (870 % _selectedRoundUpTo!)).toDouble()))}.',
            tone: _accent,
          ),
        ],
      ),
    );
  }

  Widget _onDepositConfig() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoCallout(
            icon: Icons.south_rounded,
            text:
                'Whenever your source account is credited, the rule will save '
                'either a fixed amount or a percentage of that deposit. You\'ll '
                'pick which on the next step.',
            tone: _accent,
          ),
          SizedBox(height: 16.h),
          _InfoCallout(
            icon: Icons.shield_outlined,
            text: 'Auto-save deposits never trigger themselves — debits and '
                'credits caused by your auto-save rules are filtered out.',
            tone: _success,
          ),
        ],
      ),
    );
  }

  // ─── Step 4: Amount ────────────────────────────────────────────────

  Widget _stepAmount() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_selectedTriggerType != TriggerType.roundUp) ...[
            Text(
              'Amount type',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            _SegmentedToggle(
              left: 'Fixed',
              right: 'Percentage',
              isLeft: _selectedAmountType == AmountType.fixed,
              onTap: (left) => setState(() {
                _selectedAmountType =
                    left ? AmountType.fixed : AmountType.percentage;
                _stepError = null;
              }),
            ),
            SizedBox(height: 20.h),
          ],
          StreamBuilder<String>(
            stream: CurrencySymbols.currencySymbolStream,
            builder: (context, snapshot) {
              final symbol = snapshot.data ?? '\$';
              final isPct = _selectedAmountType == AmountType.percentage &&
                  _selectedTriggerType != TriggerType.roundUp;
              final label = _selectedTriggerType == TriggerType.roundUp
                  ? 'Save amount per round-up ($symbol)'
                  : (isPct ? 'Percentage of deposit' : 'Save amount ($symbol)');
              return _LabeledField(
                label: label,
                child: _TextInput(
                  controller: _amountController,
                  hint: isPct ? '10' : '50.00',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  onChanged: (_) {
                    if (_stepError != null) setState(() => _stepError = null);
                  },
                  trailing: isPct
                      ? Text(
                          '%',
                          style: GoogleFonts.inter(
                            color: _textMuted,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : null,
                ),
              );
            },
          ),
          if (_selectedTriggerType == TriggerType.roundUp) ...[
            SizedBox(height: 16.h),
            _InfoCallout(
              icon: Icons.info_outline_rounded,
              text:
                  'For round-up rules this is just a per-fire upper bound — the '
                  'actual save is the rounding delta.',
              tone: _textMuted,
            ),
          ],
        ],
      ),
    );
  }

  // ─── Step 5: Accounts ──────────────────────────────────────────────

  Widget _stepAccounts() {
    return _StepBody(
      child: BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
        builder: (context, state) {
          if (state is AccountCardsSummaryLoaded) {
            final all = state.accountSummaries;

            // Hard-stop edge case: no accounts at all. Without
            // accounts the rule can't be created, so we surface a
            // friendly empty state with a CTA back to the dashboard
            // instead of an unhelpful empty dropdown that blocks
            // Continue forever.
            if (all.isEmpty) {
              return _EmptyAccountsState(
                onClose: () => Get.back(),
              );
            }

            // Source: any account. Destination: prefer savings.
            final dests = all.where((a) =>
                a.accountType.toLowerCase().contains('saving') ||
                a.accountType.toLowerCase().contains('money market')).toList();

            // Default destination only when nothing's been picked AND
            // the default would be valid (i.e. not the source). Skips
            // the addPostFrameCallback when source already filled in
            // so we don't auto-pick a clashing dest.
            if (_selectedDestinationAccountId == null && dests.isNotEmpty) {
              final firstDest = dests.first.id.toString();
              if (firstDest != _selectedSourceAccountId) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  if (_selectedDestinationAccountId != null) return;
                  setState(() => _selectedDestinationAccountId = firstDest);
                });
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _LabeledField(
                  label: 'Source account',
                  child: _AccountDropdown(
                    accounts: all,
                    valueId: _selectedSourceAccountId,
                    hint: 'Where to save from',
                    onChanged: (v) => setState(() {
                      _selectedSourceAccountId = v;
                      // Auto-clear destination if it now equals source
                      // so the user lands on a single recoverable
                      // pick instead of seeing a blocking error.
                      if (v != null && v == _selectedDestinationAccountId) {
                        _selectedDestinationAccountId = null;
                      }
                      _stepError = null;
                    }),
                  ),
                ),
                SizedBox(height: 18.h),
                _LabeledField(
                  label: 'Destination account',
                  badge: dests.isEmpty ? null : 'Savings',
                  help: dests.isEmpty
                      ? 'You have no savings account yet — pick any other account.'
                      : null,
                  child: _AccountDropdown(
                    // When the only candidates are the same as source,
                    // exclude source from dropdown so the user can't
                    // pick it twice.
                    accounts: (dests.isEmpty ? all : dests)
                        .where(
                            (a) => a.id.toString() != _selectedSourceAccountId)
                        .toList(),
                    valueId: _selectedDestinationAccountId,
                    hint: 'Where the money lands',
                    onChanged: (v) => setState(() {
                      _selectedDestinationAccountId = v;
                      _stepError = null;
                    }),
                  ),
                ),
              ],
            );
          }
          if (state is AccountCardsSummaryError) {
            return _AccountsLoadErrorState(
              message: state.message,
              onRetry: () {
                final userId =
                    context.read<AuthenticationCubit>().userId ?? '';
                context
                    .read<AccountCardsSummaryCubit>()
                    .fetchAccountSummaries(
                      userId: userId,
                      accessToken: null,
                    );
              },
            );
          }
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_accent),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Step 6: Limits (optional) ─────────────────────────────────────

  Widget _stepLimits() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoCallout(
            icon: Icons.tune_rounded,
            text:
                'Optional. Skip any field — the rule will still work without these.',
            tone: _textMuted,
          ),
          SizedBox(height: 16.h),
          _LabeledField(
            label: 'Target amount',
            optional: true,
            help: 'Auto-completes the rule once this much has been saved.',
            child: _TextInput(
              controller: _targetAmountController,
              hint: '1,000.00',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _LabeledField(
            label: 'Minimum balance to keep',
            optional: true,
            help: 'Source must keep at least this much after each save.',
            child: _TextInput(
              controller: _minimumBalanceController,
              hint: '100.00',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _LabeledField(
            label: 'Maximum per save',
            optional: true,
            help: 'Caps how much one fire can move.',
            child: _TextInput(
              controller: _maximumPerSaveController,
              hint: '500.00',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────

  bool _needsScheduleDay(ScheduleFrequency f) =>
      f == ScheduleFrequency.weekly ||
      f == ScheduleFrequency.biweekly ||
      f == ScheduleFrequency.monthly;

  int? _resolvedRoundUpTo() {
    if (_selectedTriggerType != TriggerType.roundUp) return null;
    if (_selectedRoundUpTo != null) return _selectedRoundUpTo;
    return int.tryParse(_customRoundUpController.text);
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  String _currencyLabel(double v) {
    final symbol = CurrencySymbols.currentSymbol;
    return '$symbol${v.toStringAsFixed(0)}';
  }
}

// ════════════════════════════════════════════════════════════════════
// Reusable building blocks (file-private)
// ════════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String stepLabel;
  final VoidCallback onBack;
  const _Header({
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabel,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    currentStep == 0
                        ? Icons.close_rounded
                        : Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step ${currentStep + 1} of $totalSteps',
                      style: GoogleFonts.inter(
                        color: _textMuted,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      stepLabel,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: List.generate(totalSteps, (i) {
              final filled = i <= currentStep;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i == totalSteps - 1 ? 0 : 4.w),
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: filled ? _accent : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _StepBody extends StatelessWidget {
  final Widget child;
  const _StepBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      child: child,
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String? error;
  final VoidCallback onBack;
  final VoidCallback onNext;
  const _BottomActionBar({
    required this.currentStep,
    required this.totalSteps,
    required this.error,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = currentStep == totalSteps - 1;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _border, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (error != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: _danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: _danger.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: _danger, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      error!,
                      style: GoogleFonts.inter(
                        color: _danger,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
          ],
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: _border),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    currentStep == 0 ? 'Cancel' : 'Back',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [_accent, _accentSoft],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: _accent.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: onNext,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLast ? 'Review rule' : 'Continue',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Icon(
                              isLast
                                  ? Icons.check_rounded
                                  : Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool optional;
  final String? badge;
  final String? help;
  const _LabeledField({
    required this.label,
    required this.child,
    this.optional = false,
    this.badge,
    this.help,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (optional) ...[
              SizedBox(width: 8.w),
              Text(
                'Optional',
                style: GoogleFonts.inter(
                  color: _textMuted,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (badge != null) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  badge!,
                  style: GoogleFonts.inter(
                    color: _success,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (help != null) ...[
          SizedBox(height: 4.h),
          Text(
            help!,
            style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final Widget? trailing;
  const _TextInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.autofocus = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        autofocus: autofocus,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: _textMuted, fontSize: 15.sp),
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          suffixIcon: trailing == null
              ? null
              : Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: trailing,
                ),
          suffixIconConstraints: BoxConstraints(minWidth: 0.w, minHeight: 0.h),
        ),
      ),
    );
  }
}

class _TriggerCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  const _TriggerCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.12) : _surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? _accent : _border,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: selected
                    ? _accent.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: selected ? _accent : _textMuted,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: _textMuted,
                      fontSize: 12.sp,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? _accent : Colors.transparent,
                border: Border.all(
                  color: selected ? _accent : _border,
                  width: 2,
                ),
              ),
              child: selected
                  ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _FrequencyTile extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _FrequencyTile({
    required this.label,
    required this.hint,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.12) : _surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? _accent : _border,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? _accent : _textMuted, size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    hint,
                    style: GoogleFonts.inter(
                      color: _textMuted,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekDayPicker extends StatelessWidget {
  final int selectedDay; // 1=Mon … 7=Sun (matches scheduler conventions)
  final ValueChanged<int> onChanged;
  const _WeekDayPicker({required this.selectedDay, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      children: List.generate(7, (i) {
        final day = i + 1;
        final selected = day == selectedDay;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i == 6 ? 0 : 6.w),
            child: GestureDetector(
              onTap: () => onChanged(day),
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: selected ? _accent : _surface,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: selected ? _accent : _border),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[i],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _MonthDayPicker extends StatelessWidget {
  final int selectedDay;
  final ValueChanged<int> onChanged;
  const _MonthDayPicker({required this.selectedDay, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      mainAxisSpacing: 6.h,
      crossAxisSpacing: 6.w,
      childAspectRatio: 1,
      children: List.generate(31, (i) {
        final day = i + 1;
        final selected = day == selectedDay;
        return GestureDetector(
          onTap: () => onChanged(day),
          child: Container(
            decoration: BoxDecoration(
              color: selected ? _accent : _surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TimePickerTile extends StatelessWidget {
  final TimeOfDay time;
  final VoidCallback onPick;
  const _TimePickerTile({required this.time, required this.onPick});

  @override
  Widget build(BuildContext context) {
    final label =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: onPick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Icon(Icons.access_time_rounded, color: _accent, size: 20.sp),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            const Spacer(),
            Icon(Icons.edit_rounded, color: _textMuted, size: 16.sp),
          ],
        ),
      ),
    );
  }
}

class _RoundUpChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _RoundUpChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? _accent : _surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? _accent : _border,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SegmentedToggle extends StatelessWidget {
  final String left;
  final String right;
  final bool isLeft;
  final ValueChanged<bool> onTap;
  const _SegmentedToggle({
    required this.left,
    required this.right,
    required this.isLeft,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Expanded(child: _segment(left, isLeft, () => onTap(true))),
          Expanded(child: _segment(right, !isLeft, () => onTap(false))),
        ],
      ),
    );
  }

  Widget _segment(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: active ? _accent : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AccountDropdown extends StatelessWidget {
  final List<dynamic> accounts; // AccountSummaryEntity-shaped items
  final String? valueId;
  final String hint;
  final ValueChanged<String?> onChanged;
  const _AccountDropdown({
    required this.accounts,
    required this.valueId,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: valueId,
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.inter(color: _textMuted, fontSize: 14.sp),
          ),
          dropdownColor: _surface,
          icon: const Icon(Icons.arrow_drop_down_rounded, color: _accent),
          items: accounts.map<DropdownMenuItem<String>>((a) {
            final id = a.id.toString();
            final label = '${a.accountType} (****${a.accountNumberLast4})';
            return DropdownMenuItem<String>(
              value: id,
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _EmptyAccountsState extends StatelessWidget {
  final VoidCallback onClose;
  const _EmptyAccountsState({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: _textMuted, size: 56.sp),
          SizedBox(height: 16.h),
          Text(
            'No accounts yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Auto-save needs at least one source and one destination account. '
              'Open an account from the dashboard, then come back.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: _textMuted,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            label: Text(
              'Back to dashboard',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _border),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountsLoadErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _AccountsLoadErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, color: _danger, size: 48.sp),
          SizedBox(height: 12.h),
          Text(
            'Couldn\'t load your accounts',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
            ),
          ),
          SizedBox(height: 16.h),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            label: Text(
              'Try again',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _border),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCallout extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color tone;
  const _InfoCallout({
    required this.icon,
    required this.text,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tone, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
