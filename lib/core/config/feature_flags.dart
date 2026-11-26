import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'voice_language_availability.dart';

/// Lightweight client-side feature-flag cache.
///
/// Backed by SharedPreferences so admin-side flips survive cold-start, and
/// re-hydrated from the admin/system_settings endpoint on each app launch
/// (call [FeatureFlags.refresh] from a startup hook that has the cached
/// settings map — same place the EndpointRegistry refresh is wired).
///
/// New flags should be:
///   1) Declared as a `static const String` key.
///   2) Exposed via a getter that returns the SharedPreferences value, with
///      a safe default if the key hasn't been seeded yet.
///   3) Hidden-by-default if exposing the surface costs us anything.
class FeatureFlags {
  /// Bumped every time a fresh admin snapshot is applied.
  ///
  /// Flags are read SYNCHRONOUSLY from SharedPreferences so a build method
  /// never waits on the network — that part was already right and is not
  /// changed here. What was missing is the other half: the background poll
  /// re-applies the snapshot mid-session, but nothing told the widget tree, so
  /// a flip landed in storage and the running session kept rendering the old
  /// value until some unrelated rebuild happened to occur. For a kill switch
  /// that meant "takes effect whenever the user next restarts the app".
  ///
  /// Gated surfaces listen via [ValueListenableBuilder] and repaint when this
  /// changes. Still zero awaits on the render path.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  // ── Existing flags ────────────────────────────────────────────────────────
  static const String useNewTransferApi = 'use_new_transfer_api';

  // ── Dashboard section visibility (admin-toggled) ──────────────────────────
  // Key the admin-side system_settings table uses. The toggle is intentionally
  // OFF by default — the Cards card on the dashboard is hidden from the user
  // until the admin flips the flag from Flutter Service Configs in the
  // admin dashboard. Code path is otherwise unchanged, so flipping the flag
  // back to true restores the section without redeploy.
  static const String dashboardCardsSectionVisible =
      'dashboard_cards_section_visible';

  // Visibility of the "Voice & Chat Assistant" accordion on the Settings page.
  // OFF by default — hidden until an admin flips this key from the admin
  // dashboard Feature Flags tab. Flip to true to restore it with no redeploy.
  static const String voiceChatAssistantSectionVisible =
      'voice_chat_assistant_section_visible';

  // Crowdfund "Donation alerts" menu entry (Telegram / WhatsApp / webhook
  // channel configuration for a campaign creator). HIDDEN by default per the
  // rule above — the surface is creator-only config that isn't ready to expose,
  // and the route stays reachable in code so flipping the flag in the admin
  // dashboard restores it with no redeploy.
  static const String crowdfundDonationAlertsVisible =
      'crowdfund_donation_alerts_visible';

  // Referral leaderboard — the public ranking of top referrers on the
  // Referral dashboard. HIDDEN by default per the rule above: it exposes
  // other customers' names and referral counts to every user, which is a
  // disclosure decision an operator should make deliberately rather than one
  // that ships switched on.
  //
  // The screen renders without it, and the fetch is SKIPPED entirely while
  // the flag is off — a hidden surface should not cost a network round trip
  // on every dashboard open.
  static const String referralLeaderboardVisible =
      'referral_leaderboard_visible';

  /// Show/hide the "Remove this fund" CTA on the Lazerfund details screen.
  static const String upliftRemoveCtaVisible = 'uplift_remove_cta_visible';

  // ── International payout (Exchange → Send Abroad) ────────────────────────
  //
  // OFF by default, because the Fincra corridor it runs on is not finished.
  // Left on, the tab collects a recipient, an amount and a PIN and only then
  // fails at the provider — the worst possible order, since the user has already
  // committed to a transfer that was never going to complete.
  //
  // Defaulting to false also makes a cold start safe: before the first settings
  // fetch the app assumes unavailable and says so, rather than opening a flow it
  // cannot finish. Turning it on later needs no app release.
  static const String intlPayoutEnabled = 'intl_payout_enabled';

  /// Which explanation the Send Abroad tab shows while payout is off:
  /// 'generic' (default) | 'account' | 'country'.
  ///
  /// Separate from the switch because the honest reason changes as the
  /// integration lands. A corridor live in some countries is not the same as one
  /// live for nobody, and telling a user "not available for your account" while
  /// it is off for everyone sends them to support about an account that is fine.
  static const String intlPayoutUnavailableScope =
      'intl_payout_unavailable_scope';

  /// Whether Send Abroad can actually complete a transfer right now.
  ///
  /// False until an admin turns it on — see the key doc above for why the
  /// default is closed rather than open.
  static bool get intlPayoutAvailable =>
      _prefs?.getBool(intlPayoutEnabled) ?? false;

  // ── Group Funds, admin-tunable ───────────────────────────────────────────
  //
  // Three switches, from the whole feature down to which KIND of contribution
  // may be created. All default ON, so an unset key leaves today's behaviour
  // and an operator never has to seed a row to keep things working.
  //
  // Why type-level and not just one switch: the two products carry different
  // risk. A one-time goal pays out once to a named person. An esusu is a
  // rotating obligation across months, where one member walking away leaves
  // the others short — so it is the half an operator may want to withdraw
  // while leaving the rest of the feature running.
  //
  // These are a UI gate. The server refuses a disabled type as well, because
  // an app already installed cannot be prevented from asking.
  static const String groupFundsEnabled = 'group_funds_enabled';
  static const String groupFundsOneTimeEnabled = 'group_funds_one_time_enabled';
  static const String groupFundsEsusuEnabled = 'group_funds_esusu_enabled';

  // Piggyvault: whether a new plan is held for review before its term starts.
  //
  // THE OPERATIONAL REALITY THIS DESCRIBES. Piggyvault deposits are placed
  // with an asset-management company by hand today — there is no API. So a
  // plan cannot begin earning the moment somebody taps Confirm: the money has
  // not reached the company that generates the return. An operator moves it,
  // then approves the plan, and the term starts there.
  //
  // The app needs this BEFORE the deposit, not after. The create response
  // carries the plan's real status and every screen renders it honestly, but
  // by then the user has already paid on the strength of a maturity date and
  // an interest projection. If those start at approval rather than at tap,
  // the wizard has to say so while they can still decide.
  //
  // Mirrors `piggyvault_manual_activation` in accounts-service, which fails
  // toward waiting for the same reason this getter defaults to true: holding
  // a plan costs a delay an operator can clear in a click, while promising
  // returns on money nobody has placed anywhere cannot be clicked back.
  static const String piggyvaultManualActivation =
      'piggyvault_manual_activation';

  /// Whether Group Funds is available at all. Default true.
  ///
  /// DEPRECATED for gating the entry point — use [groupFundsAvailableFor],
  /// which also honours the whitelist. Kept because the contribution-type
  /// getters below compose with it and their own semantics are unchanged.
  static bool get groupFundsAvailable =>
      _prefs?.getBool(groupFundsEnabled) ?? true;

  /// Whether Group Funds is available TO THIS USER.
  ///
  /// Group Funds is the one gate that read its switch as a plain boolean and
  /// never consulted the whitelist, unlike every `quick_service_*` and
  /// `feature_*` gate. The backend side already supports it — the
  /// financial-gateway rule for GroupAccountService resolves
  /// `group_funds_whitelist` through featuregate.Allowed — so switching the
  /// feature off and whitelisting one person let that person's RPCs through
  /// while the app still hid the tile from them. The gate was off, the
  /// override was server-only, and the result was a feature nobody could
  /// reach.
  ///
  /// So: the whitelist is an OVERRIDE, matching the server's precedence —
  /// whitelisted(…) OR the switch — which is what makes "off for everyone
  /// except these emails" expressible at all.
  static bool groupFundsAvailableFor(String? email) =>
      whitelisted(groupFundsPrefix, email) || groupFundsAvailable;

  /// Whitelist key prefix for Group Funds.
  ///
  /// `group_funds` rather than a `quick_service_`/`feature_` prefix because
  /// that is the gate name the financial-gateway rule already uses, and the
  /// whole point of a single name is that the app and the gateway cannot
  /// disagree about who is allowed in.
  static const String groupFundsPrefix = 'group_funds';

  /// Whether a one-time contribution may be created. Default true.
  static bool get groupFundsOneTimeAvailable =>
      _prefs?.getBool(groupFundsOneTimeEnabled) ?? true;

  /// Whether an esusu (rotating savings) contribution may be created.
  /// Default true.
  static bool get groupFundsEsusuAvailable =>
      _prefs?.getBool(groupFundsEsusuEnabled) ?? true;

  /// Whether a new Piggyvault plan is reviewed before it starts earning.
  ///
  /// Default TRUE, which is the opposite of nearly every other flag here, and
  /// deliberately: the safe answer when we do not know is the one that
  /// promises the user less. See [piggyvaultManualActivation].
  static bool get piggyvaultPlansAreReviewed =>
      _prefs?.getBool(piggyvaultManualActivation) ?? true;

  /// Whether ANY contribution type can be created right now.
  ///
  /// Both types off is a valid configuration — an operator parking new
  /// contributions while leaving existing ones running — so the create
  /// surface has to have something to say about it rather than opening a
  /// wizard with an empty type picker.
  /// Whitelist-aware, so a user who can SEE Group Funds can also use it.
  /// Composing with the plain switch instead would show a whitelisted user the
  /// tile and then refuse them the create flow behind it.
  static bool groupFundsCanCreateContributionFor(String? email) =>
      groupFundsAvailableFor(email) &&
      (groupFundsOneTimeAvailable || groupFundsEsusuAvailable);

  static bool get groupFundsCanCreateContribution =>
      groupFundsAvailable &&
      (groupFundsOneTimeAvailable || groupFundsEsusuAvailable);

  /// Normalised unavailability scope. Anything unrecognised — including a value
  /// written before this app version knew about it — falls back to 'generic',
  /// which is the only message that is true regardless of why it is off.
  static String get intlPayoutScope {
    final raw =
        _prefs?.getString(intlPayoutUnavailableScope)?.trim().toLowerCase();
    switch (raw) {
      case 'account':
      case 'country':
        return raw!;
      default:
        return 'generic';
    }
  }

  // African voice-language master gate (admin). OFF by default → the voice/chat
  // assistant is English-only and African languages (yo/ig/ha/pcm) are HIDDEN in
  // the language pickers. The server /voice/languages already filters by this; this
  // client copy is defense-in-depth for the offline fallback list.
  static const String voiceAfricanLanguagesEnabled =
      'voice_african_languages_enabled';

  // ── Quick-service landing entrance animation (admin-toggled) ──────────────
  // When ON (DEFAULT), tapping a quick service from the dashboard animates the
  // landing screen's content in — slide up from below + fade — exactly like the
  // Insurance landing. Admins can turn it OFF platform-wide from the admin
  // dashboard (no redeploy) if the motion is undesirable. Mirrored from
  // system_settings via the same internal endpoint the app already polls.
  static const String serviceEntranceAnimationEnabled =
      'mobile_service_entrance_animation_enabled';

  // ── Send Funds (transfer) flow config (admin-toggled) ─────────────────────
  // Read after login + cached (EndpointRegistry → applyRemoteSnapshot) so they
  // resolve instantly and survive poor networks via the cached value.
  //
  // sendFundsShortFlowEnabled: true (DEFAULT) = the streamlined short flow
  //   (inline recipient → amount → PIN → receipt) — the product default for
  //   every user on signup. An admin may set this false to make the long flow
  //   the platform default; a per-user setting still overrides either way.
  static const String sendFundsShortFlowEnabled =
      'send_funds_short_flow_enabled';
  // Persisted "last resolved" Send Funds flow (short=true/long=false). Written
  // through whenever the session pin is (re)resolved so the value survives a
  // logout/cold-start and can be loaded into memory at boot for INSTANT, offline
  // routing — the fresh admin/override value is revalidated on the next login in
  // the background and re-persisted only if it changed. See [pinSendFlowForSession].
  static const String sendFlowPinned = 'send_flow_pinned_short';
  // sendFundsPinRequired: true (DEFAULT) = transaction PIN required to send.
  //   This is a UI gate ONLY — the authoritative check is server-side in
  //   core-payments-service SendFunds. Default ON for safety.
  static const String sendFundsPinRequired = 'send_funds_pin_required';

  // SAVED-PAYEE MATCHING IN THE ACCOUNT-NUMBER FIELD.
  //
  // As the payer types an account number, their own saved recipients are
  // matched against the digits so far and offered in the prediction overlay —
  // before, and independently of, the bank name-enquiry, which costs seconds.
  //
  // savedPayeeMinDigits is a disclosure threshold as much as a convenience
  // one: the overlay floats over the form, so matching from a single digit
  // puts a slice of the payer's payee book on screen for anyone stood behind
  // them. savedPayeeMaxRows bounds the height of that overlay.
  //
  // Both are INTEGERS stored verbatim and parsed on read, so a malformed admin
  // value degrades to the default rather than throwing during boot.
  static const String savedPayeeMinDigitsKey =
      'send_funds_saved_payee_min_digits';
  static const String savedPayeeMaxRowsKey = 'send_funds_saved_payee_max_rows';

  // How many saved payees the as-you-type matcher holds in memory.
  //
  // NOT the same number as savedPayeeMaxRows, which bounds how many matches
  // are SHOWN. This bounds how many are SEARCHED, and the two were conflated
  // by accident rather than by decision: the snapshot was fed from the
  // recipients list's own first page of twenty, so a payer with more saved
  // payees than that could type the exact account number of the twenty-first
  // and be offered nothing. A page boundary is invisible to the payer, so it
  // reads as the feature not working at all.
  //
  // Tunable because the right number is "however many payees your users
  // actually keep", which is an operations question and not a code one.
  static const String savedPayeeSnapshotRowsKey =
      'send_funds_saved_payee_snapshot_rows';

  // The payout provider's floor for an NGN bank transfer, in KOBO.
  //
  // Mirrored from the SAME system_settings row core-payments enforces
  // (external_payout_floor_minor) so the amount screen can refuse a too-small
  // transfer before the PIN, against the server's number rather than one of
  // its own. A second copy of this value is how the UI comes to permit what
  // the server refuses.
  static const String externalPayoutFloorMinorKey =
      'external_payout_floor_minor';

  // ── Upload ceilings, admin-tunable ───────────────────────────────────────
  //
  // Both halves of "max uploads" were constants compiled into the app: the
  // gallery and attachment rows had NO count limit at all, and the file-size
  // ceilings were `static const _maxFileSize = 10 * 1024 * 1024` inside each
  // uploader. Raising or lowering either meant a release, and a store review,
  // for a number an operator should be able to turn.
  //
  // Counts are enforced server-side too (financial-products reads the same
  // keys from its own system_settings) — these copies exist so the picker can
  // stop at the limit instead of letting someone upload an eleventh file and
  // then taking it back.
  static const String upliftFundGalleryMaxImagesKey =
      'uplift_fund_gallery_max_images';
  static const String upliftApplicationMaxImagesKey =
      'uplift_application_max_images';
  static const String upliftApplicationMaxDocumentsKey =
      'uplift_application_max_documents';
  static const String mediaMaxImageMbKey = 'media_max_image_mb';
  static const String mediaMaxVideoMbKey = 'media_max_video_mb';

  // ── Receipt footer, admin-tunable ────────────────────────────────────────
  //
  // Every shareable receipt — PDF, and the PNG/JPG produced by capturing a
  // receipt screen — carried its own copy of the company name and the legal
  // disclaimer. Sixteen PDF services and fifteen screens, all hardcoded, so
  // correcting a legal detail meant a code change and a store release in
  // every one of them. That is exactly what happened here: the registered
  // name is "Lazervault LTD" and the receipts said "Lazervault Technologies
  // Ltd", a company that does not exist.
  //
  // Stored verbatim and resolved on read, so a blank or malformed admin value
  // degrades to the built-in default rather than printing an empty footer on
  // a document the user keeps as proof of payment.
  static const String receiptFooterCompanyKey = 'receipt_footer_company';
  static const String receiptFooterDisclaimerKey = 'receipt_footer_disclaimer';
  static const String receiptFooterSupportKey = 'receipt_footer_support';

  // spraymeLikeSoundKey: false (DEFAULT) = tapping to like in a Lazerspray room
  //   is silent. Admin-tunable so the sound can be restored without a release.
  static const String spraymeLikeSoundKey = 'sprayme_like_sound_enabled';
  // spraymeRecordingEnabled: false (DEFAULT) = the Record control is hidden
  //   from a LazerSpray broadcast and no recording egress can be started from
  //   the app. Off because a recording is a full-length video file per live
  //   and the platform does not have the storage to hold them yet; a host who
  //   could press Record would be promised a replay that cannot be kept.
  //   Admin-tunable so it comes back the day storage does, with no release.
  static const String spraymeRecordingEnabled = 'sprayme_recording_enabled';

  // ── Batch-transfer flow config (admin-toggled, mirrors send-funds) ────────
  // batchTransferShortFlowEnabled: false (DEFAULT) = current long flow
  //   (entry → multiselect → review → processing → receipt); true = the
  //   streamlined short flow (compose → PIN → receipt).
  static const String batchTransferShortFlowEnabled =
      'batch_transfer_short_flow_enabled';
  // batchTransferPinRequired: true (DEFAULT) = transaction PIN required. UI gate
  //   ONLY — authoritative check is server-side in core-payments BatchTransfer.
  static const String batchTransferPinRequired = 'batch_transfer_pin_required';

  // ── Scan Account Details (OCR) config (admin-toggled) ─────────────────────
  // scanAccountDetailsEnabled: true (DEFAULT) = the "Scan Account Details"
  //   quick action + scan history are shown; false hides them.
  static const String scanAccountDetailsEnabled =
      'scan_account_details_enabled';
  // scanResolveUsersEnabled: true (DEFAULT) = a scanned phone/email/username
  //   resolved to a Lazervault user is offered as a free internal transfer;
  //   false ignores resolution (bank/external routing only). UI gate.
  static const String scanResolveUsersEnabled = 'scan_resolve_users_enabled';

  /// Platform default participant layout for a Lazerspray live
  /// ('grid' | 'sidebar' | 'spotlight'). A STRING, not a boolean — mirrored
  /// verbatim below and parsed by `sprayLayoutModeFromSetting`, which falls
  /// back to grid for anything it does not recognise. A viewer's own choice
  /// inside a room always beats this.
  static const String spraymeDefaultLayoutMode = 'sprayme_default_layout_mode';

  /// The admin-configured default spray layout, or null when it has never been
  /// fetched. Null means "use the built-in default" — the caller decides, so a
  /// missing setting and an explicit 'grid' stay distinguishable.
  static String? get spraymeLayoutMode {
    final raw = _prefs?.getString(spraymeDefaultLayoutMode)?.trim();
    return (raw == null || raw.isEmpty) ? null : raw;
  }

  /// Standalone BVN-capture screen in signup (admin-toggled). OFF by default:
  /// the default onboarding uses the Mono Prove flow, whose completion webhook
  /// already auto-creates the Flutterwave virtual account server-side. When the
  /// admin turns this ON, signup shows the dedicated BVN screen after the
  /// transaction-PIN step. Read via [isBvnSignupScreenEnabled].
  static const String bvnSignupScreenEnabled = 'bvn_signup_screen_enabled';

