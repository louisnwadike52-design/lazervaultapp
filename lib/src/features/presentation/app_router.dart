import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/send_funds/presentation/chatbot_transfer_screen.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_verification_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/phone_verification_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_setup_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/change_passcode_screen.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/views/transaction_pin_setup_screen.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/views/pin_management_screen.dart';
import 'package:lazervault/src/features/transaction_pin/presentation/views/forgot_pin_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/buy_crypto_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/transfer_receipt_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/purchase_gift_card_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_details_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_purchase_processing_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_card_transactions_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/sell_gift_card_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_sales_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/currency_deposit_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_method_selection_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_amount_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_review_screen.dart';
import 'package:lazervault/src/features/presentation/views/deposit/deposit_success_screen.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/create_new_password_screen.dart';
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
import 'package:lazervault/src/features/settings/presentation/view/settings_screen.dart';
import 'package:lazervault/src/features/presentation/views/verify_password_reset_otp_screen.dart';
import 'package:lazervault/src/features/widgets/verify_password_reset_otp.dart';
import 'package:lazervault/src/features/presentation/views/camera_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_screen.dart';
import 'package:lazervault/src/features/presentation/views/input_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/new_card_screen.dart';
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
import 'package:lazervault/src/features/stocks/presentation/view/stocks_landing_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_details_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_amount_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_payment_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_review_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_receipt_screen.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/presentation/views/upload_image_scren.dart';
import 'package:lazervault/src/features/portfolio/presentation/view/portfolio_details_screen.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_cubit.dart';
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
import 'package:lazervault/src/features/invoice/presentation/view/invoice_processing_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_item_payment_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_payment_receipt_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/view/pay_invoice_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/cubit/pay_invoice_cubit.dart';
// AI Scan to Pay imports
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_to_pay_screen.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/cubit/ai_scan_cubit.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_camera_screen.dart';
// import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_payment_screen.dart';
// import 'package:lazervault/src/features/ai_scan_to_pay/presentation/view/ai_scan_payment_success_screen.dart';
// import 'package:lazervault/src/features/ai_scan_to_pay/domain/entities/scan_entities.dart';

// Move Money imports
import 'package:lazervault/src/features/move_money/cubit/move_money_cubit.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/move_transfer_flow_screen.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/move_history_screen.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/move_transfer_receipt_screen.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/move_transfer_detail_screen.dart';
import 'package:lazervault/src/features/move_money/cubit/wallet_transfer_cubit.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/wallet_transfer_flow_screen.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/wallet_transfer_receipt_screen.dart';
import 'package:lazervault/src/features/move_money/presentation/screens/wallet_history_screen.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';

// Group Account imports
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/views/group_account_list_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/group_details_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/contribution_details_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/make_payment_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/public_groups_screen.dart';
import 'package:lazervault/src/features/group_account/presentation/views/group_leaderboard_screen.dart';
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
import 'package:lazervault/src/features/insurance/domain/entities/insurance_product_entity.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_claim_entity.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_terms_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_guide_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_faq_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_contact_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_documents_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_claim_tracking_screen.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_how_it_works_screen.dart';

// Airtime imports
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_cubit.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/network_selection_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/recipient_input_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/amount_selection_screen.dart';
import 'package:lazervault/src/features/airtime/presentation/view/airtime_review_screen.dart';
// Processing screen removed — payment now runs inside PIN modal
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
import 'package:lazervault/src/features/funds/presentation/view/batch_transfer/batch_transfer_history_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/batch_transfer/batch_transfer_detail_screen.dart';
import 'package:lazervault/src/features/funds/cubit/recurring_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/presentation/view/recurring_transfers/recurring_transfers_list_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/recurring_transfers/recurring_transfer_detail_screen.dart';

// Statistics imports
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/spending_detail_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/monthly_trends_detail_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/category_analysis_detail_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/comparison_detail_screen.dart';

// Budget imports
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/budget_list_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/create_budget_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/budget_detail_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/budget_ai_insights_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/budget_reminders_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/financial_goals_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/recurring_bills_screen.dart';
import 'package:lazervault/src/features/statistics/cubit/category_management_cubit.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/category_management_screen.dart';

// Credit Score & Open Banking imports
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/presentation/screens/credit_score_screen.dart';
import 'package:lazervault/src/features/open_banking/presentation/screens/linked_accounts_screen.dart' as open_banking;

// Tag Pay imports
import 'package:lazervault/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_pay_home_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/search_users_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/create_tag_screen_redesigned.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_amount_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_payment_receipt_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_creation_processing_screen.dart';
import 'package:lazervault/src/features/tag_pay/presentation/view/tag_creation_receipt_screen.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_tag_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';

