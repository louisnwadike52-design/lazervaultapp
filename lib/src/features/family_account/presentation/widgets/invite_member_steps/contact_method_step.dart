import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Step 1: Contact Method Selection
/// - Card-based selection: Email / Phone / Username
/// - Dynamic input field based on selection
/// - Validation per method type
class ContactMethodStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onNext;

  const ContactMethodStep({
    super.key,
    required this.formData,
    required this.onNext,
  });

  @override
  State<ContactMethodStep> createState() => _ContactMethodStepState();
}

class _ContactMethodStepState extends State<ContactMethodStep> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedMethod;
  late TextEditingController _destinationController;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.formData['invitationMethod'] as String? ?? 'email';
    _destinationController = TextEditingController(
      text: widget.formData['invitationDestination'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  void _submitStep() {
    if (_formKey.currentState!.validate()) {
      widget.onNext({
        'invitationMethod': _selectedMethod,
        'invitationDestination': _destinationController.text.trim(),
      });
    }
  }

  String _getInputLabel() {
    switch (_selectedMethod) {
      case 'email':
        return 'Email Address';
      case 'phone':
        return 'Phone Number';
      case 'username':
        return 'Username';
      default:
        return 'Contact Info';
    }
  }

  String _getInputHint() {
    switch (_selectedMethod) {
      case 'email':
        return 'Enter email address';
      case 'phone':
        return 'Enter phone number';
      case 'username':
        return 'Enter username (e.g., @johndoe)';
      default:
        return 'Enter contact info';
    }
  }

  TextInputType _getKeyboardType() {
    switch (_selectedMethod) {
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'username':
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }

  String? _validateInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter ${_getInputLabel().toLowerCase()}';
    }

    switch (_selectedMethod) {
      case 'email':
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        break;
      case 'phone':
        final phoneRegex = RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');
        if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
          return 'Please enter a valid phone number';
        }
        break;
      case 'username':
        if (value.length < 3) {
          return 'Username must be at least 3 characters';
        }
        break;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'How would you like to\ninvite this member?',
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose how to send the invitation',
              style: TextStyle(
                color: const Color(0xFF666666),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 32.h),

            // Contact Method Cards
            _buildMethodCard(
              method: 'email',
              icon: Icons.email_outlined,
              title: 'Email',
              description: 'Send invitation via email',
            ),
            SizedBox(height: 12.h),
            _buildMethodCard(
              method: 'phone',
              icon: Icons.phone_outlined,
              title: 'Phone',
              description: 'Send invitation via SMS',
            ),
            SizedBox(height: 12.h),
            _buildMethodCard(
              method: 'username',
              icon: Icons.alternate_email,
              title: 'Username',
              description: 'Invite an existing user',
            ),
            SizedBox(height: 32.h),

            // Input Field
            Text(
              _getInputLabel(),
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: _destinationController,
              keyboardType: _getKeyboardType(),
              style: TextStyle(
                color: const Color(0xFF1E1E2E),
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: _getInputHint(),
                hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  _selectedMethod == 'email'
                      ? Icons.email_outlined
                      : _selectedMethod == 'phone'
                          ? Icons.phone_outlined
                          : Icons.alternate_email,
                  color: const Color(0xFF6C5CE7),
                  size: 20.sp,
                ),
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF6C5CE7),
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              validator: _validateInput,
            ),
            SizedBox(height: 40.h),

            // Continue Button
            _buildContinueButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodCard({
    required String method,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
          _destinationController.clear();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C5CE7).withValues(alpha: 0.08)
              : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C5CE7)
                : const Color(0xFFE0E0E0),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6C5CE7).withValues(alpha: 0.15)
                    : const Color(0xFFE0E0E0).withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF6C5CE7)
                    : const Color(0xFF888888),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF6C5CE7)
                          : const Color(0xFF1E1E2E),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: const Color(0xFF888888),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24.w,
                height: 24.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF6C5CE7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.sp,
                ),
              )
            else
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _submitStep,
          borderRadius: BorderRadius.circular(28.r),
          child: Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
