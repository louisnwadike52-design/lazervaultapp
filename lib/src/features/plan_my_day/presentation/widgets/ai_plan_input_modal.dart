import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/microservice_chat/data/datasources/http_direct_chat_datasource.dart';

/// AI "Plan My Day" input modal.
///
/// A focused, one-shot alternative to the conversational chat sheet: the user
/// describes their day in plain language ("gym at 7, finish the deck by noon,
/// call the bank at 3") and the Plan My Day AI agent turns it into board tasks,
/// events and time blocks. On success we refresh the board via [onPlanCreated].
///
/// Under the hood it sends ONE message to the planning agent through the direct
/// chat proxy (source_context 'planning'); the agent's `plan_my_day` tool does
/// the natural-language → structured-plan → create work server-side.
class AiPlanInputModal extends StatefulWidget {
  /// The date the board is currently showing — passed to the agent as context
  /// so items land on the right day.
  final DateTime selectedDate;

  /// Called after the agent reports success, so the caller can reload the board.
  final VoidCallback onPlanCreated;

  const AiPlanInputModal({
    super.key,
    required this.selectedDate,
    required this.onPlanCreated,
  });

  static Future<void> show(
    BuildContext context, {
    required DateTime selectedDate,
    required VoidCallback onPlanCreated,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AiPlanInputModal(
        selectedDate: selectedDate,
        onPlanCreated: onPlanCreated,
      ),
    );
  }

  @override
  State<AiPlanInputModal> createState() => _AiPlanInputModalState();
}

enum _Phase { input, loading, done, error }

class _AiPlanInputModalState extends State<AiPlanInputModal> {
  final TextEditingController _controller = TextEditingController();
  _Phase _phase = _Phase.input;
  String _resultMessage = '';

  static const _accent = Color(0xFF8B5CF6);

  static const _examples = [
    'Gym at 7am, finish the deck by noon, call the bank at 3pm',
    'Deep work 9–11, standup at 11:30, groceries after work',
    'Dentist 2pm, review PRs, plan next week',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Render the agent's reply as clean, user-friendly plain text. The model is
  /// told to avoid markdown, but strip it defensively so stray **bold**, `code`,
  /// # headings or "- " bullets never leak into the bubble as literal symbols.
  String _cleanMessage(String s) {
    var t = s
        .replaceAllMapped(RegExp(r'\*\*(.+?)\*\*'), (m) => m[1]!)
        .replaceAllMapped(RegExp(r'__(.+?)__'), (m) => m[1]!)
        .replaceAllMapped(RegExp(r'(?<!\*)\*(?!\s)(.+?)(?<!\s)\*(?!\*)'),
            (m) => m[1]!)
        .replaceAll('`', '')
        .replaceAll(RegExp(r'^\s{0,3}#{1,6}\s*', multiLine: true), '')
        .replaceAll(RegExp(r'^\s*[-*]\s+', multiLine: true), '• ');
    // Collapse any runs of 3+ newlines the model may have added.
    t = t.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    return t.trim();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    FocusScope.of(context).unfocus();
    HapticFeedback.lightImpact();
    setState(() => _phase = _Phase.loading);

    try {
      final dateStr =
          '${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}';
      final dataSource = HttpDirectChatDataSource(
        dio: Dio(),
        callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        baseUrl: endpointRegistry.httpChatAgent,
      );
      final resp = await dataSource.processDirectChat(
        DirectChatRequest(
          message: 'Plan my day for $dateStr: $text',
          sessionId: 'plan-${DateTime.now().millisecondsSinceEpoch}',
          userId: '',
          accessToken: '',
          sourceContext: 'planning',
        ),
      );

      if (!mounted) return;
      final clean = _cleanMessage(resp.response.trim());
      setState(() {
        _resultMessage =
            clean.isEmpty ? 'Your plan has been added to the board.' : clean;
        _phase = _Phase.done;
      });
      // Refresh the board so the newly-created items appear.
      widget.onPlanCreated();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _resultMessage =
            'Could not build your plan right now. Please try again.';
        _phase = _Phase.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: const Icon(Icons.auto_awesome, color: _accent, size: 22),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI plan my day',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Describe your day — I\'ll build your board',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[500]),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            switch (_phase) {
              _Phase.input => _buildInput(),
              _Phase.loading => _buildLoading(),
              _Phase.done => _buildResult(success: true),
              _Phase.error => _buildResult(success: false),
            },
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          maxLines: 4,
          minLines: 3,
          textInputAction: TextInputAction.newline,
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
          decoration: InputDecoration(
            hintText:
                'e.g. gym at 7, finish the deck by noon, call the bank at 3pm',
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            filled: true,
            fillColor: const Color(0xFF2D2D2D),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: _accent),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _examples
              .map((e) => GestureDetector(
                    onTap: () => setState(() {
                      _controller.text = e;
                      _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: e.length),
                      );
                    }),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                            color: _accent.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        e.length > 26 ? '${e.substring(0, 25)}…' : e,
                        style:
                            TextStyle(color: Colors.grey[300], fontSize: 11.sp),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: const Text('Create my plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _accent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(_accent),
          ),
          SizedBox(height: 20.h),
          Text(
            'Building your board…',
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            'Turning your day into tasks, events and time blocks',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildResult({required bool success}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error_outline,
                color: success ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                size: 20,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  _resultMessage,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            if (!success)
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _phase = _Phase.input),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: _accent),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: const Text('Try again'),
                ),
              ),
            if (!success) SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(success ? 'View my board' : 'Close'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
