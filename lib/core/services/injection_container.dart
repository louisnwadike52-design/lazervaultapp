import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/recipient.dart' as core_recipient;
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/face_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/data/repositories/auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/login_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/login_with_passcode_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/register_passcode_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/change_passcode_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_in_with_apple_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_email_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/resend_verification_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/check_email_availability_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/register_face_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_face_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/request_phone_verification_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_phone_number_usecase.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/data/repositories/face_recognition_repository.dart';
import 'package:lazervault/src/features/statements/domain/repositories/i_statement_repository.dart';
import 'package:lazervault/src/features/statements/data/repositories/statement_repository_impl.dart';
import 'package:lazervault/src/features/statements/domain/usecases/download_statement_usecase.dart';
import 'package:lazervault/src/features/statements/domain/usecases/get_statement_history_usecase.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';
import 'package:lazervault/src/features/referral/data/repositories/referral_repository_impl.dart';
import 'package:lazervault/src/features/referral/domain/usecases/validate_referral_code_usecase.dart';
import 'package:lazervault/src/features/referral/domain/usecases/get_my_referral_code_usecase.dart';
import 'package:lazervault/src/features/referral/domain/usecases/get_my_referral_stats_usecase.dart';
import 'package:lazervault/src/features/referral/domain/usecases/get_my_referrals_usecase.dart';
import 'package:lazervault/src/features/referral/domain/usecases/get_referral_leaderboard_usecase.dart';
import 'package:lazervault/src/features/referral/presentation/cubit/referral_cubit.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_face_recognition_repository.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_sign_in_screen.dart';
import 'package:lazervault/src/features/profile/data/repositories/profile_repository.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/withdrawal_cubit.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/data/repositories/withdrawal_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_withdrawal_repository.dart';
import 'package:lazervault/src/features/funds/presentation/view/withdraw_funds_screen.dart';
import 'package:lazervault/src/features/recipients/data/repositories/recipient_repository_impl.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';
import 'package:lazervault/src/features/recipients/presentation/view/add_recipient_screen.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/generated/recipient.pbgrpc.dart';
import 'package:lazervault/src/generated/transfer.pbgrpc.dart' hide TransferTransaction;
import 'package:lazervault/src/generated/user.pbgrpc.dart' as user_grpc;
import 'package:lazervault/src/generated/auth.pbgrpc.dart';
import 'package:lazervault/src/generated/deposit.pbgrpc.dart';
import 'package:lazervault/src/generated/facial_recognition.pbgrpc.dart';
import 'package:lazervault/src/generated/contact_sync.pbgrpc.dart';
import 'package:lazervault/src/generated/group_account.pbgrpc.dart';
import 'package:lazervault/src/generated/referral.pbgrpc.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/cb_currency_exchange_screen.dart';
import 'package:lazervault/src/features/presentation/views/cb_currency_exchange/currency_deposit_screen.dart';
import 'package:lazervault/src/features/presentation/views/change_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/create_new_password_screen.dart';
import 'package:lazervault/src/features/presentation/views/enable_biometric_access_screen.dart';
import 'package:lazervault/src/features/presentation/views/face_scan_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/facial_login_screen.dart';
import 'package:lazervault/src/features/presentation/views/facial_biometric_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/flights/flights_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/deposit_funds_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/initiate_send_funds_screen.dart';
import 'package:lazervault/src/features/presentation/views/languages_screen.dart';
import 'package:lazervault/src/features/presentation/views/my_account_screen.dart';
import 'package:lazervault/src/features/presentation/views/otp_verification_screen.dart';
import 'package:lazervault/src/features/presentation/views/password_recovery_screen.dart';
import 'package:lazervault/src/features/presentation/views/profile_settings_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_electricity_bills_screen.dart';
import 'package:lazervault/src/features/presentation/views/camera_scan_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_screen.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/transaction_history_screen.dart';
import 'package:lazervault/src/features/presentation/views/input_pin_screen.dart';
import 'package:lazervault/src/features/presentation/views/new_card_screen.dart';
import 'package:lazervault/src/features/presentation/views/pay_electricity_bill_screen.dart';
import 'package:lazervault/src/features/presentation/views/review_funds_transfer_screen.dart';
import 'package:lazervault/src/features/presentation/views/select_country_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/view/select_recipient_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_receipt_screen.dart';
import 'package:lazervault/src/features/presentation/views/send_fund_screen.dart';
import 'package:lazervault/src/features/funds/presentation/view/send_funds/transfer_proof_screen.dart';
import 'package:lazervault/src/features/presentation/views/set_fingerprint_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/passcode_sign_in_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/sign_up_screen.dart';
import 'package:lazervault/src/features/presentation/views/stocks/stocks_screen.dart';
import 'package:lazervault/src/features/presentation/views/upload_image_scren.dart';
import 'package:lazervault/src/generated/withdraw.pbgrpc.dart';

import 'package:lazervault/src/features/funds/data/datasources/transfer_remote_data_source.dart';
import 'package:lazervault/src/features/funds/data/repositories/transfer_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_transfer_repository.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_transfer_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';

// Batch Transfer imports
import 'package:lazervault/src/features/funds/data/datasources/batch_transfer_remote_data_source.dart';
import 'package:lazervault/src/features/funds/data/repositories/batch_transfer_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_batch_transfer_repository.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_batch_transfer_usecase.dart';
import 'package:lazervault/src/features/funds/domain/usecases/get_batch_transfer_history_usecase.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';

import '../../src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../src/features/presentation/views/onboarding_screen.dart';
import '../../src/features/presentation/views/splash_screen.dart';
import 'package:lazervault/src/features/funds/data/repositories/deposit_repository_impl.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_deposit_usecase.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/data/repositories/account_summary_repository_impl.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/repositories/i_account_summary_repository.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/usecases/get_account_summaries_usecase.dart';
import 'package:lazervault/src/generated/account.pbgrpc.dart';
import 'package:lazervault/src/features/funds/domain/usecases/initiate_withdrawal_usecase.dart';

// Card Settings Imports
import 'package:lazervault/src/features/card_settings/data/repositories/card_settings_repository_impl.dart';
import 'package:lazervault/src/features/card_settings/domain/repositories/i_card_settings_repository.dart';
import 'package:lazervault/src/features/card_settings/domain/usecases/get_account_details_usecase.dart';
import 'package:lazervault/src/features/card_settings/domain/usecases/update_security_settings_usecase.dart';
import 'package:lazervault/src/features/card_settings/domain/usecases/update_account_status_usecase.dart';
import 'package:lazervault/src/features/card_settings/cubit/card_settings_cubit.dart';
// End Card Settings Imports

// AI Chat Imports
import 'package:lazervault/src/generated/ai_chat.pbgrpc.dart';
import 'package:lazervault/src/features/ai_chats/data/datasources/grpc_ai_chat_service.dart';
import 'package:lazervault/src/features/ai_chats/data/repository/ai_chat_repository_impl.dart';
import 'package:lazervault/src/features/ai_chats/domain/repositories/i_ai_chat_repository.dart';
import 'package:lazervault/src/features/ai_chats/domain/usecases/process_ai_chat_usecase.dart';
import 'package:lazervault/src/features/ai_chats/cubit/ai_chat_cubit.dart';
import 'package:lazervault/src/features/ai_chats/domain/usecases/get_ai_chat_history_usecase.dart';
// End AI Chat Imports

import 'package:flutter_dotenv/flutter_dotenv.dart';

