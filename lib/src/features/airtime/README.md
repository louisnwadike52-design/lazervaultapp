# Airtime Purchase Service

A complete end-to-end airtime purchasing service for Nigerian fintech applications, featuring all major network providers and a modern, intuitive user interface.

## Features

### 🌟 Core Functionality
- **Multi-Network Support**: MTN, Airtel, Glo, and 9mobile
- **Smart Network Detection**: Automatic network detection from phone numbers
- **Flexible Amount Selection**: Quick amounts and custom input
- **Real-time Validation**: Phone number and amount validation
- **Transaction History**: Complete purchase history with filtering
- **Receipt Generation**: Professional receipt styling
- **Payment Processing**: Simulated payment flow with success/failure handling

### 📱 User Experience
- **Modern UI Design**: Dark theme with gradient backgrounds
- **Smooth Animations**: Loading states, transitions, and micro-interactions
- **Responsive Design**: Optimized for all screen sizes
- **Error Handling**: Comprehensive error states and user feedback
- **Offline Support**: Graceful handling of network issues

### 🔧 Technical Features
- **BLoC State Management**: Clean architecture with Cubit pattern
- **Type Safety**: Comprehensive entity models and enums
- **Modular Architecture**: Feature-based organization
- **Extensible Design**: Easy to add new networks and features

## Architecture

### Directory Structure
```
lib/src/features/airtime/
├── domain/
│   └── entities/
│       ├── network_provider.dart      # Network provider entity
│       └── airtime_transaction.dart   # Transaction entity
├── presentation/
│   ├── cubit/
│   │   ├── airtime_cubit.dart        # State management
│   │   └── airtime_state.dart        # State definitions
│   ├── view/
│   │   ├── airtime_screen.dart                    # Main airtime screen
│   │   ├── network_selection_screen.dart          # Network selection
│   │   ├── recipient_input_screen.dart            # Phone number input
│   │   ├── amount_selection_screen.dart           # Amount selection
│   │   ├── airtime_review_screen.dart             # Transaction review
│   │   ├── airtime_payment_processing_screen.dart # Payment processing
│   │   ├── airtime_payment_confirmation_screen.dart # Payment confirmation
│   │   ├── airtime_history_screen.dart            # Transaction history
│   │   └── airtime_details_screen.dart            # Transaction details
│   └── widgets/
│       ├── quick_actions_card.dart     # Quick action buttons
│       ├── network_providers_card.dart # Network provider display
│       └── recent_transactions_card.dart # Recent transactions
└── README.md
```

### State Management
The airtime service uses the BLoC pattern with Cubit for state management:

```dart
// States
- AirtimeInitial
- AirtimeLoading
- AirtimeError
- AirtimeNetworkProvidersLoaded
- AirtimeNetworkProviderSelected
- AirtimePhoneNumberValidated
- AirtimeQuickAmountsLoaded
- AirtimeAmountSelected
- AirtimeTransactionReviewReady
- AirtimePaymentProcessing
- AirtimePaymentSuccess
- AirtimePaymentFailed
- AirtimeTransactionHistoryLoaded
- AirtimeTransactionDetailsLoaded
```

## Network Providers

### Supported Networks
1. **MTN Nigeria**
   - Prefixes: 0803, 0806, 0813, 0814, 0816, 0903, 0906, 0913, 0916, 0703, 0706, 0704
   - Color: #FFCC00 (Yellow)
   - Discount: 2%

2. **Airtel Nigeria**
   - Prefixes: 0802, 0808, 0812, 0701, 0708, 0901, 0902, 0904, 0907, 0912
   - Color: #FF0000 (Red)
   - Discount: 1.5%

3. **Globacom (Glo)**
   - Prefixes: 0805, 0807, 0815, 0811, 0705, 0905, 0915
   - Color: #00B04F (Green)
   - Discount: 3%

4. **9mobile (Etisalat)**
   - Prefixes: 0809, 0817, 0818, 0819, 0909, 0908
   - Color: #00AA4F (Dark Green)
   - Discount: 1%

## User Flow

### 1. Main Airtime Screen
- Quick action buttons (Buy Airtime, Send Airtime)
- Network providers overview
- Recent transactions display
- Navigation to history

### 2. Network Selection
- Display all available networks
- Network-specific promotions and discounts
- Visual network identification

### 3. Recipient Input
- Phone number input with validation
- Automatic network detection
- Optional recipient name
- Contact selection (future feature)

### 4. Amount Selection
- Quick amount buttons (₦50, ₦100, ₦200, ₦500, ₦1000, ₦2000, ₦5000)
- Custom amount input
- Real-time fee calculation
- Discount application

