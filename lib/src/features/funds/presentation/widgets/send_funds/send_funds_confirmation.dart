import 'package:flutter/material.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:get/get.dart';

class SendFundsConfirmation extends StatefulWidget {
  final double amount = 0.00  ;
  final String senderCard = '****4321';
  final String recipientBank = 'Bank Account';
  final User recipient; 

  const SendFundsConfirmation({
    super.key,
    required this.recipient,
  });

  @override
  State<SendFundsConfirmation> createState() => _SendFundsConfirmationState();
}

class _SendFundsConfirmationState extends State<SendFundsConfirmation> with SingleTickerProviderStateMixin {
  late final double amount;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _starScaleAnimation;

  @override
  void initState() {
    super.initState();
    // Get the arguments from GetX
    final Map<String, dynamic> args = Get.arguments;
    amount = args['amount'] ?? 0.00;
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.6, curve: Curves.easeIn),
      ),
    );

    _starScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("hello");
    // return Container(
    //   color: Colors.transparent,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       // Success Icon and Stars
    //       AnimatedBuilder(
    //         animation: _controller,
    //         builder: (context, child) {
    //           return Transform.scale(
    //             scale: _scaleAnimation.value,
    //             child: Container(
    //               width: 120.w,
    //               height: 120.w,
    //               child: Stack(
    //                 alignment: Alignment.center,
    //                 children: [
    //                   // Main Circle
    //                   Container(
    //                     width: 100.w,
    //                     height: 100.w,
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       color: Color(0xFF6C3CE9).withOpacity(0.15),
    //                       border: Border.all(
    //                         color: Color(0xFF6C3CE9).withOpacity(0.3),
    //                         width: 2,
    //                       ),
    //                     ),
    //                     child: Icon(
    //                       Icons.swap_horiz_rounded,
    //                       color: Colors.white,
    //                       size: 40.w,
    //                     ),
    //                   ),
    //                   // Animated Stars
    //                   ...List.generate(8, (index) {
    //                     final angle = (index * 45) * (pi / 180);
    //                     final radius = 70.w;
    //                     return Positioned(
    //                       left: 60.w + (cos(angle) * radius),
    //                       top: 60.w + (sin(angle) * radius),
    //                       child: Transform.scale(
    //                         scale: _starScaleAnimation.value,
    //                         child: Icon(
    //                           Icons.star,
    //                           color: Color(0xFFFFD700).withOpacity(0.7),
    //                           size: 14,
    //                         ),
    //                       ),
    //                     );
    //                   }),
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //       SizedBox(height: 32.h),

    //       // Success Text
    //       FadeTransition(
    //         opacity: _opacityAnimation,
    //         child: Column(
    //           children: [
    //             Text(
    //               'Transfer Successful',
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 24.sp,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             SizedBox(height: 12.h),
    //             Text(
    //               'Transfers are reviewed which may\nresult in delays or funds being\nfrozen',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 color: Colors.white.withOpacity(0.6),
    //                 fontSize: 14.sp,
    //                 height: 1.5,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 32.h),

    //       // Amount Container
    //       FadeTransition(
    //         opacity: _opacityAnimation,
    //         child: Container(
    //           padding: EdgeInsets.symmetric(
    //             horizontal: 24.w,
    //             vertical: 12.h,
    //           ),
    //           decoration: BoxDecoration(
    //             color: Colors.white.withOpacity(0.1),
    //             borderRadius: BorderRadius.circular(16),
    //             border: Border.all(
    //               color: Colors.white.withOpacity(0.1),
    //             ),
    //           ),
    //           child: Text(
    //             '\$${amount.toStringAsFixed(2)}',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 24.sp,
    //               fontWeight: FontWeight.w600,
    //             ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 48.h),

    //       // Back to Home Button
    //       FadeTransition(
    //         opacity: _opacityAnimation,
    //         child: Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(horizontal: 24.w),
    //           child: ElevatedButton(
    //             onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: Color(0xFF1ED69E).withOpacity(0.9),
    //               padding: EdgeInsets.symmetric(vertical: 16.h),
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(12),
    //               ),
    //               elevation: 4,
    //             ),
    //             child: Text(
    //               'Back to Home',
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 16.sp,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}     