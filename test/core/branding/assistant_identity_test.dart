import 'package:flutter_test/flutter_test.dart';

import 'package:lazervault/core/branding/assistant_identity.dart';

/// One assistant, one name.
///
/// The app shipped six: "Send Funds Assistant", "Stock AI Assistant",
/// "Insurance AI Assistant", "Invoice AI Assistant", "Voice Assistant",
/// "Chat Assistant". That reads as six products rather than one that knows
/// about six things — and the backend agents already call themselves Nova, so
/// the chat header and the agent in it disagreed.
void main() {
  test('the name is Nova and carries no service in it', () {
    expect(AssistantIdentity.name, 'Nova');
    expect(AssistantIdentity.name, isNot(contains('Assistant')));
  });

  group('statusLine keeps the context out of the name', () {
    test('service and status', () {
      expect(
        AssistantIdentity.statusLine(service: 'Send Funds', status: 'Online'),
        'Send Funds · Online',
      );
    });

    test('no service prints the status alone, not a stray separator', () {
      expect(AssistantIdentity.statusLine(status: 'Online'), 'Online');
      expect(
        AssistantIdentity.statusLine(service: '   ', status: 'Typing…'),
        'Typing…',
      );
    });
  });

  group('connection copy', () {
    test('names Nova, with the service as context', () {
      expect(AssistantIdentity.connected(service: 'Stocks'),
          'Connected to Nova · Stocks');
      expect(AssistantIdentity.disconnected(service: 'Invoices'),
          'Disconnected from Nova · Invoices');
    });

    test('the general assistant needs no suffix', () {
      expect(AssistantIdentity.connected(), 'Connected to Nova');
      expect(AssistantIdentity.disconnected(), 'Disconnected from Nova');
    });
  });
}
