import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/change_passcode_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChangePasscodeScreen extends StatefulWidget {
  const ChangePasscodeScreen({super.key});

  @override
  State<ChangePasscodeScreen> createState() => _ChangePasscodeScreenState();
}

class _ChangePasscodeScreenState extends State<ChangePasscodeScreen> {
  final int _passcodeLength = 6;
  final _storage = serviceLocator<FlutterSecureStorage>();

  String _currentPasscode = '';
  String _newPasscode = '';
  String _confirmPasscode = '';

  int _step = 1; // 1: current, 2: new, 3: confirm
  bool _isLoading = false;
  String _errorMessage = '';

  String get _displayPasscode {
    if (_step == 1) return _currentPasscode;
    if (_step == 2) return _newPasscode;
    return _confirmPasscode;
  }

  String get _stepTitle {
    if (_step == 1) return 'Enter Current Passcode';
    if (_step == 2) return 'Enter New Passcode';
    return 'Confirm New Passcode';
  }

  void _onNumberPressed(String number) {
    setState(() {
      _errorMessage = '';
      if (_step == 1 && _currentPasscode.length < _passcodeLength) {
        _currentPasscode += number;
        if (_currentPasscode.length == _passcodeLength) {
          _step = 2;
        }
      } else if (_step == 2 && _newPasscode.length < _passcodeLength) {
        _newPasscode += number;
        if (_newPasscode.length == _passcodeLength) {
          _step = 3;
        }
      } else if (_step == 3 && _confirmPasscode.length < _passcodeLength) {
        _confirmPasscode += number;
        if (_confirmPasscode.length == _passcodeLength) {
          _submitPasscodeChange();
        }
      }
    });
  }

  void _onBackspacePressed() {
    setState(() {
      _errorMessage = '';
      if (_step == 1 && _currentPasscode.isNotEmpty) {
        _currentPasscode = _currentPasscode.substring(0, _currentPasscode.length - 1);
      } else if (_step == 2 && _newPasscode.isNotEmpty) {
        _newPasscode = _newPasscode.substring(0, _newPasscode.length - 1);
      } else if (_step == 3 && _confirmPasscode.isNotEmpty) {
        _confirmPasscode = _confirmPasscode.substring(0, _confirmPasscode.length - 1);
      } else if (_step == 2 && _newPasscode.isEmpty) {
        _step = 1;
      } else if (_step == 3 && _confirmPasscode.isEmpty) {
        _step = 2;
      }
    });
  }

  Future<void> _submitPasscodeChange() async {
    if (_newPasscode != _confirmPasscode) {
      setState(() {
        _errorMessage = 'Passcodes do not match';
        _confirmPasscode = '';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final changePasscodeUseCase = serviceLocator<ChangePasscodeUseCase>();
      final result = await changePasscodeUseCase(
        oldPasscode: _currentPasscode,
        newPasscode: _newPasscode,
      );

      result.fold(
        (failure) {
          setState(() {
            _errorMessage = failure.message;
            _isLoading = false;
            _currentPasscode = '';
            _newPasscode = '';
            _confirmPasscode = '';
            _step = 1;
          });
        },
        (_) async {
          // Update stored passcode
          await _storage.write(key: 'login_passcode', value: _newPasscode);

          setState(() {
            _isLoading = false;
          });

          if (!mounted) return;

          // Show success message and go back
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passcode changed successfully'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _isLoading = false;
        _currentPasscode = '';
        _newPasscode = '';
        _confirmPasscode = '';
        _step = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Change Passcode',
          style: textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _stepTitle,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // Passcode dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _passcodeLength,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            width: 16.w,
                            height: 16.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index < _displayPasscode.length
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),

                      if (_errorMessage.isNotEmpty) ...[
                        SizedBox(height: 20.h),
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Number pad
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Column(
                    children: [
                      // Numbers 1-3
                      _buildNumberRow(['1', '2', '3']),
                      SizedBox(height: 20.h),
                      // Numbers 4-6
                      _buildNumberRow(['4', '5', '6']),
                      SizedBox(height: 20.h),
                      // Numbers 7-9
                      _buildNumberRow(['7', '8', '9']),
                      SizedBox(height: 20.h),
                      // 0 and backspace
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 70.w),
                          _buildNumberButton('0'),
                          _buildBackspaceButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) => _buildNumberButton(number)).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => _onNumberPressed(number),
      borderRadius: BorderRadius.circular(35.r),
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return InkWell(
      onTap: _onBackspacePressed,
      borderRadius: BorderRadius.circular(35.r),
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 24.sp,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
