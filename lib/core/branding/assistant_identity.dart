/// The assistant has one name: Nova.
///
/// It used to have as many names as there were surfaces — "Send Funds
/// Assistant", "Stock AI Assistant", "Insurance AI Assistant", "Invoice AI
/// Assistant", "Voice Assistant", "Chat Assistant" — which reads as six
/// different products rather than one that knows about six things. It is one
/// assistant; where the user is only changes what it is currently helping
/// with, and that belongs in the subtitle, not the name.
///
/// Every chat header, voice-agent header and connection message takes its name
/// from here, so the next surface cannot invent a seventh.
class AssistantIdentity {
  const AssistantIdentity._();

  /// The name shown to users. Never interpolate a service into it.
  static const String name = 'Nova';

  /// Subtitle for a per-service surface: the service, then the status.
  /// "Send Funds · Online". Context without renaming the assistant.
  ///
  /// Falls back to the status alone when there is no service (the general
  /// assistant), rather than printing a stray separator.
  static String statusLine({String? service, required String status}) {
    final s = (service ?? '').trim();
    if (s.isEmpty) return status;
    return '$s · $status';
  }

  /// "Connected to Nova" / "Disconnected from Nova" — the copy shown when a
  /// voice session opens or closes.
  static String connected({String? service}) {
    final s = (service ?? '').trim();
    return s.isEmpty ? 'Connected to $name' : 'Connected to $name · $s';
  }

  static String disconnected({String? service}) {
    final s = (service ?? '').trim();
    return s.isEmpty ? 'Disconnected from $name' : 'Disconnected from $name · $s';
  }
}
