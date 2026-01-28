import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnEarnScreen extends StatefulWidget {
  const LearnEarnScreen({super.key});

  @override
  State<LearnEarnScreen> createState() => _LearnEarnScreenState();
}

class _LearnEarnScreenState extends State<LearnEarnScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _progressController;
  
  final int _totalEarned = 142;
  final int _coursesCompleted = 8;
  final int _currentStreak = 12;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressOverview(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCoursesTab(),
                    _buildQuizzesTab(),
                    _buildRewardsTab(),
                    _buildProgressTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learn & Earn',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Crypto education',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.school, color: Colors.green, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressOverview() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.withValues(alpha: 0.2), const Color(0xFF1E2746)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Total Earned', '£$_totalEarned', Icons.monetization_on, Colors.green),
              _buildStatItem('Courses', '$_coursesCompleted', Icons.book, Colors.blue),
              _buildStatItem('Streak', '$_currentStreak days', Icons.local_fire_department, Colors.orange),
            ],
          ),
          SizedBox(height: 20.h),
          _buildOverallProgress(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
        labelStyle: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600),
        tabs: [
          Tab(text: 'Courses'),
          Tab(text: 'Quizzes'),
          Tab(text: 'Rewards'),
          Tab(text: 'Progress'),
        ],
      ),
    );
  }

  Widget _buildCoursesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeaturedCourse(),
          SizedBox(height: 24.h),
          Text(
            'Course Categories',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildCourseCategory('Beginner', 'Start your crypto journey', 5, Colors.green),
          _buildCourseCategory('Intermediate', 'Deepen your knowledge', 8, Colors.blue),
          _buildCourseCategory('Advanced', 'Master crypto trading', 6, Colors.purple),
          _buildCourseCategory('DeFi', 'Decentralized Finance', 4, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildQuizzesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildDailyChallenge(),
          SizedBox(height: 20.h),
          _buildQuizList(),
        ],
      ),
    );
  }

  Widget _buildRewardsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildRewardsSummary(),
          SizedBox(height: 20.h),
          _buildRewardsHistory(),
          SizedBox(height: 20.h),
          _buildAchievements(),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildLearningPath(),
          SizedBox(height: 20.h),
          _buildSkillsProgress(),
          SizedBox(height: 20.h),
          _buildCertificates(),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Overall Progress',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            Text(
              '73%',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: 0.73 * _progressController.value,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              borderRadius: BorderRadius.circular(4.r),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedCourse() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.withValues(alpha: 0.3), const Color(0xFF1E2746)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'FEATURED',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.star, color: Colors.amber, size: 20.sp),
              Text(
                '4.9',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Bitcoin Fundamentals',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Learn the basics of Bitcoin, blockchain technology, and how cryptocurrency works.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildCourseInfo(Icons.access_time, '2h 30m'),
              SizedBox(width: 16.w),
              _buildCourseInfo(Icons.play_circle_outline, '12 lessons'),
              SizedBox(width: 16.w),
              _buildCourseInfo(Icons.monetization_on, '£25'),
            ],
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => _startCourse('Bitcoin Fundamentals'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Start Course',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCategory(String title, String description, int courses, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () => _openCategory(title),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2746),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getCategoryIcon(title),
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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '$courses courses',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withValues(alpha: 0.5),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyChallenge() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.withValues(alpha: 0.2), const Color(0xFF1E2746)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.purple, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Daily Challenge',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '£5 Reward',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'DeFi Quiz Challenge',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Test your knowledge about Decentralized Finance protocols and earn rewards!',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildQuizInfo(Icons.quiz, '10 questions'),
              SizedBox(width: 16.w),
              _buildQuizInfo(Icons.timer, '5 minutes'),
              SizedBox(width: 16.w),
              _buildQuizInfo(Icons.people, '2,341 completed'),
            ],
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => _startQuiz('DeFi Quiz Challenge'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              minimumSize: Size(double.infinity, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Start Challenge',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizList() {
    final quizzes = [
      {'title': 'Blockchain Basics', 'reward': '£3', 'difficulty': 'Easy', 'color': Colors.green},
      {'title': 'Crypto Trading', 'reward': '£7', 'difficulty': 'Medium', 'color': Colors.orange},
      {'title': 'Smart Contracts', 'reward': '£10', 'difficulty': 'Hard', 'color': Colors.red},
      {'title': 'NFT Fundamentals', 'reward': '£5', 'difficulty': 'Easy', 'color': Colors.green},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Quizzes',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        ...quizzes.map((quiz) => _buildQuizItem(
          quiz['title'] as String,
          quiz['reward'] as String,
          quiz['difficulty'] as String,
          quiz['color'] as Color,
        )),
      ],
    );
  }

  Widget _buildQuizItem(String title, String reward, String difficulty, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.quiz, color: color, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  difficulty,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                reward,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              GestureDetector(
                onTap: () => _startQuiz(title),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Start',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rewards Summary',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRewardStat('This Week', '£23'),
              _buildRewardStat('This Month', '£87'),
              _buildRewardStat('All Time', '£$_totalEarned'),
            ],
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _claimRewards,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(double.infinity, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Claim Available Rewards (£23)',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsHistory() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Rewards',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildRewardHistoryItem('Completed DeFi Quiz', '£5', '2 hours ago'),
          _buildRewardHistoryItem('Finished Bitcoin Course', '£25', 'Yesterday'),
          _buildRewardHistoryItem('Weekly Challenge', '£10', '3 days ago'),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAchievementBadge('First Course', Icons.school, Colors.blue, true),
              _buildAchievementBadge('Quiz Master', Icons.quiz, Colors.purple, true),
              _buildAchievementBadge('Streak Legend', Icons.local_fire_department, Colors.orange, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPath() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Learning Path',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildPathItem('Crypto Basics', true, Colors.green),
          _buildPathItem('Trading Fundamentals', true, Colors.green),
          _buildPathItem('DeFi Protocols', false, Colors.orange),
          _buildPathItem('Advanced Trading', false, Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSkillsProgress() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills Progress',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSkillProgress('Blockchain Knowledge', 0.8),
          _buildSkillProgress('Trading Skills', 0.6),
          _buildSkillProgress('DeFi Understanding', 0.4),
          _buildSkillProgress('Security Awareness', 0.9),
        ],
      ),
    );
  }

  Widget _buildCertificates() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Certificates',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildCertificateItem('Bitcoin Fundamentals', 'Completed', true),
          _buildCertificateItem('Blockchain Technology', 'Completed', true),
          _buildCertificateItem('Crypto Trading Basics', 'In Progress', false),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildCourseInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildRewardStat(String label, String amount) {
    return Column(
      children: [
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildRewardHistoryItem(String activity, String reward, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            reward,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(String title, IconData icon, Color color, bool earned) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: earned ? color.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
            shape: BoxShape.circle,
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Icon(
            icon,
            color: earned ? color : Colors.white.withValues(alpha: 0.3),
            size: 24.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: earned ? Colors.white : Colors.white.withValues(alpha: 0.5),
            fontWeight: earned ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildPathItem(String title, bool completed, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: completed ? color : Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed ? Icons.check : Icons.circle_outlined,
              color: completed ? Colors.white : Colors.white.withValues(alpha: 0.5),
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: completed ? Colors.white : Colors.white.withValues(alpha: 0.6),
              fontWeight: completed ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillProgress(String skill, double progress) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateItem(String course, String status, bool completed) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        children: [
          Icon(
            completed ? Icons.verified : Icons.schedule,
            color: completed ? Colors.green : Colors.orange,
            size: 24.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: completed ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          if (completed)
            IconButton(
              onPressed: () => _downloadCertificate(course),
              icon: Icon(Icons.download, color: Colors.green, size: 20.sp),
            ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Beginner':
        return Icons.school;
      case 'Intermediate':
        return Icons.trending_up;
      case 'Advanced':
        return Icons.psychology;
      case 'DeFi':
        return Icons.account_balance;
      default:
        return Icons.book;
    }
  }

  // Action methods
  void _startCourse(String courseName) {
    Get.snackbar(
      'Course Started',
      'Starting $courseName...',
      backgroundColor: Colors.blue.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _openCategory(String category) {
    Get.snackbar(
      category,
      'Opening $category courses...',
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _startQuiz(String quizName) {
    Get.snackbar(
      'Quiz Started',
      'Starting $quizName...',
      backgroundColor: Colors.purple.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _claimRewards() {
    Get.snackbar(
      'Rewards Claimed!',
      'Successfully claimed £23 in rewards',
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _downloadCertificate(String course) {
    Get.snackbar(
      'Certificate Downloaded',
      'Certificate for $course has been downloaded',
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }
} 