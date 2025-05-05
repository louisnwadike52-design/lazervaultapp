import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool _isAmountVisible = true;
  String? selectedCard; // Track selected card
  bool _isLoading = false;
  List<Map<String, dynamic>> _currentTransactions = [];

  // Add cached transactions for each card
  final Map<String, List<Map<String, dynamic>>> _cardTransactions = {
    '1': [], // Virtual Card transactions
    '2': [], // Physical Card transactions
  };

  // Add transaction categories
  final Map<String, IconData> categoryIcons = {
    'shopping': Icons.shopping_bag,
    'entertainment': Icons.movie,
    'subscription': Icons.subscriptions,
    'salary': Icons.work,
    'transfer': Icons.swap_horiz,
    'food': Icons.restaurant,
    'transport': Icons.directions_car,
    'utilities': Icons.power,
  };

  final Map<String, Color> categoryColors = {
    'shopping': Colors.orange.shade300,
    'entertainment': Colors.purple.shade300,
    'subscription': Colors.blue.shade300,
    'salary': Colors.green.shade300,
    'transfer': Colors.indigo.shade300,
    'food': Colors.red.shade300,
    'transport': Colors.amber.shade300,
    'utilities': Colors.teal.shade300,
  };

  // Sample card data - replace with your actual data structure
  final List<Map<String, dynamic>> cards = [
    {
      'id': '1',
      'name': 'Virtual Card',
      'balance': 5000.00,
      'number': '**** **** **** 1234',
    },
    {
      'id': '2',
      'name': 'Physical Card',
      'balance': 3500.00,
      'number': '**** **** **** 5678',
    },
  ];

  final PageController _pageController = PageController();
  final ScrollController _cardScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedCard = cards.first['id'];
    _generateAllTransactions();
    _fetchTransactions(selectedCard);

    // Add this to ensure the PageView starts at the correct position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cardScrollController.dispose();
    super.dispose();
  }

  void _generateAllTransactions() {
    // Generate transactions for each card separately
    for (var card in cards) {
      _cardTransactions[card['id']!] = _generateTransactionsForCard(card['id']);
    }
  }

  List<Map<String, dynamic>> _generateTransactionsForCard(String cardId) {
    final List<Map<String, dynamic>> transactions = [];
    final random = Random();

    // Transaction titles and descriptions for variety
    final transactionTypes = [
      {
        'title': 'Netflix Subscription',
        'category': 'subscription',
        'description': 'Monthly subscription',
        'amount': 15.99,
      },
      {
        'title': 'Uber Ride',
        'category': 'transport',
        'description': 'Trip to office',
        'amount': 25.50,
      },
      {
        'title': 'Grocery Shopping',
        'category': 'shopping',
        'description': 'Weekly groceries',
        'amount': 85.75,
      },
      {
        'title': 'Amazon Purchase',
        'category': 'shopping',
        'description': 'Electronics',
        'amount': 199.99,
      },
      {
        'title': 'Restaurant Bill',
        'category': 'food',
        'description': 'Dinner with friends',
        'amount': 45.30,
      },
      {
        'title': 'Cinema Tickets',
        'category': 'entertainment',
        'description': 'Movie night',
        'amount': 30.00,
      },
      {
        'title': 'Electricity Bill',
        'category': 'utilities',
        'description': 'Monthly utility',
        'amount': 120.50,
      },
      {
        'title': 'Salary Deposit',
        'category': 'salary',
        'description': 'Monthly salary',
        'amount': 5000.00,
      },
      {
        'title': 'Money Transfer',
        'category': 'transfer',
        'description': 'Transfer to savings',
        'amount': 500.00,
      },
    ];

    // Generate transactions for the past 7 days
    for (int day = 0; day < 7; day++) {
      final date = DateTime.now().subtract(Duration(days: day));

      for (int i = 0; i < 3; i++) {
        final transactionType =
            transactionTypes[random.nextInt(transactionTypes.length)];
        final hour = random.nextInt(24);
        final minute = random.nextInt(60);

        transactions.add({
          'cardId': cardId,
          'title': transactionType['title'],
          'date': DateTime(date.year, date.month, date.day, hour, minute),
          'amount': transactionType['amount'],
          'type': transactionType['category'] == 'salary' ||
                  transactionType['category'] == 'transfer'
              ? 'credit'
              : 'debit',
          'category': transactionType['category'],
          'description': transactionType['description'],
        });
      }
    }

    transactions.sort((a, b) => (b['date'] as DateTime).compareTo(a['date']));
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cards Section
        SizedBox(
          height: 220.h, // Increased height
          child: ListView.builder(
            controller: _cardScrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              final card = cards[index];
              final isSelected = card['id'] == selectedCard;

              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  width: 320.w,
                  margin: EdgeInsets.only(right: 16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isSelected
                          ? [
                              Color.fromARGB(255, 129, 73, 226),
                              Color.fromARGB(255, 98, 37, 208),
                            ]
                          : [
                              Color.fromARGB(255, 98, 37, 208).withOpacity(0.5),
                              Color.fromARGB(255, 78, 3, 208).withOpacity(0.7),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.2),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                    border: isSelected
                        ? Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          )
                        : null,
                  ),
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Available Balance',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              setState(
                                  () => _isAmountVisible = !_isAmountVisible);
                            },
                            icon: Icon(
                              _isAmountVisible
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isAmountVisible
                                ? '\$${card['balance'].toStringAsFixed(2)}'
                                : '••••••',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              card['number'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14.sp,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Transactions Header
        Padding(
          padding: EdgeInsets.all(24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Transactions List
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              if (_isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 78, 3, 208),
                  ),
                );
              }

              if (_currentTransactions.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt_long_rounded,
                        size: 48.sp,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No transactions yet',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                physics: BouncingScrollPhysics(),
                itemCount: groupTransactionsByDate(_currentTransactions).length,
                itemBuilder: (context, index) {
                  final groupedTransactions =
                      groupTransactionsByDate(_currentTransactions);
                  final date = groupedTransactions.keys.elementAt(index);
                  final dateTransactions = groupedTransactions[date]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          formatTransactionDate(date),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      ...dateTransactions.map((transaction) => TransactionItem(
                            transaction: transaction,
                            isAmountVisible: _isAmountVisible,
                            categoryIcon:
                                categoryIcons[transaction['category']] ??
                                    Icons.attach_money,
                            categoryColor:
                                categoryColors[transaction['category']] ??
                                    Colors.grey,
                          )),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> _fetchTransactions(String? cardId) async {
    // Simulate network delay
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    List<Map<String, dynamic>> transactions;
    if (cardId == null) {
      // If no card selected, merge all transactions
      transactions = cards
          .expand((card) => _cardTransactions[card['id']]!)
          .toList()
        ..sort((a, b) => (b['date'] as DateTime).compareTo(a['date']));
    } else {
      // Get transactions for specific card
      transactions = List.from(_cardTransactions[cardId]!);
    }

    setState(() {
      _isLoading = false;
      _currentTransactions = transactions;
    });
    return transactions;
  }

  Map<DateTime, List<Map<String, dynamic>>> groupTransactionsByDate(
      List<Map<String, dynamic>> transactions) {
    final grouped = <DateTime, List<Map<String, dynamic>>>{};

    for (var transaction in transactions) {
      final date = DateTime(
        (transaction['date'] as DateTime).year,
        (transaction['date'] as DateTime).month,
        (transaction['date'] as DateTime).day,
      );

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }

    return Map.fromEntries(
        grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)));
  }

  String formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else if (date.isAfter(now.subtract(Duration(days: 7)))) {
      return DateFormat('EEEE').format(date); // e.g., "Monday"
    } else if (date.year == now.year) {
      return DateFormat('MMM d').format(date); // e.g., "Sep 24"
    } else {
      return DateFormat('MMM d, y').format(date); // e.g., "Sep 24, 2023"
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      selectedCard = cards[index]['id'];
    });
    // Scroll the card into view
    _cardScrollController.animateTo(
      index * (300.w + 16.w), // card width + horizontal margin
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _fetchTransactions(selectedCard);
  }
}