  // ── Platform authentication mode (admin-selected) ─────────────────────────
  // Single mutually-exclusive enum mirrored from system_settings(auth_mode):
  //   'email_password' (DEFAULT) | 'phone_passcode'
  // Decides which signup/login flow brand-new / logged-out users see. Existing
  // users keep their own per-account method regardless of this value. Stored as
  // a STRING (not a bool) and read synchronously at boot to pick the flow.
  // Defaults to email_password so there is zero change until an admin flips it.
  static const String authMode = 'auth_mode';
  static const String authModeEmailPassword = 'email_password';
  static const String authModePhonePasscode = 'phone_passcode';

  /// Canonical per-user resolved login flow (see [loginFlow]). Distinct from the
  /// platform [authMode]: this is what the specific account/user should see.
  static const String effectiveLoginMethod = 'effective_login_method';

  // ── Onboarding verification requirement toggles (admin-tunable) ───────────
  // When ON, the onboarding email/phone verification step is NOT skippable and
  // the backend enforces it at signup + login. OFF by default (skippable) — zero
  // change until an admin flips it. Mirrored from system_settings via the same
  // internal endpoint + GetAuthenticationConfig.
  static const String emailVerificationRequired = 'email_verification_required';

  /// Whether identity verification (KYC) is a REQUIRED step, admin-tunable.
  ///
  /// This single switch decides which of two shapes the product takes, and it
  /// is read in both the signup flow and the post-login router so the two can
  /// never disagree:
  ///
  ///   ON  — KYC is a step of onboarding like any other. An account that has
  ///         not completed it resumes INTO verification on every login and
  ///         there is no skip. Services that need KYC are simply unreachable
  ///         because the dashboard is.
  ///   OFF — the dashboard is reachable immediately. Verification is asked for
  ///         once per login as a dismissible prompt, and the individual
  ///         services that genuinely require it keep their own gates.
  ///
  /// Named `_on_signup` because that is where it was first asked for, but it
  /// governs every entry point — a user who signed up while it was off and
  /// comes back after an admin turns it on is gated on their next login, which
  /// is the point of it being a platform setting rather than a signup-time
  /// snapshot.
  static const String kycRequiredOnSignup = 'kyc_required_on_signup';
  static const String phoneVerificationRequired = 'phone_verification_required';
  static const String socialLoginEnabledKey = 'social_login_enabled';
  static const String googleLoginEnabledKey = 'google_login_enabled';
  static const String appleLoginEnabledKey = 'apple_login_enabled';
  static const String voiceLoginEnabledKey = 'voice_login_enabled';

  // ── Auto-logon (admin-toggled) ────────────────────────────────────────────
  // When ON (DEFAULT), a returning user who has OPTED INTO biometric login and
  // has an enrolled sensor is auto-prompted with the OS Face ID / fingerprint
  // sheet the instant the passcode lock screen appears — a one-tap "auto logon".
  // This NEVER bypasses authentication: it only fires the native OS prompt for
  // users who already enabled it, and it silently no-ops (falls back to the
  // passcode keypad) when biometric isn't ready. Admins can turn it OFF
  // platform-wide from the admin dashboard with no redeploy. Mirrored from
  // system_settings via the same internal endpoint the app already polls.
  static const String autoBiometricLoginEnabled =
      'auto_biometric_login_enabled';

  // ── Appearance ────────────────────────────────────────────────────────────
  // Whether Settings shows the light/dark theme switch at all.
  //
  // OFF by default: the app's surfaces are not all audited for light mode, so
  // a user who flips it can land on a screen that was only ever designed dark.
  // Turning it on is a deliberate act once that audit is done, not something
  // that ships silently with a release.
  static const String themeSwitchVisible = 'theme_switch_visible';

  // ── Receipts ──────────────────────────────────────────────────────────────
  // Whether sharing a transfer receipt offers the PDF / JPG format sheet.
  //
  // OFF by default: the sheet adds a choice most people do not want to make,
  // between two formats that carry the same information. With it off the share
  // goes straight out in the default format.
  static const String receiptFormatSheetVisible =
      'receipt_format_sheet_visible';

  // ── Insurance hosted-webview entry points (admin-toggled) ─────────────────
  // When ON, the in-app "Buy" and "Manage Plan" insurance entry points open
  // MyCover's universal hosted webview (insuranceHostedLink) in a themed
  // bottom sheet instead of the native in-app flow. Renew/Claim are unchanged.
  // Mirrored from system_settings via the same internal endpoint the app
  // already polls. OFF by default — zero change until an admin flips it.
  static const String insuranceHostedEntrypointsEnabled =
      'insurance_hosted_entrypoints_enabled';
  // The universal MyCover merchant link (string). The Buy/Manage entry points
  // compose the per-user URL from this base client-side (append email/phone/
  // client_reference). Empty by default → hosted mode unavailable even if the
  // toggle is on (the sheet renders an "unavailable" state).
  static const String insuranceHostedLink = 'insurance_hosted_link';

  /// Whether the Insurance service is shown at all (tiles + All-Services
  /// search). Admin-toggled; the code stays in place either way.
  ///
  /// Defaults to FALSE — hidden. The app must not flash Insurance during the
  /// window before the remote snapshot arrives (first launch, offline start, a
  /// slow or failed settings call), so "unknown" has to mean hidden. A default
  /// of true would show it every cold start until the network answered.
  static const String insuranceEnabled = 'insurance_enabled';

  // ── Locale gating ────────────────────────────────────────────────────────
  //
  // Outside Nigeria the platform is not fully operational: there is no deposit
  // rail (the provider cannot issue per-customer foreign-currency virtual
  // accounts), so most services have nothing to move money with. Rather than
  // let a user in another region walk into flows that cannot complete, the
  // dashboard shows only what genuinely works there.
  //
  // Every part of it is admin-tunable, because "what works outside NGN" is a
  // commercial fact that changes when a corridor opens — and it must change
  // without an app release.
  static const String localeGatingEnabled = 'locale_gating_enabled';

  /// CSV of AppServiceName values that remain visible outside NGN.
  static const String localeNonNgnServices = 'locale_non_ngn_services';

  /// CSV of bottom-nav tab labels disabled outside NGN.
  static const String localeNonNgnNavDisabled = 'locale_non_ngn_nav_disabled';

  /// CSV of AI-insights scopes enabled outside NGN.
  static const String localeNonNgnAiScopes = 'locale_non_ngn_ai_scopes';

  /// CSV of discovery sections on the dashboard shown outside NGN.
  static const String localeNonNgnDashboardSections =
      'locale_non_ngn_dashboard_sections';

  /// CSV of ACCOUNT TYPES a user can hold and operate outside NGN.
  static const String localeNonNgnAccountTypes = 'locale_non_ngn_account_types';

  /// CSV of MONEY-MOVEMENT actions offered outside NGN: `deposit`, `withdraw`.
  static const String localeNonNgnMoneyActions = 'locale_non_ngn_money_actions';

  /// CSV of ACCOUNT-DETAILS tabs shown outside NGN: `controls`, `limits`,
  /// `documents`, `help`.
  static const String localeNonNgnAccountTabs = 'locale_non_ngn_account_tabs';

  // Whether the Bulk SMS service tile is visible anywhere in the app.
  // Hidden by default (product decision 2026-09-07); an admin can restore it
  // from the dashboard Feature Flags tab without a release.
  static const String bulkSmsVisibleKey = 'bulk_sms_visible';

  /// Master switch for merchant card acceptance (SoftPOS).
  static const String cardAcceptanceVisibleKey = 'card_acceptance_visible';

  /// Whether the consolidated "WhatsApp/Phone Banking" Quick Services tile is
  /// shown. Admin-tunable; hidden by DEFAULT — see [phoneBankingVisible].
  static const String phoneBankingVisibleKey = 'phone_banking_visible';

  /// The accent the AI chat is painted in for a user who has never chosen one.
  ///
  /// A STRING, not a colour: it names one of the accents the app ships
  /// (purple, indigo, teal, emerald, amber, rose), so a deployment can brand
  /// the assistant without an app release and a value this build does not
  /// know simply falls back instead of painting nothing. A user's own choice
  /// always wins over it.
  static const String chatDefaultAccentKey = 'chat_default_accent';

  /// The Lifestyle hub's layout for a user who has never chosen one.
  ///
  /// A STRING naming a [LifestyleViewMode] — banner, grid or list — so the
  /// default can be changed from the admin dashboard without an app release,
  /// and a value this build does not know falls back to the app's own default
  /// rather than rendering nothing. A user's own choice always wins over it,
  /// exactly like [chatDefaultAccentKey].
  static const String lifestyleDefaultViewKey = 'lifestyle_default_view';

  /// Whether the RMB (China cross-border) transfer tile is shown.
  ///
  /// Hidden by DEFAULT. The rail is in maintenance while its provider sits in
  /// sandbox, so the entry point was in front of people who could not
  /// complete a transfer behind it. Routes and deep links stay registered, so
  /// turning it on in the admin dashboard is the only change needed to bring
  /// it back — nothing has to be rebuilt or redeployed.
  static const String rmbTransferVisibleKey = 'rmb_transfer_visible';

  /// Whether the Exchange screen's "Send Abroad" tab is shown at all.
  ///
  /// Distinct from [intlPayoutEnabled], which decides whether a Send Abroad
  /// transfer can COMPLETE and, while off, makes the tab explain why. That
  /// still puts a tab in front of people for a rail that cannot run. This key
  /// removes the tab, leaving Convert as the only mode, and is the switch an
  /// operator uses to decide whether the feature is visible at all.
  ///
  /// Hidden by DEFAULT, for the same reason the payout switch is closed by
  /// default: the corridor behind it is unfinished, and a cold start before
  /// the first settings fetch should not flash a tab that is about to vanish.
  /// Nothing else is withdrawn - the mode, the cubit, the recipient screen and
  /// every route stay registered, so turning it on in the admin dashboard is
  /// the only change needed to bring it back.
  static const String exchangeSendAbroadVisibleKey =
      'exchange_send_abroad_visible';

  // ── Airtime landing tabs (admin-toggled) ─────────────────────────────────
  // Show/hide each of the three Airtime tabs (Buy / International / Sell) from
  // the admin dashboard. Buy + International default ON; Sell (airtime-to-cash)
  // defaults OFF. Read via FeatureFlags at build time so the airtime screen only
  // renders the enabled tabs (and lands on the first enabled one).
  static const String airtimeTabBuyEnabled = 'airtime_tab_buy_enabled';
  static const String airtimeTabInternationalEnabled =
      'airtime_tab_international_enabled';
  static const String airtimeTabSellEnabled = 'airtime_tab_sell_enabled';

  /// Split an invoice among several tagged payers. OFF by default — most
  /// invoices have one payer, and the split UI adds a step (and a whole share
  /// model) to every invoice. Admins turn it on per platform.
  static const String invoiceSplitEnabled = 'invoice_split_enabled';

  // ── App auto-update (store version check) ─────────────────────────────────
  // Per-platform "latest" + "minimum supported" build numbers + store URLs,
  // mirrored from system_settings via the same internal endpoint the app polls.
  // AppUpdateService compares the running PackageInfo build number against these:
  //   build < latest → optional banner/modal; build < min → blocking gate.
  // Build numbers are monotonic integers stored as strings. OTA code-push handles
  // Dart-only OTA patches separately; these keys cover
  // native/store updates OTA code-push can't deliver.
  static const String appUpdateEnabledKey = 'app_update_enabled';
  static const String appLatestVersionIos = 'app_latest_version_ios';
  static const String appLatestBuildIos = 'app_latest_build_ios';
  static const String appMinBuildIos = 'app_min_build_ios';
  static const String appStoreUrlIos = 'app_store_url_ios';
  static const String appLatestVersionAndroid = 'app_latest_version_android';
  static const String appLatestBuildAndroid = 'app_latest_build_android';
  static const String appMinBuildAndroid = 'app_min_build_android';
  static const String appStoreUrlAndroid = 'app_store_url_android';
  static const String appUpdateNotesKey = 'app_update_notes';

  // ── Planned maintenance (operator-declared) ───────────────────────────────
  // A DECLARED maintenance window, which is a different fact from the app
  // DISCOVERING the backend is unreachable. The startup gate already shows a
  // maintenance screen, but only by inferring one from a failed health probe —
  // which cannot tell a planned deploy from a real outage, cannot be switched
  // on before the work begins, and cannot be switched off until the probe
  // recovers.
  //
  // Defaults OFF, and must: a flag that fails ON would black out the app the
  // first time a settings fetch returned nothing.
  //
  // This is a NOTICE, not a kill switch. Every backend worker, reconciler,
  // settlement sweep and provider webhook keeps running, so money already in
  // flight still completes and is still reconciled.
  static const String maintenanceModeEnabledKey = 'maintenance_mode_enabled';
  static bool get maintenanceModeEnabled =>
      _prefs?.getBool(maintenanceModeEnabledKey) ?? false;

  /// Operator copy for the maintenance screen. Empty → the app's own wording.
  static const String maintenanceMessageKey = 'maintenance_message';
  static String get maintenanceMessage =>
      (_prefs?.getString(maintenanceMessageKey) ?? '').trim();

  /// WHO STILL GETS IN DURING A DECLARED MAINTENANCE WINDOW.
  ///
  /// Comma-separated emails and/or user ids. An operator putting the app
  /// behind the maintenance notice almost always needs somebody — themselves,
  /// a tester, a support responder — to keep using it and confirm the fix
  /// before the notice comes down. Without this the only way to check is to
  /// turn maintenance off for everybody.
  ///
  /// THIS ONLY EVER APPLIES TO A DECLARED WINDOW. It is read inside the
  /// `maintenanceModeEnabled` branch of the startup gate and nowhere else, so
  /// it cannot let anyone past a genuine outage: if the backend is returning
  /// 5xx or is unreachable, being on this list changes nothing, because there
  /// is no working backend to be let through to. A whitelist that suppressed a
  /// REAL outage notice would hand a tester a broken app with no explanation —
  /// the opposite of what it is for.
  ///
  /// Matching is case-insensitive and whitespace-tolerant: these are typed by
  /// a human into a dashboard field.
  static const String maintenanceWhitelistKey = 'maintenance_whitelist';

  // ---------------------------------------------------------------------
  // PIGGYVAULT PROVIDER DISCLOSURE.
  //
  // PiggyVault is powered by Swiftlynx, and the app has to say so where the
  // product is used. Same shape as the crypto risk disclosure: an
  // admin-settable URL opened in the in-app PartnerWebViewScreen, with a
  // PUBLISHED FALLBACK so the disclosure is never unreachable because nobody
  // filled the field in. A compliance surface that can be switched off by
  // leaving a setting blank is not a compliance surface.
  static const String piggyvaultDisclosureUrlKey = 'piggyvault_disclosure_url';

  /// THE ATTRIBUTION LINE, AND IT IS EMPTY UNTIL AN OPERATOR WRITES ONE.
  ///
  /// "Piggyvault is powered by Swiftlynx." was compiled in. Who powers a
  /// product is a commercial fact that changes without a release, and a
  /// hardcoded partner name is a claim the app keeps making after it stops
  /// being true. Operator decision 2026-11-24: show nothing for now.
  ///
  /// The DISCLOSURE ITSELF is unaffected — the CTA below always renders and
  /// always has a URL. Only the line of prose above it is optional, which is
  /// the right way round: the compliance surface is not what we made
  /// switchable.
  static const String piggyvaultProviderTextKey = 'piggyvault_provider_text';

  /// Blank unless an operator has set one. Deliberately NOT defaulted to the
  /// old sentence: an unset value means "say nothing", not "say what we used
  /// to say".
  static String get piggyvaultProviderText =>
      (_prefs?.getString(piggyvaultProviderTextKey) ?? '').trim();

  /// The disclosure URL. Falls back to the published page rather than ever
  /// returning empty — the CTA must always have somewhere to go.
  static String get piggyvaultDisclosureUrl {
    final configured =
        (_prefs?.getString(piggyvaultDisclosureUrlKey) ?? '').trim();
    return configured.isNotEmpty
        ? configured
        : 'https://lazervault.app/legal/piggyvault';
  }

  static String get maintenanceWhitelistRaw =>
      (_prefs?.getString(maintenanceWhitelistKey) ?? '').trim();

  /// The list, normalised. Empty when nobody is whitelisted, which is the
  /// default and means the notice applies to everyone.
  static List<String> get maintenanceWhitelist => maintenanceWhitelistRaw
      .split(RegExp(r'[,\s]+'))
      .map((e) => e.trim().toLowerCase())
      .where((e) => e.isNotEmpty)
      .toList(growable: false);

  /// Whether any of [identities] — an email, a user id, or a phone — is on the
  /// maintenance whitelist.
  ///
  /// WHAT ARRIVES HERE IS A LIST OF DIGESTS, NOT ADDRESSES. The settings poll
  /// this key comes down on answers unauthenticated callers, so admin-gateway
  /// replaces every entry with its SHA-256 before serving the app (see
  /// maintenance_whitelist_privacy.go there). The team's email addresses and
  /// phone numbers would otherwise sit in a public response body and in every
  /// installation's SharedPreferences. So we hash the identity we hold and
  /// compare digest to digest, which answers the only question this gate asks
  /// — "is the person holding this phone on the list" — and discloses nothing
  /// about anyone else.
  ///
  /// Lowercased before hashing, matching the server, because an operator types
  /// `Firstname.Lastname@…` and a case-sensitive compare would lock them out
  /// silently. Entries that are not 64 hex chars are ignored rather than
  /// compared raw: accepting a plaintext entry here would quietly undo the
  /// server-side change the first time a stale value was cached.
  ///
  /// Takes the candidates rather than reading storage itself so it stays a
  /// pure function: the caller owns the async identity lookup and this stays
  /// testable without a device.
  static bool maintenanceAllows(Iterable<String?> identities) {
    final digests =
        maintenanceWhitelist.where((e) => e.length == 64 && _isHex(e)).toSet();
    if (digests.isEmpty) return false;
    for (final raw in identities) {
      final id = (raw ?? '').trim().toLowerCase();
      if (id.isEmpty) continue;
      if (digests.contains(sha256.convert(utf8.encode(id)).toString())) {
        return true;
      }
    }
    return false;
  }

  static bool _isHex(String s) {
    for (final c in s.codeUnits) {
      final hex = (c >= 0x30 && c <= 0x39) || // 0-9
          (c >= 0x61 && c <= 0x66); // a-f (the digest is lowercased already)
      if (!hex) return false;
    }
    return true;
  }

  // ---------------------------------------------------------------------
  // SMS DND delivery help.
  //
  // Nigerian networks let a subscriber put their line on the NCC "Do Not
  // Disturb" register, which blocks SMS on promotional routes. Our OTPs ask
  // for the corporate/OTP route, but a provider may silently downgrade the
  // route when the sender ID is not registered for it — and on a downgraded
  // route a DND line receives NOTHING while the provider reports success.
  //
  // So when a customer has waited out the first cooldown and still has no
  // code, DND is a genuinely likely cause and worth surfacing. Shown only
  // AFTER that first countdown so it never pre-empts a code that is simply
  // in flight.
  //
  // Defaults ON: unlike a kill switch, a help notice that fails ON is
  // harmless — the failure mode is a customer reading advice they did not
  // need. The short code and keyword are operator-tunable WITHOUT a release
  // because they are set by the networks/NCC, not by us, and a wrong code
  // hardcoded into a shipped binary would be unfixable for weeks.
  static const String smsDndHelpEnabledKey = 'sms_dnd_help_enabled';
  static bool get smsDndHelpEnabled =>
      _prefs?.getBool(smsDndHelpEnabledKey) ?? true;

