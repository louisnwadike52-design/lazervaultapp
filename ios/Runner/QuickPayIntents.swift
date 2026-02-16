import AppIntents
import UIKit

// MARK: - App Intents (iOS 16+)
// These intents power Siri, Spotlight, Back Tap, Action Button, and Control Center.

/// "Send money with LazerVault"
@available(iOS 16.0, *)
struct SendMoneyIntent: AppIntent {
    static var title: LocalizedStringResource = "Send Money"
    static var description = IntentDescription("Open LazerVault to send money")
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        await openDeepLink("lazervault://quick-action/send_money")
        return .result()
    }
}

/// "Scan to pay with LazerVault"
@available(iOS 16.0, *)
struct ScanToPayIntent: AppIntent {
    static var title: LocalizedStringResource = "Scan to Pay"
    static var description = IntentDescription("Open LazerVault QR scanner to pay")
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        await openDeepLink("lazervault://quick-action/scan_to_pay")
        return .result()
    }
}

/// "Check my balance on LazerVault"
@available(iOS 16.0, *)
struct CheckBalanceIntent: AppIntent {
    static var title: LocalizedStringResource = "Check Balance"
    static var description = IntentDescription("Open LazerVault to view your balance")
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        await openDeepLink("lazervault://quick-action/check_balance")
        return .result()
    }
}

/// "Pay bills on LazerVault"
@available(iOS 16.0, *)
struct PayBillsIntent: AppIntent {
    static var title: LocalizedStringResource = "Pay Bills"
    static var description = IntentDescription("Open LazerVault to pay your bills")
    static var openAppWhenRun: Bool = true

    func perform() async throws -> some IntentResult {
        await openDeepLink("lazervault://quick-action/pay_bills")
        return .result()
    }
}

// MARK: - App Shortcuts Provider

/// Registers shortcuts that appear in Siri, Spotlight, and the Shortcuts app.
@available(iOS 16.0, *)
struct LazerVaultShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: SendMoneyIntent(),
            phrases: [
                "Send money with \(.applicationName)",
                "Transfer funds with \(.applicationName)",
                "Pay someone on \(.applicationName)"
            ],
            shortTitle: "Send Money",
            systemImageName: "arrow.up.right"
        )
        AppShortcut(
            intent: ScanToPayIntent(),
            phrases: [
                "Scan to pay with \(.applicationName)",
                "QR pay with \(.applicationName)",
                "Scan and pay on \(.applicationName)"
            ],
            shortTitle: "Scan to Pay",
            systemImageName: "qrcode.viewfinder"
        )
        AppShortcut(
            intent: CheckBalanceIntent(),
            phrases: [
                "Check my balance on \(.applicationName)",
                "What's my \(.applicationName) balance",
                "Show balance on \(.applicationName)"
            ],
            shortTitle: "Check Balance",
            systemImageName: "wallet.pass"
        )
        AppShortcut(
            intent: PayBillsIntent(),
            phrases: [
                "Pay bills with \(.applicationName)",
                "Pay my bills on \(.applicationName)"
            ],
            shortTitle: "Pay Bills",
            systemImageName: "doc.text"
        )
    }
}

// MARK: - Deep Link Helper

@MainActor
private func openDeepLink(_ urlString: String) {
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
}
