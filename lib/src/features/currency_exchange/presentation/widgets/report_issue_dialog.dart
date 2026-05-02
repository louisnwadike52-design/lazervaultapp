import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';

import '../../data/services/report_issue_service.dart';
import '../../domain/entities/transaction_entity.dart';

/// Dialog for submitting a support report against a failed or refunded
/// (cancelled) exchange transaction. Four states: idle → submitting →
/// success → error. Errors are retryable; success auto-dismisses after a
/// brief confirmation.
class ReportIssueDialog extends StatefulWidget {
  final CurrencyTransaction transaction;

  const ReportIssueDialog({super.key, required this.transaction});

  /// Convenience launcher — call from the bottom-sheet onTap.
  static Future<void> show(
    BuildContext context,
    CurrencyTransaction tx,
  ) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => ReportIssueDialog(transaction: tx),
    );
  }

  @override
  State<ReportIssueDialog> createState() => _ReportIssueDialogState();
}

enum _SubmitState { idle, submitting, success, error }

class _ReportIssueDialogState extends State<ReportIssueDialog> {
  final _controller = TextEditingController();
  final _service = serviceLocator<ReportIssueService>();
  _SubmitState _state = _SubmitState.idle;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final msg = _controller.text.trim();
    if (msg.isEmpty) {
      setState(() {
        _state = _SubmitState.error;
        _errorMessage = 'Please describe the issue before submitting.';
      });
      return;
    }
    setState(() {
      _state = _SubmitState.submitting;
      _errorMessage = null;
    });
    final result = await _service.submit(
      message: msg,
      transactionId: widget.transaction.id,
      transactionReference: widget.transaction.referenceNumber,
    );
    if (!mounted) return;
    if (result.ok) {
      setState(() => _state = _SubmitState.success);
      // Auto-dismiss after showing the confirmation for a beat.
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (mounted) Navigator.of(context).maybePop();
      });
    } else {
      setState(() {
        _state = _SubmitState.error;
        _errorMessage = result.errorMessage ?? 'Submission failed.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reference = widget.transaction.referenceNumber ??
        widget.transaction.id;

    return Dialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.support_agent,
                    color: _state == _SubmitState.success
                        ? const Color(0xFF10B981)
                        : const Color(0xFFFB923C),
                    size: 22),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Report Issue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _state == _SubmitState.submitting
                      ? null
                      : () => Get.back(),
                  icon: const Icon(Icons.close,
                      color: Color(0xFF9CA3AF), size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Reference: $reference',
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 16),
            if (_state == _SubmitState.success)
              _buildSuccess()
            else ...[
              _buildForm(),
              if (_state == _SubmitState.error && _errorMessage != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: Color(0xFFEF4444), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Color(0xFFEF4444),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),
              _buildActionRow(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What went wrong? Our team will follow up via in-app support.',
          style: TextStyle(color: Color(0xFFE5E7EB), fontSize: 13),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controller,
          enabled: _state != _SubmitState.submitting,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          maxLines: 5,
          minLines: 3,
          maxLength: 2000,
          decoration: InputDecoration(
            hintText: 'Describe the issue in your own words…',
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            counterStyle: const TextStyle(color: Color(0xFF6B7280)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFFB923C)),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow() {
    final submitting = _state == _SubmitState.submitting;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: submitting ? null : () => Get.back(),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF9CA3AF),
          ),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 4),
        ElevatedButton(
          onPressed: submitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFB923C),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
        ),
      ],
    );
  }

  Widget _buildSuccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Report submitted',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Our team will review your report and follow up via in-app support. '
          'You can check back any time — the transaction reference is saved '
          'with your report.',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
        ),
      ],
    );
  }
}