  /// Is our sender approved for the carrier's corporate/OTP route?
  ///
  /// That route is DND-EXEMPT: a verification code reaches a DND-registered
  /// line with the customer doing nothing at all. So once approval lands the
  /// DND advice is not merely redundant, it is WRONG — it would ask people to
  /// weaken their spam protection for no reason. The notice retires itself on
  /// every SMS OTP screen the moment this flips, with no release.
  ///
  /// Defaults FALSE, which is the measured state: a real send on 2026-11-13
  /// returned requested_gateway=otp / gateway_used=direct-refund. Failing
  /// false shows help nobody needed; failing true would strand a DND customer
  /// with no code and no explanation.
  static const String smsOtpRouteApprovedKey = 'sms_otp_route_approved';
  static bool get smsOtpRouteApproved =>
      _prefs?.getBool(smsOtpRouteApprovedKey) ?? false;

  /// NCC DND short code. Operator-tunable; defaults to the published 2442.
  static const String smsDndHelpCodeKey = 'sms_dnd_help_code';
  static String get smsDndHelpCode {
    final v = (_prefs?.getString(smsDndHelpCodeKey) ?? '').trim();
    return v.isEmpty ? '2442' : v;
  }

  /// Keyword that lifts DND. Operator-tunable; defaults to the published ALLOW.
  static const String smsDndHelpKeywordKey = 'sms_dnd_help_keyword';
  static String get smsDndHelpKeyword {
    final v = (_prefs?.getString(smsDndHelpKeywordKey) ?? '').trim();
    // "1" allows banking/insurance/financial messages only; "ALLOW" would
    // switch off the customer's spam protection wholesale. See the NCC 2442
    // table in admin-gateway's sms_dnd_defaults.go.
    return v.isEmpty ? '1' : v;
  }

  /// Body copy. Empty → the compiled fallback below.
  static const String smsDndHelpMessageKey = 'sms_dnd_help_message';
  static String get smsDndHelpMessage =>
      (_prefs?.getString(smsDndHelpMessageKey) ?? '').trim();

  // EVERY STRING THE NOTICE RENDERS IS A SETTING.
  //
  // The operator owns this copy: it explains a carrier behaviour we do not
  // control, the NCC short code and keyword can change, and getting the
  // wording wrong sends customers hunting through phone settings for a
  // network register that is not there. None of that should need a release
  // and a store review to correct.
  //
  // The compiled values are a LAST-RESORT fallback for the window before the
  // first settings snapshot lands (cold start, offline, failed fetch). They
  // are not the source of truth — any operator value wins. Rendering nothing
  // in that window would withhold correct, static advice from the customer
  // precisely when they are stuck, which is the worse failure.
  static const String smsDndHelpTitleKey = 'sms_dnd_help_title';
  static String get smsDndHelpTitle {
    final v = (_prefs?.getString(smsDndHelpTitleKey) ?? '').trim();
    return v.isEmpty ? 'Still no code?' : v;
  }

  /// The "carrier, not your phone" correction. Its own key so it can be
  /// reworded without touching the body, and dropped entirely (empty) if it
  /// ever stops being true.
  static const String smsDndHelpDistinctionKey = 'sms_dnd_help_distinction';
  static String get smsDndHelpDistinction {
    // ABSENT and EMPTY mean different things here, unlike the other strings.
    // Absent = never configured, so show the default. Explicitly empty = the
    // operator removed the line on purpose, so honour that and render nothing
    // rather than silently reinstating our wording.
    final raw = _prefs?.getString(smsDndHelpDistinctionKey);
    if (raw == null) {
      return "This is set by your mobile network, not on your phone — it is not "
          "the Do Not Disturb or Focus setting in your phone's settings.";
    }
    return raw.trim();
  }

  /// Instruction line. Supports {keyword} and {code} placeholders so the
  /// operator can reword around the values without retyping them.
  static const String smsDndHelpActionKey = 'sms_dnd_help_action';
  static String get smsDndHelpAction {
    final v = (_prefs?.getString(smsDndHelpActionKey) ?? '').trim();
    final raw = v.isEmpty
        ? 'Text {keyword} to {code} from this number to allow bank messages, then tap resend.'
            '\n\nNot sure if DND is on? Text STATUS to {code} to check. '
            'To remove DND completely, text ALLOW to {code}.'
        : v;
    return raw
        .replaceAll('{keyword}', smsDndHelpKeyword)
        .replaceAll('{code}', smsDndHelpCode);
  }

  /// Button label. Same placeholders.
  static const String smsDndHelpCtaKey = 'sms_dnd_help_cta';
  static String get smsDndHelpCta {
    final v = (_prefs?.getString(smsDndHelpCtaKey) ?? '').trim();
    final raw = v.isEmpty ? 'Text {keyword} to {code}' : v;
    return raw
        .replaceAll('{keyword}', smsDndHelpKeyword)
        .replaceAll('{code}', smsDndHelpCode);
  }

  /// HOW MANY elapsed resend cooldowns before the notice appears.
  ///
  /// 1 = after the first countdown. Raising it means the customer must have
  /// asked for, and waited out, that many codes before being shown
  /// troubleshooting — which is the right dial when SMS is healthy and the
  /// advice would just be noise. 0 disables the notice outright, same as
  /// turning the enabled flag off.
  ///
  /// Capped at 5: beyond that nobody is still on the screen, and a typo'd
  /// large value would silently disable the feature while reading as enabled.
  /// How the app-rating sheet asks the question: 'emoji' | 'stars' |
  /// 'alternate'.
  ///
  /// Faces ask "how was that for you"; stars ask "rate us". Which performs
  /// better is an empirical question about THIS audience, not one to settle in
  /// code — so it is a setting, and 'alternate' exists to compare the two on
  /// real traffic without shipping a release between arms.
  ///
  /// Defaults to emoji. An unrecognised value falls back to emoji rather than
  /// rendering nothing: a rating sheet with no scale is a dead end the
  /// customer cannot get past.
  static const String appRatingScaleModeKey = 'app_rating_scale_mode';
  static String get appRatingScaleMode {
    final v =
        (_prefs?.getString(appRatingScaleModeKey) ?? '').trim().toLowerCase();
    return (v == 'stars' || v == 'alternate') ? v : 'emoji';
  }

  static const String smsDndHelpAfterAttemptsKey =
      'sms_dnd_help_after_attempts';
  static int get smsDndHelpAfterAttempts {
    final parsed = int.tryParse(
        (_prefs?.getString(smsDndHelpAfterAttemptsKey) ?? '').trim());
    if (parsed == null || parsed < 0) return 1;
    return parsed > 5 ? 5 : parsed;
  }

  static SharedPreferences? _prefs;

  /// The same store, for [DashboardWidgets] — which is a separate file only
  /// because this one is already far past the size guideline, not a separate
  /// concern. Sharing the instance keeps one source of truth for every
  /// setting the app reads, admin and user alike.
  static SharedPreferences? get prefsForDashboard => _prefs;

  /// Session-pinned Send Funds flow decision (short vs long). Loaded from the
  /// persisted [sendFlowPinned] at boot (fast, offline), re-resolved on login,
  /// and held in memory for routing — see [sendFlowShortForSession] /
  /// [pinSendFlowForSession].
  static bool? _sessionShortSendFlow;

  /// Depth of active Send Funds journeys. While > 0 (the user has entered a send
  /// flow and hasn't returned to the dashboard) the pin is FROZEN: a re-resolve
  /// is deferred (see [_repinPending]) so the flow can never switch mid-journey.
  static int _sendFlowDepth = 0;

  /// A re-resolve arrived while a send flow was active; apply it once the last
  /// flow ends (back on the dashboard).
  static bool _repinPending = false;

