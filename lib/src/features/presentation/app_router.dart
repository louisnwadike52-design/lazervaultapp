import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_verification_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/phone_verification_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_setup_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/change_passcode_screen.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/views/transaction_pin_setup_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/buy_crypto_screen.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_proof.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/purchase_gift_card_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_details_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_payment_method_selection_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_purchase_processing_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_purchase_confirmation_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_transactions_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/redeem_gift_card_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/sell_to_contact_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/saved_recipients_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/quick_sell_screen.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/currency_deposit_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_start_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_amount_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_recipient_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/international_transfer_review_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_method_selection_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_amount_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_review_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_success_screen.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/create_new_password_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/transaction_history_screen.dart';
import 'package:lazervault/src/features/presentation/views/enable_biometric_access_screen.dart';
import 'package:lazervault/src/features/presentation/views/face_scan_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/facial_login_screen.dart';
import 'package:lazervault/src/features/presentation/views/facial_biometric_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/flights/flights_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/deposit_funds_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdraw_funds_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/initiate_send_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/languages_screen.dart';
import 'package:lazervault/src/features/presentation/views/my_account_screen.dart';
import 'package:lazervault/src/features/presentation/views/otp_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/password_recovery_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/password_recovery_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/profile_settings_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_electricity_bills_screen.dart';
import 'package:lazervault/src/features/presentation/views/camera_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_screen.dart';
import 'package:lazervault/src/features/presentation/views/input_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/new_card_screen.dart';
import 'package:lazervault/src/features/presentation/views/pay_electricity_bill_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_funds_transfer_screen.dart';
import 'package:lazervault/src/features/presentation/views/select_country_screen.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/view/add_recipient_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/select_recipient_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/qr_scanner_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/my_qr_code_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/split_bills/split_bills_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_receipt_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/transfer_processing_screen.dart';
import 'package:lazervault/src/features/presentation/views/set_fingerprint_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_setup_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_verification_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_settings_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stocks_screen.dart' as StockFeature;
import 'package:lazervault/src/features/stocks/presentation/view/stocks_home_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_details_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_amount_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_payment_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_review_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_receipt_screen.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/presentation/views/upload_image_scren.dart';
// Portfolio temporarily disabled
// import 'package:lazervault/src/features/portfolio/presentation/view/portfolio_details_screen.dart';
// import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_cubit.dart';
import '../../../core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/presentation/views/modern_onboarding_screen.dart';
import '../../../main.dart' show AuthCheckScreen;
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_chart_details_screen.dart';
import '../investments/presentation/view/investments_screen.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_detail_screen.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_chart_details_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_home_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_list_screen.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
import 'package:lazervault/src/features/cards/presentation/view/card_creation_form_screen.dart';
import 'package:lazervault/src/features/cards/presentation/view/card_creation_receipt_screen.dart';
import 'package:lazervault/src/features/voice_enrollment/cubit/voice_enrollment_cubit.dart';
import 'package:lazervault/src/features/voice_enrollment/presentation/voice_enrollment_screen.dart';
import 'package:lazervault/src/features/voice_activation/presentation/voice_activation_prompt_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/view/create_invoice_carousel.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/create_invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_details_screen.dart';
import 'package:lazervault/src/features/invoice/domain/entities/invoice_entity.dart';
import 'package:lazervault/src/features/invoice/presentation/view/incoming_tagged_invoices_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/outgoing_tagged_invoices_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_preview_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_payment_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/view/pay_invoice_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/cubit/pay_invoice_cubit.dart';
// AI Scan to Pay imports
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_to_pay_screen.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/cubit/ai_scan_cubit.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_camera_screen.dart';
// import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_payment_screen.dart';
// import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_payment_success_screen.dart';
// import 'package:lazervault/src/features/ai_scan_to_pay/domain/entities/scan_entities.dart';

// Group Account imports
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/views/group_account_list_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/group_details_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/contribution_details_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/make_payment_screen.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

// Insurance imports
import 'package:lazervault/src/features/insurance/presentation/cubit/insurance_cubit.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_list_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_policy_detail_view.dart';
import 'package:lazervault/src/features/insurance/presentation/view/edit_insurance_policy_view.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_payment_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_payment_processing_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/create_claim_screen.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_payment_entity.dart';

// Airtime imports
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_cubit.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/country_selection_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/network_selection_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/recipient_input_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/amount_selection_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_review_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_payment_processing_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_history_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_details_screen.dart';

// AutoSave imports
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/views/autosave_dashboard_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/autosave_transactions_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/create_autosave_rule_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/edit_autosave_rule_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/autosave_rule_review_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/autosave_rule_processing_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/autosave_rule_receipt_screen.dart';
import 'package:lazervault/src/features/autosave/presentation/views/autosave_rule_details_screen.dart';

// Batch Transfer imports
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/presentation/view/batch_transfer/batch_transfer_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/batch_transfer/batch_transfer_review_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/batch_transfer/batch_transfer_processing_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/batch_transfer/batch_transfer_receipt_screen.dart';

