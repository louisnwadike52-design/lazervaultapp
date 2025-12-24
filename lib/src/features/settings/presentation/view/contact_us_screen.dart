import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/src/features/support/domain/repositories/i_support_repository.dart';
import 'package:lazervault/core/services/injection_container.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedTopic = 'General Inquiry';
  bool _isSubmitting = false;

  late final ISupportRepository _supportRepository;

  @override
  void initState() {
    super.initState();
    _supportRepository = serviceLocator<ISupportRepository>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url', style: GoogleFonts.inter()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _launchEmail(String email) async {
    await _launchURL('mailto:$email');
  }

  Future<void> _launchPhone(String phone) async {
    await _launchURL('tel:$phone');
  }

  Future<void> _launchMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    await _launchURL('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Contact Us',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4E03D0),
                    Color(0xFF7C3AED),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.mail_outline,
                    size: 56.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Get in Touch',
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'We\'d love to hear from you. Send us a message and we\'ll respond as soon as possible.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Contact Methods
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildContactCard(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    subtitle: 'support@lazervault.com',
                    color: Color(0xFF3784F9),
                    onTap: () => _launchEmail('support@lazervault.com'),
                  ),
                  SizedBox(height: 12.h),
                  _buildContactCard(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    subtitle: '+1 (555) 123-4567',
                    color: Color(0xFF10B981),
                    onTap: () => _launchPhone('+15551234567'),
                  ),
                  SizedBox(height: 12.h),
                  _buildContactCard(
                    icon: Icons.location_on_outlined,
                    title: 'Office',
                    subtitle: '123 Financial District, San Francisco, CA 94105',
                    color: Color(0xFFFF7465),
                    onTap: () => _launchMaps('123 Financial District, San Francisco, CA 94105'),
                  ),
                  SizedBox(height: 12.h),
                  _buildContactCard(
                    icon: Icons.access_time,
                    title: 'Business Hours',
                    subtitle: 'Monday - Friday: 9:00 AM - 6:00 PM EST',
                    color: Color(0xFF9937FC),
                    onTap: null,
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Social Media
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Follow Us',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      _buildSocialButton(
                        icon: Icons.facebook,
                        label: 'Facebook',
                        color: Color(0xFF1877F2),
                        onTap: () => _launchURL('https://facebook.com/lazervault'),
                      ),
                      SizedBox(width: 12.w),
                      _buildSocialButton(
                        icon: Icons.camera_alt,
                        label: 'Instagram',
                        color: Color(0xFFE4405F),
                        onTap: () => _launchURL('https://instagram.com/lazervault'),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      _buildSocialButton(
                        label: 'Twitter',
                        color: Color(0xFF1DA1F2),
                        onTap: () => _launchURL('https://twitter.com/lazervault'),
                      ),
                      SizedBox(width: 12.w),
                      _buildSocialButton(
                        label: 'LinkedIn',
                        color: Color(0xFF0A66C2),
                        onTap: () => _launchURL('https://linkedin.com/company/lazervault'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Contact Form
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Send us a Message',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Field
                        _buildLabel('Full Name'),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _nameController,
                          decoration: _buildInputDecoration('John Doe'),
                          style: GoogleFonts.inter(fontSize: 14.sp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Email Field
                        _buildLabel('Email Address'),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration('john@example.com'),
                          style: GoogleFonts.inter(fontSize: 14.sp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Topic Dropdown
                        _buildLabel('Topic'),
                        SizedBox(height: 8.h),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedTopic,
                          decoration: _buildInputDecoration('Select a topic'),
                          items: [
                            'General Inquiry',
                            'Account Support',
                            'Transaction Issue',
                            'Technical Problem',
                            'Security Concern',
                            'Partnership Opportunity',
                            'Feedback',
                            'Other',
                          ].map((topic) {
                            return DropdownMenuItem(
                              value: topic,
                              child: Text(
                                topic,
                                style: GoogleFonts.inter(fontSize: 14.sp),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedTopic = value!;
                            });
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Subject Field
                        _buildLabel('Subject'),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _subjectController,
                          decoration: _buildInputDecoration('Brief subject line'),
                          style: GoogleFonts.inter(fontSize: 14.sp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a subject';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),

                        // Message Field
                        _buildLabel('Message'),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 6,
                          decoration: _buildInputDecoration(
                            'Type your message here...',
                          ),
                          style: GoogleFonts.inter(fontSize: 14.sp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a message';
                            }
                            if (value.length < 10) {
                              return 'Message must be at least 10 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 48.h,
                          child: ElevatedButton(
                            onPressed: _isSubmitting ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4E03D0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: _isSubmitting
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Send Message',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Office Locations
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Locations',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildLocationCard(
                    city: 'San Francisco (HQ)',
                    address: '123 Financial District',
                    cityState: 'San Francisco, CA 94105',
                    phone: '+1 (555) 123-4567',
                  ),
                  SizedBox(height: 12.h),
                  _buildLocationCard(
                    city: 'New York',
                    address: '456 Wall Street',
                    cityState: 'New York, NY 10005',
                    phone: '+1 (555) 987-6543',
                  ),
                  SizedBox(height: 12.h),
                  _buildLocationCard(
                    city: 'London',
                    address: '789 Canary Wharf',
                    cityState: 'London, UK E14 5AB',
                    phone: '+44 20 1234 5678',
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: color,
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
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.chevron_right,
                color: Color(0xFF9CA3AF),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: color,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
              ],
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        color: Color(0xFF9CA3AF),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Color(0xFF4E03D0), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Color(0xFFEF4444)),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 14.h,
      ),
    );
  }

  Widget _buildLocationCard({
    required String city,
    required String address,
    required String cityState,
    required String phone,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: Color(0xFF6B7280),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '$address\n$cityState',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 16.sp,
                color: Color(0xFF6B7280),
              ),
              SizedBox(width: 8.w),
              Text(
                phone,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final result = await _supportRepository.submitContactForm(
        name: _nameController.text,
        email: _emailController.text,
        topic: _selectedTopic,
        subject: _subjectController.text,
        message: _messageController.text,
      );

      setState(() {
        _isSubmitting = false;
      });

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  failure.message,
                  style: GoogleFonts.inter(),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        (contactMessage) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Thank you! Your message has been sent. We\'ll get back to you soon.',
                  style: GoogleFonts.inter(),
                ),
                backgroundColor: Color(0xFF10B981),
                duration: Duration(seconds: 3),
              ),
            );

            // Clear form
            _nameController.clear();
            _emailController.clear();
            _subjectController.clear();
            _messageController.clear();
            setState(() {
              _selectedTopic = 'General Inquiry';
            });
          }
        },
      );
    }
  }
}