// Gift Cards Imports
import 'package:lazervault/src/features/gift_cards/data/datasources/gift_card_remote_data_source.dart';
import 'package:lazervault/src/features/gift_cards/data/datasources/gift_card_remote_data_source_grpc.dart';
import 'package:lazervault/src/features/gift_cards/data/datasources/gift_card_remote_data_source_mock.dart';
import 'package:lazervault/src/features/gift_cards/data/datasources/gift_card_local_datasource.dart';
import 'package:lazervault/src/features/gift_cards/data/repositories/gift_card_repository_impl.dart';
import 'package:lazervault/src/features/gift_cards/domain/repositories/i_gift_card_repository.dart';
import 'package:lazervault/src/features/gift_cards/domain/usecases/get_gift_card_brands_usecase.dart';
import 'package:lazervault/src/features/gift_cards/domain/usecases/purchase_gift_card_usecase.dart';
import 'package:lazervault/src/features/gift_cards/domain/usecases/get_user_gift_cards_usecase.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_gift_cards_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/sell_to_contact_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/saved_recipients_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/quick_sell_screen.dart';
// End Gift Cards Imports

// Identity Verification Imports
import 'package:lazervault/src/features/identity/data/repositories/identity_repository_impl.dart';
import 'package:lazervault/src/features/identity/domain/repositories/i_identity_repository.dart';

import 'package:lazervault/src/features/support/data/repositories/support_repository_impl.dart';
import 'package:lazervault/src/features/support/domain/repositories/i_support_repository.dart';
import 'package:lazervault/src/generated/support.pbgrpc.dart' as support_grpc;
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
// End Identity Verification Imports

// Stocks Imports
import 'package:lazervault/src/features/stocks/data/datasources/stock_remote_data_source.dart';
import 'package:lazervault/src/features/stocks/data/datasources/stock_remote_data_source_impl.dart';
import 'package:lazervault/src/features/stocks/data/repositories/stock_repository_impl.dart';
import 'package:lazervault/src/features/stocks/domain/repositories/i_stock_repository.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/get_stocks_usecase.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/get_portfolio_usecase.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/place_order_usecase.dart';
import 'package:lazervault/src/features/stocks/domain/usecases/get_watchlists_usecase.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stocks_screen.dart' as StockFeature;
import 'package:lazervault/src/features/stocks/presentation/view/stock_details_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_amount_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_payment_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_review_screen.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_trade_receipt_screen.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';
import 'package:lazervault/src/features/stocks/presentation/view/stock_chart_details_screen.dart';
// End Stocks Imports

// Crypto Imports
import 'package:lazervault/src/features/crypto/data/datasources/crypto_remote_data_source.dart';
import 'package:lazervault/src/features/crypto/data/repositories/crypto_repository_impl.dart';
import 'package:lazervault/src/features/crypto/domain/repositories/crypto_repository.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_screen.dart' as CryptoFeature;
import 'package:lazervault/src/features/crypto/presentation/view/crypto_chart_details_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_detail_screen.dart';
// End Crypto Imports

// Crowdfund Imports
import 'package:lazervault/src/generated/crowdfund.pbgrpc.dart' as crowdfund_grpc;
import 'package:lazervault/src/features/crowdfund/data/datasources/crowdfund_grpc_data_source.dart';
import 'package:lazervault/src/features/crowdfund/data/repositories/crowdfund_repository_impl.dart';
import 'package:lazervault/src/features/crowdfund/data/services/crowdfund_pdf_service.dart';
import 'package:lazervault/src/features/crowdfund/domain/repositories/crowdfund_repository.dart';
import 'package:lazervault/src/features/crowdfund/domain/usecases/crowdfund_usecases.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_cubit.dart';
// End Crowdfund Imports

// Invoice Imports
import 'package:lazervault/src/features/invoice/data/datasources/invoice_local_datasource.dart';
import 'package:lazervault/src/features/invoice/data/repositories/invoice_repository_grpc_impl.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/invoice_repository.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_list_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/create_invoice_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/invoice_details_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/view/pay_invoice_screen.dart';
import 'package:lazervault/src/features/pay_invoice/presentation/cubit/pay_invoice_cubit.dart';
import 'package:lazervault/src/features/pay_invoice/data/repositories/pay_invoice_repository_grpc_impl.dart';
import 'package:lazervault/src/features/pay_invoice/data/datasources/pay_invoice_local_datasource.dart';
import 'package:lazervault/src/features/pay_invoice/domain/repositories/pay_invoice_repository.dart';

// Tagged Invoice Imports
import 'package:lazervault/src/features/invoice/domain/repositories/tagged_invoice_repository.dart';
import 'package:lazervault/src/features/invoice/data/repositories/tagged_invoice_repository_grpc_impl.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/view/incoming_tagged_invoices_screen.dart';
import 'package:lazervault/src/features/invoice/presentation/view/outgoing_tagged_invoices_screen.dart';
// End Tagged Invoice Imports

// Portfolio Imports
import 'package:lazervault/src/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:lazervault/src/features/portfolio/data/repositories/portfolio_repository_grpc_impl.dart';
import 'package:lazervault/src/features/portfolio/presentation/cubit/portfolio_cubit.dart';
// End Portfolio Imports

// End Invoice Imports

// Tag Pay Imports
import 'package:lazervault/src/features/tag_pay/data/repositories/tag_pay_repository_grpc_impl.dart';
import 'package:lazervault/src/features/tag_pay/domain/repositories/tag_pay_repository.dart';
import 'package:lazervault/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart';
// End Tag Pay Imports

// Barcode Payment Imports
import 'package:lazervault/src/features/barcode_payment/data/datasources/barcode_payment_remote_datasource.dart';
import 'package:lazervault/src/features/barcode_payment/data/repositories/barcode_payment_repository_impl.dart';
import 'package:lazervault/src/features/barcode_payment/domain/repositories/barcode_payment_repository.dart';
import 'package:lazervault/src/features/barcode_payment/presentation/cubit/barcode_payment_cubit.dart';
// End Barcode Payment Imports

// Electricity Bill Imports
import 'package:lazervault/src/features/electricity_bill/data/datasources/electricity_bill_remote_datasource.dart';
import 'package:lazervault/src/features/electricity_bill/data/repositories/electricity_bill_repository_impl.dart';
import 'package:lazervault/src/features/electricity_bill/domain/repositories/electricity_bill_repository.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/electricity_bill_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/beneficiary_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/auto_recharge_cubit.dart';
import 'package:lazervault/src/features/electricity_bill/presentation/cubit/reminder_cubit.dart';
// End Electricity Bill Imports

// Airtime Imports
import 'package:lazervault/src/features/airtime/data/datasources/airtime_local_datasource.dart';
import 'package:lazervault/src/features/airtime/data/repositories/airtime_repository_impl.dart';
import 'package:lazervault/src/features/airtime/domain/repositories/airtime_repository.dart';
import 'package:lazervault/src/features/airtime/presentation/cubit/airtime_cubit.dart';
// End Airtime Imports

import 'package:lazervault/src/features/investments/presentation/view/investments_screen.dart';

// AI Scan to Pay Imports
import 'package:lazervault/src/features/ai_scan_to_pay/data/datasources/ai_scan_datasource.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/data/datasources/ai_scan_remote_datasource.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/data/repositories/ai_scan_repository_impl_v2.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/domain/repositories/ai_scan_repository.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/domain/usecases/ai_scan_usecases.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/cubit/ai_scan_cubit.dart';

