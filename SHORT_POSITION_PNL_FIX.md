# Short Position PnL Calculation Fix

## Problem Description
The Trade List section was incorrectly displaying profit/loss for short position trades. The issue was in the PnL calculation logic that was using the legacy `TradeType.buy/sell` enum instead of the new `Side.long/short` enum.

## Root Cause
The PnL calculation was using the old logic:
```dart
final multiplier = trade.type == TradeType.buy ? 1 : -1;
```

This logic was incorrect because:
- `TradeType.buy` was being treated as long positions (multiplier = 1)
- `TradeType.sell` was being treated as short positions (multiplier = -1)

However, the new `Side` enum should be used instead:
- `Side.long` for long positions
- `Side.short` for short positions

## Fixes Applied

### 1. Fixed PnL Calculation in AddTradeUseCase
**File:** `lib/features/add_trade/domain/usecases/add_trade_usecase.dart`

**Before:**
```dart
final multiplier = trade.type == TradeType.buy ? 1 : -1;
```

**After:**
```dart
// Use the new Side enum for proper PnL calculation
double multiplier;
if (trade.side == Side.long) {
  // For long positions: profit when exit price > entry price
  multiplier = 1;
} else if (trade.side == Side.short) {
  // For short positions: profit when exit price < entry price
  multiplier = -1;
} else {
  // Fallback to legacy TradeType for backward compatibility
  multiplier = trade.type == TradeType.buy ? 1 : -1;
}
```

### 2. Fixed PnL Calculation in UpdateTradeUseCase
**File:** `lib/features/add_trade/domain/usecases/update_trade_usecase.dart`

Applied the same fix as above.

### 3. Fixed Legacy calculatePnL() Method
**File:** `lib/features/add_trade/domain/entities/trade.dart`

Applied the same fix to the legacy `calculatePnL()` method.

### 4. Fixed Risk/Reward Ratio Calculation
**Files:** 
- `lib/features/add_trade/domain/usecases/add_trade_usecase.dart`
- `lib/features/add_trade/domain/usecases/update_trade_usecase.dart`
- `lib/features/add_trade/domain/entities/trade.dart`

**Before:**
```dart
final risk = (trade.entryPrice - trade.stopLoss!).abs();
final reward = (trade.takeProfit! - trade.entryPrice).abs();
```

**After:**
```dart
double risk, reward;

if (trade.side == Side.long) {
  // For long positions: risk is entry - stop loss, reward is take profit - entry
  risk = trade.entryPrice - trade.stopLoss!;
  reward = trade.takeProfit! - trade.entryPrice;
} else if (trade.side == Side.short) {
  // For short positions: risk is stop loss - entry, reward is entry - take profit
  risk = trade.stopLoss! - trade.entryPrice;
  reward = trade.entryPrice - trade.takeProfit!;
} else {
  // Fallback to legacy calculation for backward compatibility
  risk = (trade.entryPrice - trade.stopLoss!).abs();
  reward = (trade.takeProfit! - trade.entryPrice).abs();
}
```

### 5. Fixed Risk Amount Calculation
Applied the same logic to risk amount calculations in all use cases.

## How PnL Calculation Works Now

### Long Positions (Side.long)
- **Profit:** When exit price > entry price
- **Loss:** When exit price < entry price
- **Formula:** `(exitPrice - entryPrice) * quantity`

### Short Positions (Side.short)
- **Profit:** When exit price < entry price
- **Loss:** When exit price > entry price
- **Formula:** `(entryPrice - exitPrice) * quantity`

## Backward Compatibility
The fixes maintain backward compatibility by:
1. First checking the new `Side` enum
2. Falling back to the legacy `TradeType` enum if `Side` is not set
3. This ensures existing trades continue to work correctly

## Verification
The `TradeCalculator.calculateGrossProfitLoss()` method was already correctly implemented and uses the proper logic for both long and short positions.

## Impact
- ✅ Short position trades now display correct profit/loss
- ✅ Long position trades continue to work correctly
- ✅ Risk/reward ratios are calculated correctly for both sides
- ✅ Win/Loss indicators work correctly
- ✅ Backward compatibility maintained

## Testing
To verify the fix:
1. Create a short position trade with an exit price lower than entry price
2. Verify it shows as profitable (green)
3. Create a short position trade with an exit price higher than entry price
4. Verify it shows as losing (red)
5. Long position trades should continue to work as before
