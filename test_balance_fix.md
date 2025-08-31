# Test Plan for balanceAtEntry Fix

## Problem Description
When editing a trade, the `balanceAtEntry` field was being updated with the current account balance instead of preserving the original value from when the trade was created.

## Root Cause
The `TradeCalculator.calculateBalanceAtEntry()` method was being called during both trade creation and trade updates, causing the field to be recalculated even for existing trades.

## Fix Applied
Modified `TradeCalculator.calculateBalanceAtEntry()` to check if the trade has an ID (existing trade) and preserve the original `balanceAtEntry` value instead of recalculating it.

## Test Steps

### 1. Create a New Trade
1. Add a new trade with any symbol and entry price
2. Verify that `balanceAtEntry` is set to the current account balance
3. Save the trade

### 2. Edit the Trade
1. Edit the same trade
2. Change any field (e.g., entry price, symbol, etc.)
3. Save the trade
4. Verify that `balanceAtEntry` remains unchanged (should be the original value from creation)

### 3. Verify in Database
1. Check the trade details
2. Confirm that `balanceAtEntry` shows the original balance from when the trade was created
3. Confirm that it's not the current account balance

## Expected Behavior
- **New trades**: `balanceAtEntry` = current account balance at creation time
- **Edited trades**: `balanceAtEntry` = original balance from creation time (unchanged)

## Code Changes Made
File: `lib/core/utils/trade_calculator.dart`
- Modified `calculateBalanceAtEntry()` method to preserve original value for existing trades
- Added check for `trade.id == null` to distinguish between new and existing trades

## Verification
The fix ensures that `balanceAtEntry` is only set once during trade creation and never updated during subsequent edits, preserving the historical balance information for accurate trade analysis.

