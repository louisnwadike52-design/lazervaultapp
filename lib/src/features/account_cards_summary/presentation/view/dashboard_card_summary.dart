import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/account_carousel.dart';
import '../widgets/card_details_bottom_sheet.dart';
import '../widgets/empty_account_state.dart';

// Wrapper Widget to Provide the Cubit
class DashboardCardSummary extends StatelessWidget {
  const DashboardCardSummary({super.key});

  @override
  Widget build(BuildContext context) {
    // No longer need to get authState here or provide the cubit
    // The view state will handle fetching.
    // final authState = context.watch<AuthenticationCubit>().state;
    // String? userId;
    // String? accessToken;

    // // Linter Fix: Check for AuthenticationSuccess state correctly
    // if (authState is AuthenticationSuccess) {
    //   // Access user ID via profile
    //   userId = authState.profile.user.id;
    //   // Get access token from session
    //   accessToken = authState.profile.session.accessToken;
    // } // else: userId remains null if not authenticated

    // REMOVE the BlocProvider here
    // return BlocProvider(
    //   create: (_) {
    //     final cubit = serviceLocator<AccountCardsSummaryCubit>();
    //     if (userId != null) {
    //       cubit.fetchAccountSummaries(
    //         userId: userId,
    //         accessToken: accessToken,
    //       );
    //     } else {
    //       print("DashboardCardSummary: User not authenticated...");
    //     }
    //     return cubit;
    //   },
    //   child: const _DashboardCardSummaryView(),
    // );

    // Directly return the view
    return const _DashboardCardSummaryView();
  }
}

// Internal View Widget
class _DashboardCardSummaryView extends StatefulWidget {
  const _DashboardCardSummaryView();

  @override
  State<_DashboardCardSummaryView> createState() =>
      _DashboardCardSummaryViewState();
}

class _DashboardCardSummaryViewState extends State<_DashboardCardSummaryView> {
  // Removed most state variables - they are now in CardDetailsBottomSheetState
  // Keep _currentIndex if AccountCarousel doesn't manage its own index
  // int _currentIndex = 0; // If needed for indicators outside carousel

  @override
  void initState() {
    super.initState();
    // Fetch data here using the globally provided cubit
    _fetchData();
    _setupWebSocketConnection();
  }

  void _fetchData() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;

      // Get active country from ProfileCubit
      final profileState = context.read<ProfileCubit>().state;
      String? activeCountry;
      if (profileState is ProfileLoaded) {
        activeCountry = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : null;
      }

      // Use context.read to get the cubit provided in main.dart
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
            userId: userId,
            accessToken: accessToken,
            country: activeCountry,
          );
    } else {
      print(
          "_DashboardCardSummaryView: User not authenticated, cannot fetch summaries.");
      // Optionally, handle the non-authenticated state, e.g., show an error in the UI
      // context.read<AccountCardsSummaryCubit>().emit(AccountCardsSummaryError("User not authenticated"));
    }
  }

  void _setupWebSocketConnection() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;

      // Get active country from ProfileCubit
      final profileState = context.read<ProfileCubit>().state;
      String? activeCountry;
      if (profileState is ProfileLoaded) {
        activeCountry = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : null;
      }

      if (activeCountry != null) {
        // Connect to WebSocket for real-time balance updates
        context.read<BalanceWebSocketCubit>().connect(
              userId: userId,
              countryCode: activeCountry,
              accessToken: accessToken,
            );
      }
    }
  }

  // Method to show the extracted bottom sheet widget
  void _showCardDetailsSheet(Map<String, dynamic> accountArgs) {
    Get.bottomSheet(
      CardDetailsBottomSheet(accountArgs: accountArgs),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor:
          Colors.transparent, // Let the sheet handle its background
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get user for the header
    final authState = context.watch<AuthenticationCubit>().state;
    User? currentUser;
    if (authState is AuthenticationSuccess) {
      currentUser = authState.profile.user;
    }

    return MultiBlocListener(
      listeners: [
        // Listen for WebSocket balance updates and refresh account summaries
        BlocListener<BalanceWebSocketCubit, BalanceWebSocketState>(
          listener: (context, wsState) {
            if (wsState.lastUpdate != null) {
              print('_DashboardCardSummaryView: Received balance update via WebSocket - ${wsState.lastUpdate}');
              // Refresh account summaries when balance changes
              _fetchData();
            }
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 78, 3, 208),
              Color.fromARGB(255, 95, 20, 225),
            ],
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Use DashboardHeader widget
              DashboardHeader(currentUser: currentUser),
              SizedBox(height: 16.h),
              // Use AccountCarousel widget within BlocConsumer
              BlocConsumer<AccountCardsSummaryCubit, AccountCardsSummaryState>(
                listener: (context, state) {
                  // Add listener to observe state changes received by the UI
                  print(
                      "_DashboardCardSummaryView BlocConsumer Listener: Received state -> $state");
                  // You could add specific side-effects here if needed in the future,
                  // e.g., showing a snackbar on error without rebuilding the main content.
                  // if (state is AccountCardsSummaryError) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  // }
                },
                builder: (context, state) {
                  // Get country code from user profile for empty state handling
                  // Priority: ProfileCubit preferences > User profile country > Default 'NG'
                  String countryCode = 'NG'; // Default fallback

                  // First try to get from ProfileCubit preferences
                  final profileState = context.read<ProfileCubit>().state;
                  if (profileState is ProfileLoaded &&
                      profileState.preferences.activeCountry.isNotEmpty) {
                    countryCode = profileState.preferences.activeCountry;
                  } else {
                    // Fallback to user's profile country from AuthenticationCubit
                    final authState = context.read<AuthenticationCubit>().state;
                    if (authState is AuthenticationSuccess &&
                        authState.profile.user.country != null &&
                        authState.profile.user.country!.isNotEmpty) {
                      countryCode = authState.profile.user.country!;
                    }
                  }

                  if (state is AccountCardsSummaryLoading ||
                      state is AccountCardsSummaryInitial) {
                    return SizedBox(
                      height: 228.h,
                      child: const Center(
                          child: CircularProgressIndicator(color: Colors.white)),
                    );
                  }
                  if (state is AccountCardsSummaryError) {
                    return SizedBox(
                      height: 228.h,
                      child: Center(
                          child: Text('Error: ${state.message}',
                              style: const TextStyle(color: Colors.red))),
                    );
                  }
                  if (state is AccountCardsSummaryLoaded) {
                    // Check if user has no accounts (non-Nigeria or accounts not yet created)
                    if (state.accountSummaries.isEmpty) {
                      final isNigeriaUser = EmptyAccountState.isCountrySupported(countryCode);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 200.h,
                          child: EmptyAccountState(
                            countryCode: countryCode,
                            isVirtualAccountSupported: isNigeriaUser,
                            onNotifyMe: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'We\'ll notify you when virtual accounts become available in your region!',
                                  ),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Color(0xFF6C5CE7),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }

                    // Check if there's a family account in the summaries
                    final hasFamilyAccount = state.accountSummaries.any(
                      (account) => account.isFamilyAccount,
                    );

                    // Show family setup card for users without family account
                    // Since signup is now Nigeria-only, all users can set up family accounts
                    final isNigeriaUser = EmptyAccountState.isCountrySupported(countryCode);

                    return AccountCarousel(
                      accountSummaries: state.accountSummaries,
                      onShowDetails: _showCardDetailsSheet,
                      showFamilySetupCard: !hasFamilyAccount, // Show setup card for all users without family account
                    );
                  }
                  return SizedBox(
                      height: 228.h,
                      child: const Text('Unknown state',
                          style: TextStyle(color: Colors.white)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