// QR Pay imports
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/qr_pay_home_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/generate_qr_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/qr_display_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/scan_qr_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/qr_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/qr_payment_processing_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/qr_payment_receipt_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/generated_qr_history_screen.dart';
import 'package:lazervault/src/features/qr_payment/presentation/view/qr_payments_history_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/cubit/id_pay_cubit.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_home_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/create_id_pay_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_created_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_lookup_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_payment_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_receipt_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_details_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_organization_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/create_organization_screen.dart';
import 'package:lazervault/src/features/id_pay/presentation/view/id_pay_organization_details_screen.dart';

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
import 'package:lazervault/src/features/crowdfund/presentation/views/create_crowdfund_carousel.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/create_crowdfund_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_payment_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_processing_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_receipt_screen.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/crowdfund_leaderboard_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/leaderboard_cubit.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/notification_channels_screen.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/crowdfund_report_screen.dart';

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

// Bills Hub import
import 'package:lazervault/src/features/bills/presentation/view/bills_hub_screen.dart';

// Cable TV imports
import 'package:lazervault/src/features/cable_tv/presentation/cubit/cable_tv_cubit.dart';
import 'package:lazervault/src/features/cable_tv/presentation/view/cable_tv_home_screen.dart';
import 'package:lazervault/src/features/cable_tv/presentation/view/smart_card_input_screen.dart';
import 'package:lazervault/src/features/cable_tv/presentation/view/package_selection_screen.dart';
import 'package:lazervault/src/features/cable_tv/presentation/view/cable_tv_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/cable_tv/presentation/view/cable_tv_payment_processing_screen.dart';
import 'package:lazervault/src/features/cable_tv/presentation/view/cable_tv_payment_receipt_screen.dart';

// Education imports
import 'package:lazervault/src/features/education/presentation/cubit/education_cubit.dart';
import 'package:lazervault/src/features/education/presentation/view/education_home_screen.dart';
import 'package:lazervault/src/features/education/presentation/view/education_purchase_screen.dart';
import 'package:lazervault/src/features/education/presentation/view/education_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/education/presentation/view/education_payment_processing_screen.dart';
import 'package:lazervault/src/features/education/presentation/view/education_pin_result_screen.dart';

// Water Bill imports
import 'package:lazervault/src/features/water_bill/presentation/cubit/water_bill_cubit.dart';
import 'package:lazervault/src/features/water_bill/presentation/view/water_bill_home_screen.dart';
import 'package:lazervault/src/features/water_bill/presentation/view/water_bill_customer_input_screen.dart';
import 'package:lazervault/src/features/water_bill/presentation/view/water_bill_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/water_bill/presentation/view/water_bill_payment_processing_screen.dart';
import 'package:lazervault/src/features/water_bill/presentation/view/water_bill_payment_receipt_screen.dart';
import 'package:lazervault/src/features/water_bill/presentation/view/water_bill_history_screen.dart';

// Internet Bill imports
import 'package:lazervault/src/features/internet_bill/presentation/cubit/internet_bill_cubit.dart';
import 'package:lazervault/src/features/internet_bill/presentation/view/internet_bill_home_screen.dart';
import 'package:lazervault/src/features/internet_bill/presentation/view/internet_account_input_screen.dart';
import 'package:lazervault/src/features/internet_bill/presentation/view/internet_package_selection_screen.dart';
import 'package:lazervault/src/features/internet_bill/presentation/view/internet_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/internet_bill/presentation/view/internet_payment_processing_screen.dart';
import 'package:lazervault/src/features/internet_bill/presentation/view/internet_payment_receipt_screen.dart';

// Data Bundles imports
import 'package:lazervault/src/features/data_bundles/presentation/cubit/data_bundles_cubit.dart';
import 'package:lazervault/src/features/data_bundles/presentation/view/data_bundles_home_screen.dart';
import 'package:lazervault/src/features/data_bundles/presentation/view/data_plan_selection_screen.dart';
import 'package:lazervault/src/features/data_bundles/presentation/view/data_recipient_input_screen.dart';
import 'package:lazervault/src/features/data_bundles/presentation/view/data_payment_confirmation_screen.dart';
import 'package:lazervault/src/features/data_bundles/presentation/view/data_payment_processing_screen.dart';
import 'package:lazervault/src/features/data_bundles/presentation/view/data_payment_receipt_screen.dart';

