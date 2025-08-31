# Balance Fix Test Plan

## Problem Description
When adding a trade with PnL, the Current Balance was being replaced with the PnL value instead of being updated by adding/subtracting the PnL.

## Root Cause
The `TradeCalculator.calculateNewBalance()` method was using `trade.accountBalance` (balance at trade creation time) instead of the current actual balance.

## Fix Applied
1. Modified `TradeCalculator.calculateNewBalance()` to use `getCurrentBalance()` instead of `trade.accountBalance`
2. Made the method async to fetch current balance
3. Updated `calculateAllFields()` to await the new balance calculation
4. Updated trade list page to handle async `calculateNewBalance` call

## Test Steps

### Test Case 1: Deposit + Profitable Trade
1. Deposit $1000 via Quick Actions
2. Verify Current Balance shows $1000
3. Add a trade with $1 PnL (profit)
4. Verify Current Balance becomes $1001 (not $1.77)

### Test Case 2: Deposit + Loss Trade
1. Deposit $1000 via Quick Actions
2. Verify Current Balance shows $1000
3. Add a trade with -$50 PnL (loss)
4. Verify Current Balance becomes $950

### Test Case 3: Multiple Trades
1. Deposit $1000
2. Add trade with $10 PnL → Balance should be $1010
3. Add trade with -$5 PnL → Balance should be $1005
4. Add trade with $20 PnL → Balance should be $1025

## Expected Behavior
- PnL should always be added to (profits) or subtracted from (losses) the current balance
- Balance should never be replaced, only updated
- Balance calculation should use current actual balance, not historical balance

## Files Modified
- `lib/core/utils/trade_calculator.dart` - Fixed calculateNewBalance method
- `lib/features/trade_list/presentation/pages/trade_list_page.dart` - Updated to handle async call