// Group Account Imports
import 'package:lazervault/src/features/group_account/data/datasources/group_account_remote_data_source.dart';
import 'package:lazervault/src/features/group_account/data/datasources/group_account_grpc_data_source.dart';
import 'package:lazervault/src/features/group_account/data/repositories/group_account_repository_impl.dart';
import 'package:lazervault/src/features/group_account/domain/repositories/group_account_repository.dart';
import 'package:lazervault/src/features/group_account/domain/usecases/group_account_usecases.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/views/group_account_list_screen.dart';

// Insurance Imports
import 'package:lazervault/src/features/insurance/data/datasources/insurance_local_datasource.dart';
import 'package:lazervault/src/features/insurance/data/repositories/insurance_repository_impl.dart';
import 'package:lazervault/src/features/insurance/domain/repositories/insurance_repository.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/insurance_cubit.dart';
import 'package:lazervault/src/features/insurance/presentation/view/insurance_list_screen.dart';

// Lock Funds Feature
import 'package:lazervault/src/features/lock_funds/domain/repositories/lock_funds_repository.dart';
import 'package:lazervault/src/features/lock_funds/data/repositories/lock_funds_repository_impl.dart';
import 'package:lazervault/src/features/lock_funds/presentation/cubit/lock_funds_cubit.dart';
import 'package:lazervault/src/features/lock_funds/presentation/cubit/create_lock_cubit.dart';

// Contact Sync Imports
import 'package:lazervault/core/services/contact_service.dart';
import 'package:lazervault/src/features/contacts/data/repositories/contact_sync_repository.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/sync_contacts_usecase.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/get_synced_contacts_usecase.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/find_lazervault_users_usecase.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/convert_contact_to_recipient_usecase.dart';
import 'package:lazervault/src/features/contacts/presentation/cubit/contact_sync_cubit.dart';
// End Contact Sync Imports

// Statistics Imports
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/statistics/data/statistics_repository.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/add_expense_screen.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/add_budget_screen.dart';
// End Statistics Imports

// Portfolio Imports - Using GrpcClient
// (Portfolio imports moved to top of file with other imports)
// End Portfolio Imports