// Currency Exchange imports (BLoC/Cubit)
import 'package:lazervault/src/features/currency_exchange/presentation/cubit/exchange_cubit.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_home_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_recipient_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_processing_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_receipt_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_detail_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_history_screen.dart';

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
// Payroll imports (Business)
import 'package:lazervault/src/features/payroll/presentation/cubit/payroll_cubit.dart';
import 'package:lazervault/src/features/payroll/presentation/views/payroll_home_screen.dart';
import 'package:lazervault/src/features/payroll/presentation/views/employee_list_screen.dart';
import 'package:lazervault/src/features/payroll/presentation/views/add_employee_screen.dart';
import 'package:lazervault/src/features/payroll/presentation/views/pay_run_list_screen.dart';
import 'package:lazervault/src/features/payroll/presentation/views/create_pay_run_screen.dart';
import 'package:lazervault/src/features/payroll/presentation/views/pay_run_details_screen.dart';
import 'package:lazervault/src/features/payroll/presentation/views/pay_slip_details_screen.dart';

// Business Dashboard
import 'package:lazervault/src/features/business_dashboard/presentation/cubit/business_dashboard_cubit.dart';
import 'package:lazervault/src/features/business_dashboard/presentation/views/business_dashboard_screen.dart';
import 'package:lazervault/src/features/business_analytics/presentation/cubit/business_analytics_cubit.dart';
import 'package:lazervault/src/features/business_analytics/presentation/views/analytics_screen.dart';

import 'package:lazervault/src/features/presentation/views/debug_settings_screen.dart';

// Social Linking imports
import 'package:lazervault/src/features/social_linking/presentation/screens/linked_accounts_screen.dart';
import 'package:lazervault/src/features/social_linking/presentation/cubit/social_linking_cubit.dart';

// Lock Funds imports
import 'package:lazervault/src/features/lock_funds/presentation/cubit/lock_funds_cubit.dart';
import 'package:lazervault/src/features/lock_funds/presentation/screens/lock_funds_list_screen.dart';
import 'package:lazervault/src/features/lock_funds/presentation/screens/lock_fund_receipt_screen.dart';

