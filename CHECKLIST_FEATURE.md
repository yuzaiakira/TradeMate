# Pre-Trade Checklist Feature

## Overview

The Pre-Trade Checklist feature allows users to create and manage a customizable checklist of items to review before entering a trade. This helps ensure traders follow their trading plan and don't miss important steps.

## Features

### 1. Checklist Management
- **Manage Values Page**: Users can add, edit, and remove checklist items through the "Manage Values" page
- **Category**: Checklist items are stored under the "Pre-Trade Checklist" category
- **Default Items**: The system comes with 15 pre-defined checklist items

### 2. Checklist Selection
- **Add Trade Page**: Users can select from available checklist items when adding a new trade
- **Edit Trade Page**: Users can modify checklist selections when editing existing trades
- **Search Functionality**: Users can search through available checklist items
- **Multiple Selection**: Users can select multiple items from the checklist

### 3. User Interface
- **Checklist Widget**: A reusable widget that provides a clean interface for checklist selection
- **Visual Feedback**: Selected items are highlighted with the primary color
- **Summary Display**: Shows the number of selected items with a "Clear all" option
- **Show More/Less**: Collapsible interface for better UX when there are many items

## Default Checklist Items

The system includes these default checklist items:

1. Check market trend
2. Set stop loss
3. Set take profit
4. Check risk/reward ratio
5. Verify position size
6. Check news/events
7. Review trading plan
8. Check market volatility
9. Verify entry price
10. Check trading volume
11. Review technical indicators
12. Check support/resistance levels
13. Verify leverage settings
14. Check account balance
15. Review previous trades

## How to Use

### Adding Checklist Items
1. Go to "Add Trade" page
2. Click the settings icon (⚙️) in the app bar
3. Select "Pre-Trade Checklist" category
4. Add new items using the input field

### Using Checklist in Trades
1. Go to "Add Trade" or "Edit Trade" page
2. Expand the "Pre-Trade Checklist" section
3. Search and select relevant checklist items
4. Selected items will be saved with the trade

### Managing Checklist Items
1. Navigate to "Manage Values" page
2. Select "Pre-Trade Checklist" category
3. Add new items or remove existing ones
4. Changes are automatically saved

## Technical Implementation

### Files Modified/Created

1. **`lib/core/widgets/checklist_widget.dart`** - New reusable checklist widget
2. **`lib/features/add_trade/presentation/pages/add_trade_page.dart`** - Updated to use new checklist widget
3. **`lib/features/add_trade/presentation/pages/edit_trade_page.dart`** - Updated to use new checklist widget
4. **`lib/features/add_trade/presentation/pages/manage_values_page.dart`** - Added checklist category
5. **`lib/core/providers/user_defined_values_provider.dart`** - Added checklist to categories list
6. **`lib/core/data/repositories/user_defined_values_repository.dart`** - Added default checklist items

### Data Model
- Checklist items are stored as `List<String>?` in the Trade entity
- Items are managed through the UserDefinedValues system
- Data is persisted in the local database

### Widget Features
- **Search**: Real-time search through available items
- **Selection**: Multiple item selection with visual feedback
- **Responsive**: Adapts to different screen sizes
- **Accessible**: Proper labeling and keyboard navigation

## Benefits

1. **Consistency**: Ensures traders follow the same process for each trade
2. **Risk Management**: Helps prevent common trading mistakes
3. **Customization**: Users can tailor the checklist to their trading style
4. **Documentation**: Provides a record of what was checked before each trade
5. **Improvement**: Helps identify areas where the trading process can be improved

## Future Enhancements

Potential improvements for the checklist feature:

1. **Checklist Templates**: Pre-defined templates for different trading strategies
2. **Checklist Categories**: Group checklist items by category (e.g., Technical, Fundamental, Risk Management)
3. **Checklist Analytics**: Track which items are most commonly selected
4. **Checklist Reminders**: Notifications to complete checklist before trading
5. **Checklist Sharing**: Share checklist templates with other users