// Auto-Save Imports
import 'package:lazervault/src/generated/autosave.pbgrpc.dart';
import 'package:lazervault/src/features/autosave/data/repositories/autosave_repository_impl.dart';
import 'package:lazervault/src/features/autosave/domain/repositories/i_autosave_repository.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/create_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_rules_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/update_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/toggle_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/delete_autosave_rule_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_transactions_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_statistics_usecase.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/trigger_autosave_usecase.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
// Cards temporarily disabled due to compilation errors
import 'package:lazervault/src/features/cards/data/datasources/card_remote_data_source.dart';
import 'package:lazervault/src/features/cards/data/repositories/card_repository_impl.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';
import 'package:lazervault/src/features/cards/domain/usecases/create_virtual_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/create_disposable_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/get_user_cards_usecase.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
// End Auto-Save Imports

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Load environment variables
  await dotenv.load();

  // ================== External / gRPC / HTTP ==================
  serviceLocator.registerLazySingleton(http.Client.new);

  // Register FlutterSecureStorage
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Register SecureStorageService
  serviceLocator.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(serviceLocator<FlutterSecureStorage>()),
  );

  // Register LocaleManager for centralized locale/country state management
  serviceLocator.registerLazySingleton<LocaleManager>(
    () => LocaleManager(serviceLocator<FlutterSecureStorage>()),
  );

  // Register gRPC Call Options Helper with LocaleManager
  serviceLocator.registerLazySingleton<GrpcCallOptionsHelper>(
    () => GrpcCallOptionsHelper(
      serviceLocator<FlutterSecureStorage>(),
      localeManager: serviceLocator<LocaleManager>(),
    ),
  );

  serviceLocator.registerLazySingleton<ClientChannel>(() {
    final host = dotenv.env['GRPC_API_HOST'] ?? (throw Exception('GRPC_API_HOST environment variable is not set. For Android emulator, use http://10.0.2.2:7878'));
    final port = int.parse(dotenv.env['GRPC_API_PORT'] ?? (throw Exception('GRPC_API_PORT environment variable is not set')));

    // Extract host without protocol
    final uri = Uri.parse(host);
    final cleanHost = uri.host;

    print("Creating gRPC Channel to $cleanHost:$port");
    return ClientChannel(
      cleanHost,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(), // Use insecure credentials for localhost
        keepAlive: ClientKeepAliveOptions(
          pingInterval: Duration(seconds: 30),
          timeout: Duration(seconds: 10),
          permitWithoutCalls: true,
        ),
        connectionTimeout: Duration(seconds: 10),
        idleTimeout: Duration(minutes: 5),
      ),
    );
  });

  // Register gRPC Clients
  serviceLocator.registerLazySingleton<user_grpc.UserServiceClient>(
    () => user_grpc.UserServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AuthServiceClient>(
    () => AuthServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<DepositServiceClient>(
    () => DepositServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AccountServiceClient>(
    () => AccountServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<RecipientServiceClient>(
    () => RecipientServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<WithdrawServiceClient>(
    () => WithdrawServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<TransferServiceClient>(
    () => TransferServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AIChatServiceClient>(
    () => AIChatServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<FacialRecognitionServiceClient>(
    () => FacialRecognitionServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<support_grpc.SupportServiceClient>(
    () => support_grpc.SupportServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<ContactSyncServiceClient>(
    () => ContactSyncServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<GroupAccountServiceClient>(
    () => GroupAccountServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<AutoSaveServiceClient>(
    () => AutoSaveServiceClient(serviceLocator<ClientChannel>()),
  );
  serviceLocator.registerLazySingleton<crowdfund_grpc.CrowdfundServiceClient>(
    () => crowdfund_grpc.CrowdfundServiceClient(serviceLocator<ClientChannel>()),
  );
  // Portfolio temporarily disabled
  // serviceLocator.registerLazySingleton<PortfolioServiceClient>(
  //   () => PortfolioServiceClient(serviceLocator<ClientChannel>()),
  // );
  serviceLocator.registerLazySingleton<ReferralServiceClient>(
    () => ReferralServiceClient(serviceLocator<ClientChannel>()),
  );


  // ================== Feature: Authentication ==================

  // Data Sources
  serviceLocator.registerLazySingleton
  <AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(serviceLocator<http.Client>()));

  // Repositories
  serviceLocator.registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(
          userServiceClient: serviceLocator<user_grpc.UserServiceClient>(),
          authServiceClient: serviceLocator<AuthServiceClient>(),
          callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        ));

  serviceLocator.registerLazySingleton<IFaceRecognitionRepository>(
      () => FaceRecognitionRepositoryImpl(
          facialRecognitionServiceClient: serviceLocator<FacialRecognitionServiceClient>(),
          callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => SignUpUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => LoginWithPasscodeUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => RegisterPasscodeUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => ChangePasscodeUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => SignInWithGoogleUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => SignInWithAppleUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => ForgotPasswordUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => VerifyEmailUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => ResendVerificationUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => ResetPasswordUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => CheckEmailAvailabilityUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => RegisterFaceUseCase(serviceLocator<IFaceRecognitionRepository>()));
  serviceLocator.registerLazySingleton(() => VerifyFaceUseCase(serviceLocator<IFaceRecognitionRepository>()));
  serviceLocator.registerLazySingleton(() => RequestPhoneVerificationUseCase(serviceLocator<IAuthRepository>()));
  serviceLocator.registerLazySingleton(() => VerifyPhoneNumberUseCase(serviceLocator<IAuthRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => AuthenticationCubit(
        login: serviceLocator<LoginUseCase>(),
        loginWithPasscode: serviceLocator<LoginWithPasscodeUseCase>(),
        registerPasscode: serviceLocator<RegisterPasscodeUseCase>(),
        signUp: serviceLocator<SignUpUseCase>(),
        signInWithGoogle: serviceLocator<SignInWithGoogleUseCase>(),
        signInWithApple: serviceLocator<SignInWithAppleUseCase>(),
        forgotPassword: serviceLocator<ForgotPasswordUseCase>(),
        resetPassword: serviceLocator<ResetPasswordUseCase>(),
        verifyEmail: serviceLocator<VerifyEmailUseCase>(),
        resendVerification: serviceLocator<ResendVerificationUseCase>(),
        checkEmailAvailability: serviceLocator<CheckEmailAvailabilityUseCase>(),
        storage: serviceLocator<FlutterSecureStorage>(),
      ));

  serviceLocator.registerFactory(() => FaceVerificationCubit(
        registerFace: serviceLocator<RegisterFaceUseCase>(),
        verifyFace: serviceLocator<VerifyFaceUseCase>(),
      ));

  serviceLocator.registerFactory(() => EmailVerificationCubit(
        verifyEmailUseCase: serviceLocator<VerifyEmailUseCase>(),
        resendVerificationUseCase: serviceLocator<ResendVerificationUseCase>(),
      ));

  serviceLocator.registerFactory(() => PhoneVerificationCubit(
        requestPhoneVerificationUseCase: serviceLocator<RequestPhoneVerificationUseCase>(),
        verifyPhoneNumberUseCase: serviceLocator<VerifyPhoneNumberUseCase>(),
      ));


  // ================== Feature: Profile ==================

  // Repositories
  serviceLocator.registerLazySingleton<IProfileRepository>(
      () => ProfileRepositoryImpl(
          userServiceClient: serviceLocator<user_grpc.UserServiceClient>(),
          callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        ));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => ProfileCubit(
        repository: serviceLocator<IProfileRepository>(),
      ));

  // ================== Feature: Identity Verification ==================

  // Repositories
  serviceLocator.registerLazySingleton<IIdentityRepository>(
      () => IdentityRepositoryImpl(
          userServiceClient: serviceLocator<user_grpc.UserServiceClient>(),
          callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        ));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => IdentityCubit(
        repository: serviceLocator<IIdentityRepository>(),
      ));

  // ================== Feature: Support & Help ==================

  // Repositories
  serviceLocator.registerLazySingleton<ISupportRepository>(
      () => SupportRepositoryImpl(
          supportServiceClient: serviceLocator<support_grpc.SupportServiceClient>(),
          callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        ));

  // ================== Feature: Statements ==================

  // Repositories
  serviceLocator.registerLazySingleton<IStatementRepository>(
      () => StatementRepositoryImpl());

  // Use Cases
  serviceLocator.registerLazySingleton(() => DownloadStatementUseCase(serviceLocator<IStatementRepository>()));
  serviceLocator.registerLazySingleton(() => GetStatementHistoryUseCase(serviceLocator<IStatementRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => StatementCubit(
        downloadStatementUseCase: serviceLocator<DownloadStatementUseCase>(),
        getStatementHistoryUseCase: serviceLocator<GetStatementHistoryUseCase>(),
      ));

  // ================== Feature: Referral ==================

  // Repositories
  serviceLocator.registerLazySingleton<IReferralRepository>(
      () => ReferralRepositoryImpl(
          referralServiceClient: serviceLocator<ReferralServiceClient>(),
          callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
        ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => ValidateReferralCodeUseCase(serviceLocator<IReferralRepository>()));
  serviceLocator.registerLazySingleton(() => GetMyReferralCodeUseCase(serviceLocator<IReferralRepository>()));
  serviceLocator.registerLazySingleton(() => GetMyReferralStatsUseCase(serviceLocator<IReferralRepository>()));
  serviceLocator.registerLazySingleton(() => GetMyReferralsUseCase(serviceLocator<IReferralRepository>()));
  serviceLocator.registerLazySingleton(() => GetReferralLeaderboardUseCase(serviceLocator<IReferralRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => ReferralCubit(
        validateReferralCode: serviceLocator<ValidateReferralCodeUseCase>(),
        getMyReferralCode: serviceLocator<GetMyReferralCodeUseCase>(),
        getMyReferralStats: serviceLocator<GetMyReferralStatsUseCase>(),
        getMyReferrals: serviceLocator<GetMyReferralsUseCase>(),
        getLeaderboard: serviceLocator<GetReferralLeaderboardUseCase>(),
      ));

  // ================== Feature: Account Cards Summary ==================

  // Repositories
  serviceLocator.registerLazySingleton<IAccountSummaryRepository>(
      () => AccountSummaryRepositoryImpl(
        serviceLocator<AccountServiceClient>(),
        serviceLocator<GrpcCallOptionsHelper>(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetAccountSummariesUseCase(serviceLocator<IAccountSummaryRepository>()));

  // Blocs/Cubits
  serviceLocator.registerLazySingleton(() => AccountCardsSummaryCubit(serviceLocator<GetAccountSummariesUseCase>()));


  // ================== Feature: Card Settings ==================

  // Repositories
  serviceLocator.registerLazySingleton<ICardSettingsRepository>(
      () => CardSettingsRepositoryImpl(
        serviceLocator<AccountServiceClient>(),
        serviceLocator<GrpcCallOptionsHelper>(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetAccountDetailsUseCase(serviceLocator<ICardSettingsRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateSecuritySettingsUseCase(serviceLocator<ICardSettingsRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateAccountStatusUseCase(serviceLocator<ICardSettingsRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => CardSettingsCubit(
    serviceLocator<GetAccountDetailsUseCase>(),
    serviceLocator<UpdateSecuritySettingsUseCase>(),
    serviceLocator<UpdateAccountStatusUseCase>(),
  ));


  // ================== Feature: Recipients ==================

  // Repositories
  serviceLocator.registerLazySingleton<IRecipientRepository>(
    () => RecipientRepositoryImpl(
      serviceLocator<RecipientServiceClient>(),
      serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetRecipientsUseCase(serviceLocator<IRecipientRepository>()));
  serviceLocator.registerLazySingleton(() => AddRecipientUseCase(serviceLocator<IRecipientRepository>()));
  serviceLocator.registerLazySingleton(() => ToggleFavoriteUseCase(serviceLocator<IRecipientRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => RecipientCubit(
    getRecipientsUseCase: serviceLocator<GetRecipientsUseCase>(),
    addRecipientUseCase: serviceLocator<AddRecipientUseCase>(),
    toggleFavoriteUseCase: serviceLocator<ToggleFavoriteUseCase>(),
  ));


  // ================== Feature: Funds (Deposit) ==================

  // Repositories
  serviceLocator.registerLazySingleton<IDepositRepository>(
      () => DepositRepositoryImpl(
        serviceLocator<DepositServiceClient>(),
        serviceLocator<GrpcCallOptionsHelper>(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateDepositUseCase(serviceLocator<IDepositRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => DepositCubit(serviceLocator<InitiateDepositUseCase>()));


  // ================== Feature: Funds (Withdrawal) ==================

  // Repositories
  serviceLocator.registerLazySingleton<IWithdrawalRepository>(
      () => WithdrawalRepositoryImpl(
        serviceLocator<WithdrawServiceClient>(),
        serviceLocator<GrpcCallOptionsHelper>(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateWithdrawalUseCase(serviceLocator<IWithdrawalRepository>()));

  // Blocs/Cubits
   serviceLocator.registerFactory(() => WithdrawalCubit(serviceLocator<InitiateWithdrawalUseCase>()));


  // ================== Feature: Funds (Transfer) ==================

  // Data Sources
  serviceLocator.registerLazySingleton<ITransferRemoteDataSource>(
    () => TransferRemoteDataSourceImpl(
      serviceLocator<TransferServiceClient>(),
      serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<ITransferRepository>(
    () => TransferRepositoryImpl(remoteDataSource: serviceLocator<ITransferRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateTransferUseCase(serviceLocator<ITransferRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => TransferCubit(
    initiateTransferUseCase: serviceLocator<InitiateTransferUseCase>(),
  ));


  // ================== Feature: Funds (Batch Transfer) ==================

  // Data Sources
  serviceLocator.registerLazySingleton<IBatchTransferRemoteDataSource>(
    () => BatchTransferRemoteDataSourceImpl(
      serviceLocator<TransferServiceClient>(),
      serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<IBatchTransferRepository>(
    () => BatchTransferRepositoryImpl(remoteDataSource: serviceLocator<IBatchTransferRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => InitiateBatchTransferUseCase(serviceLocator<IBatchTransferRepository>()));
  serviceLocator.registerLazySingleton(() => GetBatchTransferHistoryUseCase(repository: serviceLocator<IBatchTransferRepository>()));
  serviceLocator.registerLazySingleton(() => GetBatchTransferStatusUseCase(serviceLocator<IBatchTransferRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => BatchTransferCubit(
    initiateBatchTransferUseCase: serviceLocator<InitiateBatchTransferUseCase>(),
    getBatchTransferHistoryUseCase: serviceLocator<GetBatchTransferHistoryUseCase>(),
    getBatchTransferStatusUseCase: serviceLocator<GetBatchTransferStatusUseCase>(),
  ));


  // ================== Feature: AI Chat ==================

  // Data Sources
  serviceLocator.registerLazySingleton<IAiChatDataSource>(
    () => GrpcAiChatDataSource(
      client: serviceLocator<AIChatServiceClient>(),
      callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<IAiChatRepository>(
    () => AiChatRepositoryImpl(dataSource: serviceLocator<IAiChatDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => ProcessChatUseCase(serviceLocator<IAiChatRepository>()));
  serviceLocator.registerLazySingleton(() => GetAIChatHistoryUseCase(serviceLocator<IAiChatRepository>()));

  // Blocs/Cubits
  // Register as Factory because it depends on another Cubit (Auth)
  serviceLocator.registerFactory(() => AIChatCubit(
        processChatUseCase: serviceLocator<ProcessChatUseCase>(),
        getAIChatHistoryUseCase: serviceLocator<GetAIChatHistoryUseCase>(),
      ));


  // ================== Feature: Gift Cards ==================

  // Data Sources
  // Try gRPC first, fallback to enhanced mock
  serviceLocator.registerLazySingleton<IGiftCardRemoteDataSource>(
    () {
      try {
        return GiftCardRemoteDataSourceGrpc(
          grpcClient: serviceLocator<GrpcClient>(),
        );
      } catch (e) {
        print('⚠️ GrpcClient not available for gift cards, using enhanced mock');
        return GiftCardRemoteDataSourceMock();
      }
    },
  );

  // Local data source for caching
  serviceLocator.registerLazySingleton<IGiftCardLocalDataSource>(
    () {
      final dataSource = GiftCardLocalDataSourceImpl();
      dataSource.initialize();
      return dataSource;
    },
  );

  // Repositories
  serviceLocator.registerLazySingleton<IGiftCardRepository>(
    () => GiftCardRepositoryImpl(
      remoteDataSource: serviceLocator<IGiftCardRemoteDataSource>(),
      localDataSource: serviceLocator<IGiftCardLocalDataSource>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetGiftCardBrandsUseCase(serviceLocator<IGiftCardRepository>()));
  serviceLocator.registerLazySingleton(() => PurchaseGiftCardUseCase(serviceLocator<IGiftCardRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserGiftCardsUseCase(serviceLocator<IGiftCardRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(
    () => GiftCardCubit(repository: serviceLocator<IGiftCardRepository>()),
  );


  // ================== Feature: Stocks ==================

  // Data Sources
  serviceLocator.registerLazySingleton<IStockRemoteDataSource>(
    () => StockRemoteDataSourceRealImpl(
      client: serviceLocator<http.Client>(),
      baseUrl: 'http://10.0.2.2:8081/api/v1', // Stocks microservice endpoint
      secureStorage: serviceLocator<SecureStorageService>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<IStockRepository>(
    () => StockRepositoryImpl(remoteDataSource: serviceLocator<IStockRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetStocksUseCase(serviceLocator<IStockRepository>()));
  serviceLocator.registerLazySingleton(() => GetPortfolioUseCase(serviceLocator<IStockRepository>()));
  serviceLocator.registerLazySingleton(() => PlaceOrderUseCase(serviceLocator<IStockRepository>()));
  serviceLocator.registerLazySingleton(() => GetWatchlistsUseCase(serviceLocator<IStockRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => StockCubit(
    getStocksUseCase: serviceLocator<GetStocksUseCase>(),
    getPortfolioUseCase: serviceLocator<GetPortfolioUseCase>(),
    placeOrderUseCase: serviceLocator<PlaceOrderUseCase>(),
    getWatchlistsUseCase: serviceLocator<GetWatchlistsUseCase>(),
    repository: serviceLocator<IStockRepository>(),
      ));


  // ================== Feature: Crypto ==================

  // Data Sources
  serviceLocator.registerLazySingleton<CryptoRemoteDataSource>(
    () => CryptoRemoteDataSourceImpl(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(remoteDataSource: serviceLocator<CryptoRemoteDataSource>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => CryptoCubit(
    repository: serviceLocator<CryptoRepository>(),
  ));


  // ================== Feature: Crowdfund ==================

  // gRPC Data Source
  serviceLocator.registerLazySingleton<CrowdfundGrpcDataSource>(
    () => CrowdfundGrpcDataSource(
      client: serviceLocator<crowdfund_grpc.CrowdfundServiceClient>(),
      callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<CrowdfundRepository>(
    () => CrowdfundRepositoryImpl(
      serviceLocator<CrowdfundGrpcDataSource>(),
    ),
  );

  // PDF Service
  serviceLocator.registerLazySingleton<CrowdfundPdfService>(
    () => CrowdfundPdfService(),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => CreateCrowdfundUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => GetCrowdfundUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => ListCrowdfundsUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => SearchCrowdfundsUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateCrowdfundUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => DeleteCrowdfundUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => MakeDonationUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => GetCrowdfundDonationsUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserDonationsUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => GenerateDonationReceiptUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserReceiptsUseCase(serviceLocator<CrowdfundRepository>()));
  serviceLocator.registerLazySingleton(() => GetCrowdfundStatisticsUseCase(serviceLocator<CrowdfundRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => CrowdfundCubit(
    createCrowdfundUseCase: serviceLocator<CreateCrowdfundUseCase>(),
    getCrowdfundUseCase: serviceLocator<GetCrowdfundUseCase>(),
    listCrowdfundsUseCase: serviceLocator<ListCrowdfundsUseCase>(),
    searchCrowdfundsUseCase: serviceLocator<SearchCrowdfundsUseCase>(),
    updateCrowdfundUseCase: serviceLocator<UpdateCrowdfundUseCase>(),
    deleteCrowdfundUseCase: serviceLocator<DeleteCrowdfundUseCase>(),
    makeDonationUseCase: serviceLocator<MakeDonationUseCase>(),
    getCrowdfundDonationsUseCase: serviceLocator<GetCrowdfundDonationsUseCase>(),
    getUserDonationsUseCase: serviceLocator<GetUserDonationsUseCase>(),
    generateDonationReceiptUseCase: serviceLocator<GenerateDonationReceiptUseCase>(),
    getUserReceiptsUseCase: serviceLocator<GetUserReceiptsUseCase>(),
    getCrowdfundStatisticsUseCase: serviceLocator<GetCrowdfundStatisticsUseCase>(),
  ));


  // ================== Feature: Portfolio ==================

  // Repositories - Using gRPC implementation for backend integration
  serviceLocator.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryGrpcImpl(
      grpcClient: serviceLocator<GrpcClient>(),
      callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => PortfolioCubit(
    repository: serviceLocator<PortfolioRepository>(),
  ));

  // ================== Feature: Invoice ==================

  // Data Sources (local - for offline fallback if needed)
  serviceLocator.registerLazySingleton<InvoiceLocalDataSource>(
    () {
      final dataSource = InvoiceLocalDataSourceImpl();
      // Initialize Hive when the data source is created
      dataSource.initializeHive();
      return dataSource;
    },
  );

  // Repositories - Using gRPC implementation for backend integration
  serviceLocator.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryGrpcImpl(
      grpcClient: serviceLocator<GrpcClient>(),
      currentUserId: '', // User ID is extracted from auth token in grpcClient.callOptions
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => InvoiceCubit(
    repository: serviceLocator<InvoiceRepository>(),
    // User ID is now set dynamically via setUserId() from auth state
  ));

  // ================== Feature: Tagged Invoice ==================

  // Repositories - Using gRPC implementation for backend integration
  serviceLocator.registerLazySingleton<TaggedInvoiceRepository>(
    () => TaggedInvoiceRepositoryGrpcImpl(
      grpcClient: serviceLocator<GrpcClient>(),
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => TaggedInvoiceCubit(
    repository: serviceLocator<TaggedInvoiceRepository>(),
  ));

  // ================== Feature: Tag Pay ==================

  // Repositories - Using gRPC implementation for backend integration
  serviceLocator.registerLazySingleton<TagPayRepository>(
    () => TagPayRepositoryGrpcImpl(
      grpcClient: serviceLocator<GrpcClient>(),
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => TagPayCubit(
    repository: serviceLocator<TagPayRepository>(),
  ));

  // ================== Feature: Barcode QuickPay ==================

  // Data Sources
  serviceLocator.registerLazySingleton<BarcodePaymentRemoteDataSource>(
    () => BarcodePaymentRemoteDataSourceImpl(
      grpcClient: serviceLocator<GrpcClient>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<BarcodePaymentRepository>(
    () => BarcodePaymentRepositoryImpl(
      remoteDataSource: serviceLocator<BarcodePaymentRemoteDataSource>(),
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => BarcodePaymentCubit(
    repository: serviceLocator<BarcodePaymentRepository>(),
  ));

  // ================== Feature: Airtime ==================

  // Data Sources
  serviceLocator.registerLazySingleton<AirtimeLocalDataSource>(
    () => AirtimeLocalDataSourceImpl(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<AirtimeRepository>(
    () => AirtimeRepositoryImpl(localDataSource: serviceLocator<AirtimeLocalDataSource>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => AirtimeCubit(
    repository: serviceLocator<AirtimeRepository>(),
  ));

  // ================== Feature: Electricity Bill Payment ==================

  // Data Sources
  serviceLocator.registerLazySingleton<ElectricityBillRemoteDataSource>(
    () => ElectricityBillRemoteDataSourceImpl(
      grpcClient: serviceLocator<GrpcClient>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<ElectricityBillRepository>(
    () => ElectricityBillRepositoryImpl(
      remoteDataSource: serviceLocator<ElectricityBillRemoteDataSource>(),
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory(() => ElectricityBillCubit(
    repository: serviceLocator<ElectricityBillRepository>(),
  ));

  serviceLocator.registerFactory(() => BeneficiaryCubit(
    repository: serviceLocator<ElectricityBillRepository>(),
  ));

  serviceLocator.registerFactory(() => AutoRechargeCubit(
    repository: serviceLocator<ElectricityBillRepository>(),
  ));

  serviceLocator.registerFactory(() => ReminderCubit(
    repository: serviceLocator<ElectricityBillRepository>(),
  ));

  // ================== Screens / Presentation ==================
  serviceLocator
      ..registerFactory(() => OnboardingScreen())
      ..registerFactory(() => SplashScreen())
      ..registerFactory(() => DashboardScreen())
      ..registerFactory(() => NewCardScreen())
      ..registerFactory(() => CameraScanScreen())
      ..registerFactory(() => UploadImageScreen())
      ..registerFactory(() => SelectRecipientScreen())
      ..registerFactory(() => AddRecipientScreen())
      ..registerFactory(() => InvoiceListScreen())
      ..registerFactory(() => CreateInvoiceScreen())
      ..registerFactory(() => PayInvoiceScreen())
      ..registerFactoryParam<InvoiceDetailsScreen, String, void>(
          (invoiceId, _) => InvoiceDetailsScreen(invoiceId: invoiceId))
      ..registerFactoryParam<InputPinScreen, User, void>(
          (recipient, _) => InputPinScreen(recipient: recipient))
      ..registerFactory(() => PayElectricityBillScreen())
      ..registerFactory(() => ProfileSettingsScreen())
      ..registerFactory(() => LanguagesScreen())
      ..registerFactory(() => MyAccountScreen())
      ..registerFactory(() => SetFingerPrintScreen())
      ..registerFactory(() => ChangePinScreen())
      ..registerFactory(() => SignUpScreen())
      ..registerFactory(() => EmailSignInScreen())
      ..registerFactory(() => PasscodeSignInScreen())
      ..registerFactory(() => OTPVerificationScreen())
      ..registerFactory(() => EnableBiometricAccessScreen())
      ..registerFactory(() => PasswordRecoveryScreen())
      ..registerFactory(() => CreateNewPasswordScreen())
      ..registerFactory(() => SelectCountryScreen())
      ..registerFactory(() => FacialBiometricVerificationScreen())
      ..registerFactory(() => FaceScanScreen())
      ..registerFactory(() => FacialLoginScreen())
      ..registerFactory(() => TransactionHistoryScreen())
      ..registerFactory(() => FlightsScreen())
      ..registerFactory(() => StocksScreen())
      ..registerFactory(() => CBCurrencyExchangeScreen())
      ..registerFactory(() => CryptoFeature.CryptoScreen())
      ..registerFactoryParam<CryptoDetailScreen, Crypto, void>(
          (crypto, _) => CryptoDetailScreen(crypto: crypto))
      ..registerFactoryParam<CryptoChartDetailsScreen, Crypto, void>(
          (crypto, _) => CryptoChartDetailsScreen(crypto: crypto))
      ..registerFactoryParam<CurrencyDepositScreen, String, void>(
          (currencyCode, _) => CurrencyDepositScreen(currencyCode: currencyCode))
      ..registerFactory(() => GiftCardsScreen())
      ..registerFactory(() => MyGiftCardsScreen())
      ..registerFactory(() => SellToContactScreen())
      ..registerFactory(() => SavedRecipientsScreen())
      ..registerFactory(() => QuickSellScreen())
      ..registerFactory(() => StockFeature.StocksScreen())
      ..registerFactoryParam<StockDetailsScreen, Stock, void>(
          (stock, _) => StockDetailsScreen(stock: stock))
      ..registerFactory(() => StockTradeAmountScreen())
      ..registerFactory(() => StockTradePaymentScreen())
      ..registerFactory(() => StockTradeReviewScreen())
      ..registerFactory(() => StockTradeReceiptScreen())
      ..registerFactoryParam<ReviewFundsTransferScreen, core_recipient.Recipient, void>(
          (recipient, _) => ReviewFundsTransferScreen(recipient: recipient))
      ..registerFactoryParam<InitiateSendFundsScreen, RecipientModel, void>(
          (recipient, _) => InitiateSendFundsScreen(recipient:  recipient))
      ..registerFactoryParam<SendFundScreen, User, void>(
          (recipient, _) => SendFundScreen(recipient: recipient))
      ..registerFactoryParam<TransferProofScreen, Map<String, dynamic>, void>(
          (transferDetails, _) => TransferProofScreen(transferDetails: transferDetails))
      ..registerFactoryParam<SendFundReceiptScreen, Transaction, void>(
          (transaction, _) => SendFundReceiptScreen(transaction: transaction))
      ..registerFactoryParam<ReviewElectricityBillsScreen, ElectricityBillDetails,
              void>(
          (electricityBillDetails, _) => ReviewElectricityBillsScreen(
              electricityBillDetails: electricityBillDetails))
      ..registerFactoryParam<DepositFundsScreen, Map<String, dynamic>, void>(
        (selectedCard, _) => DepositFundsScreen(selectedCard: selectedCard),
      )
      ..registerFactoryParam<WithdrawFundsScreen, Map<String, dynamic>, void>(
        (selectedCard, _) => WithdrawFundsScreen(selectedCard: selectedCard),
      )
      ..registerFactoryParam<StockChartDetailsScreen, Stock, void>(
          (stock, _) => StockChartDetailsScreen(stock: stock))
      ..registerFactory(() => InvestmentsScreen());

  // ================== Screens / Presentation - Group Account ==================
  serviceLocator.registerFactory(() => GroupAccountListScreen());

  // ================== Screens / Presentation - Insurance ==================
  serviceLocator.registerFactory(() => InsuranceListScreen());

  // Make sure AuthenticationCubit is registered first, e.g.:
  // serviceLocator.registerLazySingleton(() => AuthenticationCubit(...));

  // Then, register VoiceSessionCubit and inject AuthenticationCubit:
  serviceLocator.registerLazySingleton<VoiceSessionCubit>(
    () => VoiceSessionCubit(),
  );

  // ================== Feature: Pay Invoice ==================

  // Data Sources
  serviceLocator.registerLazySingleton<PayInvoiceLocalDataSource>(
    () => PayInvoiceLocalDataSourceImpl(),
  );

  // Repositories - Using gRPC implementation for backend integration
  serviceLocator.registerLazySingleton<PayInvoiceRepository>(
    () => PayInvoiceRepositoryGrpcImpl(
      grpcClient: serviceLocator<GrpcClient>(),
      currentUserId: '', // User ID is extracted from auth token in grpcClient.callOptions
      invoiceRepository: serviceLocator<InvoiceRepository>(),
    ),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory<PayInvoiceCubit>(
    () => PayInvoiceCubit(repository: serviceLocator<PayInvoiceRepository>()),
  );

  // ================== Feature: AI Scan to Pay ==================

  // Data Sources - Using Remote (gRPC) implementation
  serviceLocator.registerLazySingleton<AiScanRemoteDataSource>(
    () => AiScanRemoteDataSourceImpl(
      grpcClient: serviceLocator<GrpcClient>(),
    ),
  );

  // Keep mock datasource for fallback/testing if needed
  serviceLocator.registerLazySingleton<AiScanDataSource>(
    () => AiScanDataSourceImpl(),
  );

  // Repositories - Using V2 implementation with gRPC
  serviceLocator.registerLazySingleton<AiScanRepository>(
    () => AiScanRepositoryImplV2(
      remoteDataSource: serviceLocator<AiScanRemoteDataSource>(),
      grpcClient: serviceLocator<GrpcClient>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => StartScanSessionUseCase(serviceLocator<AiScanRepository>()));
  serviceLocator.registerLazySingleton(() => ProcessScanUseCase(serviceLocator<AiScanRepository>()));
  serviceLocator.registerLazySingleton(() => AiChatUseCase(serviceLocator<AiScanRepository>()));
  serviceLocator.registerLazySingleton(() => GeneratePaymentUseCase(serviceLocator<AiScanRepository>()));
  serviceLocator.registerLazySingleton(() => ProcessPaymentUseCase(serviceLocator<AiScanRepository>()));
  serviceLocator.registerLazySingleton(() => GetScanHistoryUseCase(serviceLocator<AiScanRepository>()));

  // Cubit
  serviceLocator.registerFactory(() => AiScanCubit(
    startScanSessionUseCase: serviceLocator<StartScanSessionUseCase>(),
    processScanUseCase: serviceLocator<ProcessScanUseCase>(),
    aiChatUseCase: serviceLocator<AiChatUseCase>(),
    generatePaymentUseCase: serviceLocator<GeneratePaymentUseCase>(),
    processPaymentUseCase: serviceLocator<ProcessPaymentUseCase>(),
    getScanHistoryUseCase: serviceLocator<GetScanHistoryUseCase>(),
  ));

  // ================== Feature: Group Account ==================

  // Data Sources
  serviceLocator.registerLazySingleton<GroupAccountRemoteDataSource>(
    () => GroupAccountGrpcDataSource(
      client: serviceLocator<GroupAccountServiceClient>(),
      callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Repositories
  serviceLocator.registerLazySingleton<GroupAccountRepository>(
    () => GroupAccountRepositoryImpl(remoteDataSource: serviceLocator<GroupAccountRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => GetUserGroups(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetGroupById(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => CreateGroup(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateGroup(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => DeleteGroup(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetGroupMembers(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => AddMemberToGroup(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateMemberRole(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => RemoveMemberFromGroup(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => SearchUsers(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetGroupContributions(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetContributionById(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => CreateContribution(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateContribution(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => DeleteContribution(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetContributionPayments(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => MakeContributionPayment(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => UpdatePaymentStatus(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GenerateReceipt(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserReceipts(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GenerateContributionTranscript(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetGroupStatistics(serviceLocator<GroupAccountRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserContributionStats(serviceLocator<GroupAccountRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => GroupAccountCubit(
    getUserGroups: serviceLocator<GetUserGroups>(),
    getGroupById: serviceLocator<GetGroupById>(),
    createGroup: serviceLocator<CreateGroup>(),
    updateGroup: serviceLocator<UpdateGroup>(),
    deleteGroup: serviceLocator<DeleteGroup>(),
    getGroupMembers: serviceLocator<GetGroupMembers>(),
    addMemberToGroup: serviceLocator<AddMemberToGroup>(),
    updateMemberRole: serviceLocator<UpdateMemberRole>(),
    removeMemberFromGroup: serviceLocator<RemoveMemberFromGroup>(),
    searchUsers: serviceLocator<SearchUsers>(),
    getGroupContributions: serviceLocator<GetGroupContributions>(),
    getContributionById: serviceLocator<GetContributionById>(),
    createContribution: serviceLocator<CreateContribution>(),
    updateContribution: serviceLocator<UpdateContribution>(),
    deleteContribution: serviceLocator<DeleteContribution>(),
    getContributionPayments: serviceLocator<GetContributionPayments>(),
    makeContributionPayment: serviceLocator<MakeContributionPayment>(),
    updatePaymentStatus: serviceLocator<UpdatePaymentStatus>(),
    generateReceipt: serviceLocator<GenerateReceipt>(),
    getUserReceipts: serviceLocator<GetUserReceipts>(),
    generateContributionTranscript: serviceLocator<GenerateContributionTranscript>(),
    getGroupStatistics: serviceLocator<GetGroupStatistics>(),
    getUserContributionStats: serviceLocator<GetUserContributionStats>(),
  ));

  // ================== Feature: Insurance ==================

  // Data Sources
  serviceLocator.registerLazySingleton<InsuranceLocalDataSource>(
    () {
      final dataSource = InsuranceLocalDataSourceImpl();
      // Initialize Hive for insurance
      dataSource.initializeHive();
      return dataSource;
    },
  );

  // Repositories
  serviceLocator.registerLazySingleton<InsuranceRepository>(
    () => InsuranceRepositoryImpl(localDataSource: serviceLocator<InsuranceLocalDataSource>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory<InsuranceCubit>(
    () => InsuranceCubit(
      repository: serviceLocator<InsuranceRepository>(),
    ),
  );


  // ================== Feature: Contact Sync ==================

  // Services
  serviceLocator.registerLazySingleton<ContactService>(
    () => ContactService(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<ContactSyncRepository>(
    () => ContactSyncRepository(serviceLocator<ContactSyncServiceClient>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => SyncContactsUseCase(serviceLocator<ContactSyncRepository>()));
  serviceLocator.registerLazySingleton(() => GetSyncedContactsUseCase(serviceLocator<ContactSyncRepository>()));
  serviceLocator.registerLazySingleton(() => FindLazerVaultUsersUseCase(serviceLocator<ContactSyncRepository>()));
  serviceLocator.registerLazySingleton(() => ConvertContactToRecipientUseCase(serviceLocator<ContactSyncRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory<ContactSyncCubit>(
    () => ContactSyncCubit(
      syncContactsUseCase: serviceLocator<SyncContactsUseCase>(),
      getSyncedContactsUseCase: serviceLocator<GetSyncedContactsUseCase>(),
      findLazerVaultUsersUseCase: serviceLocator<FindLazerVaultUsersUseCase>(),
      convertContactToRecipientUseCase: serviceLocator<ConvertContactToRecipientUseCase>(),
      repository: serviceLocator<ContactSyncRepository>(),
      contactService: serviceLocator<ContactService>(),
    ),
  );

  // ================== Feature: Auto-Save ==================

  // Repositories
  serviceLocator.registerLazySingleton<IAutoSaveRepository>(
    () => AutoSaveRepositoryImpl(
      autoSaveServiceClient: serviceLocator<AutoSaveServiceClient>(),
      callOptionsHelper: serviceLocator<GrpcCallOptionsHelper>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => CreateAutoSaveRuleUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => GetAutoSaveRulesUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => UpdateAutoSaveRuleUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => ToggleAutoSaveRuleUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => DeleteAutoSaveRuleUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => GetAutoSaveTransactionsUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => GetAutoSaveStatisticsUseCase(serviceLocator<IAutoSaveRepository>()));
  serviceLocator.registerLazySingleton(() => TriggerAutoSaveUseCase(serviceLocator<IAutoSaveRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory(() => AutoSaveCubit(
    createAutoSaveRuleUseCase: serviceLocator<CreateAutoSaveRuleUseCase>(),
    getAutoSaveRulesUseCase: serviceLocator<GetAutoSaveRulesUseCase>(),
    updateAutoSaveRuleUseCase: serviceLocator<UpdateAutoSaveRuleUseCase>(),
    toggleAutoSaveRuleUseCase: serviceLocator<ToggleAutoSaveRuleUseCase>(),
    deleteAutoSaveRuleUseCase: serviceLocator<DeleteAutoSaveRuleUseCase>(),
    getAutoSaveTransactionsUseCase: serviceLocator<GetAutoSaveTransactionsUseCase>(),
    getAutoSaveStatisticsUseCase: serviceLocator<GetAutoSaveStatisticsUseCase>(),
    triggerAutoSaveUseCase: serviceLocator<TriggerAutoSaveUseCase>(),
  ));


  // ================== Feature: Statistics ==================

  // GrpcClient (for statistics and invoices) - Initialize asynchronously
  final grpcClient = GrpcClient(secureStorage: serviceLocator<FlutterSecureStorage>());
  await grpcClient.initialize();  // Properly await initialization
  serviceLocator.registerLazySingleton<GrpcClient>(() => grpcClient);

  // Repositories
  serviceLocator.registerLazySingleton<StatisticsRepository>(
    () => StatisticsRepository(grpcClient: serviceLocator<GrpcClient>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory<StatisticsCubit>(
    () => StatisticsCubit(repository: serviceLocator<StatisticsRepository>()),
  );

  // Screens
  serviceLocator.registerFactory(() => const StatisticsScreen());
  serviceLocator.registerFactory(() => const AddExpenseScreen());
  serviceLocator.registerFactory(() => const AddBudgetScreen());


  // ================== Feature: Cards ==================

  // Data Sources
  serviceLocator.registerLazySingleton<ICardRemoteDataSource>(
    () => CardRemoteDataSourceImpl(grpcClient: serviceLocator<GrpcClient>()),
  );
  // Repositories
  serviceLocator.registerLazySingleton<ICardRepository>(
    () => CardRepositoryImpl(remoteDataSource: serviceLocator<ICardRemoteDataSource>()),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => CreateVirtualCardUseCase(serviceLocator<ICardRepository>()));
  serviceLocator.registerLazySingleton(() => CreateDisposableCardUseCase(serviceLocator<ICardRepository>()));
  serviceLocator.registerLazySingleton(() => GetUserCardsUseCase(serviceLocator<ICardRepository>()));

  // Blocs/Cubits
  serviceLocator.registerFactory<CardCubit>(
    () => CardCubit(
      createVirtualCardUseCase: serviceLocator<CreateVirtualCardUseCase>(),
      createDisposableCardUseCase: serviceLocator<CreateDisposableCardUseCase>(),
      getUserCardsUseCase: serviceLocator<GetUserCardsUseCase>(),
    ),
  );


  // ================== Feature: Lock Funds ==================

  // Repositories
  serviceLocator.registerLazySingleton<LockFundsRepository>(
    () => LockFundsRepositoryImpl(grpcClient: serviceLocator<GrpcClient>()),
  );

  // Blocs/Cubits
  serviceLocator.registerFactory<LockFundsCubit>(
    () => LockFundsCubit(serviceLocator<LockFundsRepository>()),
  );

  serviceLocator.registerFactory<CreateLockCubit>(
    () => CreateLockCubit(),
  );


  print("Dependency Injection Initialized with Hierarchical Order");
}
