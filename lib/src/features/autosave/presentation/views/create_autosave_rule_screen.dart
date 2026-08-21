// Create Auto-Save Rule — multi-step wizard.
//
// Visual standard: matches the contribution/joint-funds create flow
// (`create_contribution_bottom_sheet.dart`, `step1_type_selection.dart`).
// Key cues:
//   • Cards are *elevated* (drop shadow w/ 0.3 alpha black, 8-12px blur)
//     instead of relying on 1px borders to separate from the background.
//   • Selected state stacks three visual layers: accent-tinted fill,
//     2px accent stroke, accent-tinted shadow.
//   • Trigger / preset cards put a 56×56 colored icon-badge on the
//     left, title (16sp/700) + supporting copy (13sp/grey-400) to its right.
//   • Progress bar is the same gradient-filled track + animated pill-dots
//     used by the contribution wizard.
//   • Bottom action bar is sticky with its own top shadow so it never
//     appears to float on the same plane as the form below.
//
// Steps:
//   1. Basics                — name + description
//   2. Trigger Type          — On Deposit / Scheduled / Round Up cards
//   3. Trigger Configuration — only the knobs the picked trigger needs
//   4. Amount                — fixed or percentage + value
//   5. Accounts              — source + destination
//   6. Limits (optional)     — target / minimum / maximum

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
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_state.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_management_bottomsheet.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_status_badge.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_link_fee_mixin.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'create_autosave_rule_screen_part1.dart';
part 'create_autosave_rule_screen_part2.dart';


// ─── Theme constants — aligned with the contribution flow palette ───
const _bg = Color(0xFF0A0A0A);
const _surface = Color(0xFF1F1F1F);
const _surfaceRaised = Color(0xFF252535); // slightly lifted card colour
const _hairline = Color(0xFF2D2D2D);
const _accent = Color(0xFF6366F1); // indigo — primary
const _accentDeep = Color.fromARGB(255, 78, 3, 208);
const _onDepositTint = Color(0xFF3B82F6); // blue — on-deposit
const _scheduledTint = Color(0xFF10B981); // emerald — scheduled
const _roundUpTint = Color(0xFFF59E0B); // amber — round-up
const _inflowTint = Color(0xFFFB923C); // orange — bank inflow (external)
const _scheduledExternalTint = Color(0xFF14B8A6); // teal — bank standing order
const _textMuted = Color(0xFF9CA3AF);
const _danger = Color(0xFFEF4444);
const _success = Color(0xFF10B981);

// Reusable shadows so every elevated surface in this screen quotes the
// same drop-shadow recipe — keeps the wizard feeling like one document.
const _shadowSoft = BoxShadow(
  color: Color(0x4D000000), // black @ 30%
  blurRadius: 10,
  offset: Offset(0, 3),
);
const _shadowMd = BoxShadow(
  color: Color(0x66000000), // black @ 40%
  blurRadius: 14,
  offset: Offset(0, 6),
);

class CreateAutoSaveRuleScreen extends StatefulWidget {
  const CreateAutoSaveRuleScreen({super.key});

  @override
  State<CreateAutoSaveRuleScreen> createState() =>
      _CreateAutoSaveRuleScreenState();
}