// Statistics imports
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/add_expense_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/add_budget_screen.dart';

// Tag Pay imports
import 'package:lazervault/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_pay_home_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/create_tag_pay_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/send_money_tag_pay_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/request_money_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_pay_transactions_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/pending_requests_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/search_users_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/create_tag_screen_redesigned.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/my_tags_screen_redesigned.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/outgoing_tags_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/incoming_tags_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_pay_processing_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_payment_receipt_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_creation_processing_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_creation_receipt_screen.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_tag_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';

// Barcode QuickPay imports
import 'package:lazervault/src/features/barcode_payment/presentation/cubit/barcode_payment_cubit.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/barcode_quick_pay_home_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/generate_barcode_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/barcode_display_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/scan_barcode_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/barcode_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/barcode_payment_processing_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/barcode_payment_receipt_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/generated_barcodes_history_screen.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/view/scanned_barcodes_history_screen.dart';

// Contactless Payment imports
import 'package:lazervault/src/features/contactless_payment/presentation/cubit/contactless_payment_cubit.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/view/contactless_payment_home_screen.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/view/create_payment_session_screen.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/view/nfc_reader_screen.dart';
import 'package:lazervault/src/features/contactless_payment/presentation/view/payment_history_screen.dart' as contactless_history;
import 'package:lazervault/src/features/contactless_payment/domain/repositories/contactless_payment_repository.dart';

// Crowdfund imports
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_cubit.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/crowdfund_home_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/crowdfund_list_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/crowdfund_details_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/create_crowdfund_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_payment_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_processing_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_receipt_screen.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';

// Electricity Bill imports
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/electricity_bill_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/beneficiary_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/auto_recharge_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/reminder_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/electricity_bill_home_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/meter_input_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/payment_confirmation_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/payment_processing_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/payment_receipt_screen.dart' as bill_receipt;
import 'package:lazervault/src/features/electricity_bill/presentation/view/payment_history_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/beneficiaries_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/add_beneficiary_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/auto_recharge_list_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/create_auto_recharge_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/edit_auto_recharge_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/reminders_screen.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/view/create_reminder_screen.dart';

// Currency Exchange imports
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/bindings/exchange_binding.dart';

// Settings imports
import 'package:lazervault/src/features/settings/presentation/view/privacy_policy_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/help_support_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/contact_us_screen.dart';
import 'package:lazervault/src/features/referral/presentation/screens/referral_dashboard_screen.dart';
import 'package:lazervault/src/features/referral/presentation/cubit/referral_cubit.dart';

// WhatsApp Banking imports
import 'package:lazervault/src/features/whatsapp_banking/cubit/whatsapp_banking_cubit.dart';
import 'package:lazervault/src/features/whatsapp_banking/presentation/screens/whatsapp_main_screen.dart';
import 'package:lazervault/src/features/whatsapp_banking/presentation/screens/whatsapp_linking_screen.dart';
import 'package:lazervault/src/features/whatsapp_banking/presentation/screens/whatsapp_security_screen.dart';

// KYC imports
import 'package:lazervault/src/features/kyc/presentation/views/progressive_kyc_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/views/id_verification_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/presentation/views/debug_settings_screen.dart';

// Lock Funds imports
import 'package:lazervault/src/features/lock_funds/presentation/cubit/lock_funds_cubit.dart';
import 'package:lazervault/src/features/lock_funds/presentation/screens/lock_funds_list_screen.dart';

// Family Account imports
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_setup_flow_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_add_member_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_invite_member_flow_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_account_detail_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_edit_member_limits_screen.dart';

