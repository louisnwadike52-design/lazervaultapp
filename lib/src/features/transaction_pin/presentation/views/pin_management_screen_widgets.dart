part of 'pin_management_screen.dart';

enum _PinStage {
  loading,
  enterCurrent,
  enterNew,
  confirmNew,
  submitting,
  success,
}

class _StageBreadcrumb extends StatelessWidget {
  final _PinStage stage;
  final bool hasExistingPin;

  const _StageBreadcrumb({required this.stage, required this.hasExistingPin});

  @override
  Widget build(BuildContext context) {
    final steps = hasExistingPin
        ? const [_PinStage.enterCurrent, _PinStage.enterNew, _PinStage.confirmNew]
        : const [_PinStage.enterNew, _PinStage.confirmNew];

    int currentIdx = steps.indexOf(stage);
    if (currentIdx == -1) {
      // Submitting or success — peg to the last step.
      currentIdx = steps.length - 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final filled = i <= currentIdx;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 28.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: filled
                ? const Color(0xFF3B82F6)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      }),
    );
  }
}

class _PinDots extends StatelessWidget {
  final int length;
  final int filled;
  final bool isError;

  const _PinDots({
    required this.length,
    required this.filled,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final isOn = i < filled;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isError
                ? const Color(0xFFEF4444).withValues(alpha: 0.85)
                : isOn
                    ? const Color(0xFF3B82F6)
                    : Colors.white.withValues(alpha: 0.18),
            border: Border.all(
              color: isError
                  ? const Color(0xFFEF4444)
                  : Colors.white.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
        );
      }),
    );
  }
}

class _Keypad extends StatelessWidget {
  final void Function(String) onKey;
  final VoidCallback onBackspace;
  final bool disabled;

  const _Keypad({
    required this.onKey,
    required this.onBackspace,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    final keys = const [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '⌫'],
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 320.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: keys.map((row) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((k) {
                if (k.isEmpty) {
                  return SizedBox(width: 72.w, height: 56.h);
                }
                if (k == '⌫') {
                  return _KeypadKey(
                    onTap: disabled ? null : onBackspace,
                    child: const Icon(Icons.backspace_outlined,
                        color: Colors.white, size: 22),
                  );
                }
                return _KeypadKey(
                  onTap: disabled ? null : () => onKey(k),
                  child: Text(
                    k,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _KeypadKey extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const _KeypadKey({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 72.w,
          height: 56.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: onTap == null ? 0.04 : 0.08),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
