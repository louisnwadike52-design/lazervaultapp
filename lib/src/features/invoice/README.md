# Invoice/Request Funds Feature

A complete invoice and payment request system built with Clean Architecture and BLoC pattern.

## Architecture Overview

```
lib/src/features/invoice/
├── domain/                 # Business logic and entities
│   ├── entities/          
│   │   └── invoice_entity.dart        # Core invoice business object
│   └── repositories/
│       └── invoice_repository.dart    # Repository interface
├── data/                  # Data layer
│   ├── models/
│   │   └── invoice_model.dart        # Data model with JSON serialization
│   ├── datasources/
│   │   └── invoice_local_datasource.dart  # Local storage implementation
│   └── repositories/
│       └── invoice_repository_impl.dart   # Repository implementation
└── presentation/          # UI layer
    ├── cubit/
    │   ├── invoice_cubit.dart        # Business logic controller
    │   └── invoice_state.dart        # UI states
    ├── view/
    │   ├── invoice_list_screen.dart      # Main invoices list
    │   ├── create_invoice_screen.dart    # Create/edit invoice form
    │   ├── invoice_details_screen.dart   # Invoice details with QR code
    │   └── request_funds_original_screen.dart  # Original request screen
    └── widgets/
        ├── invoice_card.dart             # Invoice list item
        ├── invoice_statistics_card.dart  # Analytics dashboard
        └── invoice_filter_chip.dart      # Filter UI component
```

## Features

### Core Invoice Management
- ✅ Create, edit, delete invoices
- ✅ Multiple invoice types (Invoice, Payment Request, Quote)
- ✅ Item-based invoicing with quantity and pricing
- ✅ Tax and discount calculations
- ✅ Due date management
- ✅ Status tracking (Draft, Pending, Paid, Expired, Cancelled)

### Advanced Features
- ✅ QR Code generation for payments
- ✅ Invoice search and filtering
- ✅ Statistics and analytics dashboard
- ✅ Share functionality
- ✅ Local data persistence
- ✅ Offline-first architecture

### UI/UX Features
- ✅ Modern dark theme design
- ✅ Responsive layout with ScreenUtil
- ✅ Smooth animations and transitions
- ✅ Form validation and error handling
- ✅ Loading states and error recovery
- ✅ Accessibility considerations

## Data Models

### Invoice Entity
```dart
class Invoice {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String currency;
  final InvoiceStatus status;
  final InvoiceType type;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? paidAt;
  final String fromUserId;
  final String? toUserId;
  final String? toEmail;
  final String? toName;
  final List<InvoiceItem> items;
  final double? taxAmount;
  final double? discountAmount;
  final double totalAmount;
  // ... additional fields
}
```

### Invoice Item
```dart
class InvoiceItem {
  final String id;
  final String name;
  final String? description;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
}
```

## State Management

The feature uses BLoC pattern with Cubit for state management:

### States
- `InvoiceInitial` - Initial state
- `InvoiceLoading` - Loading operations
- `InvoicesLoaded` - List of invoices loaded
- `InvoiceDetailsLoaded` - Single invoice details
- `InvoiceFormState` - Form editing state
- `InvoiceOperationSuccess` - Successful operations
- `InvoiceError` - Error states
- `QRCodeGenerated` - QR code ready for display
- `InvoiceSearchResults` - Search results

### Key Operations
- `loadInvoices()` - Load all invoices with statistics
- `createInvoice()` - Create new invoice
- `updateInvoice()` - Update existing invoice
- `deleteInvoice()` - Delete invoice
- `markAsPaid()` - Mark invoice as paid
- `generateQRCode()` - Generate payment QR code
- `searchInvoices()` - Search invoices

## Screens

### 1. Invoice List Screen (`invoice_list_screen.dart`)
- Displays all invoices in a filterable list
- Statistics dashboard showing key metrics
- Search functionality
- Tab-based filtering (All, Drafts, Pending, Paid, Overdue)
- Quick actions (edit, send, mark as paid, share, delete)

### 2. Create Invoice Screen (`create_invoice_screen.dart`)
- Comprehensive form for creating/editing invoices
- Item management with add/edit/remove functionality
- Tax and discount calculations
- Recipient information
- Due date selection
- Draft and send options

### 3. Invoice Details Screen (`invoice_details_screen.dart`)
- Complete invoice information display
- QR code generation for payments
- Action buttons (share, edit, mark as paid)
- Payment history tracking
- Professional invoice layout

## Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.6
  equatable: ^2.0.7
  uuid: ^4.5.1
  shared_preferences: ^2.5.3
  qr_flutter: ^4.1.0
  intl: ^0.19.0
  path_provider: ^2.1.5
  share_plus: ^10.1.2
  flutter_screenutil: ^5.9.6
  google_fonts: ^6.2.1
  get: ^4.6.6
```

## Usage

### 1. Add to your app's dependency injection:
```dart
// Repository
final invoiceRepository = InvoiceRepositoryImpl(
  localDataSource: InvoiceLocalDataSourceImpl(
    sharedPreferences: await SharedPreferences.getInstance(),
  ),
);

// Cubit
BlocProvider(
  create: (context) => InvoiceCubit(
    repository: invoiceRepository,
    currentUserId: 'user_id_here',
  ),
  child: InvoiceListScreen(),
)
```

### 2. Navigate to invoice screens:
```dart
// Open invoice list
Get.to(() => const InvoiceListScreen());

// Create new invoice
Get.to(() => const CreateInvoiceScreen());

// View invoice details
Get.to(() => InvoiceDetailsScreen(invoiceId: 'invoice_id'));
```

## QR Code Integration

The system generates QR codes for payment requests with the following format:
```
invoice://pay?id={invoice_id}&amount={total_amount}&currency={currency}
```

This can be customized to integrate with:
- Payment processors (Stripe, PayPal, etc.)
- Cryptocurrency wallets
- Bank payment systems
- Custom payment handlers

## Data Persistence

Invoices are stored locally using SharedPreferences with JSON serialization. The system supports:
- Offline-first operation
- Data synchronization (ready for cloud integration)
- Backup and restore functionality
- Data migration capabilities

## Future Enhancements

- [ ] Cloud synchronization
- [ ] PDF generation
- [ ] Email integration
- [ ] Recurring invoices
- [ ] Payment gateway integration
- [ ] Multi-currency support
- [ ] Invoice templates
- [ ] Bulk operations
- [ ] Analytics export
- [ ] Notification system

## Testing

The architecture supports easy testing with:
- Repository pattern for data mocking
- BLoC pattern for UI testing
- Dependency injection for unit testing
- Widget testing capabilities

## Contributing

When extending this feature:
1. Follow the Clean Architecture principles
2. Maintain separation of concerns
3. Add comprehensive tests
4. Update documentation
5. Follow existing code style and patterns 