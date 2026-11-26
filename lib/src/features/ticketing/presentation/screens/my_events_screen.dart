import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import 'package:lazervault/core/shared_widgets/load_more_footer.dart'
    show ScrollEndLoader;
import '../widgets/load_more_footer.dart';
import '../widgets/ticket_event_card.dart';
import '../widgets/ticketing_theme.dart';

/// MY EVENTS — the organiser's list, every status, newest first.
class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketingCubit>().loadMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('My events',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: TicketingTheme.cta,
        // The label and icon inherit the THEME's FAB foreground when this is
        // unset, which on the light theme is a dark colour — on a filled
        // purple CTA. Same inheritance that made the app bars disappear; a
        // filled control has to state both halves of its own contrast.
        foregroundColor: TicketingTheme.onBar,
        onPressed: () => Get.toNamed(AppRoutes.ticketingCreate),
        icon: const Icon(Icons.add),
        label: Text('New event',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ),
      body: BlocBuilder<TicketingCubit, TicketingState>(
        builder: (context, state) {
          if (state is TicketingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TicketingFailure) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Text(state.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, color: TicketingTheme.textSecondary)),
              ),
            );
          }
          if (state is! MyTicketEventsLoaded) return const SizedBox.shrink();
          if (state.events.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Text(
                    'You have not created an event yet.\n'
                    'Publish one and start selling tickets.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, color: TicketingTheme.textSecondary)),
              ),
            );
          }
          return // SCROLL TO THE BOTTOM AND THE NEXT PAGE ARRIVES.
// The footer below is still pressable and still says how many rows
// remain — it is what makes a FAILED page recoverable, since a list
// already at its end generates no further scroll notification.
              ScrollEndLoader(
            hasMore: state.events.length < state.total,
            loading: context.read<TicketingCubit>().isPaging('myevents'),
            onReachEnd: () => context
                .read<TicketingCubit>()
                .loadMyEvents(page: state.page + 1),
            child: RefreshIndicator(
              onRefresh: () => context.read<TicketingCubit>().loadMyEvents(),
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 96.h),
                itemCount: state.events.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) {
                  if (i == state.events.length) {
                    return LoadMoreFooter(
                      loaded: state.events.length,
                      total: state.total,
                      onLoadMore: () => context
                          .read<TicketingCubit>()
                          .loadMyEvents(page: state.page + 1),
                    );
                  }
                  final e = state.events[i];
                  return TicketEventCard(
                    event: e,
                    // EDIT IS A LONG-PRESS, not a second button on every row: a
                    // tap goes to the money, which is what an organiser opens
                    // this list for. The card also states what is still
                    // editable once tickets are sold, so the gesture never
                    // leads to a form that only argues.
                    onLongPress: () async {
                      final saved = await Get.toNamed(
                        AppRoutes.ticketingEdit,
                        arguments: e,
                      );
                      if (saved != true || !context.mounted) return;
                      context.read<TicketingCubit>().loadMyEvents();
                    },
                    // The organiser list SHOWS the status pill: unlike the
                    // discover list, these are not all on sale.
                    showStatus: true,
                    onTap: () => Get.toNamed(
                      AppRoutes.ticketingOrganiser
                          .replaceFirst(':eventId', e.id),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
