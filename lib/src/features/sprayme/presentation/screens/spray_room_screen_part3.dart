part of 'spray_room_screen.dart';

/// The room's overflow ("three dots") menu.
///
/// WHY THIS EXISTS
/// ---------------
/// Every action here was already implemented and still works — SprayLiveCubit
/// has goLive/stopLive/toggleCamera/flipCamera/toggleRecording/inviteCoHost,
/// SprayRoomCubit has loadLeaderboard/sendComment/endSession, and
/// TagPeopleAction can invite people to a session. What disappeared was the way
/// IN: each control renders only under a narrow condition — host-only, live-only,
/// or inside a panel that has to be opened first — so in an ordinary room none
/// of them were on screen and the features read as deleted.
///
/// Tagging is the clearest case: TagPeopleAction was reachable from the CREATE
/// screen and from nowhere inside the room, so "tag friends in a room" had no
/// entry point at all rather than a broken one.
///
/// Rules this menu follows:
///   - Actions are listed for everyone but ENABLED only when they can succeed.
///     A menu that offers something and then fails is worse than one that greys
///     it out and says why.
///   - Host-only actions are labelled as such rather than hidden, so a guest can
///     see the room has them.
///   - Nothing here duplicates a primary control's behaviour; it re-exposes the
///     same cubit calls, so there is one implementation per action.
extension SprayRoomOverflowMenu on _SprayRoomViewState {
  void _showRoomOverflowSheet(SprayRoomState state) {
    final roomCubit = context.read<SprayRoomCubit>();
    final liveCubit = context.read<SprayLiveCubit>();
    final amHost = _isHost(state);
    final sessionId = state.session?.id ?? '';
    final ended = state.sessionEnded;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MultiBlocProvider(
        // The sheet builds under the Navigator, not under this screen, so the
        // room's cubits are not ancestors of it. Re-provided by value — they
        // belong to the screen and must not be disposed when the sheet closes.
        providers: [
          BlocProvider<SprayRoomCubit>.value(value: roomCubit),
          BlocProvider<SprayLiveCubit>.value(value: liveCubit),
        ],
        child: BlocBuilder<SprayLiveCubit, SprayLiveState>(
          builder: (sheetCtx, live) {
            final liveActive = live.isLiveActive;
            final broadcasting = live.isBroadcaster && liveActive;

            void close() => Navigator.of(sheetCtx).pop();

            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: MediaQuery.of(sheetCtx).padding.bottom + 12.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A3C),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // ── Everyone ─────────────────────────────────────────
                    _overflowTile(
                      icon: Icons.leaderboard_rounded,
                      label: 'Statistics',
                      subtitle: 'Top sprayers and gift totals',
                      onTap: () {
                        close();
                        _showStatsSheet(state);
                      },
                    ),
                    _overflowTile(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Comments',
                      onTap: () {
                        close();
                        _showCommentsSheet(state);
                      },
                    ),
                    _overflowTile(
                      icon: Icons.people_alt_outlined,
                      label: 'People in the room',
                      subtitle: 'Viewers, seats and requests',
                      onTap: () {
                        close();
                        _showViewersSheet(state);
                      },
                    ),
                    _overflowTile(
                      icon: Icons.person_add_alt_1_rounded,
                      label: 'Tag people',
                      subtitle: 'Invite friends into this room',
                      // Needs a session to invite to; disabled rather than
                      // hidden so the action is discoverable.
                      disabled: sessionId.isEmpty || ended,
                      onTap: () async {
                        close();
                        await TagPeopleAction.pickAndSend(
                          context,
                          sessionId: sessionId,
                        );
                      },
                    ),
                    _overflowTile(
                      icon: Icons.ios_share_rounded,
                      label: 'Share invite',
                      onTap: () {
                        close();
                        _shareLive(state);
                      },
                    ),

                    // ── Host ─────────────────────────────────────────────
                    if (amHost) ...[
                      Divider(color: const Color(0xFF2A2A2C), height: 20.h),
                      _overflowSectionLabel('Host controls'),
                      _overflowTile(
                        icon: liveActive
                            ? Icons.videocam_off_rounded
                            : Icons.videocam_rounded,
                        label: liveActive ? 'End live video' : 'Switch to live video',
                        subtitle: liveActive
                            ? 'Keep the room open, stop broadcasting'
                            : 'Start broadcasting to the room',
                        disabled: ended,
                        onTap: () {
                          close();
                          liveActive ? liveCubit.stopLive() : liveCubit.goLive();
                        },
                      ),
                      _overflowTile(
                        icon: live.isCameraOn
                            ? Icons.videocam_rounded
                            : Icons.mic_rounded,
                        label: live.isCameraOn
                            ? 'Switch to audio only'
                            : 'Turn the camera back on',
                        subtitle: live.isCameraOn
                            ? 'Your voice keeps going, the video stops'
                            : null,
                        // Only meaningful while actually broadcasting.
                        disabled: !broadcasting,
                        onTap: () {
                          close();
                          liveCubit.toggleCamera();
                        },
                      ),
                      _overflowTile(
                        icon: Icons.flip_camera_ios_rounded,
                        label: 'Flip camera',
                        disabled: !broadcasting || !live.isCameraOn,
                        onTap: () {
                          close();
                          liveCubit.flipCamera();
                        },
                      ),
                      _overflowTile(
                        icon: live.isMicOn
                            ? Icons.mic_rounded
                            : Icons.mic_off_rounded,
                        label: live.isMicOn ? 'Mute my mic' : 'Unmute my mic',
                        disabled: !broadcasting,
                        onTap: () {
                          close();
                          liveCubit.toggleMic();
                        },
                      ),
                      _overflowTile(
                        icon: live.isRecording
                            ? Icons.stop_circle_rounded
                            : Icons.fiber_manual_record_rounded,
                        label: live.isRecording
                            ? 'Stop recording'
                            : 'Record this live',
                        disabled: !broadcasting,
                        onTap: () async {
                          close();
                          final err = await liveCubit.toggleRecording();
                          if (err != null && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(err)),
                            );
                          }
                        },
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _overflowSectionLabel(String text) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 2.h, 20.w, 8.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              color: const Color(0xFF8E8E93),
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
      );

  /// One row. [disabled] greys it out and swallows the tap rather than removing
  /// it — the point of collecting these is that the room's capabilities are
  /// visible even when the current state cannot use them.
  Widget _overflowTile({
    required IconData icon,
    required String label,
    String? subtitle,
    bool disabled = false,
    required VoidCallback onTap,
  }) {
    final color = disabled ? const Color(0xFF6B7280) : Colors.white;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
          child: Row(
            children: [
              Icon(icon, color: color, size: 21.sp),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: color,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: disabled
                              ? const Color(0xFF4B5563)
                              : const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