  /// Called once from app boot (after SharedPreferences is available) so the
  /// synchronous getters below don't have to await. Idempotent.
  ///
  /// Note: it deliberately does NOT seed the in-memory session pin
  /// [_sessionShortSendFlow] from the persisted value. The pin is established
  /// ONCE per login-session by the first genuine login (or a Settings change),
  /// so an in-session re-pin (app-lock unlock, background default change) can't
  /// flip the user. Cold-boot routing before that first login stays instant +
  /// offline-safe because [sendFlowShortForSession] falls back to the persisted
  /// [sendFlowPinned] value.
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Test-only: rebind + clear the backing store so each test starts clean.
  /// No-op in production (never called). Call after
  /// `SharedPreferences.setMockInitialValues(...)`.
  @visibleForTesting
  static Future<void> debugResetForTest() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.clear();
    _sessionShortSendFlow = null;
    _sendFlowDepth = 0;
    _repinPending = false;
    _smsAvailableForUserMemo = null;
  }

  /// Apply a fresh batch of flags pulled from the admin endpoint. The map is
  /// the same shape as the `url_*` cache the EndpointRegistry already
  /// refreshes — just `key → "true"/"false"`. Silently ignores unknown keys.
  static Future<void> applyRemoteSnapshot(Map<String, String> remote) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    // Share the same store with the voice-language gate so its allowlist is
    // live the moment a snapshot lands, rather than only after a restart.
    VoiceLanguageAvailability.bind(prefs);
    for (final key in <String>[
      dashboardCardsSectionVisible,
      voiceChatAssistantSectionVisible,
      serviceEntranceAnimationEnabled,
      sendFundsShortFlowEnabled,
      sendFundsPinRequired,
      batchTransferShortFlowEnabled,
      batchTransferPinRequired,
      scanAccountDetailsEnabled,
      scanResolveUsersEnabled,
      bvnSignupScreenEnabled,
      insuranceHostedEntrypointsEnabled,
      insuranceEnabled,
      localeGatingEnabled,
      // SMS / phone-OTP master switches.
      //
      // Absent from this list until now, which made them unreachable: the
      // admin could not write them (not allowlisted) and the app would not
      // ingest them (not here). They were pinned at their compiled defaults,
      // so the only way to restore phone OTP after an SMS provider came back
      // was a release. Both halves are now wired.
      //
      // smsProviderActiveKey is the one to flip; the other two derive from it
      // when unset (see their getters), so a single write restores the whole
      // phone-OTP flow coherently.
      smsProviderActiveKey,
      smsOtpEnabledKey,
      // Boolean: whether the DND help notice may render at all.
      smsDndHelpEnabledKey,
      smsOtpRouteApprovedKey,
      maintenanceModeEnabledKey,
      bvnPhoneNoticeEnabledKey,
      bulkSmsVisibleKey,
      cardAcceptanceVisibleKey,
      phoneBankingVisibleKey,
      rmbTransferVisibleKey,
      exchangeSendAbroadVisibleKey,
      airtimeTabBuyEnabled,
      airtimeTabInternationalEnabled,
      airtimeTabSellEnabled,
      invoiceSplitEnabled,
      voiceAfricanLanguagesEnabled,
      emailVerificationRequired,
      phoneVerificationRequired,
      kycRequiredOnSignup,
      autoBiometricLoginEnabled,
      themeSwitchVisible,
      receiptFormatSheetVisible,
      appUpdateEnabledKey,
      crowdfundDonationAlertsVisible,
      referralLeaderboardVisible,
      upliftRemoveCtaVisible,
      intlPayoutEnabled,
      groupFundsEnabled,
      groupFundsOneTimeEnabled,
      groupFundsEsusuEnabled,
      spraymeLikeSoundKey,
      spraymeRecordingEnabled,
      piggyvaultManualActivation,
    ]) {
      final v = remote[key]?.trim();
      // An EMPTY value is not `false`.
      //
      // A row can exist carrying no value at all — seeded before anyone chose,
      // or a field cleared from the dashboard — and `'' == 'true'` is false,
      // so storing it would write a hard OFF for a flag whose declared default
      // is ON. For `group_funds_enabled` that reads as the entire service
      // disappearing from every phone because a text field was blanked, with
      // the getter's `?? true` powerless: a value IS stored, so the fallback
      // never fires.
      //
      // Skipped rather than removed, so the last choice an operator actually
      // recorded survives a degraded read; a key that was never written stays
      // unwritten and the getter default stands.
      if (v == null || v.isEmpty) continue;
      await prefs.setBool(key, v.toLowerCase() == 'true');
    }
    // Quick-service gates: a KEY FAMILY, not a fixed list. Persisted verbatim
    // (CSV / "true"|"false" / free text) and parsed on read, so a service
    // configured for the first time tomorrow needs no app change.
    for (final e in remote.entries) {
      if (e.key.startsWith('quick_service_')) {
        await prefs.setString(e.key, e.value);
      }
    }
    // Generic gate family: feature_<domain>_<id>_(available|message|whitelist|
    // whitelist_enabled). Stored VERBATIM as strings for the same reason the
    // quick-service family is: the values are a mix of "false", free-text copy
    // and CSV, and the ids are not knowable in advance, so a gate configured
    // for the first time tomorrow needs no app change.
    //
    // Read through [FeatureGate], which parses per key on read.
    for (final e in remote.entries) {
      if (e.key.startsWith('feature_')) {
        await prefs.setString(e.key, e.value);
      }
    }
    // Assistant entry-point toggles are BOOLEAN families, so they are stored
    // as bools and read with getBool — unlike the quick_service_ family above,
    // whose values are CSV/free text. Only an explicit "false" disables;
    // anything unparseable leaves the entry point visible, because a typo must
    // not silently remove a user's way into an assistant.
    for (final e in remote.entries) {
      if (e.key.startsWith('chat_icon_') || e.key.startsWith('voice_agent_')) {
        await prefs.setBool(e.key, e.value.trim().toLowerCase() != 'false');
      }
      // Whitelists are CSV strings; their _enabled companions and the
      // bottom-nav switches are booleans. Split on the suffix rather than the
      // prefix, because both shapes share the bottom_nav_ prefix.
      if (e.key.endsWith('_whitelist')) {
        await prefs.setString(e.key, e.value);
      } else if (e.key.endsWith('_whitelist_enabled') ||
          e.key.startsWith('bottom_nav_')) {
        await prefs.setBool(e.key, e.value.trim().toLowerCase() != 'false');
      }
    }
    // insurance_hosted_link is a string (a URL), not a boolean — store verbatim.
    final hostedLink = remote[insuranceHostedLink];
    if (hostedLink != null) {
      await prefs.setString(insuranceHostedLink, hostedLink.trim());
    }
    // App auto-update string values (build numbers, versions, store URLs, notes)
    // — stored verbatim. AppUpdateService parses build numbers on read.
    for (final key in <String>[
      appLatestVersionIos,
      appLatestBuildIos,
      appMinBuildIos,
      appStoreUrlIos,
      appLatestVersionAndroid,
      appLatestBuildAndroid,
      appMinBuildAndroid,
      appStoreUrlAndroid,
      appUpdateNotesKey,
      // STRING, not boolean: "bottom" | "grid". In the bool list above
      // `v == 'true'` would store it as false and the getter would read the
      // compiled default forever while the dashboard showed a saved value —
      // the same quiet strand referralMinKycTierKey and the DND copy keys hit.
      quickServicesMorePlacementKey,
      maintenanceMessageKey,
      // STRING: a comma-separated allow-list. In the bool list it would be
      // stored as false and every whitelisted tester would be locked out
      // while the dashboard showed the names saved.
      maintenanceWhitelistKey,
      // A URL, not a boolean. In the bool list above it would be coerced to
      // false and the footer would silently serve the compiled fallback
      // forever while the dashboard showed the operator a saved value.
      piggyvaultDisclosureUrlKey,
      // The attribution LINE beside it. A string, and it has to be HERE as
      // well as in the gateway's two allow-lists — the fourth wiring point
      // every app-visible setting needs. Missing any one of them means the
      // dashboard saves it, shows it saved, and the app never sees it.
      piggyvaultProviderTextKey,
      // STRINGS, not booleans — the NCC short code ("2442"), the keyword
      // ("ALLOW") and the operator copy override. In the bool list above
      // `v == 'true'` would store each as false and the getters would fall
      // back to their compiled defaults while the dashboard showed a saved
      // value — the same quiet strand referralMinKycTierKey hit.
      smsDndHelpCodeKey,
      smsDndHelpKeywordKey,
      smsDndHelpMessageKey,
      smsDndHelpTitleKey,
      smsDndHelpDistinctionKey,
      smsDndHelpActionKey,
      smsDndHelpCtaKey,
      // A COUNT, not a boolean — string list, like referralMinKycTierKey.
      smsDndHelpAfterAttemptsKey,
      // A string enum ('emoji'|'stars'|'alternate'), mirrored verbatim.
      appRatingScaleModeKey,
      // A DIGIT, NOT A BOOLEAN — it belongs here and not in the bool list
      // above, which coerces every value with `v == 'true'`. Putting it there
      // stored "3" as false, the getter read nothing, and the app silently
      // fell back to its default while the dashboard showed the operator a
      // saved value. Exactly the quiet strand the allowlist comments warn of.
      referralMinKycTierKey,
      // Spray layout default is a string enum ('grid'|'sidebar'|'spotlight'),
      // so it is mirrored verbatim here rather than coerced to a bool above.
      spraymeDefaultLayoutMode,
      // Unavailability scope is a string enum ('generic'|'account'|'country'),
      // mirrored verbatim; FeatureFlags.intlPayoutScope normalises on read.
      intlPayoutUnavailableScope,
      // BILL SERVICE FEES (betting / ePIN) — the four keys per bill type that
      // calcSimpleFee prices from.
      //
      // IN THE STRING LOOP, INCLUDING THE BOOLEAN ONE. The loop above stores
      // with setBool, and billServiceFee reads every one of these with
      // getString: a fee of "28" through setBool becomes `false`, and the
      // enabled flag written as a bool reads back null. Both halves then
      // agree the fee is zero while the server charges it. One loop, one
      // storage type, one reader.
      //
      // Without being ingested AT ALL the chain is silent end to end:
      // admin-gateway merges these into the response from utility-payments'
      // database, and a key not named in one of these lists is discarded on
      // arrival. Exactly the failure the SMS keys record above — writable,
      // served, and still unreachable.
      ...billFeeSettingKeys,
      // The bank-payout floor is a number; stored verbatim and parsed on
      // read so a malformed admin value degrades to the default instead of
      // throwing during boot.
      externalPayoutFloorMinorKey,
      // Upload ceilings. Numbers, stored verbatim and parsed on read, so a
      // malformed admin value degrades to the built-in default rather than
      // throwing during boot.
      // How long the auth backdrop holds each photo. A number, stored verbatim
      // and parsed on read like the ceilings below, so a malformed admin value
      // degrades to the default instead of throwing during boot.
      authBackgroundRotateSecondsKey,
      // Saved-payee matching bounds. Numbers — in the BOOL loop above they
      // would be coerced by `v == 'true'` and a "3" would store as false,
      // which is the quiet strand referralMinKycTierKey records.
      savedPayeeMinDigitsKey,
      savedPayeeMaxRowsKey,
      savedPayeeSnapshotRowsKey,
      upliftFundGalleryMaxImagesKey,
      upliftApplicationMaxImagesKey,
      upliftApplicationMaxDocumentsKey,
      mediaMaxImageMbKey,
      mediaMaxVideoMbKey,
      // Receipt footer text. Verbatim: it is prose an operator writes, and
      // the resolver below supplies the default when it is blank.
      receiptFooterCompanyKey,
      receiptFooterDisclaimerKey,
      receiptFooterSupportKey,
      // Locale gating lists are CSVs, stored verbatim and parsed on read.
      localeNonNgnServices,
      localeNonNgnNavDisabled,
      localeNonNgnAiScopes,
      localeNonNgnDashboardSections,
      // These two were DECLARED and READ but never persisted, so the admin
      // snapshot could not reach them: an operator opening a corridor saved
      // the row, the dashboard showed it saved, and the app went on using the
      // built-in default forever. Absent-vs-empty matters here — see _csv —
      // so a missing key still means "use the default", not "allow none".
      localeNonNgnAccountTypes,
      localeNonNgnMoneyActions,
      localeNonNgnAccountTabs,
    ]) {
      final v = remote[key];
      if (v == null) continue;
      await prefs.setString(key, v.trim());
    }
    // auth_mode is a string enum, not a boolean — store it verbatim (normalized
    // to a known value; anything unexpected falls back to phone_passcode, the
    // product default).
    final mode = remote[authMode];
    if (mode != null) {
      final m = mode.toLowerCase().trim();
      await prefs.setString(
        authMode,
        m == authModeEmailPassword
            ? authModeEmailPassword
            : authModePhonePasscode,
      );
    }
    // Everything above is now in SharedPreferences. Tell anyone rendering a
    // gated surface, so a flip reaches the screen within one poll instead of
    // at next launch. Last statement on purpose: listeners read the flags
    // synchronously the moment this fires, so it must not run until every
    // write above has completed.
    revision.value++;
    // AND THE DASHBOARD'S OWN TWO, which are not the same notifier.
    //
    // A snapshot can change which quick services a basic dashboard shows,
    // which sections are offered at all, and where the customise card sits —
    // every one of them a dashboard surface. But the dashboard does not
    // listen to `revision`; it listens to these two. So an operator could
    // move the customise card or change the basic set, watch the value save,
    // and see nothing change on a running app until it was restarted — the
    // setting was live in SharedPreferences and the page that reads it had no
    // reason to rebuild.
    // ONE notifier, not two: DashboardWidgets imports this file, so reaching
    // back for its revision here would close an import cycle. The dashboard
    // merges the two listenables instead — see the section builder in
    // dashboard.dart, which rebuilds on either.
    dashboardLayoutRevision.value++;
  }

  // ── Existing transfer-API helpers ────────────────────────────────────────
  static bool isUsingNewTransferApi() {
    return _prefs?.getBool(useNewTransferApi) ?? false;
  }

  static void enableNewTransferApi() {
    _prefs?.setBool(useNewTransferApi, true);
  }

  // ── Referral leaderboard visibility ──────────────────────────────────────
  /// `false` by default, so the leaderboard stays hidden until an admin turns
  /// it on — including on the very first launch, before any snapshot has
  /// been fetched. Defaulting to true would publish customers' names to every
  /// user for the length of one cold start.
  ///
  /// Synchronous read, like every flag here: a build method never waits on
  /// the network.
  static bool get referralLeaderboardEnabled {
    return _prefs?.getBool(referralLeaderboardVisible) ?? false;
  }

  // ── Dashboard cards visibility ───────────────────────────────────────────
  /// `false` by default so the Cards section stays hidden until an admin
  /// enables it from Flutter Service Configs. Synchronous read — must be
  /// called after [init].
  static bool get dashboardCardsVisible {
    return _prefs?.getBool(dashboardCardsSectionVisible) ?? false;
  }

  /// Whether the Insurance service is visible anywhere in the app.
  ///
  /// Defaults to FALSE so it is hidden BEFORE the admin snapshot resolves —
  /// on a cold start, offline, or if the settings call fails. The screens and
  /// routes remain compiled in; only the entry points are withheld, so flipping
  /// the admin switch restores it without a release.
  static bool get insuranceVisible {
    return _prefs?.getBool(insuranceEnabled) ?? false;
  }

  // ── SMS availability, admin-tunable ──────────────────────────────────────
  //
  // THE SITUATION THESE EXIST FOR. The platform has no working SMS provider:
  // Twilio is suspended and nothing else is integrated. Every flow that sends
  // a one-time code by SMS therefore cannot complete — and the worst version
  // of that is the one we shipped, where the OTP step is SHOWN with a "skip
  // for now" link. A user in the middle of signing up is asked for a code
  // that will never arrive, and has to work out for themselves that skipping
  // is the right move. That reads as a broken app at the exact moment a new
  // user is deciding whether to trust us with money.
  //
  // So the step is not shown at all while SMS is off. Not disabled, not
  // skippable — absent. The moment an operator marks a provider active, it
  // returns, with no release.
  //
  // WHY THE DEFAULTS ARE WHAT THEY ARE. smsProviderActive defaults FALSE,
  // which matches reality today and is the safe direction: if the admin
  // snapshot has not resolved yet, or the settings call failed, the app
  // behaves as though SMS is unavailable. Showing an OTP screen that cannot
  // work is worse than skipping one that could have.

  static const String smsProviderActiveKey = 'sms_provider_active';

  /// Whether a working SMS provider is integrated and enabled.
  ///
  /// This is the master switch. The two keys below exist so an operator can
  /// override a specific behaviour, but neither has to be set: both derive
  /// sensible values from this one.
  static bool get smsProviderActive =>
      _prefs?.getBool(smsProviderActiveKey) ?? false;

  /// Whether SMS one-time codes may be used anywhere — signup verification,
  /// login step-up, two-factor, passcode recovery.
  ///
  /// Defaults to following [smsProviderActive], so an operator turning the
  /// provider on gets the OTP flows back without having to find a second
  /// switch. Settable independently for the case where a provider is
  /// configured but not yet trusted for production traffic.
  static const String smsOtpEnabledKey = 'sms_otp_enabled';
  static bool get smsOtpEnabled =>
      _prefs?.getBool(smsOtpEnabledKey) ?? smsProviderActive;

  /// Whether to tell the user, on the phone-number step, that the number must
  /// be the one on their BVN.
  ///
  /// DEFAULTS ON, REGARDLESS OF SMS — changed 2026-11-02, and the reason is
  /// Mono's own requirement rather than ours.
  ///
  /// This used to default to the INVERSE of [smsProviderActive], on the
  /// reasoning that the notice only existed to cover for our missing OTP and
  /// became redundant once SMS returned. That is wrong: Mono Prove requires the
  /// submitted number to be LINKED TO THE BVN and its FAQ says so outright —
  /// "ensure the number you provide is registered, active, and is a number
  /// linked to your BVN"
  /// (https://support.mono.co/en/articles/11035147-faqs-on-mono-prove).
  ///
  /// So the constraint is permanent and has nothing to do with our SMS
  /// provider. With SMS back on, an OTP would prove the customer HOLDS the
  /// number while saying nothing about whether it is their BVN's number — and
  /// KYC would still fail later, at which point they have long forgotten what
  /// they typed. Defaulting the notice away on SMS restoration would silently
  /// reintroduce that failure.
  ///
  /// Still independently settable, so an operator can suppress it if the copy
  /// ever moves elsewhere in the flow.
  static const String bvnPhoneNoticeEnabledKey = 'bvn_phone_notice_enabled';
  static bool get bvnPhoneNoticeEnabled =>
      _prefs?.getBool(bvnPhoneNoticeEnabledKey) ?? true;

  // ── Locale gating readers ────────────────────────────────────────────────

  /// Master switch for restricting the product outside NGN.
  ///
  /// Defaults to TRUE, which is the opposite of the other admin gates here and
  /// deliberate: the restriction exists because those flows genuinely cannot
  /// complete outside Nigeria, so the safe state before the admin snapshot
  /// resolves is the restricted one. Defaulting open would show a user in
  /// another region a dashboard full of services that dead-end.
  static bool get localeGatingOn =>
      _prefs?.getBool(localeGatingEnabled) ?? true;

  // ── Quick-services "More" placement ──────────────────────────────────────
  //
  // WHERE THE PAGE-TURN CONTROL LIVES, and it is a layout decision an operator
  // can take back without a release.
  //
  //   "bottom" (DEFAULT) — a pill on the trailing edge of the indicator row,
  //                        styled like the section's own "View All" but
  //                        filled rather than tinted, because this one turns
  //                        the page rather than opening a sheet. The
  //                        Financial Connections icon moves to the LEADING
  //                        edge so the two controls bracket the dots instead
  //                        of fighting for the same corner.
  //   "grid"             — the original: the control takes the last cell of
  //                        the grid, and Financial Connections keeps the
  //                        trailing edge of the indicator row.
  //
  // One key, not two booleans: the placement and the icon's side are the SAME
  // decision, and expressing them separately invites the combination nobody
  // wants — both controls stacked in one corner.
  //
  // Defaults to "bottom" because that is the operator's chosen arrangement;
  // an unreadable or mistyped value falls back to it rather than to the layout
  // it replaced, so a typo cannot quietly restore the old grid cell.
  static const String quickServicesMorePlacementKey =
      'quick_services_more_placement';

  /// Whether the page-turn control sits in the GRID rather than the bottom row.
  static bool get quickServicesMoreInGrid =>
      (_prefs?.getString(quickServicesMorePlacementKey) ?? '')
          .trim()
          .toLowerCase() ==
      'grid';

  // ── Per-account SMS availability (told BY THE SERVER) ───────────────────
  //
  // SMS stopped being one platform-wide fact on 2026-11-17: the provider
  // accepts and bills OTP traffic it does not deliver, so [smsProviderActive]
  // is off for everyone while an operator whitelist keeps SMS for named
  // testers — resolved server-side against the account's own email and phone.
  //
  // WHY THE SERVER HAS TO TELL US. The whitelist is personal contact details
  // and the settings snapshot below arrives over an UNAUTHENTICATED poll that
  // every installation downloads, so the list can never be readable here. But
  // the app is what decides whether the phone-OTP step is rendered at all
  // (signup_steps REMOVES it, main.dart routes resumption past it) — so with
  // only the global flag, a whitelisted tester never reached a screen that
  // would send, and a whitelist that was correct and tested on the server did
  // nothing in the product. The answer therefore rides on every auth response
  // (auth.proto User.sms_available) and is cached here.
  //
  // PER USER, so it is in kPerUserStorageKeys and purged on a user switch —
  // one holder's answer must never be applied to another's.
  static const String smsAvailableForUserKey = 'sms_available_for_user';

  /// In-memory mirror, preferred over the stored value.
  ///
  /// THIS IS WHAT MAKES THE FLAG USABLE AT LOGIN, and the reason is a race the
  /// stored value cannot win. The post-login router resolves its route
  /// SYNCHRONOUSLY, the moment the auth response is mapped — while the
  /// SharedPreferences write is still in flight. Reading only the store would
  /// hand the router the PREVIOUS session's answer on the very login that
  /// carried the new one.
  ///
  /// That is not hypothetical: the same one-launch lag already bites the admin
  /// snapshot. main.dart applies the CACHED settings at boot and the fresh poll
  /// lands later, so flipping sms_provider_active on in the dashboard did not
  /// prompt anyone for phone verification until their next launch — the login
  /// route had already been decided from the stale cache. An answer that
  /// arrives ON the login response must not inherit that lag.
  static bool? _smsAvailableForUserMemo;

  /// The server's last answer for THIS account, or null if none has arrived.
  ///
  /// Null is "not known", NOT "unavailable" — before the first auth response
  /// (a fresh install at the login screen) there is no account to answer for,
  /// and SmsPolicy falls back to the platform-wide flag.
  static bool? get smsAvailableForUser =>
      _smsAvailableForUserMemo ?? _prefs?.getBool(smsAvailableForUserKey);

  /// Record what the server just said. Called from the one mapper every auth
  /// response passes through, so no path can skip it.
  ///
  /// The memo is set SYNCHRONOUSLY before the await, so a caller that reads the
  /// flag in the same turn — the post-login router does — sees this response's
  /// answer rather than the last one's.
  static Future<void> rememberSmsAvailableForUser(bool value) async {
    _smsAvailableForUserMemo = value;
    try {
      await _prefs?.setBool(smsAvailableForUserKey, value);
    } catch (_) {
      // Best effort: the memo already carries this session, and a failed write
      // costs a hidden affordance next launch, never a wrong one — SmsPolicy
      // only ever reads this permissively.
    }
  }

  /// Drop the IN-MEMORY mirror only.
  ///
  /// Not the whole answer: the getter falls back to the stored value, so a
  /// caller that wants the account forgotten must remove
  /// [smsAvailableForUserKey] from the store as well. purgeStaleUserCache does
  /// both, and that pairing is what a user switch needs — the memo lives in
  /// the process and would otherwise outlive the store it was cleared from,
  /// leaving one holder's answer in force for the next person on the device.
  static void forgetSmsAvailableForUser() {
    _smsAvailableForUserMemo = null;
  }

  /// The signed-in user's email, for whitelist checks.
  ///
  /// Read through the locator and swallowed on failure: these gates run
  /// during build, and a thrown lookup there is a blank screen. An unknown
  /// email simply means no whitelist can match, which falls back to the
  /// ordinary rules rather than granting or denying anything.
  static String? currentUserEmail() {
    try {
      return serviceLocator<AuthenticationCubit>().currentProfile?.user.email;
    } catch (_) {
      return null;
    }
  }

  // ── Email whitelists (admin-tunable, per surface) ─────────────────────
  //
  // A whitelist is an OVERRIDE, not a filter. An email on an enabled
  // whitelist sees the thing even when it is hidden from their account type
  // or switched off for everyone — which is the point: ship a service to a
  // handful of testers while it stays invisible to everyone else.
  //
  //   <prefix>_whitelist           CSV of emails
  //   <prefix>_whitelist_enabled   false parks the list without deleting it
  //
  // The list is kept when disabled on purpose. Turning a pilot off and back
  // on must not mean retyping twenty addresses, and deleting the list to
  // pause it is how you lose who was in it.
  //
  // Prefixes: quick_service_<service>  ·  bottom_nav_<label>
  static String whitelistKey(String prefix) => '${prefix}_whitelist';
  static String whitelistEnabledKey(String prefix) =>
      '${prefix}_whitelist_enabled';

  /// A remote settings value exactly as the admin dashboard wrote it.
  ///
  /// The `quick_service_` family is persisted VERBATIM (CSV, "true"/"false",
  /// free text) and parsed per key on read, so a reader needs the raw string
  /// rather than a typed getter. Synchronous — backed by SharedPreferences,
  /// which the settings poll has already written in the background. Nothing
  /// on a gesture path may await.
  static String? rawString(String key) => _prefs?.getString(key);

  /// Emails on this surface's whitelist, lower-cased and trimmed.
  static Set<String> whitelistEmails(String prefix) {
    final raw = _prefs?.getString(whitelistKey(prefix));
    if (raw == null || raw.trim().isEmpty) return const <String>{};
    return raw
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty)
        .toSet();
  }

  /// Whether the list is currently in force. Default TRUE: an admin who adds
  /// addresses means them to take effect, and a list that silently did
  /// nothing until a second toggle was found would read as a broken feature.
  static bool whitelistActive(String prefix) =>
      _prefs?.getBool(whitelistEnabledKey(prefix)) ?? true;

  /// Whether [email] is granted access to [prefix] by its whitelist.
  ///
  /// False whenever we cannot be sure — an empty list, a disabled list, or an
  /// unknown email. Fail-closed on purpose: a whitelist that accidentally
  /// matched everyone would publish a service that was deliberately hidden,
  /// which is the one outcome worse than it not working at all.
  static bool whitelisted(String prefix, String? email) {
    final e = email?.trim().toLowerCase() ?? '';
    if (e.isEmpty) return false;
    if (!whitelistActive(prefix)) return false;
    final list = whitelistEmails(prefix);
    if (list.isEmpty) return false;
    return list.contains(e);
  }

  // ── Generic feature gates (admin-tunable, any surface) ────────────────
  //
  // One key family for every surface that is not a quick service, a bottom-nav
  // destination or an airtime tab — bill types, the data Local/International
  // scopes, account types and the Lifestyle entries:
  //
  //   feature_<domain>_<id>_available          "false" disables   (default ON)
  //   feature_<domain>_<id>_message            unavailable copy   (optional)
  //   feature_<domain>_<id>_whitelist          CSV of emails      (override)
  //   feature_<domain>_<id>_whitelist_enabled  park the list      (default ON)
  //
  // ONE prefix rather than one per domain, deliberately. The gateway's bulk
  // read builds its WHERE from hand-counted `LIKE ?` placeholders, and a
  // prefix added without a matching placeholder takes down the no-auth
  // endpoint the app polls for everything — that outage is on record.
  //
  // Absent keys mean AVAILABLE. Nothing needs seeding, and a surface added
  // later is live by default rather than invisible until somebody remembers to
  // configure it — an unconfigured new surface silently missing is far harder
  // to notice than one that is present.
  static String featurePrefix(String domain, String id) =>
      'feature_${domain}_$id';

  /// Whether [prefix] is switched on, IGNORING any whitelist.
  ///
  /// Only the exact string "false" disables. Anything unparseable leaves the
  /// surface available, because a typo in an admin field must not take a
  /// working service off the app — the backend still refuses whatever it
  /// would refuse anyway.
  ///
  /// [defaultOn] is the answer when NOBODY HAS CHOSEN — no row, or a blank
  /// one. It is true for every gate that withholds an existing surface, which
  /// is all of them bar one: a gate that ADDS optional UI must default OFF, or
  /// shipping the gate ships the UI to everyone on the next poll. The one
  /// caller that passes false is the Lazerfunds guide card, which was
  /// deliberately taken off the tabs — see [lazerfundsGuideCardEnabled].
  ///
  /// A blank value is treated as unset for the same reason the admin screen
  /// does: `upsertSystemSetting(key, "")` is how a cleared field saves, and
  /// reading "" as "false" would make clearing a message switch a surface off.
  static bool gateAvailable(String prefix, {bool defaultOn = true}) {
    final raw = _prefs?.getString('${prefix}_available');
    if (raw == null || raw.trim().isEmpty) return defaultOn;
    final v = raw.trim().toLowerCase();
    if (defaultOn) return v != 'false';
    // Default-OFF gates are the mirror image: only the exact string "true"
    // enables, so the same typo that cannot take a service down also cannot
    // put unasked-for UI back on every phone.
    return v == 'true';
  }

  /// Whether the current user may see [prefix].
  ///
  /// The whitelist is an OVERRIDE and is checked FIRST: an address on an
  /// enabled list sees the surface even while it is switched off for everyone
  /// else, which is the entire point of shipping to testers.
  static bool gateAllowed(String prefix,
      {String? email, bool defaultOn = true}) {
    if (whitelisted(prefix, email ?? currentUserEmail())) return true;
    return gateAvailable(prefix, defaultOn: defaultOn);
  }

  /// The gate a ROUTE should consult — the same decision the tile makes.
  ///
  /// A QUICK SERVICE HAS TWO SWITCHES AND A ROUTE WAS ONLY READING ONE.
  /// `_visible` removes the tile from the grid and the search corpus;
  /// `_available` leaves the tile up and explains itself on tap. Tapping a
  /// tile goes through `openAppService` → [quickServiceEntryBlocked], which
  /// honours BOTH plus the whitelist. A route guard called [gateAllowed],
  /// which reads `_available` alone — so an operator who turned a service OFF
  /// the natural way (hiding the tile) still left every other door open:
  /// a deep link, a shared URL, an AI-chat `Get.toNamed`, a notification tap.
  /// The service vanished from the dashboard and remained fully usable.
  ///
  /// For a `quick_service_*` gate this now asks exactly what the tile asks, so
  /// "off" means off at every entrance. Non-quick-service gates are unchanged.
  static bool routeGateAllowed(String gate, {String? email}) {
    const p = 'quick_service_';
    if (gate.startsWith(p)) {
      final service = gate.substring(p.length);
      if (service.isNotEmpty) {
        return !quickServiceEntryBlocked(service, email: email);
      }
    }
    return gateAllowed(gate, email: email);
  }

  /// The gift-card SELL tab.
  ///
  /// DEFAULT OFF, so the gift-cards screen shows Buy alone until an operator
  /// turns selling on. Selling is the side with the manual settlement queue,
  /// the per-brand sell rates and the reversal path behind it; shipping the
  /// tab before that is staffed puts users into a flow nobody is watching.
  ///
  /// Uses the generic gate family, so it comes with its whitelist for free:
  ///
  ///   feature_giftcard_sell_available   "false" (the default) hides the tab
  ///   feature_giftcard_sell_whitelist   CSV of emails that always see it
  ///
  /// The whitelist is checked FIRST and overrides the switch, which is how
  /// the people running the pilot keep access while it stays hidden from
  /// everyone else.
  static const String giftcardSellPrefix = 'feature_giftcard_sell';

  static bool giftcardSellTabIsVisible({String? email}) =>
      gateAllowed(giftcardSellPrefix, email: email, defaultOn: false);

  // ---------------------------------------------------------------------
  // PAY WITH CRYPTO.
  //
  //   feature_cryptopay_available   "true" enables it (DEFAULT OFF)
  //   feature_cryptopay_whitelist   CSV of emails that see it regardless
  //
  // DEFAULT OFF, and deliberately `defaultOn: false` rather than the usual
  // `true`: this one spends a customer's crypto. A key that failed to reach
  // the handset — a settings poll that 500s, a prefix someone forgot — must
  // leave the option ABSENT, not present. Every other gate in this file can
  // afford to fail open; this one cannot.
  //
  // The whitelist is checked first and overrides the switch, which is how
  // production testing happens while it stays hidden from everyone else.
  // ── Crowdfund contribution: async by default ──────────────────────────
  //
  //   feature_crowdfund_asynccontribution_available
  //     "false" → the PIN sheet holds its processing phase until the money
  //               RPC answers, and the receipt opens already terminal.
  //     anything else (the DEFAULT) → the receipt opens immediately in
  //               Processing and settles in place.
  //
  // WHY ASYNC IS THE DEFAULT. The contribution RPC straddles the PIN
  // validation, the wallet debit and the campaign-row update, and the user
  // watched a dedicated full-screen spinner for all of it — reported simply
  // as "why's the processing stage in crowdfund that slow". It is not faster
  // either way; what changes is that the customer is holding a receipt with a
  // live status instead of a progress animation they cannot leave, which is
  // how the send-funds flow has always worked.
  //
  // Tunable rather than hardcoded so the sync path stays one switch away if a
  // provider incident ever makes an in-place settle worse than a wait.
  static const String crowdfundAsyncPrefix =
      'feature_crowdfund_asynccontribution';

  /// True when a contribution hands the customer a receipt immediately.
  static bool get crowdfundAsyncContribution =>
      gateAvailable(crowdfundAsyncPrefix);

  static const String cryptoPayPrefix = 'feature_cryptopay';

  /// `feature_cryptopay_min_fiat_minor` — the smallest payment that may be
  /// funded by selling crypto, in KOBO. Default ₦1,000.
  static const String cryptoPayMinFiatKey = 'feature_cryptopay_min_fiat_minor';

  /// The floor below which a crypto-funded payment cannot be attempted.
  ///
  /// THE CLIENT HALF OF A SERVER RULE, exactly like
  /// [payWithCryptoAvailable] above: crypto-service already refuses with
  /// `below_minimum` and its refusal is the one that matters. What this buys
  /// is the customer learning the rule BEFORE choosing a coin, reading a
  /// split and entering their PIN — a refusal earned that way reads as a
  /// failed payment rather than a limit.
  ///
  /// Mirrors `crypto.pay.min_fiat_minor` (itself seeded from
  /// `crypto.min_order.ngn.minor_units`, live value 100000). Two settings in
  /// two services is a drift risk, which is why this one may only ever REFUSE
  /// EARLY: it is never consulted to allow anything, so a stale copy costs an
  /// unnecessary message, never an unchecked conversion.
  ///
  /// NOTE FOR WHOEVER TUNES IT: the venue has its own minimum and it is
  /// RATE-DEPENDENT. Measured 2026-11-24, a ₦1,000 attempt was refused by
  /// Quidax with "The minimum swap amount is 1253.19... NGN" — so this floor
  /// sitting at ₦1,000 lets customers through a gate the exchange then
  /// closes. Raising it is an operator decision; the copy says the exchange
  /// may ask for more either way.
  static int get payWithCryptoMinFiatMinor =>
      _positiveSetting(cryptoPayMinFiatKey, 100000, cap: 100000000);

  /// Whether the Fiat | Crypto choice may be offered at all.
  ///
  /// This is the CLIENT half of the gate and is only ever a courtesy: the
  /// server refuses a funding request from a user it has not enabled, so a
  /// tampered app gains nothing by forcing this true.
  static bool payWithCryptoAvailable({String? email, String? userId}) {
    // THE WHITELIST ARRIVES AS DIGESTS, NOT ADDRESSES.
    //
    // gateAllowed compares the whitelist as plaintext, which is right for the
    // staff lists it was written for. This one rides the same public settings
    // poll while naming the people running a money pilot, so admin-gateway
    // hashes it (digestedWhitelistKeys) and the comparison happens here
    // instead. Entries that are not 64 hex chars are ignored rather than
    // compared raw — accepting plaintext would quietly undo the server-side
    // change the first time a stale value was cached.
    final digests = (_prefs?.getString('${cryptoPayPrefix}_whitelist') ?? '')
        .split(RegExp(r'[,\s]+'))
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.length == 64 && _isHex(e))
        .toSet();
    // BOTH IDENTIFIERS ARE COMPARED, and the user id is the one to prefer.
    //
    // A digest only hides a list; it cannot hide a value someone can guess,
    // and an email address is guessable — hash the address you already suspect
    // and you have your answer. A user id is a random UUID, so a digest of one
    // really is opaque. The privacy note in admin-gateway tells operators to
    // whitelist by id for exactly that reason, and this used to hash the email
    // ONLY: an operator who followed that advice was silently never matched,
    // which for a gate is the worst way to be wrong — it looks like the
    // feature is broken rather than like the list is.
    if (digests.isNotEmpty) {
      for (final raw in [userId, email]) {
        final v = (raw ?? '').trim().toLowerCase();
        if (v.isEmpty) continue;
        final d = sha256.convert(utf8.encode(v)).toString();
        // The whitelist OVERRIDES the switch — that is how a pilot runs while
        // the feature stays off for everyone else.
        if (digests.contains(d)) return true;
      }
    }
    return gateAvailable(cryptoPayPrefix, defaultOn: false);
  }

  /// Whether Lazerfunds should show the FULL first-run guide card on its tabs,
  /// instead of the one-line info link that is now the standing state.
  ///
  /// DEFAULT OFF. The big card was removed from the tabs on purpose — three of
  /// them stacked an explainer above content that is itself the explanation,
  /// and on a small screen the first thing below the tab bar was a paragraph
  /// rather than a fund. The compact `UpliftTabInfoLink` carries the same copy
  /// behind an info icon and opens the identical sheet, so nothing became
  /// unreachable.
  ///
  /// It stays switchable rather than deleted because it is the better state for
  /// a cohort we cannot identify from here — a first-run audience, a demo, a
  /// market where the product needs more framing. An admin turns it on for
  /// everyone, or whitelists it to the accounts running the demo.
  ///
  /// The per-user Settings switch still applies on top: this gate decides
  /// whether the card EXISTS as a state, the user's choice decides whether it
  /// appears unprompted to them.
  static bool get lazerfundsGuideCardEnabled => gateAllowed(
        featurePrefix('explainer', 'lazerfundsguide'),
        defaultOn: false,
      );

  /// Admin copy for a gate, or EMPTY when none is set.
  ///
  /// Distinct from [gateMessage], which substitutes "This service is not
  /// available at the moment" — right for a withdrawn service, wrong for
  /// anything else. A transfer refused for a balance floor needs its own
  /// wording, and a caller has to be able to tell "no copy was set" from "the
  /// admin wrote this" in order to choose its own default.
  static String gateMessageOrEmpty(String prefix) =>
      _prefs?.getString('${prefix}_message')?.trim() ?? '';

  /// A numeric gate tunable in MINOR units (`<prefix>_amount`), or 0 when unset.
  ///
  /// Zero means "not configured" rather than "a floor of nothing", which is
  /// what lets an operator clear the field to switch a threshold off — the
  /// same convention the admin screen and the server both use.
  static int gateAmountMinor(String prefix) {
    final raw = _prefs?.getString('${prefix}_amount')?.trim();
    if (raw == null || raw.isEmpty) return 0;
    final n = int.tryParse(raw);
    if (n == null || n < 0) return 0;
    return n;
  }

  /// Copy for the "not available" modal. Never blank, so an admin who disables
  /// a surface without writing a message still gets a sentence that is true.
  static String gateMessage(String prefix) {
    final raw = _prefs?.getString('${prefix}_message')?.trim();
    if (raw == null || raw.isEmpty) {
      return 'This service is not available at the moment. '
          'Please try again later.';
    }
    return raw;
  }

  // ── Scoped landing tabs (airtime Buy/International/Sell, data Local/Intl) ──
  //
  // Airtime ALREADY had `airtime_tab_<scope>_enabled` booleans, and rows may be
  // configured against them, so that switch is honoured rather than replaced —
  // renaming it would silently re-enable a tab somebody had turned off. What it
  // never had is a whitelist or any copy explaining the closure, and those come
  // from the generic `feature_airtimetab_<scope>` gate layered beside it.
  //
  // Data had no gate at all.
  //
  // Either switch can close a tab (AND); the whitelist opens it regardless
  // (OVERRIDE), which is what lets a tab ship to testers while it stays shut
  // for everyone else.

  /// Airtime landing tab: 'buy' | 'international' | 'sell'.
  static bool airtimeTabAllowed(String scope, {String? email}) {
    final prefix = featurePrefix('airtimetab', scope);
    if (whitelisted(prefix, email ?? currentUserEmail())) return true;
    final legacy = switch (scope) {
      'buy' => airtimeBuyTabIsEnabled,
      'international' => airtimeInternationalTabIsEnabled,
      'sell' => airtimeSellTabIsEnabled,
      _ => true,
    };
    return legacy && gateAvailable(prefix);
  }

  /// Why an airtime tab is closed, for the message shown in its place.
  static String airtimeTabMessage(String scope) =>
      gateMessage(featurePrefix('airtimetab', scope));

  /// Data bundles landing tab: 'local' | 'international'.
  static bool dataTabAllowed(String scope, {String? email}) =>
      gateAllowed(featurePrefix('datatab', scope), email: email);

  /// Why a data tab is closed.
  static String dataTabMessage(String scope) =>
      gateMessage(featurePrefix('datatab', scope));

  // ── Bottom-nav gating (admin-tunable, per destination) ────────────────
  //
  // Destinations are DISABLED, never removed. The nav is addressed by INDEX —
  // deep links and receipt returns pass `initialTab` — so dropping an entry
  // silently retargets those links at the wrong screen. Same reason the
  // locale gate dims rather than deletes.
  static String bottomNavPrefix(String label) =>
      'bottom_nav_${assistantSlug(label)}';

  static bool bottomNavEnabled(String label, {String? email}) {
    final prefix = bottomNavPrefix(label);
    if (whitelisted(prefix, email)) return true;
    return _prefs?.getBool('${prefix}_enabled') ?? true;
  }

  // ── Per-service assistant entry points (admin-tunable) ────────────────
  //
  // Two independent toggles per service — the chat icon and the voice button
  // — plus one master switch each that withholds EVERY per-service entry
  // point at once, leaving only the central assistant (NOVA, which is its own
  // bottom-nav screen rather than one of these icons, so it is untouched by
  // definition).
  //
  //   chat_icon_<slug>_enabled      one service's chat icon
  //   chat_icon_all_enabled         false ⇒ every per-service chat icon off
  //   voice_agent_<slug>_enabled    one service's voice button
  //   voice_agent_all_enabled       false ⇒ every per-service voice button off
  //
  // `all` is a RESERVED slug for that reason; no service may use it.
  //
  // The slug is the widget's own serviceName lowercased with non-alphanumerics
  // stripped, because the two widgets do not agree on names for the same
  // service ('Auto-Save' vs 'autosave', 'Currency Exchange' vs 'exchange').
  // Normalising inside each widget means an admin never has to know which
  // spelling a given surface happens to use, and the two key spaces stay
  // separate — which they should, since the toggles are independent.
  static const String chatIconsAllEnabled = 'chat_icon_all_enabled';
  static const String voiceAgentsAllEnabled = 'voice_agent_all_enabled';

  /// Normalise a widget's serviceName into a settings-key token.
  static String assistantSlug(String serviceName) {
    final buf = StringBuffer();
    for (final c in serviceName.toLowerCase().codeUnits) {
      final isDigit = c >= 0x30 && c <= 0x39;
      final isLower = c >= 0x61 && c <= 0x7a;
      if (isDigit || isLower) buf.writeCharCode(c);
    }
    return buf.toString();
  }

  static String chatIconKey(String slug) => 'chat_icon_${slug}_enabled';
  static String voiceAgentKey(String slug) => 'voice_agent_${slug}_enabled';

  /// Whether a per-service CHAT icon should render.
  ///
  /// The master switch wins: an admin turning per-service chat off expects
  /// silence everywhere, not "everywhere except the ones I also ticked".
  /// Defaults to true at both levels, so nothing needs seeding and a service
  /// added later keeps its assistant.
  static bool chatIconVisible(String serviceName) {
    if (_prefs?.getBool(chatIconsAllEnabled) == false) return false;
    final slug = assistantSlug(serviceName);
    if (slug.isEmpty) return true;
    return _prefs?.getBool(chatIconKey(slug)) ?? true;
  }

  /// Whether a per-service VOICE button should render.
  ///
  /// PER-SERVICE VOICE IS OFF UNTIL AN ADMIN TURNS IT ON — the opposite
  /// default to chat, and deliberate. The mic appears on 45 service screens,
  /// and each one opens a live agent session; shipping that on by default
  /// means every new service surfaces a voice agent before anyone has decided
  /// it should. Chat has no such cost and stays on.
  ///
  /// The CENTRAL assistant is untouched: NOVA is its own bottom-nav screen,
  /// not one of these icons, so none of these keys can reach it.
  ///
  /// Reading the master as `?? false` is what makes the default OFF. Once an
  /// admin sets voice_agent_all_enabled=true the per-service keys apply
  /// normally, each defaulting ON, so individual services can then be turned
  /// off one at a time.
  static bool voiceAgentVisible(String serviceName) {
    if (!(_prefs?.getBool(voiceAgentsAllEnabled) ?? false)) return false;
    final slug = assistantSlug(serviceName);
    if (slug.isEmpty) return true;
    return _prefs?.getBool(voiceAgentKey(slug)) ?? true;
  }

  // ── Quick-service gating (admin-tunable, per service) ──────────────────
  //
  // ONE key family per service rather than a boolean per (service, account
  // type): 39 services across 11 account types would be 429 booleans, which is
  // unusable both as settings rows and as an admin screen. The account types a
  // service is withheld from are a CSV on a single key instead.
  //
  //   quick_service_<service>_hidden_for  CSV of account types ("savings,investment")
  //   quick_service_<service>_available   "false" marks it temporarily unavailable
  //   quick_service_<service>_message     what the unavailable modal says
  //
  // <service> is the AppServiceName enum name, which is already the app's
  // stable identifier for a service.
  //
  // Absent keys mean "visible everywhere, available" — so nothing needs
  // seeding, and a service added later is live by default rather than
  // invisible until someone remembers to configure it. That direction is
  // deliberate: an unconfigured NEW service silently missing from the grid is
  // far harder to notice than one that is present.
  static String quickServiceHiddenForKey(String service) =>
      'quick_service_${service}_hidden_for';
  static String quickServiceAvailableKey(String service) =>
      'quick_service_${service}_available';
  static String quickServiceMessageKey(String service) =>
      'quick_service_${service}_message';
  static String quickServiceVisibleKey(String service) =>
      'quick_service_${service}_visible';

  static String quickServiceLabelKey(String service) =>
      'quick_service_${service}_label';

  /// The tile label for [service], or [shipped] when the operator has not
  /// renamed it.
  ///
  /// WHY A RENAME NEEDS TO BE A SETTING. The label is the only part of a
  /// service a customer reads before tapping, and the words that work change
  /// without the service changing at all — "Send Funds" became "Transfer"
  /// because that is what people here call it. Shipping that as a constant
  /// means a wording decision waits on a store review.
  ///
  /// THE SHIPPED LABEL IS RETURNED FIRST AND WITHOUT WAITING. This read is
  /// synchronous from SharedPreferences, which the settings poll fills in the
  /// background, so the first frame shows the shipped word and the tile
  /// re-renders to the operator's when the poll lands. There is deliberately
  /// no loading state: a grid of skeletons while we ask the network what to
  /// call things would be worse than a word changing a moment later.
  ///
  /// Bounded and non-blank: a tile is two short lines, and an empty override
  /// would render an unlabelled icon that looks broken rather than renamed.
  /// Both fall back to the shipped label rather than to nothing.
  static String quickServiceLabel(String service, String shipped) {
    final raw = (_prefs?.getString(quickServiceLabelKey(service)) ?? '').trim();
    if (raw.isEmpty) return shipped;
    if (raw.runes.length > quickServiceLabelMaxRunes) return shipped;
    return raw;
  }

  /// The longest label a tile can render without the text being clipped.
  /// Measured against the existing two-line labels — "Financial Connections"
  /// is 21 — with a little headroom.
  static const int quickServiceLabelMaxRunes = 24;

  /// Whether the service appears AT ALL. Default TRUE.
  ///
  /// This is the withdrawal switch, and it is deliberately NOT the same thing
  /// as [quickServiceAvailable]:
  ///
  ///   _visible=false    gone from the grid, gone from the swipe-down search
  ///                     corpus, gone from every per-account-type list. A deep
  ///                     link or notification still gets the modal, which is
  ///                     exactly when an explanation is worth having.
  ///   _available=false  still on the grid, explains itself on tap. A service
  ///                     that silently vanishes during an outage reads as a
  ///                     bug, which is why that one shows rather than hides.
  ///
  /// Both are overridden by the whitelist, so a tester keeps a withdrawn
  /// service while it is invisible to everyone else — the whole point of
  /// shipping to a few addresses first.
  ///
  /// Only the exact string "false" hides it. A typo in an admin field must not
  /// take a working service off every phone.
  static bool quickServiceVisible(String service) {
    final raw = _prefs?.getString(quickServiceVisibleKey(service));
    if (raw == null || raw.trim().isEmpty) return true;
    return raw.trim().toLowerCase() != 'false';
  }

  /// Whether [service] should be shown to the current user, considering the
  /// withdrawal switch and the whitelist override together.
  static bool quickServiceShown(String service, {String? email}) {
    if (whitelisted('quick_service_$service', email ?? currentUserEmail())) {
      return true;
    }
    return quickServiceVisible(service);
  }

  /// Whether ENTERING [service] should be refused, whichever switch is set.
  ///
  /// The two entry points — tapping a tile and following a notification or
  /// deep link — must agree, so they both ask this one question. A withdrawn
  /// service has no tile to tap, but a push can still name its route, and
  /// landing inside a service an admin has taken off the app is the confusion
  /// the modal exists to prevent. A tap that does nothing reads as the app
  /// ignoring the user, so it is explained rather than swallowed.
  static bool quickServiceEntryBlocked(String service, {String? email}) {
    if (whitelisted('quick_service_$service', email ?? currentUserEmail())) {
      return false;
    }
    return !quickServiceVisible(service) || !quickServiceAvailable(service);
  }

  /// Account types this service is hidden from. Empty = shown to all.
  ///
  /// Values are compared lower-cased and trimmed so an admin typing
  /// "Savings, Investment" behaves the same as "savings,investment".
  static Set<String> quickServiceHiddenFor(String service) {
    final raw = _prefs?.getString(quickServiceHiddenForKey(service));
    if (raw == null || raw.trim().isEmpty) return const <String>{};
    return raw
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty)
        .toSet();
  }

  /// Whether the service is currently offered. Default TRUE.
  ///
  /// Only the exact string "false" disables it. Anything unparseable leaves
  /// the service available, because a typo in an admin field must not take a
  /// working service off the grid — and the backend still refuses whatever it
  /// would refuse anyway.
  static bool quickServiceAvailable(String service) {
    final raw = _prefs?.getString(quickServiceAvailableKey(service));
    if (raw == null) return true;
    return raw.trim().toLowerCase() != 'false';
  }

  /// Copy for the "temporarily unavailable" modal. Falls back to a neutral
  /// sentence so the modal is never blank when an admin disables a service
  /// without writing a message.
  static String quickServiceMessage(String service) {
    final raw = _prefs?.getString(quickServiceMessageKey(service))?.trim();
    if (raw == null || raw.isEmpty) {
      return 'This service is temporarily unavailable. Please try again later.';
    }
    return raw;
  }

  static Set<String> _csv(String key, String fallback) {
    // ABSENT and EMPTY mean different things, and conflating them would
    // silently overrule the admin.
    //
    // An absent key means nobody has configured this yet → use the built-in
    // default. A key set to the EMPTY STRING is a deliberate choice, and the
    // gateway validates it as legitimate: for the services list it means
    // "nothing outside NGN", for the disabled-nav list "disable nothing".
    // Treating empty as "fall back to the default" would hand an admin who
    // cleared the services list the default `exchange` instead of the lockout
    // they asked for — the setting would appear to save and do the opposite.
    final stored = _prefs?.getString(key);
    final source = stored == null ? fallback : stored;
    return source
        .split(',')
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty)
        .toSet();
  }

  /// Quick services that stay available outside NGN.
  ///
  /// Exchange only by default: it is the one flow that does not need a local
  /// deposit or payout rail to be useful.
  static Set<String> get localeNonNgnServiceNames =>
      _csv(localeNonNgnServices, 'exchange');

  /// Bottom-nav destinations disabled outside NGN, by label (lower-cased).
  ///
  /// Disabled rather than removed: the nav is addressed by INDEX (deep links
  /// and receipt returns pass `initialTab`), so dropping entries would
  /// silently retarget those links at the wrong screen.
  static Set<String> get localeNonNgnDisabledNav =>
      _csv(localeNonNgnNavDisabled, 'beam,lifestyle');

  /// AI-insights scopes enabled outside NGN.
  ///
  /// LazerVault wallets only by default. Linked-bank insights come from open
  /// banking, which is a Nigeria-only rail, so those scopes have no data to
  /// show in another region.
  static Set<String> get localeNonNgnAiScopeNames =>
      _csv(localeNonNgnAiScopes, 'lazervault');

  /// Dashboard discovery sections shown outside NGN.
  ///
  /// EMPTY by default — neither Trending crowdfunds nor Public groups appears
  /// in a non-Naira region. Both are NGN-denominated communal pots: a user on
  /// a USD account cannot contribute to or withdraw from one, so the rail is a
  /// scroll of things they can look at and not join.
  static Set<String> get localeNonNgnDashboardSectionNames =>
      _csv(localeNonNgnDashboardSections, '');

  /// Account types available outside NGN.
  ///
  /// PERSONAL only by default. Every other type is built on rails that stop
  /// at the Nigerian border: a business account settles to a Nigerian
  /// corporate payout, savings and investments are NGN-denominated products,
  /// and family/group pots are contributed to in Naira. Offering one in
  /// another region creates an account that can be opened and then not used.
  static Set<String> get localeNonNgnAccountTypeNames =>
      _csv(localeNonNgnAccountTypes, 'personal');

  /// Money-movement actions offered outside NGN.
  ///
  /// EMPTY by default — neither Deposit nor Withdraw. Fincra confirmed they
  /// cannot issue per-customer virtual accounts outside Nigeria, so a foreign
  /// wallet has no number to pay INTO; and with nothing in it there is
  /// nothing to pay out. The deposit sheet's own methods make this concrete:
  /// card, Apple Pay and bank transfer are all integrated for Naira only, so
  /// every route off that screen is a dead end.
  ///
  /// Admin-tunable because it stops being true the day a corridor opens, and
  /// that is a commercial fact rather than a property of the code.
  static Set<String> get localeNonNgnMoneyActionNames =>
      _csv(localeNonNgnMoneyActions, '');

  /// Account-details tabs shown outside NGN.
  ///
  /// ALL of them by default. Freezing an account, bounding its limits,
  /// pulling a statement and getting help all work on a foreign wallet —
  /// which can hold a balance, since currency exchange funds it even with no
  /// deposit rail. This exists so an operator can narrow it the day a tab
  /// stops making sense in a region, without a release.
  static Set<String> get localeNonNgnAccountTabNames =>
      _csv(localeNonNgnAccountTabs, 'controls,limits,documents,help');

  // ── Bulk SMS visibility ──────────────────────────────────────────────────
  /// Whether the Bulk SMS service is visible anywhere in the app.
  ///
  /// Defaults to FALSE (hidden) — including before the admin snapshot
  /// resolves, offline, and on cold start. The screens and routes remain
  /// compiled in; only the entry points are withheld, so flipping the admin
  /// switch restores it without a release.
  /// The smallest NGN bank transfer a payout provider will accept, in kobo.
  ///
  /// Defaults to the MEASURED Flutterwave floor (₦100.00) when the admin
  /// snapshot has not resolved — cold start, offline, first launch. Defaulting
  /// to the known floor rather than to zero matters: zero would let the amount
  /// screen wave through a transfer the server then refuses after the PIN,
  /// which is the exact failure this value exists to prevent.
  static int get externalPayoutFloorMinor {
    final raw = _prefs?.getString(externalPayoutFloorMinorKey);
    final parsed = int.tryParse((raw ?? '').trim());
    if (parsed == null || parsed <= 0) return 10000; // NGN 100.00
    return parsed;
  }

  /// A positive integer admin setting, or [fallback].
  ///
  /// Zero and negative values fall back deliberately: "0" in the admin field
  /// would otherwise mean "no uploads allowed at all", which is never what an
  /// operator clearing a box intends, and [cap] keeps a typo from raising a
  /// limit past what the gateway will actually accept.
  // ── Bill service fee (betting / ePIN) ────────────────────────────────────
  //
  // MIRRORS calcSimpleFee IN utility-payments, key for key and default for
  // default:
  //
  //   {bt}_service_fee_enabled  bool   master switch, default FALSE → fee 0
  //   {bt}_fee_type             string "fixed" | "percentage" (default pct)
  //   {bt}_fee_fixed            NGN    when type == fixed
  //   {bt}_fee_percentage       pct    when type == percentage (1.0 == 1%)
  //
  // The SERVER is authoritative — it charges amount + fee and the hold covers
  // the total. This exists only so the amount sheet and the transaction-PIN
  // sheet can SHOW the customer what they are about to pay, instead of
  // displaying the funding amount and letting them discover the real total
  // from their balance afterwards. If the two ever disagree the displayed
  // number is wrong, which is why it is a faithful mirror rather than an
  // independent pricing rule, and why bill_service_fee_test.dart pins the
  // arithmetic to the Go implementation's.
  /// The eight keys the settings poll must INGEST for a fee to be visible.
  ///
  /// Mirrors billFeeSettingKeys in admin-gateway, which is what merges them
  /// into the response. Listed once and spread into applyRemoteSnapshot's
  /// ingest list, so adding a bill type cannot leave the two halves out of
  /// step — the gap that made the betting fee invisible even once the server
  /// was pricing it.
  /// How long the rotating auth backdrop holds each photo, in seconds.
  ///
  /// It was `const Duration(seconds: 10)` written at one call site, which is
  /// not a setting however reasonable the number: changing it meant a release
  /// and a store review. Now admin-tunable like every other pacing value.
  static const String authBackgroundRotateSecondsKey =
      'auth_background_rotate_seconds';

  /// Default 7s — the operator's chosen pace.
  static const int _authBackgroundRotateSecondsDefault = 7;

  /// Bounded on READ, not on write alone.
  ///
  /// A 0 would restart the timer continuously and decode a 7.9 MB photo on
  /// every tick; a very large value is indistinguishable from a static
  /// backdrop and would read as the feature being broken. Anything
  /// unparseable or outside the range falls back to the default rather than
  /// throwing on a screen the user cannot get past — this is the SIGN-IN
  /// screen, so a crash here locks everyone out.
  static Duration get authBackgroundRotateInterval {
    final raw = _prefs?.getString(authBackgroundRotateSecondsKey)?.trim();
    final parsed = int.tryParse(raw ?? '');
    if (parsed == null || parsed < 2 || parsed > 120) {
      return const Duration(seconds: _authBackgroundRotateSecondsDefault);
    }
    return Duration(seconds: parsed);
  }

  static const List<String> billFeeSettingKeys = <String>[
    'betting_service_fee_enabled',
    'betting_fee_type',
    'betting_fee_fixed',
    'betting_fee_percentage',
    'epin_service_fee_enabled',
    'epin_fee_type',
    'epin_fee_fixed',
    'epin_fee_percentage',
  ];

  static String billFeeTypeKey(String billType) => '${billType}_fee_type';
  static String billFeeEnabledKey(String billType) =>
      '${billType}_service_fee_enabled';
  static String billFeeFixedKey(String billType) => '${billType}_fee_fixed';
  static String billFeePercentageKey(String billType) =>
      '${billType}_fee_percentage';

  /// The service fee the server will add for [billType] on [amount], in naira.
  ///
  /// Returns 0 when the fee is switched off or unset — the same answer
  /// calcSimpleFee gives, so a rail nobody has priced shows no fee rather
  /// than a guess.
  static double billServiceFee(String billType, double amount) {
    if (amount <= 0) return 0;
    if (!_boolSetting(billFeeEnabledKey(billType), false)) return 0;
    final type =
        (_prefs?.getString(billFeeTypeKey(billType)) ?? 'percentage').trim();
    if (type == 'fixed') {
      return _nonNegativeDouble(billFeeFixedKey(billType));
    }
    final pct = _nonNegativeDouble(billFeePercentageKey(billType));
    return amount * pct / 100.0;
  }

  static bool _boolSetting(String key, bool fallback) {
    final raw = (_prefs?.getString(key) ?? '').trim().toLowerCase();
    if (raw.isEmpty) return fallback;
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  /// A negative fee would SUBTRACT from what the customer pays, so a malformed
  /// row reads as "no fee" rather than a discount nobody authorised.
  static double _nonNegativeDouble(String key) {
    final parsed = double.tryParse((_prefs?.getString(key) ?? '').trim());
    if (parsed == null || parsed <= 0 || parsed.isNaN || parsed.isInfinite) {
      return 0;
    }
    return parsed;
  }

  /// The KYC tier a REFEREE must reach before their referrer is paid.
  ///
  /// NEVER HARDCODED. This is a commercial rule an operator changes from the
  /// dashboard — Tier 2 (BVN verified, account minted) buys growth, Tier 3
  /// (BVN + NIN + liveness) buys certainty — and the app PROMISES it to the
  /// customer on the referral screen. A number baked in here would tell
  /// someone their friend needs Tier 2 while the allocator paid only on
  /// Tier 3, which is a promise the product does not keep.
  ///
  /// Defaults to 3, matching DefaultReferralMinKYCTier in auth-service: with
  /// no row set, both sides independently resolve the same strict answer.
  /// Clamped to 2..3 because tier 1 is the unverified baseline and there is
  /// no tier above 3.
  /// The referral conditions shown to the customer — CMS copy, not code.
  ///
  /// Lives in `feature_referral_terms_message`, which needs no allow-list
  /// change: the gateway's bulk read already serves `feature_%` and its write
  /// validator already accepts the `_message` suffix, and this app already
  /// stores every `feature_` key verbatim. Newline-separated, one condition
  /// per line.
  ///
  /// `{tier}` is substituted from [referralMinKycTier] — the value
  /// auth-service actually gates on — for the same reason that accessor
  /// exists: a number written into the copy would tell someone their friend
  /// needs Tier 2 while the allocator paid only on Tier 3.
  ///
  /// Returns EMPTY when unset, and the caller then shows nothing. Inventing a
  /// condition is worse than omitting one, because the customer acts on it.
  static const String referralTermsKey = 'feature_referral_terms_message';
  static List<String> referralTerms() {
    final raw = (_prefs?.getString(referralTermsKey) ?? '').trim();
    if (raw.isEmpty) return const [];
    final tier = referralMinKycTier.toString();
    return raw
        .split('\n')
        .map((l) => l.trim().replaceAll('{tier}', tier))
        .where((l) => l.isNotEmpty)
        .toList(growable: false);
  }

  /// WHAT THE REFERRAL SCREEN SAYS, IN EACH OF THE PROGRAMME'S STATES.
  ///
  /// The screen used to assert, in four places and in compiled text, that a
  /// bonus lands in your wallet automatically once your referee passes KYC.
  /// That is true only while the programme is RUNNING, and the programme has
  /// three live states an operator can choose between from the console —
  /// running, recording referrals but paying nothing, and closed to new
  /// referrals altogether. In the other two the app went on promising money,
  /// which is a promise nobody could keep.
  ///
  /// `feature_referral_*` needs no allow-list change: admin-gateway's bulk
  /// read already serves `feature_%`, its write validator already accepts the
  /// `_message` suffix, and the app stores every `feature_` key verbatim.
  ///
  /// Blank falls back to the compiled wording rather than showing nothing —
  /// an empty explanation where money is concerned is worse than a plain one.
  /// The CLOSED state has no key here on purpose: it already travels on the
  /// wire as `programmeNotice`, and a second place to write it is a second
  /// place for the two to disagree.
  static const String referralEarnMessageKey = 'feature_referral_earn_message';
  static const String referralRewardsPausedMessageKey =
      'feature_referral_rewards_paused_message';
  static const String referralEarnPendingMessageKey =
      'feature_referral_earn_pending_message';
  static const String referralEmptyPromptKey =
      'feature_referral_empty_prompt_message';

  /// One CMS string, trimmed, or [fallback] when nothing is configured.
  static String referralCopy(String key, String fallback) {
    final v = (_prefs?.getString(key) ?? '').trim();
    return v.isEmpty ? fallback : v;
  }

  // ── Crowdfunding policy ────────────────────────────────────────────────

  /// Where the public crowdfunding policy lives.
  ///
  /// A URL rather than text compiled into the app, so there is ONE copy and a
  /// build can never ship a stale version of a policy document.
  ///
  /// COMPOSED SERVER-SIDE from `link_base_domain` + `legal_crowdfunding_path`,
  /// exactly like every other legal link (terms, privacy, gift cards, crypto
  /// disclosure). That composition is why this is not a full URL in its own
  /// row: moving the marketing site changes one setting and every legal link
  /// follows, instead of leaving one policy pointing at the old domain.
  ///
  /// Reaches the app through the `legal_%` bulk-read prefix that already
  /// carries the others.
  static const String crowdfundPolicyUrlKey = 'legal_crowdfunding_url';

  /// The policy URL, or null when no policy page is published.
  ///
  /// NULL IS A REAL ANSWER and every caller must hide the link on it. A
  /// blocked creator — the person most likely to tap it — would otherwise be
  /// sent into a blank WebView, which reads as the app being broken on top of
  /// their campaign having been refused.
  static String? get crowdfundPolicyUrl {
    final v = (_prefs?.getString(crowdfundPolicyUrlKey) ?? '').trim();
    if (v.isEmpty) return null;
    // Validated on READ. The composer runs in another service and another
    // deploy; a malformed base domain, or a value written straight to the
    // database, must not reach a WebView.
    final uri = Uri.tryParse(v);
    if (uri == null || !uri.isScheme('https') || uri.host.trim().isEmpty) {
      return null;
    }
    return v;
  }

  static const String referralMinKycTierKey = 'referral_bonus_min_kyc_tier';
  static int get referralMinKycTier {
    final parsed =
        int.tryParse((_prefs?.getString(referralMinKycTierKey) ?? '').trim());
    if (parsed == null || parsed < 2 || parsed > 3) return 3;
    return parsed;
  }

  static int _positiveSetting(String key, int fallback, {int? cap}) {
    final parsed = int.tryParse((_prefs?.getString(key) ?? '').trim());
    if (parsed == null || parsed <= 0) return fallback;
    if (cap != null && parsed > cap) return cap;
    return parsed;
  }

  /// How many images a LazerFund fund gallery may carry (the first is the
  /// cover). Default 8.
  // 3, down from 8. A fund gallery is a cover plus a couple of supporting
  // shots — the detail page renders them in one row and the eighth was never
  // looked at. Still admin-tunable: this is only the value when no row is
  // set, and it matches defaultFundGalleryMaxImages in financial-products so
  // the picker stops exactly where the server would refuse.
  static int get upliftFundGalleryMaxImages =>
      _positiveSetting(upliftFundGalleryMaxImagesKey, 3, cap: 30);

  /// How many photos a LazerFund application may attach. Default 8.
  static int get upliftApplicationMaxImages =>
      _positiveSetting(upliftApplicationMaxImagesKey, 3, cap: 30);

  /// How many documents (pitch deck, accounts) an application may attach.
  /// Default 5.
  static int get upliftApplicationMaxDocuments =>
      _positiveSetting(upliftApplicationMaxDocumentsKey, 3, cap: 20);

  /// How many digits the payer must type before their saved payees are
  /// matched against the account-number field. Default 3.
  ///
  /// Not zero and not one: this list floats over the form, and at one digit a
  /// payer with a full payee book shows a slice of it to whoever is stood
  /// behind them. Three is enough to be a real narrowing.
  static int get savedPayeeMinDigits =>
      _positiveSetting(savedPayeeMinDigitsKey, 3, cap: 10);

  /// How many saved-payee matches the prediction overlay may show at once.
  /// Default 5 — the overlay is anchored under the field, so a taller list
  /// covers the form rather than scrolling it.
  static int get savedPayeeMaxRows =>
      _positiveSetting(savedPayeeMaxRowsKey, 5, cap: 20);

  /// How many saved payees the matcher keeps in memory to search. Default 500.
  ///
  /// Capped at 2000 rather than left open: this is one request and one list
  /// held for the session, and a payer with more payees than that is a
  /// business account whose matching belongs on the server, not a reason to
  /// pull an unbounded table onto a phone.
  static int get savedPayeeSnapshotRows =>
      _positiveSetting(savedPayeeSnapshotRowsKey, 500, cap: 2000);

  /// Largest image or PDF any uploader will send, in MB. Default 10.
  ///
  /// Capped at 100 because prod traffic crosses the Cloudflare tunnel, which
  /// refuses a body over 100MB on our plan — a higher admin value would only
  /// produce uploads that die at the edge.
  static int get mediaMaxImageMb =>
      _positiveSetting(mediaMaxImageMbKey, 10, cap: 100);

  /// Largest video, in MB. Default 70.
  ///
  /// 70 is the products-gateway's own default (`defaultVideoUploadMB`), and
  /// the pair must agree: this check exists only so a founder is refused
  /// BEFORE spending mobile data on an upload, and a value above the
  /// gateway's turns that saving into a 413 after the wait. Capped at 95 for
  /// the same reason the gateway is — the Cloudflare tunnel refuses a body
  /// over 100MB and multipart overhead rides on top of the file, so a limit
  /// at the edge value fails with Cloudflare's page instead of ours.
  ///
  /// Setting it LOWER than the gateway is safe and sometimes right; setting
  /// it higher is not, so raise `UPLOAD_MAX_VIDEO_MB` there first.
  static int get mediaMaxVideoMb =>
      _positiveSetting(mediaMaxVideoMbKey, 70, cap: 95);

  /// Registered company name printed on receipts. NOT "Technologies" —
  /// that word is not in the company registration.
  static String get receiptFooterCompany =>
      _nonEmptySetting(receiptFooterCompanyKey, 'Lazervault LTD');

  /// Legal disclaimer template. `{company}` and `{subject}` are substituted
  /// by ReceiptFooter.disclaimer(); an admin editing this must keep them, and
  /// the resolver tolerates their absence rather than printing the literal.
  static String get receiptFooterDisclaimer => _nonEmptySetting(
        receiptFooterDisclaimerKey,
        '{company} is a financial technology company. This document is a '
        'confirmation of {subject} processed through the Lazervault platform. '
        'For any queries regarding this transaction, please contact support '
        'through the Lazervault app.',
      );

  /// Short support line in the footer's left column.
  ///
  /// The default is a LITERAL and must stay one. It briefly read
  /// `ReceiptFooter.support`, which reads back through this getter — mutual
  /// recursion that blew the stack on every receipt export ("Failed to share
  /// transfer receipt: Stack Overflow"). It compiled, analysed clean, and
  /// only failed when a PDF was actually generated.
  static String get receiptFooterSupport =>
      _nonEmptySetting(receiptFooterSupportKey, 'Get help directly in-app');

  /// A blank admin value must not blank the footer of a document someone
  /// keeps as proof of payment, so empty/whitespace falls back to [fallback].
  static String _nonEmptySetting(String key, String fallback) {
    final v = _prefs?.getString(key)?.trim();
    return (v == null || v.isEmpty) ? fallback : v;
  }

  static bool get bulkSmsVisible {
    return _prefs?.getBool(bulkSmsVisibleKey) ?? false;
  }

  // ── Card acceptance (SoftPOS) visibility ─────────────────────────────────
  /// Whether merchant card acceptance is visible in Quick Services.
  ///
  /// Defaults to FALSE — hidden on cold start, offline, and before the admin
  /// snapshot resolves. Taking a card needs a rail certified in the merchant's
  /// market, so showing the tile by default would put a button in front of
  /// merchants who cannot use it. The screen and route stay compiled in; only
  /// the entry point is withheld, so the admin switch restores it without a
  /// release.
  static bool get cardAcceptanceVisible {
    return _prefs?.getBool(cardAcceptanceVisibleKey) ?? false;
  }

  // ── WhatsApp / Phone Banking visibility ──────────────────────────────────
  /// Whether the consolidated "WhatsApp/Phone Banking" tile appears in Quick
  /// Services. It opens the Banking Channels hub, which registers BOTH the
  /// WhatsApp and Phone/SMS channels and manages their channel PINs.
  ///
  /// Defaults to FALSE — hidden on cold start, offline, and before the admin
  /// snapshot resolves, the same mechanics as insurance, bulk SMS and card
  /// acceptance. These channels are a per-market arrangement (a WhatsApp
  /// Business number and a telephony rail that must exist for the user's
  /// locale), so offering the tile by default puts an entry point in front of
  /// people who cannot complete the registration behind it.
  ///
  /// The screens, routes and deep links stay compiled in and registered —
  /// only the Quick Services entry point is withheld, so flipping the admin
  /// switch restores it without a release.
  static bool get phoneBankingVisible {
    return _prefs?.getBool(phoneBankingVisibleKey) ?? false;
  }

  /// Platform default accent for the AI chat. Empty means "the app decides",
  /// which is how every deployment behaves until an admin sets one.
  static String get chatDefaultAccent =>
      _prefs?.getString(chatDefaultAccentKey) ?? '';

  /// Platform default layout for the Lifestyle hub. Empty means "the app
  /// decides", which is how every deployment behaves until an admin sets one.
  static String get lifestyleDefaultView =>
      _prefs?.getString(lifestyleDefaultViewKey) ?? '';

  /// RMB cross-border transfers. Hidden unless an admin turns it on — see
  /// [rmbTransferVisibleKey] for why the default is off.
  static bool get rmbTransferVisible {
    return _prefs?.getBool(rmbTransferVisibleKey) ?? false;
  }

  /// The Exchange "Send Abroad" tab. Hidden unless an admin turns it on — see
  /// [exchangeSendAbroadVisibleKey] for why the default is off.
  static bool get exchangeSendAbroadVisible {
    return _prefs?.getBool(exchangeSendAbroadVisibleKey) ?? false;
  }

  // ── Voice & Chat Assistant section visibility ────────────────────────────
  /// `true` by default so the full "Voice & Chat Assistant" settings accordion
  /// (voice enrollment/re-enroll, cloned/assistant voice, language, voice-PIN,
  /// per-service voice) — the SAME `VoiceSettingsScreen` the in-call settings
  /// gear opens — is available from general Settings out of the box. An admin
  /// can still explicitly hide it by pushing the key as `false`. Synchronous
  /// read — call after [init].
  static bool get voiceChatAssistantVisible {
    return _prefs?.getBool(voiceChatAssistantSectionVisible) ?? true;
  }

  /// Whether tapping the screen to like in a Lazerspray room plays a sound.
  ///
  /// Defaults to FALSE. Liking is a rapid repeated tap, so the sound fired
  /// several times a second and became a rattle over the room's own audio —
  /// the host's voice and music, which is what the live is actually for. The
  /// haptic and the floating hearts already confirm the tap landed.
  ///
  /// Kept as an admin dial rather than deleted outright so it can come back
  /// without an app release if people miss it.
  static bool get spraymeLikeSoundEnabled {
    return _prefs?.getBool(spraymeLikeSoundKey) ?? false;
  }

  /// Whether a LazerSpray host can record their live.
  ///
  /// Defaults to FALSE and the control is hidden entirely, not disabled: a
  /// recording is a full-length video per session and there is no storage to
  /// keep them, so offering the button would promise a replay that never
  /// arrives. An admin turns it on the day there is somewhere to put them.
  static bool get spraymeRecordingAllowed {
    return _prefs?.getBool(spraymeRecordingEnabled) ?? false;
  }

  /// Whether the crowdfund "Donation alerts" menu entry is shown.
  ///
  /// Defaults to FALSE (hidden) — unlike the other visibility flags, which
  /// default true. This surface is deliberately off until an admin turns it on.
  /// Whether the Lazerfund details screen offers "Remove this fund".
  ///
  /// Defaults TRUE — the control shipped visible, so an unset key must not
  /// silently remove it. Unset keys are omitted by the bulk read, which means
  /// the default here is what applies until an admin flips it.
  static bool get upliftRemoveCta {
    return _prefs?.getBool(upliftRemoveCtaVisible) ?? true;
  }

  static bool get crowdfundDonationAlerts {
    return _prefs?.getBool(crowdfundDonationAlertsVisible) ?? false;
  }

  // ── Quick-service landing entrance animation ─────────────────────────────
  /// `true` by default — quick-service landing screens animate their content in
  /// (slide-up + fade), matching the Insurance landing. Admin can flip this off
  /// platform-wide. Synchronous read — call after [init]; offline/first-launch
  /// defaults to ON so the motion is present out of the box.
  static bool get serviceEntranceAnimation {
    return _prefs?.getBool(serviceEntranceAnimationEnabled) ?? true;
  }

  // ── Plan My Day: Google integrations (admin-toggled) ─────────────────────
  /// Visibility of the Gmail and Google Calendar connect surfaces in Plan My Day.
  ///
  /// OFF BY DEFAULT, and the reason is external rather than technical. Both flows
  /// request scopes that Google gates behind its verification process — Gmail asks for
  /// `gmail.readonly` (RESTRICTED, requiring an annual CASA security assessment) and
  /// `gmail.send`, and Calendar asks for `calendar.events` / `calendar.readonly` (both
  /// SENSITIVE). Until that verification completes, the consent screen refuses every
  /// account that is not on the project's test-user list with
  /// "Access blocked: Lazervault has not completed the Google verification process".
  ///
  /// Ordinary sign-in is unaffected and stays visible: it requests only
  /// `openid email profile`, which never opens the consent page at all. Same project,
  /// same client — the difference is purely the scope tier.
  ///
  /// So the CTAs are hidden rather than removed. Every code path behind them is intact
  /// and tested; flipping this key from the admin dashboard restores the feature with no
  /// redeploy, which is what makes it the right shape for a block we expect to clear.
  static const String planMyDayGoogleIntegrationsVisible =
      'plan_my_day_google_integrations_visible';

  /// `false` unless an admin has explicitly enabled it. Synchronous read — call after
  /// [init]. Offline / first launch resolves to hidden, which is the safe direction:
  /// showing a connect button that can only end in Google's block page is worse than
  /// not offering it yet.
  static bool get planMyDayGoogleIntegrations {
    return _prefs?.getBool(planMyDayGoogleIntegrationsVisible) ?? false;
  }

  /// The duplicate "Weekly" and "Reminders" shortcut chips on the Plan My Day
  /// landing page.
  ///
  /// Hidden because both already exist elsewhere and better: Reminders is a
  /// top-level TAB on this very screen (index 3, same icon), and weekly grouping
  /// is a property of a task, not a separate destination. Two routes to the same
  /// place is not twice the access — it is a reader wondering whether they differ.
  ///
  /// Kept behind a flag rather than deleted because, unlike the Outlook stub,
  /// both destinations are REAL and working screens — only redundant here. The
  /// flag is the switch to bring them back without a redeploy if that judgement
  /// changes. Default OFF, and deliberately left OFF in the dashboard too.
  static const String planMyDayDuplicateShortcutsVisible =
      'plan_my_day_duplicate_shortcuts_visible';

  static bool get planMyDayDuplicateShortcuts {
    return _prefs?.getBool(planMyDayDuplicateShortcutsVisible) ?? false;
  }

  // ── Send Funds flow config ───────────────────────────────────────────────
  /// `true` (SHORT flow) by DEFAULT for every user — the short flow is the
  /// product default on signup. An admin can flip the platform default to the
  /// long flow from the dashboard (key [sendFundsShortFlowEnabled], synced into
  /// prefs via the endpoint registry); when that admin value is present it wins.
  /// A per-user choice (see [transferStyleOverride]) still takes precedence over
  /// both via [useShortSendFlow]. Synchronous read — call after [init].
  static bool get sendFundsShortFlow {
    return _prefs?.getBool(sendFundsShortFlowEnabled) ?? true;
  }

  // ── Dashboard layout style ───────────────────────────────────────────────
  // User-selectable dashboard layout, mirroring the transfer-style override:
  //   "showcase" (DEFAULT) = compact quick-services grid (illustrated tiles) +
  //     a small adverts carousel, with a compact themed refer-a-friend card
  //     directly below it.
  //   "classic"            = the older layout — full-height quick-services grid
  //     with the full refer-a-friend card below it.
  // Defaults to SHOWCASE for everyone; a user who explicitly picks classic in
  // Settings has that persisted. Purely a client-side preference.
  static const String userDashboardLayout = 'user_dashboard_layout';
  static const String dashboardLayoutClassic = 'classic';
  static const String dashboardLayoutShowcase = 'showcase';

  /// Bumps whenever the dashboard layout choice changes so a live dashboard can
  /// rebuild immediately (it may be kept alive inside the TabBarView). Widgets
  /// wrap the affected region in a `ValueListenableBuilder`.
  static final ValueNotifier<int> dashboardLayoutRevision =
      ValueNotifier<int>(0);

  /// `true` unless the user has explicitly opted into the classic layout.
  /// Showcase is the default for everyone (compact illustrated services +
  /// adverts carousel). Synchronous — call after [init].
  static bool get dashboardShowcaseLayout =>
      _prefs?.getString(userDashboardLayout) != dashboardLayoutClassic;

  /// Persist the user's dashboard-layout choice. Both "showcase" and "classic"
  /// are stored explicitly so a returning user keeps their pick; any other
  /// value clears the override (→ back to the showcase default).
  static Future<void> setDashboardLayout(String style) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final s = style.toLowerCase().trim();
    if (s == dashboardLayoutShowcase || s == dashboardLayoutClassic) {
      await prefs.setString(userDashboardLayout, s);
    } else {
      await prefs.remove(userDashboardLayout);
    }
    dashboardLayoutRevision.value++;
  }

  // ── Adaptive quick services ──────────────────────────────────────────────
  // When ON, the personal quick-services grid reorders by the user's most-used
  // services (floating them onto the first slide) and records per-service usage
  // (locally + synced to the backend). DEFAULT OFF — nothing is tracked until
  // the user opts in from Settings. Send Funds stays pinned first, and revenue
  // services still lead the default (OFF) order.
  static const String userAdaptiveQuickServices =
      'user_adaptive_quick_services';

  /// `true` when the user has opted into adaptive (usage-based) quick-services
  /// reordering. Defaults to `false`. Synchronous — call after [init].
  static bool get adaptiveQuickServices =>
      _prefs?.getBool(userAdaptiveQuickServices) ?? false;

  /// Persist the adaptive-quick-services choice and bump the dashboard revision
  /// so the live grid re-sorts immediately.
  static Future<void> setAdaptiveQuickServices(bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(userAdaptiveQuickServices, enabled);
    dashboardLayoutRevision.value++;
  }

  // ── Deposit "keep your balance live" guide ───────────────────────────────
  // The one-time educational modal on the deposit screen is suppressed per-user
  // once they tick "Don't show this again". This is the SAME uid-scoped key the
  // deposit screen reads/writes, centralised here so the Settings toggle and the
  // in-modal checkbox stay in perfect two-way sync: re-enabling from Settings
  // clears the flag (guide shows again); ticking "don't show again" in the modal
  // sets it (Settings then reads OFF).
  // NOTE: the `_v2` suffix versions the dismissal. Bumping it (done when the
  // guide's copy was refreshed) makes the updated guide re-appear ONCE even for
  // users who previously ticked "Don't show again", then respects their choice.
  static String depositBalanceGuideKey(String uid) =>
      'deposit_balance_refresh_guide_dismissed_v2_$uid';

  /// `true` when the deposit balance-refresh guide is ENABLED (not yet dismissed)
  /// for [uid]. Synchronous — call after [init].
  static bool depositBalanceGuideEnabled(String uid) =>
      !(_prefs?.getBool(depositBalanceGuideKey(uid)) ?? false);

  /// Enable/disable the deposit balance-refresh guide for [uid]. Enabling clears
  /// the "dismissed" flag so the guide reappears; disabling sets it.
  static Future<void> setDepositBalanceGuideEnabled(
      String uid, bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(depositBalanceGuideKey(uid), !enabled);
  }

  // ---- Pending-payments launch prompt -------------------------------------
  //
  // Uid-scoped like the deposit guide above: the device is shared (family
  // accounts, a handed-over phone), and one person switching off a money
  // reminder must not silence another's.
  //
  // Lives here rather than in secure storage because Settings reads it
  // SYNCHRONOUSLY during build, and because the sheet's "Don't show this
  // again" and the Settings switch have to be the same flag — two stores would
  // drift and the switch would lie.
  static String pendingPaymentsPromptKey(String uid) =>
      'pending_payments_prompt_disabled_$uid';

  /// How many times the prompt has been shown to [uid]. Gates the opt-out.
  static String pendingPaymentsShowCountKey(String uid) =>
      'pending_payments_prompt_shows_$uid';

  // ── Per-account balance visibility ─────────────────────────────────────
  // Which account cards have their balance hidden, stored per user as a list
  // of account ids. Scoped to the uid for the same reason the prompt flags
  // are: two people sharing a device must not inherit each other's choices.

  static String hiddenBalanceAccountsKey(String uid) =>
      'hidden_balance_accounts_$uid';

  /// Account ids whose balance the user has hidden.
  ///
  /// Fails CLOSED to "everything visible": an unreadable preference shows the
  /// balance, which is the state the user already sees today. Failing the
  /// other way would blank every card and look like the balances had been
  /// lost.
  static Set<String> hiddenBalanceAccounts(String uid) =>
      (_prefs?.getStringList(hiddenBalanceAccountsKey(uid)) ?? const [])
          .toSet();

  static bool isBalanceHidden(String uid, String accountId) =>
      hiddenBalanceAccounts(uid).contains(accountId);

  /// Toggles one account and returns the new hidden state.
  static Future<bool> toggleBalanceHidden(String uid, String accountId) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final current = hiddenBalanceAccounts(uid);
    final nowHidden = !current.contains(accountId);
    if (nowHidden) {
      current.add(accountId);
    } else {
      current.remove(accountId);
    }
    await prefs.setStringList(
        hiddenBalanceAccountsKey(uid), current.toList(growable: false));
    return nowHidden;
  }

  /// `true` when the launch prompt is ENABLED (the default).
  ///
  /// Fails OPEN: an unreadable preference shows the prompt. Silence is the
  /// damaging direction, because it hides money the user owes.
  static bool pendingPaymentsPromptEnabled(String uid) =>
      !(_prefs?.getBool(pendingPaymentsPromptKey(uid)) ?? false);

  static Future<void> setPendingPaymentsPromptEnabled(
      String uid, bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(pendingPaymentsPromptKey(uid), !enabled);
    if (enabled) {
      // Re-enabling restarts the count, so someone who turns it back on is not
      // immediately re-offered the opt-out on the very next launch.
      await prefs.remove(pendingPaymentsShowCountKey(uid));
    }
  }

  static int pendingPaymentsShowCount(String uid) =>
      _prefs?.getInt(pendingPaymentsShowCountKey(uid)) ?? 0;

  static Future<void> incrementPendingPaymentsShowCount(String uid) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final n = prefs.getInt(pendingPaymentsShowCountKey(uid)) ?? 0;
    await prefs.setInt(pendingPaymentsShowCountKey(uid), n + 1);
  }

  // User-selectable transfer style: "classic" (short flow) | "standard" (long
  // flow) | "" (follow the platform default). Client-side preference, mirroring
  // the auth_mode override pattern.
  static const String userTransferStyle = 'user_transfer_style';
  static const String transferStyleClassic = 'classic';
  static const String transferStyleStandard = 'standard';

  /// The user's explicit transfer-style choice, or `null` when they haven't
  /// chosen (→ follow the platform default). Synchronous read — call after [init].
  static String? get transferStyleOverride {
    final v = _prefs?.getString(userTransferStyle);
    return (v == null || v.isEmpty) ? null : v;
  }

  /// Resolved decision for which Send Funds flow to show: the per-user choice
  /// wins when set, otherwise the platform [sendFundsShortFlow] default.
  /// `true` = short ("classic"), `false` = long ("standard").
  static bool get useShortSendFlow {
    final override = transferStyleOverride;
    if (override == transferStyleClassic) return true;
    if (override == transferStyleStandard) return false;
    return sendFundsShortFlow;
  }

  /// Persist the user's transfer-style choice. Pass `null`/empty to clear the
  /// override and fall back to the platform default.
  static Future<void> setTransferStyle(String? style) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final s = (style ?? '').toLowerCase().trim();
    if (s == transferStyleClassic || s == transferStyleStandard) {
      await prefs.setString(userTransferStyle, s);
    } else {
      await prefs.remove(userTransferStyle);
    }
    // A style change is a DELIBERATE user action (Settings, never mid-send) —
    // force-re-pin so the new choice takes effect immediately for the next send,
    // even if a stray freeze were somehow active.
    pinSendFlowForSession(force: true);
  }

  /// The Send Funds flow decision to use everywhere the app STARTS a send
  /// journey. Returns the value pinned at login/boot (persisted, so it is stable
  /// for the whole session AND survives a cold start) — a mid-session background
  /// config refresh can never flip a user between the long and short flow
  /// mid-journey (e.g. switching right after the transaction-PIN sheet on a slow
  /// network). Falls back to the live [useShortSendFlow] only before the first
  /// pin (a brand-new install that has never resolved one).
  static bool get sendFlowShortForSession =>
      _sessionShortSendFlow ??
      _prefs?.getBool(sendFlowPinned) ??
      useShortSendFlow;

  /// (Re)resolve [useShortSendFlow] and pin it in memory + persist it (write-
  /// through) so the next cold start routes instantly with the last-known value.
  /// Called at login/session-revalidation (authentication_cubit, beside
  /// `LoginFlowResolver`) and on an explicit Settings change.
  ///
  /// A BACKGROUND re-resolve (login/session-revalidation) is FROZEN while a send
  /// flow is active ([_sendFlowDepth] > 0): it's deferred until the user is back
  /// on the dashboard, so a change can never take effect mid-journey. Memory is
  /// updated BEFORE the (async, fire-and-forget) disk write so the fast path is
  /// instant.
  ///
  /// A DELIBERATE user change (Settings) passes [force] — it is never mid-send,
  /// so it applies immediately and clears any deferred pin. `force` also makes
  /// the setting robust to a (bug-path) leaked [_sendFlowDepth] that would
  /// otherwise silently swallow the user's own change for the whole session.
  static void pinSendFlowForSession({bool force = false}) {
    if (!force) {
      // Establish the flow ONCE per login-session. A NON-force re-pin — an
      // app-lock passcode/biometric/voice unlock (session revalidation), a
      // background admin/remote default change, or a deferred re-pin applied
      // when a send journey ends — must NEVER flip the user mid-session (the
      // reported bug: short flow flipped to the long amount page right after a
      // send / after the receipt). It is re-resolved only on a GENUINE fresh
      // login (the pin is cleared on logout) or an explicit Settings change
      // ([force]).
      _repinPending = false;
      if (_sessionShortSendFlow != null) return;
    } else {
      _repinPending = false;
    }
    final v = useShortSendFlow;
    if (_sessionShortSendFlow == v) return; // unchanged — no memory/disk churn
    _sessionShortSendFlow = v;
    _prefs?.setBool(sendFlowPinned, v);
  }

  /// Clear the in-memory session flow pin (call on logout) so the NEXT genuine
  /// login re-resolves the flow (and picks up any changed platform default).
  /// The persisted [sendFlowPinned] value is intentionally KEPT so cold-boot
  /// routing before that login is still instant + offline-safe.
  static void clearSessionSendFlowPin() {
    _sessionShortSendFlow = null;
    _repinPending = false;
  }

  /// Mark that a Send Funds journey has been entered (the user tapped into it).
  /// Freezes the flow pin until the matching [endSendFlow] — reference-counted so
  /// nested send screens (picker → amount) don't unfreeze early.
  static void beginSendFlow() {
    _sendFlowDepth++;
  }

  /// Mark that a Send Funds screen was left. When the last one is gone (back on
  /// the dashboard) any deferred re-resolve is applied.
  static void endSendFlow() {
    if (_sendFlowDepth > 0) _sendFlowDepth--;
    if (_sendFlowDepth == 0 && _repinPending) {
      _repinPending = false;
      pinSendFlowForSession();
    }
  }

  /// `true` (PIN required) by default — fail-safe. UI gate only; the backend
  /// independently enforces the same setting. Synchronous read — call after
  /// [init].
  static bool get sendFundsPinIsRequired {
    return _prefs?.getBool(sendFundsPinRequired) ?? true;
  }

  // ── Batch Transfer flow config ───────────────────────────────────────────
  /// Batch transfer is PINNED to the long (step-by-step) flow by product
  /// decision — always false, regardless of any cached/admin short-flow value.
  /// (Re-enable the admin toggle by returning the prefs read below.)
  static bool get batchTransferShortFlow {
    return false;
    // return _prefs?.getBool(batchTransferShortFlowEnabled) ?? false;
  }

  /// `true` (PIN required) by default — fail-safe. UI gate only; the backend
  /// independently enforces the same setting. Synchronous read — call after [init].
  static bool get batchTransferPinIsRequired {
    return _prefs?.getBool(batchTransferPinRequired) ?? true;
  }

  // ── Scan Account Details config ──────────────────────────────────────────
  /// `true` (shown) by default until an admin hides the scan feature.
  /// Synchronous read — call after [init].
  static bool get scanAccountDetailsIsEnabled {
    return _prefs?.getBool(scanAccountDetailsEnabled) ?? true;
  }

  /// `true` (resolve scanned identifiers to Lazervault users for free internal
  /// transfers) by default. Synchronous read — call after [init].
  static bool get scanResolveUsersIsEnabled {
    return _prefs?.getBool(scanResolveUsersEnabled) ?? true;
  }

  /// Whether the standalone signup BVN screen is enabled (admin-toggled).
  /// Defaults to `false` → onboarding uses the Mono Prove flow (its webhook
  /// auto-creates the virtual account). Synchronous read — call after [init].
  static bool isBvnSignupScreenEnabled() =>
      _prefs?.getBool(bvnSignupScreenEnabled) ?? false;

  // ── Insurance hosted-webview entry points ────────────────────────────────
  /// `false` by default → native in-app Buy + Manage flows. When `true`, those
  /// two entry points open the MyCover hosted webview. Synchronous — call after
  /// [init].
  static bool get insuranceHostedEntrypoints {
    return _prefs?.getBool(insuranceHostedEntrypointsEnabled) ?? false;
  }

  /// The universal MyCover hosted base link, or empty when unset. The Buy/Manage
  /// flows compose the per-user URL from this. Synchronous — call after [init].
  static String get insuranceHostedBaseLink {
    return _prefs?.getString(insuranceHostedLink) ?? '';
  }

  // ── Airtime landing tabs ─────────────────────────────────────────────────
  /// Buy (domestic airtime) tab — ON by default. Synchronous — call after [init].
  static bool get airtimeBuyTabIsEnabled {
    return _prefs?.getBool(airtimeTabBuyEnabled) ?? true;
  }

  /// International airtime tab — ON by default. Synchronous — call after [init].
  static bool get airtimeInternationalTabIsEnabled {
    return _prefs?.getBool(airtimeTabInternationalEnabled) ?? true;
  }

  /// Sell (airtime-to-cash) tab — OFF by default. Synchronous — call after [init].
  static bool get airtimeSellTabIsEnabled {
    return _prefs?.getBool(airtimeTabSellEnabled) ?? false;
  }

  /// Invoice "split among multiple people" — OFF by default, so the standard
  /// invoice flow has a single payer. Synchronous — call after [init].
  static bool get invoiceSplitIsEnabled {
    return _prefs?.getBool(invoiceSplitEnabled) ?? false;
  }

  /// African voice languages (yo/ig/ha/pcm) — OFF by default. When off the voice
  /// assistant is English-only and African languages are hidden in the pickers.
  /// Synchronous — call after [init].
  static bool get africanVoiceLanguagesEnabled {
    return _prefs?.getBool(voiceAfricanLanguagesEnabled) ?? false;
  }

  // ── Platform authentication mode ─────────────────────────────────────────
  /// Active platform auth mode, defaulting to `phone_passcode` (the product
  /// default) so a fresh/pre-config launch is CONSISTENT with the platform
  /// intent and doesn't flip to email when `/auth/config` is slow/unreachable.
  /// Synchronous — call after [init].
  static String get authenticationMode {
    // NORMALISED, exactly like the server's normalizeAuthMode: only an explicit
    // "email_password" selects email mode; anything else — unset, empty, a
    // typo, a value from a newer build — resolves to the product default.
    //
    // Before this a bare `?? phone_passcode` covered only the NULL case, so a
    // corrupt or unrecognised stored value fell through as "not phone mode" and
    // silently put brand-new users into the email signup. The server refuses to
    // let an unknown value enable email mode; the client must agree, or the two
    // disagree precisely when something has already gone wrong.
    final raw = _prefs?.getString(authMode)?.toLowerCase().trim();
    return raw == authModeEmailPassword
        ? authModeEmailPassword
        : authModePhonePasscode;
  }

  /// True when the platform is in phone+passcode mode (brand-new/logged-out
  /// users get the phone onboarding + phone login). Existing accounts always
  /// keep their own method via [loginFlow].
  static bool get isPhonePasscodeMode {
    return authenticationMode == authModePhonePasscode;
  }

  /// Overwrite the cached auth mode (used by a startup refresh that reads the
  /// authoritative value from GET /api/v1/auth/config). Idempotent. Unknown
  /// values normalize to phone_passcode (the default).
  static Future<void> setAuthenticationMode(String mode) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final m = mode.toLowerCase().trim();
    await prefs.setString(
      authMode,
      m == authModeEmailPassword
          ? authModeEmailPassword
          : authModePhonePasscode,
    );
  }

  // ── Effective (per-user) login flow — SINGLE SOURCE OF TRUTH ─────────────
  /// The one canonical decision for "which login flow to show": either
  /// `phone_passcode` (→ passcode screen / phone signup) or `email_password`
  /// (→ email sign-in / email signup). It is resolved ONCE (from the account's
  /// shape + the user's explicit Settings choice) and cached here, so every
  /// site — the boot router, [AppRoutes.loginEntry]/[AppRoutes.signupEntry],
  /// and both login screens' sub-state — reads the SAME value instead of
  /// re-deriving it from a racy mix of signals.
  ///
  /// Offline-safe: a plain SharedPreferences read, never a network call. Falls
  /// back to the platform [authenticationMode] (itself default phone_passcode)
  /// when never set, so a brand-new user still follows the platform default.
  static String get loginFlow {
    return _prefs?.getString(effectiveLoginMethod) ?? authenticationMode;
  }

  /// True when the resolved per-user flow is email+password.
  static bool get isEmailPasswordLogin => loginFlow == authModeEmailPassword;

  /// Whether an effective login flow has been resolved+cached yet (used by the
  /// one-time boot migration to seed it from legacy signals).
  static bool get hasLoginFlow =>
      _prefs?.getString(effectiveLoginMethod) != null;

  /// Persist the resolved per-user login flow. Called on every successful login
  /// (from the account shape) and when the user switches method in Settings.
  static Future<void> setLoginFlow(String mode) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    final m = mode.toLowerCase().trim();
    await prefs.setString(
      effectiveLoginMethod,
      m == authModeEmailPassword
          ? authModeEmailPassword
          : authModePhonePasscode,
    );
  }

  /// Whether onboarding email verification is required (admin toggle). When true
  /// the verify-email step is not skippable.
  ///
  /// Defaults to TRUE — required. This is the value used before the app has ever
  /// reached the server, and on a fresh install that is exactly the moment a
  /// skip button must not appear. Defaulting to false meant a first run, a
  /// cleared cache or an unreachable backend all silently offered the escape
  /// hatch on a security step.
  ///
  /// An admin turning verification off is an explicit, server-side decision; it
  /// arrives with the auth config and overwrites this. Synchronous — call after
  /// [init].
  static bool get isEmailVerificationRequired {
    return _prefs?.getBool(emailVerificationRequired) ?? true;
  }

  /// Whether onboarding phone verification is required (admin toggle).
  static bool get isPhoneVerificationRequired {
    return _prefs?.getBool(phoneVerificationRequired) ?? false;
  }

  /// Whether identity verification is REQUIRED (admin toggle). See
  /// [kycRequiredOnSignup] for what each state means.
  ///
  /// Defaults to FALSE, which is the opposite choice from
  /// [isEmailVerificationRequired] and for a reason worth keeping: this default
  /// is what a phone uses before it has ever reached the server, and when it is
  /// wrong the two flags fail in opposite directions. A missing
  /// email-verification value hides a SKIP BUTTON — erring towards required
  /// costs a verified user nothing. A missing value here would REFUSE THE
  /// DASHBOARD to everyone whose verification we cannot currently read, turning
  /// one unreachable config endpoint into a platform-wide lockout of every
  /// unverified account.
  ///
  /// So an unreadable config falls back to asking rather than blocking, and the
  /// live admin value — which arrives within one settings poll — is what
  /// actually enforces. Synchronous; call after [init].
  static bool get isKycRequired {
    return _prefs?.getBool(kycRequiredOnSignup) ?? false;
  }

  /// Whether to auto-fire the biometric OS prompt on the passcode lock screen for
  /// opted-in returning users (admin toggle). Defaults to true so the "auto
  /// logon" is on until an admin turns it off. Synchronous — call after [init].
  /// The passcode screen still requires the biometric to be enrolled AND opted
  /// into, so this is a convenience trigger, never an auth bypass.
  /// Whether Settings shows the light/dark theme switch.
  ///
  /// Defaults to FALSE — hidden until an admin turns it on. An unreadable
  /// config must not reveal a control whose other half (a fully light-audited
  /// app) may not be ready; hiding is the safe direction here, unlike the
  /// verification flags where hiding would lock people out.
  static bool get themeSwitchEnabled {
    return _prefs?.getBool(themeSwitchVisible) ?? false;
  }

  /// Whether a receipt share offers the PDF / JPG format sheet.
  ///
  /// Defaults to FALSE — share straight out in the default format. Same
  /// reasoning: an unreadable config should not surface an extra choice.
  static bool get receiptFormatSheetEnabled {
    return _prefs?.getBool(receiptFormatSheetVisible) ?? false;
  }

  static bool get autoBiometricLoginOnLaunch {
    return _prefs?.getBool(autoBiometricLoginEnabled) ?? true;
  }

  /// Overwrite the cached verification-required flags (used by the startup
  /// refresh that reads them from GET /api/v1/auth/config alongside auth_mode).
  static Future<void> setVerificationRequirements({
    required bool email,
    required bool phone,
  }) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(emailVerificationRequired, email);
    await prefs.setBool(phoneVerificationRequired, phone);
  }

  // ── Social sign-in visibility (admin toggles, from GetAuthenticationConfig) ──
  /// Whether social sign-in is shown at all (admin master toggle). Default TRUE
  /// so a fresh install / config-read failure shows it (it is not a security
  /// control — the server verifies every provider token regardless).
  static bool get isSocialLoginEnabled =>
      _prefs?.getBool(socialLoginEnabledKey) ?? true;

  /// Whether the Google button is shown (admin toggle AND the master toggle).
  static bool get isGoogleLoginEnabled =>
      isSocialLoginEnabled && (_prefs?.getBool(googleLoginEnabledKey) ?? true);

  /// Whether the Apple button is shown (admin toggle AND the master toggle).
  static bool get isAppleLoginEnabled =>
      isSocialLoginEnabled && (_prefs?.getBool(appleLoginEnabledKey) ?? true);

  /// Whether voice sign-in shows on the passcode screen (admin toggle).
  /// DEFAULT FALSE (hidden) — opt-in per deployment. Still requires the user's
  /// own voice enrolment to actually be usable.
  static bool get isVoiceLoginEnabled =>
      _prefs?.getBool(voiceLoginEnabledKey) ?? false;

  /// Overwrite the cached social-login visibility flags (from the startup
  /// GET /api/v1/auth/config refresh, alongside auth_mode + verification).
  static Future<void> setSocialLoginVisibility({
    required bool social,
    required bool google,
    required bool apple,
  }) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(socialLoginEnabledKey, social);
    await prefs.setBool(googleLoginEnabledKey, google);
    await prefs.setBool(appleLoginEnabledKey, apple);
  }

  /// Overwrite the cached voice-login visibility flag (same config refresh).
  static Future<void> setVoiceLoginVisibility(bool enabled) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setBool(voiceLoginEnabledKey, enabled);
  }

  // ── App auto-update (store version check) ─────────────────────────────────
  /// Master toggle for the OPTIONAL update prompt (banner + one-time modal).
  /// `true` by default. The forced/blocking update (below minimum build) is
  /// independent of this and always applies. Synchronous — call after [init].
  static bool get appUpdateEnabled {
    return _prefs?.getBool(appUpdateEnabledKey) ?? true;
  }

  static int _buildOf(String key) {
    final raw = _prefs?.getString(key);
    if (raw == null || raw.trim().isEmpty) return 0;
    return int.tryParse(raw.trim()) ?? 0;
  }

  /// Latest available build number for the platform (0 = unset/unknown → no
  /// update prompt). Pass `isIOS = true` for iOS, false for Android.
  static int appLatestBuild({required bool isIOS}) {
    return _buildOf(isIOS ? appLatestBuildIos : appLatestBuildAndroid);
  }

  /// Minimum supported build number for the platform (0 = unset → never force).
  /// A running build below this triggers the blocking update gate.
  static int appMinBuild({required bool isIOS}) {
    return _buildOf(isIOS ? appMinBuildIos : appMinBuildAndroid);
  }

  /// Admin-configured store URL for the platform, or empty when unset (the
  /// service falls back to a sensible default store link).
  static String appStoreUrl({required bool isIOS}) {
    return (_prefs?.getString(isIOS ? appStoreUrlIos : appStoreUrlAndroid) ??
            '')
        .trim();
  }

  /// Human-readable latest version string (e.g. "1.1.0") for display, or empty.
  static String appLatestVersion({required bool isIOS}) {
    return (_prefs?.getString(
              isIOS ? appLatestVersionIos : appLatestVersionAndroid,
            ) ??
            '')
        .trim();
  }

  /// Optional release notes shown in the update modal, or empty.
  static String get appUpdateNotes {
    return (_prefs?.getString(appUpdateNotesKey) ?? '').trim();
  }
}