class _CreateAutoSaveRuleScreenState extends State<CreateAutoSaveRuleScreen> {
  // Four-step flow (was six). Consolidated for a shorter-feeling journey
  // without dropping any field:
  //   0 Setup     = name + description + trigger type   (old 0 + 1)
  //   1 Configure = trigger-specific config + amount    (old 2 + 3)
  //   2 Accounts  = source + destination                (old 4)
  //   3 Limits    = optional goals/guardrails           (old 5)
  static const int _totalSteps = 4;
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Form state
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
  TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);
  int? _selectedRoundUpTo;
  String? _selectedSourceAccountId;
  String? _selectedDestinationAccountId;

  // Bank-inflow trigger: the Mono-linked external account that feeds the
  // rule. Selectable only when its Direct Debit mandate is ready to debit.
  LinkedBankAccount? _selectedLinkedAccount;

  String? _stepError;

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthenticationCubit>().userId ?? '';
    context
        .read<AccountCardsSummaryCubit>()
        .fetchAccountSummaries(userId: userId, accessToken: null);

    // Bank-inflow trigger needs the user's Mono-linked accounts + mandate
    // states (same data the Beam flow uses).
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<OpenBankingCubit>().fetchLinkedAccounts(
            userId: authState.profile.userId,
            accessToken: authState.profile.session.accessToken,
          );
      context.read<MandateCubit>().fetchUserMandates(
            userId: authState.profile.userId,
          );
    }

    // Optional "duplicate rule" prefill. Type-check the value (not just the key)
    // so a malformed argument can't crash the create wizard; a wrong-typed
    // duplicateFrom simply opens a blank create form.
    final args = Get.arguments;
    if (args is Map && args['duplicateFrom'] is AutoSaveRuleEntity) {
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
    if (rule.triggerType == TriggerType.scheduled ||
        rule.triggerType == TriggerType.scheduledExternal) {
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

  // ─── Step orchestration ──────────────────────────────────────────

  String? _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        // Setup: name (trigger always has a default, no validation needed).
        if (_nameController.text.trim().length < 3) {
          return 'Give your rule a name (3+ characters)';
        }
        return null;
      case 1:
        // Configure: trigger-specific config THEN amount.
        if (_selectedTriggerType == TriggerType.scheduled ||
            _selectedTriggerType == TriggerType.scheduledExternal) {
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
        final amt = double.tryParse(_amountController.text.trim());
        if (amt == null || amt <= 0) return 'Enter a valid amount';
        if (_selectedAmountType == AmountType.percentage && amt > 100) {
          return 'Percentage must be 1-100';
        }
        return null;
      case 2:
        if (_selectedTriggerType == TriggerType.externalInflow ||
            _selectedTriggerType == TriggerType.scheduledExternal) {
          if (_selectedLinkedAccount == null) {
            return 'Pick the linked bank to save from';
          }
          if (!_isMandateReady(_selectedLinkedAccount!)) {
            return 'Set up Direct Debit on that bank first';
          }
          if (_selectedDestinationAccountId == null) {
            return 'Pick a destination account';
          }
          return null;
        }
        if (_selectedSourceAccountId == null) return 'Pick a source account';
        if (_selectedDestinationAccountId == null) {
          return 'Pick a destination account';
        }
        if (_selectedSourceAccountId == _selectedDestinationAccountId) {
          return 'Source and destination must differ';
        }
        return null;
      case 3:
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
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
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
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
    FocusScope.of(context).unfocus();
  }

  void _submit() {
    final accountsState = context.read<AccountCardsSummaryCubit>().state;
    final isInflow = _selectedTriggerType == TriggerType.externalInflow;
    final isScheduledExternal =
        _selectedTriggerType == TriggerType.scheduledExternal;
    // Both bank-inflow and standing-order rules pull from a linked bank, so
    // the LazerVault wallet source is unused and the linked account is set.
    final usesLinkedSource = isInflow || isScheduledExternal;
    String sourceName = 'Source';
    String destName = 'Destination';
    if (accountsState is AccountCardsSummaryLoaded) {
      final summaries = accountsState.accountSummaries;
      if (!usesLinkedSource) {
        final src = summaries.firstWhere(
          (a) => a.id.toString() == _selectedSourceAccountId,
          orElse: () => summaries.first,
        );
        sourceName = '${src.accountType} (****${src.accountNumberLast4})';
      }
      final dst = summaries.firstWhere(
        (a) => a.id.toString() == _selectedDestinationAccountId,
        orElse: () => summaries.first,
      );
      destName = '${dst.accountType} (****${dst.accountNumberLast4})';
    }
    if (usesLinkedSource && _selectedLinkedAccount != null) {
      sourceName =
          '${_selectedLinkedAccount!.bankName} (${_selectedLinkedAccount!.accountNumber})';
    }

    // Standing orders reuse the scheduled cadence fields on top of the
    // linked-bank source.
    final usesSchedule =
        _selectedTriggerType == TriggerType.scheduled || isScheduledExternal;
    final isRoundUp = _selectedTriggerType == TriggerType.roundUp;

    Get.toNamed(
      AppRoutes.autoSaveRuleReview,
      arguments: {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'triggerType': _selectedTriggerType,
        'amountType': _selectedAmountType,
        'amountValue': double.parse(_amountController.text),
        // External-inflow rules have no LazerVault source wallet — the
        // linked bank is the source (banking-service mandate pulls from it).
        'sourceAccountId': usesLinkedSource ? '' : _selectedSourceAccountId!,
        'sourceLinkedAccountId':
            usesLinkedSource ? _selectedLinkedAccount!.id : null,
        'sourceBankName':
            usesLinkedSource ? _selectedLinkedAccount!.bankName : null,
        'destinationAccountId': _selectedDestinationAccountId!,
        'sourceAccountName': sourceName,
        'destinationAccountName': destName,
        'frequency': usesSchedule ? _selectedFrequency : null,
        'scheduleTime': usesSchedule ? _formatTime(_selectedTime) : null,
        'scheduleDay': usesSchedule ? _selectedScheduleDay : null,
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

  // ─── Build ───────────────────────────────────────────────────────

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
              titleHero: _stepHeroTitle(_currentStep),
              titleHeroAccent: _stepHeroAccent(),
              subtitle: _stepHeroSubtitle(_currentStep),
              onBack: _goBack,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStep = i),
                children: [
                  _stepSetup(),
                  _stepConfigure(),
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

  String _stepHeroTitle(int step) {
    switch (step) {
      case 0:
        return 'Set up your rule';
      case 1:
        return 'Configure & amount';
      case 2:
        return 'Pick accounts';
      case 3:
        return 'Optional limits';
    }
    return '';
  }

  String _stepHeroSubtitle(int step) {
    switch (step) {
      case 0:
        return 'Name it and pick how it should fire. You can change this later.';
      case 1:
        // Configure step blends the trigger config with the amount, so the
        // subtitle leads with the trigger-specific framing.
        switch (_selectedTriggerType) {
          case TriggerType.scheduled:
            return 'Choose the cadence, then how much to save each run.';
          case TriggerType.roundUp:
            return 'Set the round-up unit, then an optional per-fire cap.';
          case TriggerType.onDeposit:
            return 'Save a fixed amount or a percentage of each deposit.';
          case TriggerType.externalInflow:
            return 'Save a fixed amount or a percentage of each bank inflow.';
          case TriggerType.scheduledExternal:
            return 'Choose the cadence, then a fixed amount to pull from your bank each run.';
          case TriggerType.unknown:
            return '';
        }
      case 2:
        return (_selectedTriggerType == TriggerType.externalInflow ||
                _selectedTriggerType == TriggerType.scheduledExternal)
            ? 'Pick the linked bank to pull from and the Lazervault account the savings land in.'
            : 'Money goes from the source to the destination. Pick a destination savings account.';
      case 3:
        return 'Goals and guardrails. Skip anything you don\'t need.';
    }
    return '';
  }

  Color _stepHeroAccent() {
    // The Configure step (1) carries the picked trigger's accent; everything
    // else uses the wizard's primary indigo.
    if (_currentStep != 1) return _accent;
    return _triggerColor(_selectedTriggerType);
  }

  Color _triggerColor(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return _onDepositTint;
      case TriggerType.scheduled:
        return _scheduledTint;
      case TriggerType.roundUp:
        return _roundUpTint;
      case TriggerType.externalInflow:
        return _inflowTint;
      case TriggerType.scheduledExternal:
        return _scheduledExternalTint;
      case TriggerType.unknown:
        return _accent;
    }
  }

  // ─── Step 0: Setup (name + description + trigger type) ──────────

  Widget _stepSetup() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _basicsSection(),
          SizedBox(height: 28.h),
          _SectionTitle('Choose a trigger'),
          SizedBox(height: 14.h),
          _triggerTypeSection(),
        ],
      ),
    );
  }

  Widget _basicsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LabeledField(
          label: 'Rule name',
          counter: '${_nameController.text.length}/60',
          child: _TextInput(
            controller: _nameController,
            hint: 'e.g. Save on Paycheck',
            autofocus: true,
            maxLength: 60,
            onChanged: (_) {
              if (_stepError != null) setState(() => _stepError = null);
              setState(() {}); // counter
            },
          ),
        ),
        SizedBox(height: 20.h),
        _LabeledField(
          label: 'Description',
          optional: true,
          counter: '${_descriptionController.text.length}/200',
          child: _TextInput(
            controller: _descriptionController,
            hint: 'A short note for yourself',
            maxLines: 3,
            maxLength: 200,
            onChanged: (_) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Widget _triggerTypeSection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TriggerCard(
            tint: _onDepositTint,
            icon: Icons.south_rounded,
            title: 'On Deposit',
            description:
                'Save every time money lands in your account. Pair with a fixed amount or a % of the deposit.',
            selected: _selectedTriggerType == TriggerType.onDeposit,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.onDeposit;
              _stepError = null;
            }),
          ),
          SizedBox(height: 14.h),
          _TriggerCard(
            tint: _scheduledTint,
            icon: Icons.schedule_rounded,
            title: 'Scheduled',
            description:
                'Save a fixed amount on a recurring cadence: daily, weekly or monthly at any time of day.',
            selected: _selectedTriggerType == TriggerType.scheduled,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.scheduled;
              _stepError = null;
            }),
          ),
          SizedBox(height: 14.h),
          _TriggerCard(
            tint: _roundUpTint,
            icon: Icons.trending_up_rounded,
            title: 'Round Up',
            description:
                'Round each spend up to the nearest unit and pocket the change. Great for passive saving.',
            selected: _selectedTriggerType == TriggerType.roundUp,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.roundUp;
              _stepError = null;
            }),
          ),
          SizedBox(height: 14.h),
          _TriggerCard(
            tint: _inflowTint,
            icon: Icons.account_balance_rounded,
            title: 'Bank Inflow',
            description:
                'Auto-save when money enters your linked bank. Direct Debit moves a slice straight into Lazervault.',
            selected: _selectedTriggerType == TriggerType.externalInflow,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.externalInflow;
              _stepError = null;
            }),
          ),
          SizedBox(height: 14.h),
          _TriggerCard(
            tint: _scheduledExternalTint,
            icon: Icons.account_balance_wallet_rounded,
            title: 'Bank standing order',
            description:
                'Pull a fixed amount from your linked bank into savings on a recurring schedule.',
            selected: _selectedTriggerType == TriggerType.scheduledExternal,
            onTap: () => setState(() {
              _selectedTriggerType = TriggerType.scheduledExternal;
              // Standing orders are fixed-amount only.
              _selectedAmountType = AmountType.fixed;
              _stepError = null;
            }),
          ),
        ],
      );
  }

  // ─── Step 1: Configure (trigger config + amount) ────────────────

  Widget _stepConfigure() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _triggerConfigSection(),
          SizedBox(height: 26.h),
          Container(height: 1, color: _hairline),
          SizedBox(height: 26.h),
          _SectionTitle('Amount'),
          SizedBox(height: 14.h),
          _amountSection(),
        ],
      ),
    );
  }

  Widget _triggerConfigSection() {
    switch (_selectedTriggerType) {
      case TriggerType.scheduled:
        return _scheduledConfig();
      case TriggerType.roundUp:
        return _roundUpConfig();
      case TriggerType.onDeposit:
        return _onDepositConfig();
      case TriggerType.externalInflow:
        return _externalInflowConfig();
      case TriggerType.scheduledExternal:
        // Bank standing order = the scheduled cadence config, driving a
        // Direct Debit pull from the linked bank picked on the accounts step.
        return _scheduledConfig();
      case TriggerType.unknown:
        return const SizedBox.shrink();
    }
  }

  Widget _scheduledConfig() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle('Frequency'),
          SizedBox(height: 12.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 2.2,
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
                  _selectedScheduleDay = 1;
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
                  _selectedScheduleDay = 1;
                  _stepError = null;
                }),
              ),
            ],
          ),
          if (_selectedFrequency != null &&
              _needsScheduleDay(_selectedFrequency!)) ...[
            SizedBox(height: 28.h),
            _SectionTitle(
              _selectedFrequency == ScheduleFrequency.monthly
                  ? 'Day of month'
                  : 'Day of week',
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
          SizedBox(height: 28.h),
          _SectionTitle('Time of day'),
          SizedBox(height: 4.h),
          Text(
            'Defaults to 00:00. Tap the tile to change.',
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
      );
  }

  Widget _roundUpConfig() {
    final presets = const [50, 100, 500, 1000];
    final isCustom =
        _selectedRoundUpTo != null && !presets.contains(_selectedRoundUpTo);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle('Round up unit'),
          SizedBox(height: 4.h),
          Text(
            'Every spend rounds up to the nearest multiple of this value.',
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
                icon: Icons.tune_rounded,
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
          SizedBox(height: 22.h),
          _PreviewCard(
            tint: _roundUpTint,
            icon: Icons.calculate_outlined,
            title: 'Example',
            body: _roundUpExampleText(),
          ),
        ],
      );
  }

  String _roundUpExampleText() {
    if (_selectedRoundUpTo == null) {
      return 'Spend ${_currencyLabel(870)} with a round-up of '
          '${_currencyLabel(100)} → save ${_currencyLabel(30)}.';
    }
    final unit = _selectedRoundUpTo!;
    final delta = unit - (870 % unit);
    return 'Spend ${_currencyLabel(870)} with a round-up of '
        '${_currencyLabel(unit.toDouble())} → save '
        '${_currencyLabel(delta.toDouble())}.';
  }

  Widget _onDepositConfig() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewCard(
            tint: _onDepositTint,
            icon: Icons.south_rounded,
            title: 'How it works',
            body:
                'Whenever your source account is credited, the rule saves either a fixed amount or a percentage of that deposit. Pick the amount on the next step.',
          ),
          SizedBox(height: 14.h),
          _PreviewCard(
            tint: _success,
            icon: Icons.shield_outlined,
            title: 'Recursion-safe',
            body:
                'Saves caused by your own auto-save rules are filtered out, so the trigger can never fire itself.',
          ),
        ],
      );
  }

  Widget _externalInflowConfig() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewCard(
            tint: _inflowTint,
            icon: Icons.account_balance_rounded,
            title: 'How it works',
            body:
                'When money lands in your linked bank account, Lazervault pulls your configured save through the bank\'s Direct Debit mandate into your savings. You pick the bank on the accounts step.',
          ),
          SizedBox(height: 14.h),
          _PreviewCard(
            tint: _onDepositTint,
            icon: Icons.sync_rounded,
            title: 'Detection timing',
            body:
                'Inflows are detected when your bank data syncs. Most saves fire within minutes of the money arriving.',
          ),
          SizedBox(height: 14.h),
          _PreviewCard(
            tint: _success,
            icon: Icons.shield_outlined,
            title: 'Direct Debit required',
            body:
                'The selected bank needs an active Direct Debit mandate. If it doesn\'t have one yet, you can set it up in the same flow.',
          ),
        ],
      );
  }

  // ─── Amount section (rendered inside the Configure step) ────────

  Widget _amountSection() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_selectedTriggerType != TriggerType.roundUp &&
              _selectedTriggerType != TriggerType.scheduledExternal) ...[
            _SectionTitle('Amount type'),
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
            SizedBox(height: 24.h),
          ],
          StreamBuilder<String>(
            stream: CurrencySymbols.currencySymbolStream,
            builder: (context, snapshot) {
              final symbol = snapshot.data ?? '\$';
              final isPct = _selectedAmountType == AmountType.percentage &&
                  _selectedTriggerType != TriggerType.roundUp &&
                  _selectedTriggerType != TriggerType.scheduledExternal;
              final pctLabel =
                  _selectedTriggerType == TriggerType.externalInflow
                      ? 'Percentage of each inflow'
                      : 'Percentage of deposit';
              final label = _selectedTriggerType == TriggerType.roundUp
                  ? 'Per-fire cap ($symbol)'
                  : _selectedTriggerType == TriggerType.scheduledExternal
                      ? 'Amount to pull each time ($symbol)'
                      : (isPct ? pctLabel : 'Save amount ($symbol)');
              return _LabeledField(
                label: label,
                child: _TextInput(
                  controller: _amountController,
                  hint: isPct ? '10' : '50.00',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  onChanged: (_) {
                    if (_stepError != null) setState(() => _stepError = null);
                  },
                  trailing: isPct
                      ? Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Text(
                            '%',
                            style: GoogleFonts.inter(
                              color: _textMuted,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : null,
                ),
              );
            },
          ),
          if (_selectedTriggerType == TriggerType.roundUp) ...[
            SizedBox(height: 16.h),
            _PreviewCard(
              tint: _textMuted,
              icon: Icons.info_outline_rounded,
              title: 'Heads up',
              body:
                  'For round-up rules this is just a per-fire upper bound. '
                  'The actual save is the rounding delta you configured.',
            ),
          ],
        ],
      );
  }

  // ─── Step 5: Accounts ───────────────────────────────────────────

  Widget _stepAccounts() {
    if (_selectedTriggerType == TriggerType.externalInflow ||
        _selectedTriggerType == TriggerType.scheduledExternal) {
      return _stepAccountsExternalInflow();
    }
    return _StepBody(
      child: BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
        builder: (context, state) {
          if (state is AccountCardsSummaryLoaded) {
            final all = state.accountSummaries;
            if (all.isEmpty) {
              return _EmptyAccountsState(onClose: () => Get.back());
            }

            final dests = all.where((a) =>
                a.accountType.toLowerCase().contains('saving') ||
                a.accountType.toLowerCase().contains('money market')).toList();

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
                      ? 'You have no savings account yet. Pick any other account.'
                      : null,
                  child: _AccountDropdown(
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
              padding: EdgeInsets.symmetric(vertical: 60.h),
              child: LazerVaultLoader.tiny(),
            ),
          );
        },
      ),
    );
  }

  // ─── Step 5 (Bank Inflow): linked bank source + wallet destination ───

  bool _isMandateReady(LinkedBankAccount account) {
    final mandate = context.read<MandateCubit>().getMandateForAccount(account.id);
    return mandate != null &&
        (mandate.status == MandateStatus.readyToDebit ||
            mandate.status == MandateStatus.active);
  }

  Widget _stepAccountsExternalInflow() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle('Linked bank to watch'),
          SizedBox(height: 4.h),
          Text(
            'Saves are pulled from this bank via Direct Debit. Banks without a ready mandate show a setup action.',
            style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
          ),
          SizedBox(height: 12.h),
          BlocBuilder<OpenBankingCubit, OpenBankingState>(
            builder: (context, obState) {
              final accounts =
                  context.read<OpenBankingCubit>().linkedAccounts;
              if (obState is OpenBankingLoading && accounts.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: const Center(
                    child: LazerVaultLoader.tiny(),
                  ),
                );
              }
              if (accounts.isEmpty) {
                return Column(
                  children: [
                    _PreviewCard(
                      tint: _inflowTint,
                      icon: Icons.link_off_rounded,
                      title: 'No linked banks yet',
                      body:
                          'Link your bank to fund autosave by Direct Debit — no need to leave for the Deposit screen.',
                    ),
                    SizedBox(height: 12.h),
                    _linkBankButton(label: 'Link a bank'),
                  ],
                );
              }
              return BlocBuilder<MandateCubit, MandateState>(
                builder: (context, _) => Column(
                  children: [
                    for (final account in accounts) ...[
                      _LinkedBankRow(
                        account: account,
                        mandate: context
                            .read<MandateCubit>()
                            .getMandateForAccount(account.id),
                        selected: _selectedLinkedAccount?.id == account.id,
                        ready: _isMandateReady(account),
                        onTap: () => _onLinkedBankTapped(account),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    _linkBankButton(label: 'Link another bank'),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
            builder: (context, state) {
              if (state is! AccountCardsSummaryLoaded) {
                return const SizedBox.shrink();
              }
              final all = state.accountSummaries;
              final dests = all
                  .where((a) =>
                      a.accountType.toLowerCase().contains('saving') ||
                      a.accountType.toLowerCase().contains('money market'))
                  .toList();
              if (_selectedDestinationAccountId == null && dests.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  if (_selectedDestinationAccountId != null) return;
                  setState(() => _selectedDestinationAccountId =
                      dests.first.id.toString());
                });
              }
              return _LabeledField(
                label: 'Destination account',
                badge: dests.isEmpty ? null : 'Savings',
                help: dests.isEmpty
                    ? 'You have no savings account yet. Pick any other account.'
                    : 'Where each save lands inside Lazervault.',
                child: _AccountDropdown(
                  accounts: dests.isEmpty ? all : dests,
                  valueId: _selectedDestinationAccountId,
                  hint: 'Where the money lands',
                  onChanged: (v) => setState(() {
                    _selectedDestinationAccountId = v;
                    _stepError = null;
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Link a new bank in-flow — no more "go to Deposit to link". Same Mono link
  /// flow the deposit/analytics screens use. autoCreateMandate:true because
  /// autosave DEBITS the account; if the mandate can't be created (e.g. BVN not
  /// verified) the cubit surfaces it and the user finishes setup by tapping the
  /// bank row (management sheet). After linking we refresh accounts + mandates so
  /// the new bank appears here immediately.
  Future<void> _linkBankForAutosave() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    if (!MonoConfig.isEnabled) {
      setState(() => _stepError =
          'Bank linking is not available right now. Please try again later.');
      return;
    }
    final user = authState.profile.user;
    final customerName = '${user.firstName} ${user.lastName}'.trim();
    final proceed = await showBankConnectionFeeNotice(context);
    if (!proceed || !mounted) return;
    final txnId = 'link-${DateTime.now().millisecondsSinceEpoch}';
    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: user.email.isNotEmpty ? user.email : null,
      reference: 'lzv_autosave_${DateTime.now().millisecondsSinceEpoch}',
    );
    if (result == null || !mounted) return;
    final obc = context.read<OpenBankingCubit>();
    await obc.linkAccount(
      userId: user.id,
      code: result.code,
      accessToken: authState.profile.session.accessToken,
      setAsDefault: obc.linkedAccounts.isEmpty,
      transactionId: txnId,
      // autosave needs to debit the account → set up the Direct Debit mandate.
      autoCreateMandate: true,
      userEmail: user.email.isNotEmpty ? user.email : null,
      userName: customerName.isNotEmpty ? customerName : null,
      userPhone: user.phoneNumber,
    );
    if (!mounted) return;
    context.read<MandateCubit>().fetchUserMandates(userId: user.id);
  }

  /// The in-flow "Link a bank" CTA (replaces the old "go to Deposit" copy).
  Widget _linkBankButton({required String label}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _linkBankForAutosave,
        icon: Icon(Icons.add_link_rounded, size: 18.sp, color: _inflowTint),
        label: Text(label,
            style: TextStyle(
                color: _inflowTint,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          side: BorderSide(color: _inflowTint.withValues(alpha: 0.5)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }

  void _onLinkedBankTapped(LinkedBankAccount account) {
    if (_isMandateReady(account)) {
      setState(() {
        _selectedLinkedAccount = account;
        _stepError = null;
      });
      return;
    }
    // No ready mandate — open the same management sheet the Beam flow uses
    // so the user can set up / finish Direct Debit without leaving the wizard.
    final userId = context.read<AuthenticationCubit>().userId ?? '';
    final mandate =
        context.read<MandateCubit>().getMandateForAccount(account.id);
    showMandateManagementBottomSheet(
      context: context,
      linkedAccountId: account.id,
      userId: userId,
      bankName: account.bankName,
      accountName: account.accountName,
      mandate: mandate,
    ).then((_) {
      if (!mounted) return;
      // Refresh mandate state after the sheet closes; auto-select when the
      // mandate became ready while the sheet was open.
      context.read<MandateCubit>().fetchUserMandates(userId: userId);
      if (_isMandateReady(account)) {
        setState(() => _selectedLinkedAccount = account);
      } else {
        setState(() {});
      }
    });
  }

  // ─── Step 6: Limits ────────────────────────────────────────────

  Widget _stepLimits() {
    return _StepBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PreviewCard(
            tint: _textMuted,
            icon: Icons.tune_rounded,
            title: 'Optional',
            body:
                'Skip any field. The rule still works fine without these.',
          ),
          SizedBox(height: 18.h),
          _LabeledField(
            label: 'Target amount',
            optional: true,
            help: 'Auto-completes the rule once this much has been saved.',
            child: _TextInput(
              controller: _targetAmountController,
              hint: '1,000.00',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────

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
