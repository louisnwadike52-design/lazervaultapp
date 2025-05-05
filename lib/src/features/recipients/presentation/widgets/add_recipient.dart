import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class AddRecipient extends StatefulWidget {
  const AddRecipient({super.key});

  @override
  State<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends State<AddRecipient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();
  final TextEditingController _bankController =
      TextEditingController(text: "Select Bank");
  bool _isFavorite = false;

  final List<Map<String, dynamic>> ukBanks = [
    {
      "name": "Barclays",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/3/3e/Barclays_logo.svg",
      "isFavorite": false,
    },
    {
      "name": "HSBC",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/5/5a/HSBC_logo_%282018%29.svg",
      "isFavorite": false,
    },
    {
      "name": "Lloyds Bank",
      "logo": "https://images.app.goo.gl/e69Fa8zSismMDCb5A",
      "isFavorite": false,
    },
    {
      "name": "NatWest",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/3/31/NatWest_logo.svg",
      "isFavorite": false,
    },
    {
      "name": "Santander UK",
      "logo":
          "https://upload.wikimedia.org/wikipedia/commons/b/b3/Santander_Logo.svg",
      "isFavorite": false,
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _accountController.dispose();
    _sortCodeController.dispose();
    _bankController.dispose();
    super.dispose();
  }

  void _showBankSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Bank",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: ukBanks.length,
                  itemBuilder: (context, index) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _bankController.text = ukBanks[index]["name"]!;
                            _isFavorite = ukBanks[index]["isFavorite"];
                          });
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.network(
                                    ukBanks[index]["logo"]!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  ukBanks[index]["name"]!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ukBanks[index]["isFavorite"] =
                                        !ukBanks[index]["isFavorite"];
                                    if (_bankController.text ==
                                        ukBanks[index]["name"]) {
                                      _isFavorite =
                                          ukBanks[index]["isFavorite"];
                                    }
                                  });
                                },
                                icon: Icon(
                                  ukBanks[index]["isFavorite"]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: ukBanks[index]["isFavorite"]
                                      ? Colors.red
                                      : Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipientCubit, RecipientState>(
      listener: (context, state) {
        if (state is RecipientError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is RecipientSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          if (ModalRoute.of(context)?.isCurrent ?? false) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A1A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Add New Recipient',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3498DB).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: const Color(0xFF3498DB),
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                'Please ensure all details are correct before adding a new recipient.',
                                style: TextStyle(
                                  color: const Color(0xFF3498DB),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Recipient Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildFormField(
                              controller: _nameController,
                              label: 'Full Name',
                              hint: 'Enter recipient\'s full name',
                              icon: Icons.person_outline,
                            ),
                            SizedBox(height: 16.h),
                            _buildFormField(
                              controller: _accountController,
                              label: 'Account Number',
                              hint: 'Enter account number',
                              icon: Icons.account_balance_outlined,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.h),
                            _buildFormField(
                              controller: _sortCodeController,
                              label: 'Sort Code',
                              hint: 'Enter sort code',
                              icon: Icons.numbers_outlined,
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 16.h),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _showBankSelectionBottomSheet(context),
                                borderRadius: BorderRadius.circular(12.r),
                                child: Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 24.sp,
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Text(
                                          _bankController.text,
                                          style: TextStyle(
                                            color: _bankController.text ==
                                                    "Select Bank"
                                                ? Colors.white.withOpacity(0.5)
                                                : Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.white.withOpacity(0.7),
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Save as Favorite',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: _isFavorite,
                                  onChanged: (value) {
                                    setState(() {
                                      _isFavorite = value;
                                    });
                                  },
                                  activeColor: const Color(0xFF3498DB),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                    minimumSize: Size(double.infinity, 56.h),
                  ),
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _accountController.text.isEmpty ||
                        _sortCodeController.text.isEmpty ||
                        _bankController.text == "Select Bank") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    final authState = context.read<AuthenticationCubit>().state;
                    String? accessToken;
                    if (authState is AuthenticationSuccess) {
                      accessToken = authState.profile.session.accessToken;
                    }

                    if (accessToken == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Authentication error. Please log in again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    context.read<RecipientCubit>().addRecipient(
                      recipient: RecipientModel(
                        id: '',
                        name: _nameController.text,
                        accountNumber: _accountController.text,
                        bankName: _bankController.text,
                        sortCode: _sortCodeController.text,
                        isFavorite: _isFavorite,
                      ),
                      accessToken: accessToken,
                    );
                  },
                  child: BlocBuilder<RecipientCubit, RecipientState>(
                    builder: (context, state) {
                      if (state is RecipientLoading) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        );
                      }
                      return Text(
                        'Add Recipient',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              icon: Icon(
                icon,
                color: Colors.white.withOpacity(0.7),
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
