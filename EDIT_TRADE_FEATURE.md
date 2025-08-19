# Trade Edit Feature

## Overview
The trade edit functionality allows users to modify existing trades in the TradeMate app. This feature provides a comprehensive editing interface that reuses the add trade form structure while maintaining data integrity and proper validation.

## Features

### 1. Edit Trade Access
- **Location**: Trade List Page
- **Access Method**: Tap the three-dot menu (⋮) on any trade card and select "Edit"
- **Navigation**: Opens the Edit Trade Page with pre-populated form fields

### 2. Edit Trade Page
- **Title**: "Edit Trade - [Symbol]"
- **Form Structure**: Reuses the Add Trade Page form with all sections
- **Pre-populated Fields**: All existing trade data is loaded into the form
- **Validation**: Same validation rules as adding a new trade

### 3. Form Sections
The edit form includes all the same comprehensive sections as the add trade form:

#### Trade Transfers
- Tag
- Trade Date & Time
- Symbol (trading pair)
- Entry Type
- Side (Long/Short)
- Entry Price
- Position Margin
- Leverage
- Order Type
- Time Frame
- Entry Fee Rate
- Entry Mental States
- Entry Screenshot

#### Pre-Trade Checklist
- Checklist items (one per line)

#### Trade Management
- Stop Loss Price
- Take Profit Price

#### Trade Exit
- Actual Exit Price
- % of Margin Closed
- Exit Type (TP/SL)
- Exit Fee Rate
- Exit Date & Time
- Exit Mental State
- Exit Screenshot

#### Memo & Rating
- Trade Rating (1-5 stars)
- Memo/Notes

#### Analysis & Tracking
- Analysis Method
- Mistakes Made

#### Transfers
- Transfer Amount
- Transfer Screenshot

### 4. Update Process
- **Validation**: Form validates all required fields before submission
- **Calculation**: Automatically recalculates derived fields (PnL, risk/reward ratio, etc.)
- **Database Update**: Updates the trade record in the database
- **Success Feedback**: Shows success message and navigates back to trade list
- **Error Handling**: Displays error messages if update fails

## Technical Implementation

### Architecture
Following Clean Architecture principles:

#### Domain Layer
- **UpdateTradeUseCase**: Handles trade update business logic
- **TradeRepository**: Interface for trade data operations

#### Data Layer
- **TradeRepositoryImpl**: Implements trade update operations
- **TradeModel**: Data transfer object for database operations

#### Presentation Layer
- **EditTradeProvider**: Manages edit form state and update operations
- **EditTradePage**: UI for editing trades
- **AddTradeProvider**: Reused for form state management

### Key Components

#### UpdateTradeUseCase
```dart
class UpdateTradeUseCase {
  Future<bool> call(Trade trade) async {
    // Validates trade data
    // Calculates derived fields
    // Updates trade in repository
  }
}
```

#### EditTradeProvider
```dart
class EditTradeProvider extends ChangeNotifier {
  void initializeWithTrade(Trade trade);
  Future<void> updateTrade(Trade updatedTrade);
}
```

#### EditTradePage
- Reuses AddTradePage form structure
- Pre-populates form with existing trade data
- Handles form submission and navigation

### Data Flow
1. User selects "Edit" from trade card menu
2. EditTradePage is navigated to with trade data
3. Form is initialized with existing trade values
4. User makes changes to form fields
5. On submit, EditTradeProvider calls UpdateTradeUseCase
6. Trade is updated in database
7. Success feedback is shown and user returns to trade list

## Usage Instructions

### For Users
1. Navigate to the Trade List page
2. Find the trade you want to edit
3. Tap the three-dot menu (⋮) on the trade card
4. Select "Edit" from the menu
5. Make your changes in the form
6. Tap "Update Trade" to save changes
7. You'll see a success message and return to the trade list

### For Developers
1. The edit functionality is fully integrated with the existing architecture
2. All form validation and business logic is reused from the add trade feature
3. The edit page reuses the AddTradeProvider for form state management
4. New providers and use cases are registered in main.dart

## Benefits
- **Consistency**: Reuses existing form structure and validation
- **Data Integrity**: Proper validation and error handling
- **User Experience**: Familiar interface for editing trades
- **Maintainability**: Clean separation of concerns following Clean Architecture
- **Extensibility**: Easy to add new fields or modify validation rules

## Future Enhancements
- Add confirmation dialog before updating
- Add change tracking to show what fields were modified
- Add bulk edit functionality for multiple trades
- Add edit history/audit trail
- Add undo/redo functionality
