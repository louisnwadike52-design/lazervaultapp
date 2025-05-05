import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDetails extends StatefulWidget {
  final bool isNewCard;
  const CardDetails({super.key, this.isNewCard = false});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  void _toggleCardDetailsVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.isNewCard
          ? EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w)
          : EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: AssetImage('assets/images/card_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/visa.png',
                width: 50, // Set a fixed width and height
                height: 30,
                fit: BoxFit.contain,
              ),
              Image.asset(
                'assets/images/card_chip.png',
                width: 30,
                height: 20,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 16),
          widget.isNewCard
              ? Text("-----------------------------------------",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return Text(
                        _isObscured
                            ? '**** **** **** 1234'
                            : '1234 5678 9012 3456',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }),
                    Text(
                      '05/23',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 16),
          widget.isNewCard
              ? Text("------------",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Balance",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$5,044.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _toggleCardDetailsVisibility,
                      icon: _isObscured
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.white,
                            )
                          : const Icon(Icons.visibility_off,
                              color: Colors.white),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