// Transaction History imports (Redesigned)
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/dashboard_transaction_history_screen.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/service_transaction_history_screen.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppRoutes.root,
      page: () => const ModernOnboardingScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.authCheck,
      page: () => const AuthCheckScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => serviceLocator<DashboardScreen>(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: AppRoutes.newCard,
      page: () => serviceLocator<NewCardScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cameraScan,
      page: () => serviceLocator<CameraScanScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.uploadImage,
      page: () => serviceLocator<UploadImageScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.flights,
      page: () => serviceLocator<FlightsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.crypto,
      page: () => BlocProvider(
        create: (context) => serviceLocator<CryptoCubit>(),
        child: serviceLocator<CryptoScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cryptoDetails,
      page: () {
        final crypto = Get.arguments as Crypto;
        return BlocProvider(
          create: (context) => serviceLocator<CryptoCubit>(),
          child: serviceLocator<CryptoDetailScreen>(param1: crypto),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.buyCrypto,
      page: () {
        final selectedCrypto = Get.arguments as Crypto?;
        return BlocProvider(
          create: (context) => serviceLocator<CryptoCubit>(),
          child: BuyCryptoScreen(selectedCrypto: selectedCrypto),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stocks,
      page: () => BlocProvider(
        create: (context) => serviceLocator<StockCubit>(),
        child: const StocksHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.investments,
      page: () => serviceLocator<InvestmentsScreen>(),
      transition: Transition.rightToLeft,
    ),
    // Portfolio temporarily disabled
    // GetPage(
    //   name: AppRoutes.portfolioDetails,
    //   page: () => const PortfolioDetailsScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: AppRoutes.giftCards,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<GiftCardsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.selectRecipient,
      page: () => BlocProvider(
        create: (_) => serviceLocator<RecipientCubit>(),
        child: serviceLocator<SelectRecipientScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addRecipient,
      page: () => BlocProvider(
        create: (_) => serviceLocator<RecipientCubit>(),
        child: serviceLocator<AddRecipientScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.qrScanner,
      page: () => const QRScannerScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myQRCode,
      page: () => const MyQRCodeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.splitBills,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<RecipientCubit>()),
          BlocProvider(create: (_) => serviceLocator<TransferCubit>()),
        ],
        child: const SplitBillsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoice,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<InvoiceCubit>()..loadInvoices()),
          BlocProvider(create: (_) => serviceLocator<TaggedInvoiceCubit>()..loadIncomingInvoices()),
        ],
        child: const InvoiceHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoiceList,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InvoiceCubit>(),
        child: const InvoiceListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createInvoice,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => serviceLocator<InvoiceCubit>(),
            ),
            BlocProvider(
              create: (_) => CreateInvoiceCubit(),
            ),
          ],
          child: const CreateInvoiceCarousel(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoiceDetails,
      page: () {
        final invoiceId = Get.arguments as String;
        return BlocProvider(
          create: (_) => serviceLocator<InvoiceCubit>(),
          child: serviceLocator<InvoiceDetailsScreen>(param1: invoiceId),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoicePreview,
      page: () {
        final invoice = Get.arguments as Invoice;
        return InvoicePreviewScreen(invoice: invoice);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoicePayment,
      page: () {
        final invoice = Get.arguments as Invoice;
        return InvoicePaymentScreen(invoice: invoice);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.incomingTaggedInvoices,
      page: () => BlocProvider(
        create: (_) => serviceLocator<TaggedInvoiceCubit>(),
        child: const IncomingTaggedInvoicesScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.outgoingTaggedInvoices,
      page: () => BlocProvider(
        create: (_) => serviceLocator<TaggedInvoiceCubit>(),
        child: const OutgoingTaggedInvoicesScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.inputPin,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<InputPinScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payElectricityBill,
      page: () => serviceLocator<PayElectricityBillScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profileSettings,
      page: () => serviceLocator<ProfileSettingsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.languages,
      page: () => serviceLocator<LanguagesScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myAccount,
      page: () => serviceLocator<MyAccountScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.setFingerPrint,
      page: () => serviceLocator<SetFingerPrintScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.changePin,
      page: () => serviceLocator<ChangePinScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => serviceLocator<SignUpScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.emailSignIn,
      page: () => serviceLocator<EmailSignInScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.passcodeLogin,
      page: () => serviceLocator<PasscodeSignInScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.passcodeSetup,
      page: () => const PasscodeSetupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transactionPinSetup,
      page: () => const TransactionPinSetupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.changePasscode,
      page: () => const ChangePasscodeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.emailVerification,
      page: () {
        // Handle both Map arguments and direct String arguments
        final args = Get.arguments;
        String? email;
        bool codeSent = true;
        bool isRequired = true;
        String? secondaryPhone;

        if (args is Map) {
          final mapArgs = Map<String, dynamic>.from(args);
          email = mapArgs['email']?.toString();
          codeSent = mapArgs['codeSent'] as bool? ?? true;
          isRequired = mapArgs['isRequired'] as bool? ?? true;
          secondaryPhone = mapArgs['secondaryPhone']?.toString();
        } else if (args is String) {
          email = args;
        } else {
          email = Get.parameters['email'];
        }

        return BlocProvider(
          create: (context) => serviceLocator<EmailVerificationCubit>(),
          child: EmailVerificationScreen(
            email: email,
            codeSent: codeSent,
            isRequired: isRequired,
            secondaryPhone: secondaryPhone,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.phoneVerification,
      page: () {
        // Handle both Map arguments and direct String arguments
        final args = Get.arguments;
        String? phoneNumber;
        if (args is Map<String, dynamic>) {
          phoneNumber = args['phoneNumber'] as String?;
        } else if (args is String) {
          phoneNumber = args;
        } else {
          phoneNumber = Get.parameters['phoneNumber'];
        }
        return BlocProvider(
          create: (context) => serviceLocator<PhoneVerificationCubit>(),
          child: PhoneVerificationScreen(
            phoneNumber: phoneNumber,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => serviceLocator<PasscodeSignInScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => serviceLocator<OTPVerificationScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.enableBiometricAccess,
      page: () => serviceLocator<EnableBiometricAccessScreen>(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.passwordRecovery,
      page: () => serviceLocator<PasswordRecoveryScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.passwordRecoveryVerification,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return PasswordRecoveryVerificationScreen(
          email: args['email'] as String,
          deliveryMethod: args['deliveryMethod'] as String? ?? 'SMS',
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createNewPassword,
      page: () => serviceLocator<CreateNewPasswordScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.selectCountry,
      page: () => serviceLocator<SelectCountryScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.facialBiometricVerification,
      page: () => serviceLocator<FacialBiometricVerificationScreen>(),
      transition: Transition.upToDown,
    ),
    GetPage(
      name: AppRoutes.faceScan,
      page: () => serviceLocator<FaceScanScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.facialLogin,
      page: () => serviceLocator<FacialLoginScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.referralDashboard,
      page: () => BlocProvider(
        create: (context) => serviceLocator<ReferralCubit>(),
        child: const ReferralDashboardScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // WhatsApp Banking Routes
    GetPage(
      name: AppRoutes.whatsappBanking,
      page: () => BlocProvider(
        create: (context) => serviceLocator<WhatsAppBankingCubit>(),
        child: const WhatsAppMainScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.whatsappLinking,
      page: () => BlocProvider(
        create: (context) => serviceLocator<WhatsAppBankingCubit>(),
        child: const WhatsAppLinkingScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.whatsappSecurity,
      page: () => BlocProvider(
        create: (context) => serviceLocator<WhatsAppBankingCubit>(),
        child: const WhatsAppSecurityScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.reviewFundsTransfer,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<ReviewFundsTransferScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.reviewElectricityBillDetails,
      page: () {
        final electricityBillDetails = Get.arguments as ElectricityBillDetails;
        return serviceLocator<ReviewElectricityBillsScreen>(
          param1: electricityBillDetails,
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sendFunds,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<SendFundScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferProcessing,
      page: () => const TransferProcessingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferProof,
      page: () {
        final transferDetails = Get.arguments as Map<String, dynamic>? ?? {};
        return TransferProof(transferDetails: transferDetails);
      },
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.initiateSendFunds,
      page: () {
        final recipient = Get.arguments as RecipientModel;
        return BlocProvider(
          create: (_) => serviceLocator<TransferCubit>(),
          child: serviceLocator<InitiateSendFundsScreen>(param1: recipient),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sendFundReceipt,
      page: () {
        final transaction = Get.arguments as Transaction;
        return serviceLocator<SendFundReceiptScreen>(param1: transaction);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transactionHistory,
      page: () => serviceLocator<TransactionHistoryScreen>(),
      transition: Transition.rightToLeft,
    ),
    // New Transaction History Routes (Redesigned)
    GetPage(
      name: AppRoutes.dashboardTransactionHistory,
      page: () => BlocProvider(
        create: (_) => serviceLocator<TransactionHistoryCubit>(),
        child: const DashboardTransactionHistoryScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.serviceTransactionHistory,
      page: () {
        final serviceType = Get.arguments as TransactionServiceType;
        return BlocProvider(
          create: (_) => serviceLocator<TransactionHistoryCubit>(),
          child: ServiceTransactionHistoryScreen(serviceType: serviceType),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositFunds,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => serviceLocator<DepositCubit>(),
          child:
              serviceLocator<DepositFundsScreen>(param1: args['selectedCard']),
        );
      },
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.withdrawFunds,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => serviceLocator<WithdrawalCubit>(),
          child:
              serviceLocator<WithdrawFundsScreen>(param1: args['selectedCard']),
        );
      },
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.cbCurrencyExchange,
      page: () => serviceLocator<CBCurrencyExchangeScreen>(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AppRoutes.currencyExchange,
      page: () => const ExchangeScreen(),
      binding: ExchangeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.currencyDeposit,
      page: () {
        final currencyCode = Get.arguments as String;
        return serviceLocator<CurrencyDepositScreen>(param1: currencyCode);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.purchaseGiftCard,
      page: () {
        final brand = Get.arguments as GiftCardBrand;
        return BlocProvider(
          create: (_) => serviceLocator<GiftCardCubit>(),
          child: PurchaseGiftCardScreen(brand: brand),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.giftCardDetails,
      page: () {
        final giftCard = Get.arguments as GiftCard;
        return GiftCardDetailsScreen(giftCard: giftCard);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.giftCardPaymentMethod,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return GiftCardPaymentMethodSelectionScreen(
          brandId: args['brandId'],
          brandName: args['brandName'],
          brandLogoUrl: args['brandLogoUrl'],
          amount: args['amount'],
          discountPercentage: args['discountPercentage'],
          finalPrice: args['finalPrice'],
          currency: args['currency'],
          recipientEmail: args['recipientEmail'],
          recipientName: args['recipientName'],
          message: args['message'],
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.giftCardPurchaseProcessing,
      page: () => BlocProvider.value(
        value: serviceLocator<GiftCardCubit>(),
        child: const GiftCardPurchaseProcessingScreen(),
      ),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.giftCardPurchaseConfirmation,
      page: () => const GiftCardPurchaseConfirmationScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.giftCardTransactions,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: const GiftCardTransactionsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.redeemGiftCard,
      page: () {
        final giftCard = Get.arguments as GiftCard?;
        return BlocProvider(
          create: (_) => serviceLocator<GiftCardCubit>(),
          child: RedeemGiftCardScreen(giftCard: giftCard),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myGiftCards,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<MyGiftCardsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sellToContact,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<SellToContactScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.savedRecipients,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<SavedRecipientsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.quickSell,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: serviceLocator<QuickSellScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferStart,
      page: () => const InternationalTransferStartScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferAmount,
      page: () => const InternationalTransferAmountScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferRecipient,
      page: () => const InternationalTransferRecipientScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internationalTransferReview,
      page: () => const InternationalTransferReviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositMethodSelection,
      page: () => const DepositMethodSelectionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositAmount,
      page: () => const DepositAmountScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositReview,
      page: () => const DepositReviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.depositSuccess,
      page: () => const DepositSuccessScreen(),
      transition: Transition.rightToLeft,
    ),
    // Stock Exchange Routes
    GetPage(
      name: AppRoutes.stockDetails,
      page: () {
        final stock = Get.arguments as Stock;
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>()..loadStockDetails(stock.symbol),
          child: serviceLocator<StockDetailsScreen>(param1: stock),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTrade,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadStocks(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show trade dialog
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradeAmount,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradeAmountScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradePayment,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradePaymentScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradeReview,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradeReviewScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockTradeReceipt,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>(),
          child: serviceLocator<StockTradeReceiptScreen>(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockPortfolio,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadPortfolio(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show portfolio tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockWatchlist,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadWatchlists(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show watchlist tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockOrders,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadOrders(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show orders tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockNews,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StockCubit>()..loadMarketNews(),
        child: serviceLocator<StockFeature.StocksScreen>(), // Will show news tab
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.stockChartDetails,
      page: () {
        final stock = Get.arguments as Stock;
        return BlocProvider(
          create: (_) => serviceLocator<StockCubit>()..loadStockDetails(stock.symbol),
          child: serviceLocator<StockChartDetailsScreen>(param1: stock),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cryptoChartDetails,
      page: () {
        final crypto = Get.arguments as Crypto;
        return BlocProvider(
          create: (context) => serviceLocator<CryptoCubit>(),
          child: serviceLocator<CryptoChartDetailsScreen>(param1: crypto),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payInvoice,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<PayInvoiceCubit>(),
          ),
        ],
        child: serviceLocator<PayInvoiceScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    // AI Scan to Pay routes
    GetPage(
      name: AppRoutes.aiScanToPay,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AiScanCubit>(),
        child: const AiScanToPayScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.aiScanCamera,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AiScanCubit>(),
        child: const AiScanCameraScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.aiScanPayment,
    //   page: () {
    //     final paymentInstruction = Get.arguments as PaymentInstruction;
    //     return BlocProvider(
    //       create: (_) => serviceLocator<AiScanCubit>(),
    //       child: AiScanPaymentScreen(paymentInstruction: paymentInstruction),
    //     );
    //   },
    //   transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: AppRoutes.aiScanPaymentSuccess,
    //   page: () {
    //     final args = Get.arguments as Map<String, dynamic>;
    //     return BlocProvider(
    //       create: (_) => serviceLocator<AiScanCubit>(),
    //       child: AiScanPaymentSuccessScreen(
    //         paymentInstruction: args['paymentInstruction'] as PaymentInstruction,
    //         transactionId: args['transactionId'] as String,
    //       ),
    //     );
    //   },
    //   transition: Transition.rightToLeft,
    // ),
    
    // Group Account routes
    GetPage(
      name: AppRoutes.groupAccount,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GroupAccountCubit>()..loadUserGroups(),
        child: const GroupAccountListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.groupDetails,
      page: () {
        final groupId = Get.arguments as String;
        return BlocProvider(
          create: (_) => serviceLocator<GroupAccountCubit>()..loadGroupDetails(groupId),
          child: GroupDetailsScreen(groupId: groupId),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createGroup,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GroupAccountCubit>(),
        child: const GroupAccountListScreen(), // This will be replaced with CreateGroupScreen later
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contributionDetails,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final contributionId = args['contributionId'] as String;
        final contribution = args['contribution'] as Contribution?;
        return BlocProvider(
          create: (_) => serviceLocator<GroupAccountCubit>(),
          child: ContributionDetailsScreen(
            contributionId: contributionId,
            contribution: contribution,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.makePayment,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final contributionId = args['contributionId'] as String;
        final contribution = args['contribution'] as Contribution?;
        return BlocProvider(
          create: (_) => serviceLocator<GroupAccountCubit>(),
          child: MakePaymentScreen(
            contributionId: contributionId,
            contribution: contribution,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    
    // Insurance routes
    GetPage(
      name: AppRoutes.insurance,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InsuranceCubit>(),
        child: const InsuranceListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceDetails,
      page: () {
        final insurance = Get.arguments as Insurance;
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: InsurancePolicyDetailView(insurance: insurance),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceEdit,
      page: () {
        final insurance = Get.arguments as Insurance;
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: EditInsurancePolicyView(insurance: insurance),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insurancePayment,
      page: () {
        final insurance = Get.arguments as Insurance;
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: InsurancePaymentScreen(insurance: insurance),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insurancePaymentProcessing,
      page: () {
        final payment = Get.arguments as InsurancePayment;
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: InsurancePaymentProcessingScreen(payment: payment),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insurancePaymentConfirmation,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final payment = args['payment'] as InsurancePayment;
        final receiptUrl = args['receiptUrl'] as String? ?? '';
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: InsurancePaymentConfirmationScreen(
            payment: payment,
            receiptUrl: receiptUrl,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createClaim,
      page: () {
        final insuranceId = Get.arguments as String;
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: CreateClaimScreen(insuranceId: insuranceId),
        );
      },
      transition: Transition.rightToLeft,
    ),
    
    // Airtime routes
    GetPage(
      name: AppRoutes.airtime,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AirtimeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeCountrySelection,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const CountrySelectionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeNetworkSelection,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const NetworkSelectionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeRecipientInput,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const RecipientInputScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeAmountSelection,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AmountSelectionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeReview,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AirtimeReviewScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimePaymentProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AirtimePaymentProcessingScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimePaymentConfirmation,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AirtimePaymentConfirmationScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeHistory,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AirtimeHistoryScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.airtimeDetails,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AirtimeCubit>(),
        child: const AirtimeDetailsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // AutoSave routes
    GetPage(
      name: AppRoutes.autoSave,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AutoSaveCubit>(),
        child: const AutoSaveDashboardScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createAutoSaveRule,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AutoSaveCubit>(),
        child: const CreateAutoSaveRuleScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.editAutoSaveRule,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AutoSaveCubit>(),
        child: const EditAutoSaveRuleScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.autoSaveRuleReview,
      page: () => const AutoSaveRuleReviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.autoSaveRuleProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AutoSaveCubit>(),
        child: const AutoSaveRuleProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.autoSaveRuleReceipt,
      page: () => const AutoSaveRuleReceiptScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.autoSaveTransactions,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AutoSaveCubit>(),
        child: const AutoSaveTransactionsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.autoSaveDetails,
      page: () => BlocProvider(
        create: (_) => serviceLocator<AutoSaveCubit>(),
        child: const AutoSaveRuleDetailsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Batch Transfer routes
    GetPage(
      name: AppRoutes.batchTransfer,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BatchTransferCubit>(),
        child: const BatchTransferScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferReview,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BatchTransferCubit>(),
        child: const BatchTransferReviewScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferProcessing,
      page: () => const BatchTransferProcessingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferReceipt,
      page: () => const BatchTransferReceiptScreen(),
      transition: Transition.rightToLeft,
    ),

    // Statistics routes
    GetPage(
      name: AppRoutes.statistics,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StatisticsCubit>()..loadStatistics(),
        child: serviceLocator<StatisticsScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addExpense,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StatisticsCubit>(),
        child: serviceLocator<AddExpenseScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addBudget,
      page: () => BlocProvider(
        create: (_) => serviceLocator<StatisticsCubit>(),
        child: serviceLocator<AddBudgetScreen>(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Tag Pay routes
    GetPage(
      name: AppRoutes.tagPay,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const TagPayHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createTagPay,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const CreateTagPayScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.sendMoneyTagPay,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const SendMoneyTagPayScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.requestMoneyTagPay,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const RequestMoneyScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.tagPayTransactions,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const TagPayTransactionsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.pendingRequests,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const PendingRequestsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.searchUsers,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const SearchUsersScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createTag,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const CreateTagScreenRedesigned(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myTags,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const MyTagsScreenRedesigned(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.outgoingTags,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const OutgoingTagsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.incomingTags,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const IncomingTagsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.tagPaymentConfirmation,
      page: () {
        final tag = Get.arguments as UserTagEntity;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<TagPayCubit>()),
            BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
          ],
          child: TagPaymentConfirmationScreen(tag: tag),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.tagPayProcessing,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<TagPayCubit>(),
          child: const TagPayProcessingScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.tagPaymentReceipt,
      page: () => const TagPaymentReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.tagCreationProcessing,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<TagPayCubit>(),
          child: const TagCreationProcessingScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.tagCreationReceipt,
      page: () => const TagCreationReceiptScreen(),
      transition: Transition.zoom,
    ),

    // Barcode QuickPay routes
    GetPage(
      name: AppRoutes.barcodeQuickPayHome,
      page: () {
        return BlocProvider(
          create: (context) => serviceLocator<BarcodePaymentCubit>(),
          child: const BarcodeQuickPayHomeScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.generateBarcode,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<BarcodePaymentCubit>(),
          child: const GenerateBarcodeScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.barcodeDisplay,
      page: () => const BarcodeDisplayScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.scanBarcode,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<BarcodePaymentCubit>(),
          child: const ScanBarcodeScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.barcodePaymentConfirmation,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<BarcodePaymentCubit>(),
          child: const BarcodePaymentConfirmationScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.barcodePaymentProcessing,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<BarcodePaymentCubit>(),
          child: const BarcodePaymentProcessingScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.barcodePaymentReceipt,
      page: () => const BarcodePaymentReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.generatedBarcodesHistory,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<BarcodePaymentCubit>(),
          child: const GeneratedBarcodesHistoryScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.scannedBarcodesHistory,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<BarcodePaymentCubit>(),
          child: const ScannedBarcodesHistoryScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // Contactless Payment routes
    GetPage(
      name: AppRoutes.contactlessPay,
      page: () => BlocProvider(
        create: (_) => ContactlessPaymentCubit(
          repository: serviceLocator<ContactlessPaymentRepository>(),
        ),
        child: const ContactlessPaymentHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contactlessPayCreate,
      page: () => BlocProvider(
        create: (_) => ContactlessPaymentCubit(
          repository: serviceLocator<ContactlessPaymentRepository>(),
        ),
        child: const CreatePaymentSessionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contactlessPayReader,
      page: () => const NfcReaderScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contactlessPayHistory,
      page: () => BlocProvider(
        create: (_) => ContactlessPaymentCubit(
          repository: serviceLocator<ContactlessPaymentRepository>(),
        ),
        child: const contactless_history.PaymentHistoryScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Electricity Bill Payment routes
    GetPage(
      name: AppRoutes.electricityBillHome,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<ElectricityBillCubit>()),
            BlocProvider(create: (_) => serviceLocator<BeneficiaryCubit>()),
          ],
          child: const ElectricityBillHomeScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillMeterInput,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<ElectricityBillCubit>(),
          child: const MeterInputScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillConfirmation,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<ElectricityBillCubit>(),
          child: const PaymentConfirmationScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillProcessing,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<ElectricityBillCubit>(),
          child: const PaymentProcessingScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.electricityBillReceipt,
      page: () => const bill_receipt.PaymentReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.electricityBillHistory,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<ElectricityBillCubit>(),
          child: const PaymentHistoryScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillBeneficiaries,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<BeneficiaryCubit>(),
          child: const BeneficiariesScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillAddBeneficiary,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<ElectricityBillCubit>()),
            BlocProvider(create: (_) => serviceLocator<BeneficiaryCubit>()),
          ],
          child: const AddBeneficiaryScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillAutoRecharge,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<AutoRechargeCubit>(),
          child: const AutoRechargeListScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillCreateAutoRecharge,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<BeneficiaryCubit>()),
            BlocProvider(create: (_) => serviceLocator<AutoRechargeCubit>()),
          ],
          child: const CreateAutoRechargeScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillEditAutoRecharge,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<AutoRechargeCubit>(),
          child: const EditAutoRechargeScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillReminders,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<ReminderCubit>(),
          child: const RemindersScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.electricityBillCreateReminder,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<BeneficiaryCubit>()),
            BlocProvider(create: (_) => serviceLocator<ReminderCubit>()),
          ],
          child: const CreateReminderScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // Settings screens
    GetPage(
      name: '/privacy-policy',
      page: () => const PrivacyPolicyScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/help-support',
      page: () => const HelpSupportScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: '/contact-us',
      page: () => const ContactUsScreen(),
      transition: Transition.rightToLeft,
    ),

    // Crowdfund routes
    GetPage(
      name: AppRoutes.crowdfund,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CrowdfundCubit>()..loadCrowdfunds(),
        child: const CrowdfundHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.crowdfundList,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CrowdfundCubit>()..loadCrowdfunds(),
        child: const CrowdfundListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.crowdfundDetails,
      page: () {
        final crowdfundId = Get.arguments as String;
        return BlocProvider(
          create: (_) => serviceLocator<CrowdfundCubit>()..loadCrowdfundDetails(crowdfundId),
          child: CrowdfundDetailsScreen(crowdfundId: crowdfundId),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createCrowdfund,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CrowdfundCubit>(),
        child: const CreateCrowdfundScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.donationPayment,
      page: () {
        final crowdfund = Get.arguments as Crowdfund;
        return BlocProvider(
          create: (_) => serviceLocator<CrowdfundCubit>(),
          child: DonationPaymentScreen(crowdfund: crowdfund),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.donationProcessing,
      page: () {
        final crowdfund = Get.arguments as Crowdfund;
        return BlocProvider.value(
          value: serviceLocator<CrowdfundCubit>(),
          child: DonationProcessingScreen(crowdfund: crowdfund),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.donationReceipt,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider.value(
          value: serviceLocator<CrowdfundCubit>(),
          child: DonationReceiptScreen(
            donation: args['donation'] as CrowdfundDonation,
            receipt: args['receipt'] as CrowdfundReceipt?,
            crowdfund: args['crowdfund'] as Crowdfund,
          ),
        );
      },
      transition: Transition.zoom,
    ),

    // Card Management Routes
    GetPage(
      name: AppRoutes.cardCreationForm,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CardCubit>(),
        child: const CardCreationFormScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cardCreationReceipt,
      page: () => BlocProvider.value(
        value: serviceLocator<CardCubit>(),
        child: const CardCreationReceiptScreen(),
      ),
      transition: Transition.zoom,
    ),

    // Lock Funds Routes
    GetPage(
      name: AppRoutes.lockFunds,
      page: () => BlocProvider(
        create: (_) => serviceLocator<LockFundsCubit>(),
        child: const LockFundsListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Voice Enrollment Routes
    GetPage(
      name: AppRoutes.voiceActivationPrompt,
      page: () {
        final storage = serviceLocator<FlutterSecureStorage>();
        return FutureBuilder<String?>(
          future: storage.read(key: 'user_id'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            final userId = snapshot.data ?? '';
            return FutureBuilder<String?>(
              future: storage.read(key: 'voice_activation_skips'),
              builder: (context, skipSnapshot) {
                final skipCountStr = skipSnapshot.data ?? '0';
                return VoiceActivationPromptScreen(
                  userId: userId,
                  isMandatory: (int.tryParse(skipCountStr) ?? 0) >= 3,
                );
              },
            );
          },
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.voiceEnrollment,
      page: () => BlocProvider(
        create: (_) => serviceLocator<VoiceEnrollmentCubit>(),
        child: const VoiceEnrollmentScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Family Account Routes
    GetPage(
      name: AppRoutes.familySetup,
      page: () => BlocProvider(
        create: (_) => serviceLocator<FamilyAccountCubit>(),
        child: const FamilySetupFlowScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familyDetails,
      page: () {
        // Get familyId from arguments
        final args = Get.arguments as Map<String, dynamic>?;
        final familyId = args?['familyId'] as String? ?? '';

        return BlocProvider(
          create: (_) => serviceLocator<FamilyAccountCubit>(),
          child: FamilyAccountDetailScreen(familyId: familyId),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familyAddMember,
      page: () => BlocProvider(
        create: (_) => serviceLocator<FamilyAccountCubit>(),
        child: FamilyAddMemberScreen(
          familyId: Get.parameters['familyId'] ?? '',
          familyName: Get.parameters['familyName'],
        ),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familyInviteMemberFlow,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final familyId = args?['familyId'] as String? ?? '';
        final familyName = args?['familyName'] as String?;

        return BlocProvider(
          create: (_) => serviceLocator<FamilyAccountCubit>(),
          child: FamilyInviteMemberFlowScreen(
            familyId: familyId,
            familyName: familyName,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familyEditMemberLimits,
      page: () {
        // Get arguments
        final args = Get.arguments as Map<String, dynamic>?;
        final familyId = args?['familyId'] as String? ?? '';
        final member = args?['member'] as FamilyMember?;

        return BlocProvider(
          create: (_) => serviceLocator<FamilyAccountCubit>(),
          child: FamilyEditMemberLimitsScreen(
            familyId: familyId,
            member: member!,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // Two-Factor Authentication Routes
    GetPage(
      name: AppRoutes.twoFactorSetup,
      page: () => const TwoFactorSetupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.twoFactorVerification,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        return TwoFactorVerificationScreen(
          twoFactorToken: args?['twoFactorToken'] as String? ?? '',
          userEmail: args?['userEmail'] as String?,
          userFirstName: args?['userFirstName'] as String?,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.twoFactorSettings,
      page: () => const TwoFactorSettingsScreen(),
      transition: Transition.rightToLeft,
    ),

    // KYC Routes - Progressive Onboarding (gRPC-based)
    GetPage(
      name: AppRoutes.kycProgressive,
      page: () => BlocProvider(
        create: (_) => serviceLocator<KYCCubit>(),
        child: const ProgressiveKYCScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.kycVerifyId,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return BlocProvider(
          create: (_) => serviceLocator<KYCCubit>(),
          child: IdVerificationScreen(
            targetTier: args['targetTier'] as KYCTier? ?? KYCTier.tier2,
            preferredIdType: args['preferredIdType'] as IDType?,
            countryCode: args['countryCode'] as String?,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // Debug Routes (Remove before production)
    GetPage(
      name: AppRoutes.debugSettings,
      page: () => const DebugSettingsScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
