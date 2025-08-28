# Trade Detail Implementation Summary

## Overview
This document summarizes the implementation of new calculated fields in the trade detail section of the trade list page. All these fields are calculated by the system and should never be taken from user input.

## New Fields Added

### Trade Transfers Section
- **W/L**: Win/Loss indicator (W, L, BE for breakeven, N/A for open trades)
- **Day of Week**: Day of the week when the trade was entered
- **Session**: Trading session based on entry time (London, NY, Tokyo, Sydney, Other)
- **Order Value**: Total value of the order (entry price × quantity)
- **QTY**: Quantity of the trade (same as existing quantity field)

### Trade Management Section
- **Position to ACC %**: Position size as a percentage of account balance
- **Planned SL % (Trade)**: Planned stop loss as a percentage of entry price
- **% of ACC Risked**: Percentage of account balance risked on this trade
- **Planned Return (R)**: Planned risk/reward ratio

### Trade Exit Section
- **Day of Week**: Day of the week when the trade was exited
- **PS Tag**: PS Tag (placeholder implementation - returns "PS" for closed trades)

### Trade Results Section
- **Actual Return**: Actual return percentage based on PnL
- **Gross Profit/Loss**: Gross profit/loss before fees
- **Position Fees**: Total fees paid (entry + exit fees)
- **Net Profit/Loss**: Net profit/loss after fees
- **Trade Gain %**: Net profit/loss as a percentage of position value
- **Account Change %**: Net profit/loss as a percentage of account balance
- **New Balance**: Account balance after the trade
- **Trade Duration**: Duration of the trade in minutes

## Implementation Details

### Database Schema
- Added new columns to the `Trades` table for all calculated fields
- Updated schema version from 1 to 2
- Added migration strategy to handle database upgrades

### Entity Updates
- Updated `Trade` entity to include all new calculated fields
- Updated constructor, copyWith method, and props list
- All new fields are nullable to handle cases where calculation is not possible

### Model Updates
- Updated `TradeModel` to include all new calculated fields
- Updated `fromDatabase`, `toDomain`, and `toDatabaseCompanion` methods
- Proper type conversion between database and domain layers

### Calculation Service
- Created `TradeCalculator` class in `lib/core/utils/trade_calculator.dart`
- Implemented individual calculation methods for each field
- Implemented `calculateAllFields` method to calculate all fields at once
- All calculations are based on existing trade data

### UI Updates
- Updated trade detail page to display all new calculated fields
- Organized fields into appropriate sections
- Used `TradeCalculator` to calculate values in real-time
- Added proper formatting for currency, percentages, and durations
- Used color coding for profit/loss values

## Calculation Logic

### Win/Loss (W/L)
- Returns "W" for winning trades (PnL > 0)
- Returns "L" for losing trades (PnL < 0)
- Returns "BE" for breakeven trades (PnL = 0)
- Returns "N/A" for open trades

### Trading Sessions
- **London**: 8:00-15:59 UTC
- **NY**: 13:00-20:59 UTC
- **Tokyo**: 00:00-07:59 UTC
- **Sydney**: 21:00-23:59 UTC
- **Other**: Any other time

### Position to Account Percentage
- Calculated as: (Position Value / Account Balance) × 100
- Position Value = Entry Price × Quantity

### Planned Stop Loss Percentage
- Calculated as: |Entry Price - Stop Loss Price| / Entry Price × 100

### Account Risked Percentage
- Calculated as: (Risk Amount / Account Balance) × 100
- Risk Amount = |Entry Price - Stop Loss Price| × Quantity

### Planned Return (R)
- Calculated as: |Take Profit Price - Entry Price| / |Entry Price - Stop Loss Price|
- Represents the risk/reward ratio

### Position Fees
- Entry fees: Entry Value × Entry Fee Rate / 100
- Exit fees: Exit Value × Exit Fee Rate / 100
- Total fees = Entry fees + Exit fees

### Net Profit/Loss
- Calculated as: Gross Profit/Loss - Position Fees

### Trade Duration
- Calculated as: Exit DateTime - Entry DateTime in minutes

## Usage

### In Trade Detail Page
The trade detail page automatically calculates and displays all these fields when viewing a trade. The calculations are performed in real-time using the `TradeCalculator` service.

### Future Enhancements
- The PS Tag calculation can be enhanced with specific business logic
- Session calculations can be made more sophisticated based on market hours
- Additional calculations can be added as needed

## Database Migration
When the app is updated, existing databases will be automatically migrated to include the new columns. The migration strategy ensures data integrity and backward compatibility.

## Notes
- All calculated fields show "N/A" when the calculation is not possible (e.g., missing data)
- The system prioritizes existing PnL data over calculated PnL for consistency
- All calculations are performed client-side for real-time updates
- The implementation follows the existing code patterns and architecture