### 5. Transaction Review
- Complete transaction summary
- Recipient details confirmation
- Payment breakdown
- Final confirmation

### 6. Payment Processing
- Animated loading screen
- Transaction status updates
- Processing simulation (3-second delay)

### 7. Payment Confirmation
- Success/failure status
- Professional receipt display
- Transaction details
- Action buttons (Dashboard, Buy More, History)

### 8. Transaction History
- Chronological transaction list
- Status indicators
- Search and filter capabilities
- Transaction details access

### 9. Transaction Details
- Complete transaction information
- Payment breakdown
- Status tracking
- Share functionality

## API Integration

### Current Implementation
The service currently uses simulated API calls for demonstration purposes:

```dart
// Simulated payment processing
Future<void> processPayment(AirtimeTransaction transaction) async {
  emit(AirtimePaymentProcessing(transaction));
  
  // Simulate processing delay
  await Future.delayed(Duration(seconds: 3));
  
  // Simulate 90% success rate
  final isSuccess = DateTime.now().millisecond % 10 != 0;
  
  if (isSuccess) {
    // Handle success
  } else {
    // Handle failure
  }
}
```

### Production Integration
For production deployment, replace simulation with actual API calls:

1. **Network Provider API**: Integrate with telecom provider APIs
2. **Payment Gateway**: Connect to payment processing services
3. **Transaction Storage**: Implement persistent storage
4. **Real-time Updates**: Add WebSocket support for status updates

## Customization

### Adding New Networks
1. Add new network type to `NetworkProviderType` enum
2. Update extension methods with network details
3. Add network configuration to `AirtimeCubit`
4. Update UI components with new network colors/logos

### Modifying UI Theme
The service uses a consistent dark theme with customizable colors:

```dart
// Primary colors
Color(0xFF6366F1) // Primary blue
Color(0xFF8B5CF6) // Secondary purple
Color(0xFF10B981) // Success green
Color(0xFFEF4444) // Error red
Color(0xFFFFA500) // Warning orange

// Background gradient
LinearGradient(
  colors: [
    Color(0xFF1A1A3E),
    Color(0xFF0A0E27),
    Color(0xFF0F0F23),
  ],
)
```

### Fee Structure
Current fee calculation (customizable):

```dart
double _calculateFee(double amount) {
  // 1% of amount, minimum ₦5, maximum ₦100
  final fee = amount * 0.01;
  return fee.clamp(5.0, 100.0);
}

double _calculateDiscount(double amount, double discountPercentage) {
  return amount * (discountPercentage / 100);
}
```

## Testing

### Unit Tests
- Entity model validation
- State management logic
- Fee calculation accuracy
- Network detection algorithms

### Integration Tests
- Complete user flow testing
- API integration validation
- Error handling verification
- Performance benchmarking

### UI Tests
- Screen navigation flow
- Form validation
- Animation performance
- Responsive design

## Performance Considerations

### Optimization Features
- **Lazy Loading**: Screens loaded on demand
- **State Persistence**: Maintain state across navigation
- **Memory Management**: Proper disposal of controllers
- **Efficient Rendering**: Optimized widget rebuilds

### Monitoring
- Transaction success rates
- Payment processing times
- User flow completion rates
- Error frequency tracking

## Security

### Data Protection
- Sensitive data encryption
- Secure API communication
- Input validation and sanitization
- Transaction integrity verification

### Privacy
- Minimal data collection
- User consent management
- Data retention policies
- Compliance with regulations

## Future Enhancements

### Planned Features
1. **Scheduled Purchases**: Recurring airtime purchases
2. **Bulk Purchases**: Multiple recipients at once
3. **Loyalty Program**: Rewards for frequent users
4. **Data Bundles**: Internet data purchase integration
5. **Bill Payments**: Utility bill payment expansion
6. **Wallet Integration**: Digital wallet connectivity
7. **Offline Mode**: Cached transaction support
8. **Push Notifications**: Transaction status updates

### Technical Improvements
1. **Real-time Sync**: Live transaction updates
2. **Advanced Analytics**: Usage pattern analysis
3. **Machine Learning**: Smart amount suggestions
4. **Biometric Auth**: Fingerprint/face authentication
5. **Multi-language**: Localization support
6. **Accessibility**: Enhanced accessibility features

## Support

### Documentation
- API documentation
- Integration guides
- Troubleshooting guides
- Best practices

### Contact
For technical support or feature requests, please contact the development team.

---

**Version**: 1.0.0  
**Last Updated**: December 2024  
**Compatibility**: Flutter 3.0+, Dart 3.0+ 