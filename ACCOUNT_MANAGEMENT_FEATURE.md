# Account Management Feature

## Overview

The Account Management feature provides comprehensive account balance tracking and transaction management for the TradeMate app. Users can manage their trading account balance, track deposits and withdrawals, and automatically process trade results.

## Features

### 🏦 Account Balance Management
- **Current Balance Display**: Real-time account balance with last updated timestamp
- **Balance Updates**: Manual balance adjustments with notes
- **Initial Balance Setup**: Automatic initialization with zero balance

### 💰 Transaction Management
- **Deposits**: Add funds to account with optional notes
- **Withdrawals**: Remove funds from account with optional notes
- **Trade Results**: Automatic processing of trade profits, losses, and fees
- **Transaction History**: Complete history with filtering and search

### 📊 Statistics & Analytics
- **Total Deposits**: Sum of all deposits
- **Total Withdrawals**: Sum of all withdrawals
- **Trade P&L**: Total profit/loss from trading activities
- **Account Growth**: Visual representation of balance changes

### 🔄 Integration with Trade System
- **Automatic Updates**: Account balance updates automatically after trade completion
- **Trade Linking**: Transactions linked to specific trades
- **PnL Processing**: Automatic profit/loss calculation and balance adjustment

## Architecture

### Clean Architecture Implementation

```
lib/features/account_management/
├── data/
│   ├── models/
│   │   ├── account_balance_model.dart
│   │   └── transaction_model.dart
│   ├── datasources/
│   │   ├── account_local_datasource.dart
│   │   └── transaction_local_datasource.dart
│   └── repositories/
│       └── account_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── account_balance.dart
│   │   └── transaction.dart
│   ├── repositories/
│   │   └── account_repository.dart
│   └── usecases/
│       ├── get_account_balance_usecase.dart
│       ├── update_balance_usecase.dart
│       └── add_transaction_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── account_bloc.dart
    │   ├── account_event.dart
    │   └── account_state.dart
    ├── pages/
    │   ├── account_page.dart
    │   └── transaction_history_page.dart
    └── widgets/
        ├── balance_card.dart
        ├── quick_actions.dart
        ├── account_statistics.dart
        └── transaction_list.dart
```

### Database Schema

#### AccountBalance Table
```sql
CREATE TABLE account_balance (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  balance REAL NOT NULL,
  last_updated DATETIME NOT NULL,
  note TEXT
);
```

#### AccountTransactions Table
```sql
CREATE TABLE account_transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type TEXT NOT NULL, -- deposit, withdrawal, tradeProfit, tradeLoss, tradeFee
  amount REAL NOT NULL,
  note TEXT,
  datetime DATETIME NOT NULL,
  trade_id INTEGER, -- Foreign key to trades table
  balance_before REAL NOT NULL,
  balance_after REAL NOT NULL
);
```

## Usage

### Adding Account Management to Navigation

The feature is integrated into the main navigation with a dedicated "Account" tab:

```dart
BottomNavigationBar(
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Trade'),
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Trade List'),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Account'),
    BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Tools'),
  ],
)
```

### Home Page Integration

Account balance is displayed on the Home page:

```dart
// Account Balance Card
BlocBuilder<AccountBloc, AccountState>(
  builder: (context, accountState) {
    if (accountState is AccountLoaded) {
      return BalanceCard(balance: accountState.balance);
    }
    return const SizedBox.shrink();
  },
),
```

### Dependency Injection

All dependencies are registered in `main.dart`:

```dart
// Account Management - Data Sources
Provider<AccountLocalDataSource>(
  create: (context) => AccountLocalDataSourceImpl(
    database: context.read<TradeMateDatabase>(),
  ),
),
Provider<TransactionLocalDataSource>(
  create: (context) => TransactionLocalDataSourceImpl(
    database: context.read<TradeMateDatabase>(),
  ),
),

// Account Management - Repository
Provider<AccountRepository>(
  create: (context) => AccountRepositoryImpl(
    accountLocalDataSource: context.read<AccountLocalDataSource>(),
    transactionLocalDataSource: context.read<TransactionLocalDataSource>(),
  ),
),

// Account Management - Use Cases
Provider<GetAccountBalance>(
  create: (context) => GetAccountBalance(
    context.read<AccountRepository>(),
  ),
),
Provider<UpdateBalance>(
  create: (context) => UpdateBalance(
    context.read<AccountRepository>(),
  ),
),
Provider<AddTransaction>(
  create: (context) => AddTransaction(
    context.read<AccountRepository>(),
  ),
),

// Account Management - Bloc
BlocProvider<AccountBloc>(
  create: (context) => AccountBloc(
    getAccountBalance: context.read<GetAccountBalance>(),
    updateBalance: context.read<UpdateBalance>(),
    addTransaction: context.read<AddTransaction>(),
    accountRepository: context.read<AccountRepository>(),
  ),
),
```

## UI/UX Features

### Modern Design
- **Gradient Cards**: Beautiful gradient backgrounds for balance display
- **Color Coding**: Green for profits/deposits, red for losses/withdrawals
- **Icons**: Intuitive icons for different transaction types
- **Responsive Layout**: Adapts to different screen sizes

### User Experience
- **Quick Actions**: One-tap deposit and withdrawal buttons
- **Modal Dialogs**: Clean transaction input forms
- **Real-time Updates**: Instant balance updates after transactions
- **Error Handling**: User-friendly error messages
- **Loading States**: Smooth loading indicators

### Transaction History
- **Filtering**: Filter by transaction type and date range
- **Search**: Find specific transactions
- **Pagination**: Load transactions in batches
- **Export**: Export transaction history (future feature)

## Transaction Types

### Manual Transactions
- **Deposit**: Adding funds to account
- **Withdrawal**: Removing funds from account

### Automatic Transactions
- **Trade Profit**: Positive P&L from closed trades
- **Trade Loss**: Negative P&L from closed trades
- **Trade Fee**: Trading fees and commissions

## Error Handling

The feature implements comprehensive error handling:

```dart
try {
  final balance = await getAccountBalance(const NoParams());
  // Process success
} catch (e) {
  emit(AccountError(message: e.toString()));
}
```

### Error Types
- **DatabaseFailure**: Database operation errors
- **ValidationFailure**: Input validation errors
- **InsufficientBalanceFailure**: Insufficient funds for withdrawal

## Testing

### Unit Tests
- Repository tests for data operations
- Use case tests for business logic
- Bloc tests for state management

### Widget Tests
- UI component tests
- Integration tests for user flows

## Future Enhancements

### Planned Features
- **Multiple Accounts**: Support for multiple trading accounts
- **Currency Support**: Multi-currency account balances
- **Budget Tracking**: Monthly/yearly budget limits
- **Export Features**: CSV/PDF export of transactions
- **Notifications**: Balance alerts and reminders
- **Charts**: Visual balance history charts

### Performance Optimizations
- **Caching**: Cache frequently accessed data
- **Lazy Loading**: Load transactions on demand
- **Background Sync**: Sync with external data sources

## Migration

The feature includes database migration to version 3:

```dart
if (from < 3) {
  Logger.migration('Adding account management tables...');
  try {
    // Create new tables for account management
    await m.createTable(accountBalance);
    await m.createTable(accountTransactions);
    
    // Initialize account balance with 0 if no records exist
    await m.into(accountBalance).insert(
      AccountBalanceCompanion.insert(
        balance: 0.0,
        lastUpdated: DateTime.now(),
        note: 'Initial balance',
      ),
    );
    
    Logger.migration('Account management tables created successfully');
  } catch (e) {
    Logger.error('Error during account management migration: $e', e);
    rethrow;
  }
}
```

## Conclusion

The Account Management feature provides a robust foundation for tracking trading account balances and transactions. It follows Clean Architecture principles, implements modern UI/UX patterns, and integrates seamlessly with the existing trade system. The feature is designed to be scalable and extensible for future enhancements.

