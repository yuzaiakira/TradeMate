# Balance at Entry Field Implementation

## Overview
This document describes the implementation of the `balance_at_entry` field for trades, which automatically captures the user's current balance at the time of trade creation.

## Requirements
- ✅ Field must be automatically calculated by the system
- ✅ Value should equal user's `current_balance` at trade creation time
- ✅ Field should only be set when trade is created
- ✅ Field should not be updated later
- ✅ User should not be able to provide this value manually

## Implementation Details

### 1. Database Schema Changes
**File:** `lib/core/data/database.dart`
- Added `balanceAtEntry` field to the `Trades` table
- Field type: `RealColumn` (nullable)
- Positioned after `accountBalance` for logical grouping

```dart
RealColumn get balanceAtEntry => real().nullable()(); // Balance at the time of trade creation
```

### 2. Domain Entity Changes
**File:** `lib/features/add_trade/domain/entities/trade.dart`
- Added `balanceAtEntry` field to the `Trade` entity
- Field type: `double?` (nullable)
- Added to constructor, copyWith method, and props list

### 3. Data Model Changes
**File:** `lib/features/add_trade/data/models/trade_model.dart`
- Added `balanceAtEntry` field to the `TradeModel` class
- Updated `fromDatabase`, `toDomain`, and `toDatabaseCompanion` methods
- Field is properly mapped between domain and database layers

### 4. Calculation Logic
**File:** `lib/core/utils/trade_calculator.dart`
- Added `calculateBalanceAtEntry()` method
- Logic ensures field is only set for new trades (when `balanceAtEntry` is null)
- Uses `getCurrentBalance()` to fetch current account balance
- Added to `calculateAllFields()` method for automatic calculation

```dart
/// Calculate balance at entry = current balance at the time of trade creation
/// This should only be set when the trade is created and not updated later
static Future<double?> calculateBalanceAtEntry(domain.Trade trade) async {
  // If balanceAtEntry is already set, return it (don't recalculate)
  if (trade.balanceAtEntry != null) {
    return trade.balanceAtEntry;
  }
  
  // For new trades, get the current balance
  return await getCurrentBalance();
}
```

### 5. Repository Implementation
**File:** `lib/features/add_trade/data/repositories/trade_repository_impl.dart`
- Updated `insertTrade()` method to include `balanceAtEntry`
- Updated `updateTrade()` method to include `balanceAtEntry`
- Field is automatically populated by `TradeCalculator.calculateAllFields()`

### 6. User Interface Protection
**Files:** 
- `lib/features/add_trade/presentation/provider/add_trade_provider.dart`
- `lib/features/add_trade/domain/usecases/add_trade_usecase.dart`

- The `buildTrade()` method in `AddTradeProvider` does NOT set `balanceAtEntry`
- The `AddTradeUseCase` does NOT set `balanceAtEntry`
- This ensures users cannot manually provide this value

## Database Migration
The database schema was updated using Drift's code generation:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Testing
- ✅ Code compiles without errors (`flutter analyze`)
- ✅ APK builds successfully (`flutter build apk --debug`)
- ✅ Database schema includes new field
- ✅ Field is automatically calculated during trade creation
- ✅ Field is not modifiable by users

## Usage Example
When a new trade is created:
1. User fills trade form (without `balance_at_entry` field)
2. System calls `TradeCalculator.calculateAllFields()`
3. `calculateBalanceAtEntry()` fetches current balance
4. Trade is saved with `balance_at_entry` = current balance
5. Field remains unchanged in future updates

## Security & Data Integrity
- Field is read-only from user perspective
- System automatically calculates and sets the value
- No user input validation needed (field is system-controlled)
- Field preserves historical balance information for analysis

## Benefits
1. **Historical Analysis**: Track account balance at trade entry time
2. **Performance Tracking**: Compare entry balance vs current balance
3. **Risk Management**: Understand position sizing relative to account size
4. **Audit Trail**: Maintain accurate balance history for each trade
5. **Automated**: No manual input required, reducing errors

## UI Display
The `balance_at_entry` field is displayed in the trade detail view in two locations:

### 1. Trade Transfers Section
- Shows the balance at entry as part of the entry information
- Positioned after entry-related fields for logical grouping
- Only displayed if the field has a value

### 2. Trade Results Section  
- Shows the balance at entry alongside other balance-related information
- Positioned after "New Balance" field for comparison
- Only displayed if the field has a value

### Display Format
- Format: `$X,XXX.XX` (with 2 decimal places)
- Example: `$1,250.00`
- Only shown when `balance_at_entry` is not null