// Family Account imports
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_setup_flow_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_activation_setup_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_add_member_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_invite_member_flow_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_account_detail_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_edit_member_limits_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_accounts_list_screen.dart';
import 'package:lazervault/src/features/family_account/presentation/views/family_pending_invitations_screen.dart';

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
        child: const StocksLandingScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.investments,
      page: () => serviceLocator<InvestmentsScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.portfolioDetails,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PortfolioCubit>()..loadPortfolio(),
        child: const PortfolioDetailsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
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
        String? serviceFeeRef;
        final args = Get.arguments;
        if (args is Map<String, dynamic>) {
          serviceFeeRef = args['serviceFeeRef'] as String?;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => serviceLocator<InvoiceCubit>(),
            ),
            BlocProvider(
              create: (_) => CreateInvoiceCubit(),
            ),
          ],
          child: CreateInvoiceCarousel(serviceFeeRef: serviceFeeRef),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoiceDetails,
      page: () {
        final args = Get.arguments;
        String invoiceId;
        bool isFromReceivedTab = true;
        if (args is Map<String, dynamic>) {
          invoiceId = args['invoiceId'] as String;
          isFromReceivedTab = args['isFromReceivedTab'] as bool? ?? true;
        } else {
          invoiceId = args as String;
        }
        return BlocProvider(
          create: (_) => serviceLocator<InvoiceCubit>(),
          child: InvoiceDetailsScreen(
            invoiceId: invoiceId,
            isFromReceivedTab: isFromReceivedTab,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoicePreview,
      page: () {
        final args = Get.arguments;
        if (args is Map<String, dynamic>) {
          return InvoicePreviewScreen(
            invoice: args['invoice'] as Invoice,
            showTaggedUsers: args['showTaggedUsers'] as bool? ?? true,
          );
        }
        return InvoicePreviewScreen(invoice: args as Invoice);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoicePayment,
      page: () {
        final args = Get.arguments;
        Invoice? invoice;
        bool isPrePayment = false;
        if (args is Invoice) {
          invoice = args;
        } else if (args is Map<String, dynamic>) {
          isPrePayment = args['isPrePayment'] as bool? ?? false;
          invoice = args['invoice'] as Invoice?;
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<InvoiceCubit>()),
            BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
          ],
          child: InvoicePaymentScreen(
            invoice: invoice,
            isPrePayment: isPrePayment,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoiceProcessing,
      page: () {
        final invoice = Get.arguments as Invoice;
        return InvoiceProcessingScreen(invoice: invoice);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoiceItemPayment,
      page: () {
        final invoice = Get.arguments as Invoice;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<TaggedInvoiceCubit>()),
            BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
          ],
          child: InvoiceItemPaymentScreen(invoice: invoice),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.invoicePaymentReceipt,
      page: () {
        final transaction = Get.arguments as Map<String, dynamic>;
        return InvoicePaymentReceiptScreen(transaction: transaction);
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
      name: AppRoutes.profileSettings,
      page: () => const SettingsScreen(),
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
      name: AppRoutes.pinManagement,
      page: () => const PinManagementScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPin,
      page: () => const ForgotPinScreen(),
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
      name: AppRoutes.createNewPassword,
      page: () => serviceLocator<CreateNewPasswordScreen>(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.verifyPasswordResetOTP,
      page: () => const VerifyPasswordResetOTPScreen(),
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
      name: AppRoutes.sendFunds,
      page: () {
        final recipient = Get.arguments as User;
        return serviceLocator<SendFundScreen>(param1: recipient);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.chatbotTransfer,
      page: () => const ChatbotTransferScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferProcessing,
      page: () => const TransferProcessingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.transferProof,
      page: () => const TransferReceiptScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: AppRoutes.initiateSendFunds,
      page: () {
        final args = Get.arguments;
        RecipientModel recipient;
        if (args is RecipientModel) {
          recipient = args;
        } else if (args is Map) {
          if (args['recipient'] is RecipientModel) {
            recipient = args['recipient'] as RecipientModel;
          } else {
            recipient = RecipientModel(
              id: (args['id'] ?? '') as String,
              name: (args['name'] ?? '') as String,
              accountNumber: (args['accountNumber'] ?? '') as String,
              bankName: (args['bankName'] ?? '') as String,
              sortCode: (args['sortCode'] ?? '') as String,
              isFavorite: (args['isFavorite'] ?? false) as bool,
              isSaved: (args['isSaved'] ?? false) as bool,
              countryCode: args['countryCode'] as String?,
              email: args['email'] as String?,
              phoneNumber: args['phoneNumber'] as String?,
              currency: args['currency'] as String?,
            );
          }
        } else {
          recipient = RecipientModel(
            id: '',
            name: '',
            accountNumber: '',
            bankName: '',
            sortCode: '',
            isFavorite: false,
          );
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<TransferCubit>()),
            BlocProvider(create: (_) => serviceLocator<RecurringTransferCubit>()),
            BlocProvider.value(value: serviceLocator<BudgetCubit>()),
          ],
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
      page: () => BlocProvider(
        create: (_) => serviceLocator<TransactionHistoryCubit>(),
        child: const DashboardTransactionHistoryScreen(),
      ),
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
    // Currency Exchange Routes (BLoC/Cubit)
    GetPage(
      name: AppRoutes.exchangeHome,
      page: () => BlocProvider(
        create: (_) => serviceLocator<ExchangeCubit>(),
        child: const ExchangeHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.exchangeRecipient,
      page: () => BlocProvider(
        create: (_) => serviceLocator<ExchangeCubit>(),
        child: const ExchangeRecipientScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.exchangeProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<ExchangeCubit>(),
        child: const ExchangeProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.exchangeReceipt,
      page: () => const ExchangeReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.exchangeDetail,
      page: () => BlocProvider(
        create: (_) => serviceLocator<ExchangeCubit>(),
        child: const ExchangeDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.exchangeHistory,
      page: () => BlocProvider(
        create: (_) => serviceLocator<ExchangeCubit>(),
        child: const ExchangeHistoryScreen(),
      ),
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
        return BlocProvider(
          create: (_) => serviceLocator<GiftCardCubit>(),
          child: GiftCardDetailsScreen(giftCard: giftCard),
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
      name: AppRoutes.giftCardTransactions,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: const GiftCardTransactionsScreen(),
      ),
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
      name: AppRoutes.sellGiftCard,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: const SellGiftCardScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.mySales,
      page: () => BlocProvider(
        create: (_) => serviceLocator<GiftCardCubit>(),
        child: const MySalesScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // International transfer routes removed — now handled by /exchange/* flow
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
    // Note: Using BlocProvider.value() instead of BlocProvider(create:) because
    // GroupAccountCubit is a singleton. Using create: would dispose the singleton
    // when navigating away, causing "cubit is closed" errors.
    GetPage(
      name: AppRoutes.groupAccount,
      page: () => BlocProvider.value(
        value: serviceLocator<GroupAccountCubit>(),
        // Note: loadUserGroups() is called by GroupAccountListScreen when auth state is available
        child: const GroupAccountListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.groupDetails,
      page: () {
        final groupId = Get.arguments as String;
        // Note: loadGroupDetails is called in GroupDetailsScreen's initState
        return BlocProvider.value(
          value: serviceLocator<GroupAccountCubit>(),
          child: GroupDetailsScreen(groupId: groupId),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createGroup,
      page: () => BlocProvider.value(
        value: serviceLocator<GroupAccountCubit>(),
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
        return BlocProvider.value(
          value: serviceLocator<GroupAccountCubit>(),
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
        return BlocProvider.value(
          value: serviceLocator<GroupAccountCubit>(),
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
        return BlocProvider(
          create: (_) => serviceLocator<InsuranceCubit>(),
          child: const InsurancePaymentProcessingScreen(),
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
    GetPage(
      name: AppRoutes.insuranceTerms,
      page: () {
        final arg = Get.arguments;
        if (arg is InsuranceProduct) {
          return InsuranceTermsScreen(product: arg);
        }
        final insurance = arg as Insurance;
        return InsuranceTermsScreen(
          product: InsuranceProduct(
            id: insurance.id,
            name: insurance.type.displayName,
            description: insurance.description ?? '',
            category: InsuranceProductCategory.fromString(insurance.type.name),
            providerName: insurance.provider,
            providerLogo: insurance.providerLogo,
            minPremium: insurance.premiumAmount,
            maxPremium: insurance.premiumAmount,
            currency: insurance.currency,
            benefits: insurance.coverageDetails.entries
                .map((e) => '${e.key}: ${e.value}')
                .toList(),
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceGuide,
      page: () => const InsuranceGuideScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceFaq,
      page: () => const InsuranceFaqScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceContact,
      page: () {
        final insurance = Get.arguments as Insurance;
        return InsuranceContactScreen(insurance: insurance);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceDocuments,
      page: () {
        final insurance = Get.arguments as Insurance;
        return InsuranceDocumentsScreen(insurance: insurance);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceClaimTracking,
      page: () {
        final claim = Get.arguments as InsuranceClaim;
        return InsuranceClaimTrackingScreen(claim: claim);
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.insuranceHowItWorks,
      page: () => const InsuranceHowItWorksScreen(),
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
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<AirtimeCubit>()),
          BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
        ],
        child: const AirtimeReviewScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Processing screen removed — payment now runs inside PIN modal on review screen
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
      page: () => const BatchTransferReviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BatchTransferCubit>(),
        child: const BatchTransferProcessingScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferReceipt,
      page: () => const BatchTransferReceiptScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferHistory,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BatchTransferCubit>(),
        child: const BatchTransferHistoryScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.batchTransferDetail,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BatchTransferCubit>(),
        child: const BatchTransferDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Recurring Transfer routes
    GetPage(
      name: AppRoutes.recurringTransfers,
      page: () => BlocProvider(
        create: (_) => serviceLocator<RecurringTransferCubit>(),
        child: const RecurringTransfersListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.recurringTransferDetail,
      page: () => BlocProvider(
        create: (_) => serviceLocator<RecurringTransferCubit>(),
        child: const RecurringTransferDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Statistics routes
    GetPage(
      name: AppRoutes.statisticsSpendingDetail,
      page: () => BlocProvider.value(
        value: serviceLocator<StatisticsCubit>(),
        child: const SpendingDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.statisticsMonthlyTrends,
      page: () => BlocProvider.value(
        value: serviceLocator<StatisticsCubit>(),
        child: const MonthlyTrendsDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.statisticsCategoryAnalysis,
      page: () => BlocProvider.value(
        value: serviceLocator<StatisticsCubit>(),
        child: CategoryAnalysisDetailScreen(
          analysisType: (Get.arguments as Map<String, dynamic>?)?['type'] as String? ?? 'expense',
        ),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.statisticsComparison,
      page: () => BlocProvider.value(
        value: serviceLocator<StatisticsCubit>(),
        child: const ComparisonDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Category management route
    GetPage(
      name: AppRoutes.categoryManagement,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CategoryManagementCubit>(),
        child: const CategoryManagementScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Budget routes
    GetPage(
      name: AppRoutes.budgetList,
      page: () => BlocProvider.value(
        value: serviceLocator<BudgetCubit>(),
        child: const BudgetListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createBudget,
      page: () => BlocProvider.value(
        value: serviceLocator<BudgetCubit>(),
        child: const CreateBudgetScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.budgetDetail,
      page: () => BlocProvider.value(
        value: serviceLocator<BudgetCubit>(),
        child: const BudgetDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.budgetAIInsights,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: serviceLocator<BudgetCubit>()),
          BlocProvider.value(value: serviceLocator<StatisticsCubit>()),
        ],
        child: const BudgetAIInsightsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Budget Reminders (Alerts) route
    GetPage(
      name: AppRoutes.budgetReminders,
      page: () => BlocProvider.value(
        value: serviceLocator<BudgetCubit>(),
        child: const BudgetRemindersScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Financial Goals routes
    GetPage(
      name: AppRoutes.financialGoals,
      page: () => BlocProvider.value(
        value: serviceLocator<BudgetCubit>(),
        child: const FinancialGoalsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Recurring Bills routes
    GetPage(
      name: AppRoutes.recurringBills,
      page: () => BlocProvider.value(
        value: serviceLocator<BudgetCubit>(),
        child: const RecurringBillsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    // Credit Score route
    GetPage(
      name: AppRoutes.creditScore,
      page: () => BlocProvider.value(
        value: serviceLocator<OpenBankingCubit>(),
        child: CreditScoreScreen(
          userId: (Get.arguments as Map<String, dynamic>?)?['userId'] as String? ?? '',
        ),
      ),
      transition: Transition.rightToLeft,
    ),
    // Open Banking routes
    GetPage(
      name: AppRoutes.openBankingConnect,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        return BlocProvider.value(
          value: serviceLocator<OpenBankingCubit>(),
          child: open_banking.LinkedAccountsScreen(
            userId: args?['userId'] as String? ?? '',
            accessToken: args?['accessToken'] as String? ?? '',
          ),
        );
      },
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
      name: AppRoutes.tagAmount,
      page: () => BlocProvider(
        create: (context) => serviceLocator<TagPayCubit>(),
        child: const TagAmountScreen(),
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

    // QR Pay routes
    GetPage(
      name: AppRoutes.qrPayHome,
      page: () {
        return BlocProvider(
          create: (context) => serviceLocator<QRPaymentCubit>()..getRecentActivity(),
          child: const QRPayHomeScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.generateQR,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<QRPaymentCubit>(),
          child: const GenerateQRScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.qrDisplay,
      page: () => const QRDisplayScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.scanQR,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<QRPaymentCubit>(),
          child: const ScanQRScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.qrPaymentConfirmation,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<QRPaymentCubit>()),
            BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
          ],
          child: const QRPaymentConfirmationScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.qrPaymentProcessing,
      page: () {
        return BlocProvider.value(
          value: serviceLocator<QRPaymentCubit>(),
          child: const QRPaymentProcessingScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.qrPaymentReceipt,
      page: () => const QRPaymentReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.generatedQRHistory,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<QRPaymentCubit>(),
          child: const GeneratedQRHistoryScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.qrPaymentsHistory,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<QRPaymentCubit>(),
          child: const QRPaymentsHistoryScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // IDPay routes
    GetPage(
      name: AppRoutes.idPayHome,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>()..getMyIDPays(),
          child: const IDPayHomeScreen(),
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.createIdPay,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>(),
          child: const CreateIDPayScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.idPayCreated,
      page: () => const IDPayCreatedScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.idPayLookup,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>(),
          child: const IDPayLookupScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.idPayPayment,
      page: () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<IDPayCubit>()),
            BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
          ],
          child: const IDPayPaymentScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.idPayReceipt,
      page: () => const IDPayReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.idPayDetails,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>(),
          child: const IDPayDetailsScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // IDPay Organization routes
    GetPage(
      name: AppRoutes.idPayOrganizations,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>(),
          child: const IDPayOrganizationScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createIdPayOrganization,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>(),
          child: const CreateOrganizationScreen(),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.idPayOrganizationDetails,
      page: () {
        return BlocProvider(
          create: (_) => serviceLocator<IDPayCubit>(),
          child: const IDPayOrganizationDetailsScreen(),
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

    // Bills Hub route
    GetPage(
      name: AppRoutes.billsHub,
      page: () => const BillsHubScreen(),
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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<ElectricityBillCubit>()),
            BlocProvider(create: (_) => serviceLocator<BeneficiaryCubit>()),
          ],
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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => serviceLocator<AutoRechargeCubit>()),
            BlocProvider(create: (_) => serviceLocator<ElectricityBillCubit>()),
          ],
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
            BlocProvider(create: (_) => serviceLocator<ElectricityBillCubit>()),
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
        child: const CreateCrowdfundCarousel(),
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
    GetPage(
      name: AppRoutes.crowdfundLeaderboard,
      page: () => BlocProvider(
        create: (_) => serviceLocator<LeaderboardCubit>(),
        child: const CrowdfundLeaderboardScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.crowdfundNotificationChannels,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => serviceLocator<CrowdfundCubit>(),
          child: NotificationChannelsScreen(
            crowdfundId: args['crowdfundId'] as String,
            crowdfundTitle: args['crowdfundTitle'] as String,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.crowdfundReport,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return BlocProvider(
          create: (_) => serviceLocator<CrowdfundCubit>(),
          child: CrowdfundReportScreen(
            crowdfund: args['crowdfund'] as Crowdfund,
            statistics: args['statistics'] as CrowdfundStatistics?,
            donations: args['donations'] as List<CrowdfundDonation>?,
            campaignUrl: args['campaignUrl'] as String?,
          ),
        );
      },
      transition: Transition.rightToLeft,
    ),

    // Public Groups & Group Leaderboard Routes
    GetPage(
      name: AppRoutes.publicGroups,
      page: () => BlocProvider.value(
        value: serviceLocator<GroupAccountCubit>(),
        child: const PublicGroupsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.groupLeaderboard,
      page: () => BlocProvider.value(
        value: serviceLocator<GroupAccountCubit>(),
        child: const GroupLeaderboardScreen(),
      ),
      transition: Transition.rightToLeft,
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
    GetPage(
      name: AppRoutes.lockFundReceipt,
      page: () => const LockFundReceiptScreen(),
      transition: Transition.zoom,
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
      name: AppRoutes.familyAccounts,
      page: () => BlocProvider(
        create: (_) => serviceLocator<FamilyAccountCubit>(),
        child: const FamilyAccountsListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familyInvitations,
      page: () => BlocProvider(
        create: (_) => serviceLocator<FamilyAccountCubit>(),
        child: const FamilyPendingInvitationsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familySetup,
      page: () => BlocProvider(
        create: (_) => serviceLocator<FamilyAccountCubit>(),
        child: const FamilySetupFlowScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.familyActivationSetup,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final familyId = args?['familyId'] as String? ?? '';
        return BlocProvider(
          create: (_) => serviceLocator<FamilyAccountCubit>(),
          child: FamilyActivationSetupScreen(familyId: familyId),
        );
      },
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

    // Social Linking Routes
    GetPage(
      name: AppRoutes.linkedSocialAccounts,
      page: () => BlocProvider(
        create: (_) => serviceLocator<SocialLinkingCubit>(),
        child: const LinkedAccountsScreen(),
      ),
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

    // Cable TV routes
    GetPage(
      name: AppRoutes.cableTVHome,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CableTVCubit>(),
        child: const CableTVHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cableTVSmartCardInput,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CableTVCubit>(),
        child: const SmartCardInputScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cableTVPackageSelection,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CableTVCubit>(),
        child: const PackageSelectionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cableTVPaymentConfirmation,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CableTVCubit>(),
        child: const CableTVPaymentConfirmationScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cableTVPaymentProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<CableTVCubit>(),
        child: const CableTVPaymentProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.cableTVPaymentReceipt,
      page: () => const CableTVPaymentReceiptScreen(),
      transition: Transition.zoom,
    ),

    // Education routes
    GetPage(
      name: AppRoutes.educationHome,
      page: () => BlocProvider(
        create: (_) => serviceLocator<EducationCubit>(),
        child: const EducationHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.educationPurchase,
      page: () => BlocProvider(
        create: (_) => serviceLocator<EducationCubit>(),
        child: const EducationPurchaseScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.educationPaymentConfirmation,
      page: () => BlocProvider(
        create: (_) => serviceLocator<EducationCubit>(),
        child: const EducationPaymentConfirmationScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.educationPaymentProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<EducationCubit>(),
        child: const EducationPaymentProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.educationPinResult,
      page: () => const EducationPinResultScreen(),
      transition: Transition.zoom,
    ),

    // Water Bill routes
    GetPage(
      name: AppRoutes.waterBillHome,
      page: () => BlocProvider(
        create: (_) => serviceLocator<WaterBillCubit>(),
        child: const WaterBillHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.waterBillCustomerInput,
      page: () => BlocProvider(
        create: (_) => serviceLocator<WaterBillCubit>(),
        child: const WaterBillCustomerInputScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.waterBillPaymentConfirmation,
      page: () => BlocProvider(
        create: (_) => serviceLocator<WaterBillCubit>(),
        child: const WaterBillPaymentConfirmationScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.waterBillPaymentProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<WaterBillCubit>(),
        child: const WaterBillPaymentProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.waterBillPaymentReceipt,
      page: () => const WaterBillPaymentReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.waterBillHistory,
      page: () => BlocProvider(
        create: (_) => serviceLocator<WaterBillCubit>(),
        child: const WaterBillHistoryScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // Internet Bill routes
    GetPage(
      name: AppRoutes.internetBillHome,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InternetBillCubit>(),
        child: const InternetBillHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internetAccountInput,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InternetBillCubit>(),
        child: const InternetAccountInputScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internetPackageSelection,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InternetBillCubit>(),
        child: const InternetPackageSelectionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internetPaymentConfirmation,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InternetBillCubit>(),
        child: const InternetPaymentConfirmationScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.internetPaymentProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<InternetBillCubit>(),
        child: const InternetPaymentProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.internetPaymentReceipt,
      page: () => const InternetPaymentReceiptScreen(),
      transition: Transition.zoom,
    ),

    // Data Bundles routes
    GetPage(
      name: AppRoutes.dataBundlesHome,
      page: () => const DataBundlesHomeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dataBundlesPlanSelection,
      page: () => BlocProvider(
        create: (_) => serviceLocator<DataBundlesCubit>(),
        child: const DataPlanSelectionScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dataBundlesRecipientInput,
      page: () => const DataRecipientInputScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dataBundlesPaymentConfirmation,
      page: () => BlocProvider(
        create: (_) => serviceLocator<DataBundlesCubit>(),
        child: const DataPaymentConfirmationScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.dataBundlesPaymentProcessing,
      page: () => BlocProvider(
        create: (_) => serviceLocator<DataBundlesCubit>(),
        child: const DataPaymentProcessingScreen(),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.dataBundlesPaymentReceipt,
      page: () => const DataPaymentReceiptScreen(),
      transition: Transition.zoom,
    ),

    // ================== Business Dashboard Routes ==================
    GetPage(
      name: AppRoutes.businessDashboard,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BusinessDashboardCubit>(),
        child: const BusinessDashboardScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // ================== Business Analytics Routes ==================
    GetPage(
      name: AppRoutes.businessAnalytics,
      page: () => BlocProvider(
        create: (_) => serviceLocator<BusinessAnalyticsCubit>(),
        child: const AnalyticsScreen(),
      ),
      transition: Transition.rightToLeft,
    ),

    // ================== Payroll Routes (Business) ==================
    GetPage(
      name: AppRoutes.payroll,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: const PayrollHomeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payrollEmployees,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: const EmployeeListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addEmployee,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: const AddEmployeeScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payRuns,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: const PayRunListScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.createPayRun,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: const CreatePayRunScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payRunDetails,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: PayRunDetailsScreen(payRunId: Get.parameters['id'] ?? ''),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.paySlipDetails,
      page: () => BlocProvider(
        create: (_) => serviceLocator<PayrollCubit>(),
        child: PaySlipDetailsScreen(paySlipId: Get.parameters['id'] ?? ''),
      ),
      transition: Transition.rightToLeft,
    ),

    // ================== Move Money Routes ==================
    GetPage(
      name: AppRoutes.moveMoneyTransfer,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: serviceLocator<OpenBankingCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<MoveMoneyCubit>(),
          ),
          BlocProvider.value(
            value: serviceLocator<MandateCubit>(),
          ),
        ],
        child: const MoveTransferFlowScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.moveMoneyHistory,
      page: () => BlocProvider(
        create: (_) => serviceLocator<MoveMoneyCubit>(),
        child: const MoveHistoryScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.moveMoneyReceipt,
      page: () => const MoveTransferReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.moveMoneyDetail,
      page: () => BlocProvider(
        create: (_) => serviceLocator<MoveMoneyCubit>(),
        child: const MoveTransferDetailScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.walletTransfer,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<WalletTransferCubit>()),
          BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
        ],
        child: const WalletTransferFlowScreen(),
      ),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.walletTransferReceipt,
      page: () => const WalletTransferReceiptScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: AppRoutes.walletTransferHistory,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<WalletTransferCubit>()),
          BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
        ],
        child: const WalletHistoryScreen(),
      ),
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
