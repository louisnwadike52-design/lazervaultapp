# Insurance Feature

A complete end-to-end insurance management feature for the LazerVault app, following clean architecture principles.

## Features

### Core Functionality
- ✅ **Insurance Policy Management**: Create, view, update, and delete insurance policies
- ✅ **Premium Payment Processing**: Complete payment flow with processing animations
- ✅ **Payment Confirmation**: Success screens with receipt sharing and downloading
- ✅ **Multiple Insurance Types**: Health, Auto, Home, Life, Travel, and Business insurance
- ✅ **Payment Methods**: Support for cards, bank transfers, mobile money, crypto, and digital wallets
- ✅ **Real-time Statistics**: Dashboard with policy counts, coverage amounts, and payment tracking
- ✅ **Local Data Storage**: Hive-based local storage for offline functionality

### Payment Flow
1. **Insurance List Screen**: Overview of all policies with statistics
2. **Insurance Details Screen**: Detailed policy information
3. **Payment Selection Screen**: Choose payment method and amount
4. **Payment Processing Screen**: Animated processing with real-time updates
5. **Payment Confirmation Screen**: Success confirmation with receipt options

### Architecture

The feature follows clean architecture with clear separation of concerns:

```
lib/src/features/insurance/
├── domain/
│   ├── entities/           # Core business entities
│   └── repositories/       # Repository interfaces
├── data/
│   ├── models/            # Hive data models
│   ├── datasources/       # Local data source implementation
│   └── repositories/      # Repository implementations
├── presentation/
│   ├── cubit/            # State management (Cubit pattern)
│   ├── view/             # UI screens
│   └── providers/        # BLoC providers
└── services/             # Service layer for dependency injection
```

### Key Components

#### Entities
- **Insurance**: Main insurance policy entity with type, status, coverage details
- **InsurancePayment**: Payment tracking with status, method, and transaction details
- **InsuranceClaim**: Claims management (basic structure for future expansion)

#### Screens
- **InsuranceListScreen**: Main dashboard with policy overview
- **InsuranceDetailsScreen**: Detailed policy view with payment option
- **InsurancePaymentScreen**: Payment method selection
- **InsurancePaymentProcessingScreen**: Animated payment processing
- **InsurancePaymentConfirmationScreen**: Success confirmation with sharing

#### State Management
- **InsuranceCubit**: Manages all insurance-related state
- **InsuranceState**: Comprehensive state definitions for all scenarios

### Integration

The insurance feature is fully integrated into the LazerVault app:

1. **App Services**: Added to the main services grid
2. **Navigation**: Integrated with GetX routing
3. **Dependency Injection**: Service locator pattern for clean dependencies
4. **Design System**: Consistent with app's design language and color scheme

### Usage

To use the insurance feature:

1. Navigate to the insurance service from the main dashboard
2. Add sample insurance policies using the "+" button
3. View policy details by tapping on any insurance card
4. Process premium payments through the complete payment flow
5. Share or download receipts after successful payments

### Technical Details

- **State Management**: BLoC/Cubit pattern for predictable state management
- **Local Storage**: Hive database for offline-first functionality
- **Animations**: Custom animations for payment processing and confirmations
- **Error Handling**: Comprehensive error states and user feedback
- **Type Safety**: Full Dart type safety with enums and sealed classes

### Future Enhancements

- Claims management system
- Policy renewal notifications
- Integration with external insurance APIs
- Document upload for claims
- Advanced analytics and reporting
- Push notifications for payment reminders

## Getting Started

The insurance feature is automatically available when running the LazerVault app. No additional setup is required as it uses local storage and mock data for demonstration purposes. 