// Updated TransactionItem widget
class TransactionItem extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final bool isAmountVisible;
  final IconData categoryIcon;
  final Color categoryColor;

  const TransactionItem({
    required this.transaction,
    required this.isAmountVisible,
    required this.categoryIcon,
    required this.categoryColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTransactionDetails(context),
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                categoryIcon,
                color: categoryColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['title'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    transaction['description'] ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isAmountVisible
                      ? '${transaction['type'] == 'credit' ? '+' : '-'}\$${transaction['amount'].toStringAsFixed(2)}'
                      : '••••••',
                  style: TextStyle(
                    color: transaction['type'] == 'credit'
                        ? Colors.green.shade300
                        : Colors.red.shade300,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  DateFormat('h:mm a').format(transaction['date']),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TransactionDetailsSheet(transaction: transaction),
    );
  }
}

// Add new TransactionDetailsSheet widget
class TransactionDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailsSheet({
    required this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 129, 73, 226),
            Color.fromARGB(255, 98, 37, 208),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction Status
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Icon(
                            transaction['type'] == 'credit'
                                ? Icons.arrow_downward_rounded
                                : Icons.arrow_upward_rounded,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['type'] == 'credit'
                                  ? 'Money Received'
                                  : 'Payment Sent',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              DateFormat('MMM d, y • h:mm a')
                                  .format(transaction['date']),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Amount
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 32.h),
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${transaction['type'] == 'credit' ? '+' : '-'}\$${transaction['amount'].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: transaction['type'] == 'credit'
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              transaction['type'] == 'credit'
                                  ? 'Completed'
                                  : 'Processed',
                              style: TextStyle(
                                color: transaction['type'] == 'credit'
                                    ? Colors.green.shade300
                                    : Colors.red.shade300,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Transaction Details
                    Text(
                      'Transaction Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildDetailRow('Transaction ID',
                        '#${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}'),
                    _buildDetailRow('Category',
                        transaction['category'].toString().toUpperCase()),
                    _buildDetailRow('Description', transaction['description']),
                    _buildDetailRow('Payment Method',
                        'Card ending in ${transaction['cardId']}234'),

                    // Receipt Button
                    SizedBox(height: 32.h),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 32.h),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showReceiptPreview(context),
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long_rounded,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'View Receipt',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showReceiptPreview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ReceiptPreviewSheet(transaction: transaction),
    );
  }
}

