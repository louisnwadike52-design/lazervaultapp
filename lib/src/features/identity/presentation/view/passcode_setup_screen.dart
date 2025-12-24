import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';
import 'package:lazervault/src/features/identity/presentation/widgets/pin_pad_widget.dart';

class PasscodeSetupScreen extends StatefulWidget {
  const PasscodeSetupScreen({Key? key}) : super(key: key);

  @override
  State<PasscodeSetupScreen> createState() => _PasscodeSetupScreenState();
}

class _PasscodeSetupScreenState extends State<PasscodeSetupScreen> {
  String _passcode = '';
  String _confirmPasscode = '';
  String _password = '';
  bool _isConfirming = false;
  final _passwordController = TextEditingController();

  void _onNumberPressed(String number) {
    setState(() {
      if (!_isConfirming) {
        if (_passcode.length < 6) {
          _passcode += number;
          if (_passcode.length == 6) {
            // Auto-advance to confirmation
            Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                _isConfirming = true;
              });
            });
          }
        }
      } else {
        if (_confirmPasscode.length < 6) {
          _confirmPasscode += number;
        }
      }
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (!_isConfirming) {
        if (_passcode.isNotEmpty) {
          _passcode = _passcode.substring(0, _passcode.length - 1);
        }
      } else {
        if (_confirmPasscode.isNotEmpty) {
          _confirmPasscode =
              _confirmPasscode.substring(0, _confirmPasscode.length - 1);
        }
      }
    });
  }

  void _onSubmit() {
    if (_passcode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a passcode')),
      );
      return;
    }

    if (_passcode.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passcode must be at least 4 digits')),
      );
      return;
    }

    if (_passcode != _confirmPasscode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passcodes do not match')),
      );
      setState(() {
        _confirmPasscode = '';
        _isConfirming = false;
      });
      return;
    }

    if (_password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your account password')),
      );
      return;
    }

    context.read<IdentityCubit>().setPasscode(
          passcode: _passcode,
          password: _password,
        );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Passcode'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: BlocConsumer<IdentityCubit, IdentityState>(
        listener: (context, state) {
          if (state is PasscodeSet) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pop(context);
          } else if (state is IdentityError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is IdentityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Text(
                  _isConfirming ? 'Confirm Your Passcode' : 'Create a Passcode',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isConfirming
                      ? 'Re-enter your passcode'
                      : '4-6 digit passcode for quick access',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 48),

                // Passcode Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final currentPasscode =
                        _isConfirming ? _confirmPasscode : _passcode;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < currentPasscode.length
                            ? Colors.purple.shade700
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 48),

                // PIN Pad
                PinPadWidget(
                  onNumberPressed: _onNumberPressed,
                  onDeletePressed: _onDeletePressed,
                ),
                const SizedBox(height: 32),

                // Password Field (only show when ready to submit)
                if (_isConfirming && _confirmPasscode.length == 6) ...[
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Account Password',
                      hintText: 'Enter your account password to confirm',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Set Passcode',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
