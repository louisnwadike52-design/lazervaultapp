import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import 'crowdfund_details_screen.dart';

class CreateCrowdfundScreen extends StatefulWidget {
  const CreateCrowdfundScreen({super.key});

  @override
  State<CreateCrowdfundScreen> createState() => _CreateCrowdfundScreenState();
}

class _CreateCrowdfundScreenState extends State<CreateCrowdfundScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _storyController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _selectedCurrency = 'GBP';
  String _selectedCategory = 'Medical';
  CrowdfundVisibility _selectedVisibility = CrowdfundVisibility.public;
  DateTime? _selectedDeadline;

  final List<String> _categories = [
    'Medical',
    'Education',
    'Emergency',
    'Community',
    'Creative',
    'Business',
    'Other',
  ];

  final List<String> _currencies = ['GBP', 'USD', 'EUR'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _storyController.dispose();
    _targetAmountController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _createCrowdfund() {
    if (_formKey.currentState!.validate()) {
      context.read<CrowdfundCubit>().createCrowdfund(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            story: _storyController.text.trim(),
            targetAmount: double.parse(_targetAmountController.text.trim()),
            currency: _selectedCurrency,
            deadline: _selectedDeadline,
            category: _selectedCategory,
            imageUrl: _imageUrlController.text.trim().isEmpty
                ? null
                : _imageUrlController.text.trim(),
            visibility: _selectedVisibility,
          );
    }
  }

  Future<void> _selectDeadline() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF4E03D0),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Crowdfund',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<CrowdfundCubit, CrowdfundState>(
        listener: (context, state) {
          if (state is CrowdfundCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Crowdfund created successfully!'),
                backgroundColor: Color(0xFF10B981),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CrowdfundDetailsScreen(
                  crowdfundId: state.crowdfund.id,
                ),
              ),
            );
          } else if (state is CrowdfundError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CrowdfundLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Basic Information'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Enter crowdfund title',
                    maxLength: 255,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      if (value.trim().length < 10) {
                        return 'Title must be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Brief description of your crowdfund',
                    maxLines: 3,
                    maxLength: 500,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      if (value.trim().length < 20) {
                        return 'Description must be at least 20 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    controller: _storyController,
                    label: 'Story (Optional)',
                    hint: 'Tell your story...',
                    maxLines: 5,
                    maxLength: 2000,
                  ),
                  SizedBox(height: 24.h),
                  _buildSectionTitle('Funding Details'),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildTextField(
                          controller: _targetAmountController,
                          label: 'Target Amount',
                          hint: '1000.00',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter target amount';
                            }
                            final amount = double.tryParse(value.trim());
                            if (amount == null || amount <= 0) {
                              return 'Invalid amount';
                            }
                            if (amount < 10) {
                              return 'Minimum amount is 10';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildDropdown(
                          label: 'Currency',
                          value: _selectedCurrency,
                          items: _currencies,
                          onChanged: (value) {
                            setState(() {
                              _selectedCurrency = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildDropdown(
                    label: 'Category',
                    value: _selectedCategory,
                    items: _categories,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildDeadlineSelector(),
                  SizedBox(height: 24.h),
                  _buildSectionTitle('Settings'),
                  SizedBox(height: 12.h),
                  _buildTextField(
                    controller: _imageUrlController,
                    label: 'Image URL (Optional)',
                    hint: 'https://example.com/image.jpg',
                  ),
                  SizedBox(height: 16.h),
                  _buildVisibilitySelector(),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _createCrowdfund,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        disabledBackgroundColor:
                            const Color(0xFF4E03D0).withOpacity(0.5),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Create Crowdfund',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF4E03D0),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFFEF4444),
                width: 2,
              ),
            ),
            counterStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
          dropdownColor: const Color(0xFF1F1F1F),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF4E03D0),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeadlineSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deadline (Optional)',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: _selectDeadline,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDeadline != null
                      ? '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year}'
                      : 'Select deadline',
                  style: TextStyle(
                    color: _selectedDeadline != null
                        ? Colors.white
                        : Colors.grey[600],
                    fontSize: 14.sp,
                  ),
                ),
                Row(
                  children: [
                    if (_selectedDeadline != null)
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[500],
                          size: 20.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedDeadline = null;
                          });
                        },
                      ),
                    Icon(
                      Icons.calendar_today,
                      color: const Color(0xFF4E03D0),
                      size: 20.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisibilitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        ...CrowdfundVisibility.values.map((visibility) {
          return RadioListTile<CrowdfundVisibility>(
            value: visibility,
            groupValue: _selectedVisibility,
            onChanged: (value) {
              setState(() {
                _selectedVisibility = value!;
              });
            },
            title: Text(
              _getVisibilityLabel(visibility),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
            subtitle: Text(
              _getVisibilityDescription(visibility),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
            activeColor: const Color(0xFF4E03D0),
            tileColor: const Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(
                color: _selectedVisibility == visibility
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF2D2D2D),
              ),
            ),
          );
        }),
      ],
    );
  }

  String _getVisibilityLabel(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return 'Public';
      case CrowdfundVisibility.private:
        return 'Private';
      case CrowdfundVisibility.unlisted:
        return 'Unlisted';
    }
  }

  String _getVisibilityDescription(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return 'Anyone can find and donate to this crowdfund';
      case CrowdfundVisibility.private:
        return 'Only people you share with can access';
      case CrowdfundVisibility.unlisted:
        return 'Anyone with the link can donate';
    }
  }
}
