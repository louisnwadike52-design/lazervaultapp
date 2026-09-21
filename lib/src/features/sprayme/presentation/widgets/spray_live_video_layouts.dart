part of 'spray_live_video_layer.dart';

/// The three participant arrangements a live can be rendered in.
///
/// Kept in a part file rather than a separate library so they can reuse
/// [_ParticipantTile] and the other private widgets in the video layer without
/// exporting any of it, and so [spray_live_video_layer.dart] stays inside the
/// 200–500 line budget.
///
/// SPACE THESE LAYOUTS MUST NOT USE
/// --------------------------------
/// These arrangements are drawn UNDER the room's overlays, so any tile placed
/// in an occupied band is simply hidden behind a control. The room reserves:
///
///   * right edge — the action rail (Nova / Gift / Spray / Share / More). The
///     room itself already excludes 80.w on the right from its spray tap area,
///     so that figure is the contract, not a guess.
///   * top        — the session header and spray-mode indicator.
///   * bottom     — the comment feed and input bar.
///
/// A face hidden behind a button is the whole failure mode here, so every
/// layout below keeps its tiles inside the free region.

/// Width of the right-hand band owned by the action rail.
const double _kRailBand = 88; // logical px, scaled with .w at each use

/// Top band owned by the session header / spray-mode indicator.
const double _kHeaderBand = 104; // logical px, scaled with .h

/// Bottom band owned by the comment feed and input bar.
const double _kFooterBand = 180; // logical px, scaled with .h

/// Everyone the same size.
///
/// The column count steps with the roster instead of being fixed: two people
/// side by side read as a conversation, four as a 2×2, and a full party packs
/// three across before the tiles get too small to recognise a face in.
class _GridLayout extends StatelessWidget {
  final List<SprayLiveTrack> tracks;
  final Map<String, String> nameByIdentity;
  const _GridLayout({required this.tracks, required this.nameByIdentity});

  static int columnsFor(int count) {
    if (count <= 1) return 1;
    if (count <= 4) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    // A grid of one IS a full-bleed view. Special-casing it keeps a solo host
    // looking exactly as they did before, so defaulting the platform to grid
    // changes nothing for the overwhelmingly common single-broadcaster live.
    if (tracks.length == 1) {
      return VideoTrackRenderer(tracks.first.track, fit: VideoViewFit.cover);
    }

    final columns = columnsFor(tracks.length);
    return ColoredBox(
      color: const Color(0xFF0A0A0A),
      child: GridView.builder(
        // Right padding clears the action rail; top and bottom clear the
        // header and the comment bar. Without these the outer tiles render
        // underneath the controls and those participants are invisible.
        padding: EdgeInsets.fromLTRB(
            8.w, _kHeaderBand.h, _kRailBand.w, _kFooterBand.h),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 6.w,
          mainAxisSpacing: 6.h,
          childAspectRatio: 3 / 4,
        ),
        itemCount: tracks.length,
        itemBuilder: (_, i) => _ParticipantTile(
          track: tracks[i],
          displayName: nameByIdentity[tracks[i].participantId],
        ),
      ),
    );
  }
}

/// One large view with the others stacked down the right-hand side.
///
/// The strip sits INBOARD of the action rail rather than against the screen
/// edge: the rail owns the right-hand band, so a strip at `right: 8` would put
/// every co-host's face directly behind the Nova / Gift / Spray buttons.
/// Offsetting by the rail band keeps the familiar right-side filmstrip while
/// leaving every tile visible.
class _SidebarLayout extends StatelessWidget {
  final SprayLiveTrack primary;
  final List<SprayLiveTrack> others;
  final Map<String, String> nameByIdentity;
  const _SidebarLayout({
    required this.primary,
    required this.others,
    required this.nameByIdentity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: VideoTrackRenderer(primary.track, fit: VideoViewFit.cover),
        ),
        if (others.isNotEmpty)
          Positioned(
            right: (_kRailBand + 4).w,
            top: _kHeaderBand.h,
            bottom: _kFooterBand.h,
            width: 84.w,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: others.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, i) => SizedBox(
                height: 116.h,
                child: _ParticipantTile(
                  track: others[i],
                  displayName: nameByIdentity[others[i].participantId],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// One person full-bleed with the rest in a strip along the bottom.
///
/// This is the arrangement the room shipped with; it stays available as an
/// explicit choice rather than being replaced by the new default.
class _SpotlightLayout extends StatelessWidget {
  final SprayLiveTrack primary;
  final List<SprayLiveTrack> others;
  final Map<String, String> nameByIdentity;
  const _SpotlightLayout({
    required this.primary,
    required this.others,
    required this.nameByIdentity,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: VideoTrackRenderer(primary.track, fit: VideoViewFit.cover),
        ),
        // Guest boxes row — horizontally scrollable so up to 8 guests fit.
        if (others.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: 170.h,
            child: SizedBox(
              height: 116.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                // End padding lets the last guest scroll clear of the action
                // rail instead of coming to rest underneath it.
                padding: EdgeInsets.only(left: 12.w, right: _kRailBand.w),
                itemCount: others.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (_, i) => SizedBox(
                  width: 84.w,
                  child: _ParticipantTile(
                    track: others[i],
                    displayName: nameByIdentity[others[i].participantId],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A participant's video plus their name chip, sized by its parent.
///
/// [_GuestBox] hard-coded 84×116 because it only ever appeared in the bottom
/// strip. Grid and sidebar need the same content at different sizes, so the
/// tile fills whatever box it is given and the callers do the sizing.
class _ParticipantTile extends StatelessWidget {
  final SprayLiveTrack track;
  final String? displayName; // from the roster; falls back to the track name
  const _ParticipantTile({required this.track, this.displayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          // The host stays visually distinct in every layout — in a grid there
          // is no "big view" to mark who is running the live.
          color:
              track.isHost ? const Color(0xFFFFD700) : const Color(0xFF7C3AED),
          width: 1.5,
        ),
        color: const Color(0xFF0A0A0A),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoTrackRenderer(track.track, fit: VideoViewFit.cover),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              color: Colors.black54,
              child: Text(
                track.isLocal
                    ? 'You'
                    : (displayName != null && displayName!.isNotEmpty
                        ? displayName!
                        : track.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