// Add new ReceiptPreviewSheet widget
class ReceiptPreviewSheet extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const ReceiptPreviewSheet({
    required this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Logo Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 32.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 129, 73, 226),
                          Color.fromARGB(255, 98, 37, 208),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Color.fromARGB(255, 98, 37, 208),
                              size: 40.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Transaction Receipt',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Receipt Content
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                        // Status and Amount
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: transaction['type'] == 'credit'
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction['type'] == 'credit'
                                        ? 'Payment Received'
                                        : 'Payment Sent',
                                    style: TextStyle(
                                      color: transaction['type'] == 'credit'
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    DateFormat('MMM d, y • h:mm a')
                                        .format(transaction['date']),
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${transaction['type'] == 'credit' ? '+' : '-'}\$${transaction['amount'].toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: transaction['type'] == 'credit'
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Transaction Details
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24.h),
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            children: [
                              _buildReceiptRow('Transaction ID',
                                  '#${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}'),
                              _buildDivider(),
                              _buildReceiptRow(
                                  'Category',
                                  transaction['category']
                                      .toString()
                                      .toUpperCase()),
                              _buildDivider(),
                              _buildReceiptRow(
                                  'Description', transaction['description']),
                              _buildDivider(),
                              _buildReceiptRow('Payment Method',
                                  'Card ending in ${transaction['cardId']}234'),
                              _buildDivider(),
                              _buildReceiptRow(
                                  'Status',
                                  transaction['type'] == 'credit'
                                      ? 'Completed'
                                      : 'Processed'),
                            ],
                          ),
                        ),

                        // Download Button
                        Container(
                          width: double.infinity,
                          height: 56.h,
                          margin: EdgeInsets.only(top: 24.h),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement download functionality
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 98, 37, 208),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_download_outlined,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Download Receipt',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Share Button
                        Container(
                          width: double.infinity,
                          height: 56.h,
                          margin: EdgeInsets.only(top: 12.h),
                          child: TextButton(
                            onPressed: () {
                              // Implement share functionality
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  color: Colors.grey.shade700,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Share Receipt',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade200,
      height: 1,
    );
  }
}
