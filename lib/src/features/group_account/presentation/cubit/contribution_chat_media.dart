part of 'contribution_chat_cubit.dart';

/// Voice notes and images in a contribution chat.
///
/// Split from the cubit body because sending media is a two-step exchange the
/// text path does not have: the bytes are uploaded first, and only the URL that
/// comes back is posted as a message. Everything else — the optimistic bubble,
/// the client id that makes a retry idempotent, the failed state — is
/// deliberately identical to [ContributionChatCubit.send], so a media bubble
/// behaves exactly like a text one.
///
/// Where the bytes land is not this layer's concern: group-accounts routes the
/// upload to storage-service, so the active storage provider decides, and the
/// URL returned is absolute and keeps resolving after a provider switch.
extension ContributionChatMedia on ContributionChatCubit {
  /// Sends an image. [file] is a local file already chosen by the picker.
  Future<void> sendImage(File file) =>
      _sendMedia(file: file, kind: 'image', durationMs: 0);

  /// Sends a voice note. [durationMs] is what the recorder measured — the
  /// server echoes it back, but sending it means the bubble can show a length
  /// immediately rather than after a round-trip.
  Future<void> sendVoiceNote(File file, {required int durationMs}) =>
      _sendMedia(file: file, kind: 'voice', durationMs: durationMs);

  Future<void> _sendMedia({
    required File file,
    required String kind,
    required int durationMs,
  }) async {
    final clientId = _uuid.v4();
    final reply = replyingTo;

    // The bubble appears immediately, before the upload starts. A voice note
    // can take seconds on a phone connection, and a chat that shows nothing
    // until it completes feels broken — the user cannot tell whether their tap
    // registered.
    final optimistic = ContributionMessage(
      id: '',
      contributionId: contributionId,
      senderId: currentUserId,
      senderName: 'You',
      kind: kind,
      body: '',
      // Points at the LOCAL file so the image renders from disk while it
      // uploads. The bubble swaps to the remote URL when the server replies.
      mediaUrl: file.path,
      durationMs: durationMs,
      createdAt: DateTime.now(),
      clientMessageId: clientId,
      replyToMessageId: reply?.id ?? '',
      replyToBody: reply?.body ?? '',
      replyToSender: reply?.senderName ?? '',
      status: ChatDeliveryStatus.sending,
    );
    messages.add(optimistic);
    replyingTo = null;
    _clearTyping();
    _safeNotify();

    try {
      final uploaded = await _ds.uploadMedia(
        token: _token(),
        contributionId: contributionId,
        file: file,
        kind: kind,
        durationMs: durationMs,
      );

      final saved = await _ds.send(
        token: _token(),
        contributionId: contributionId,
        body: '',
        clientMessageId: clientId,
        kind: kind,
        mediaUrl: uploaded.mediaUrl,
        durationMs: uploaded.durationMs,
        replyToMessageId: reply?.id ?? '',
      );

      final i = messages
          .indexWhere((m) => m.clientMessageId == clientId && m.id.isEmpty);
      if (i >= 0) {
        messages[i] = saved.copyWith(status: ChatDeliveryStatus.sent);
        if (_cursor == null || saved.createdAt.isAfter(_cursor!)) {
          _cursor = saved.createdAt;
        }
      }
    } catch (_) {
      // Failing the bubble rather than dropping it: the local file is still on
      // disk, so Retry can re-upload the same bytes under the same client id.
      final i = messages
          .indexWhere((m) => m.clientMessageId == clientId && m.id.isEmpty);
      if (i >= 0) {
        messages[i] = messages[i].copyWith(status: ChatDeliveryStatus.failed);
      }
    }
    _safeNotify();
  }

  /// Re-sends a failed media bubble from the local file it still references.
  ///
  /// Kept separate from the text retry because that one re-posts a body; this
  /// has to re-upload bytes first. The client id is reused either way, so a
  /// request that actually landed returns the original row instead of posting
  /// a duplicate.
  Future<void> retryMedia(ContributionMessage failed) async {
    final local = File(failed.mediaUrl);
    if (!local.existsSync()) {
      // The temp file is gone (app restarted, OS cleaned it). Nothing can be
      // re-uploaded; say so rather than silently spinning.
      final i = messages.indexWhere(
          (m) => m.clientMessageId == failed.clientMessageId && m.id.isEmpty);
      if (i >= 0) {
        messages[i] = messages[i].copyWith(status: ChatDeliveryStatus.failed);
        _safeNotify();
      }
      return;
    }

    final i = messages.indexWhere(
        (m) => m.clientMessageId == failed.clientMessageId && m.id.isEmpty);
    if (i < 0) return;
    messages[i] = messages[i].copyWith(status: ChatDeliveryStatus.sending);
    _safeNotify();

    try {
      final uploaded = await _ds.uploadMedia(
        token: _token(),
        contributionId: contributionId,
        file: local,
        kind: failed.kind,
        durationMs: failed.durationMs,
      );
      final saved = await _ds.send(
        token: _token(),
        contributionId: contributionId,
        body: '',
        clientMessageId: failed.clientMessageId,
        kind: failed.kind,
        mediaUrl: uploaded.mediaUrl,
        durationMs: uploaded.durationMs,
        replyToMessageId: failed.replyToMessageId,
      );
      final j = messages.indexWhere(
          (m) => m.clientMessageId == failed.clientMessageId && m.id.isEmpty);
      if (j >= 0) {
        messages[j] = saved.copyWith(status: ChatDeliveryStatus.sent);
      }
    } catch (_) {
      final j = messages.indexWhere(
          (m) => m.clientMessageId == failed.clientMessageId && m.id.isEmpty);
      if (j >= 0) {
        messages[j] = messages[j].copyWith(status: ChatDeliveryStatus.failed);
      }
    }
    _safeNotify();
  }
}
