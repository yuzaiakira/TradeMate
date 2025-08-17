import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/trade.dart';
import '../provider/add_trade_provider.dart';
import '../../../../core/utils/app_theme.dart';

class AddTradePage extends StatelessWidget {
  const AddTradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Trade'),
      ),
      body: Consumer<AddTradeProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trade Type Selection
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trade Type',
                          style: AppTheme.subheadingStyle,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTypeButton(
                                context,
                                provider,
                                TradeType.buy,
                                'BUY',
                                Icons.trending_up,
                                AppTheme.successColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTypeButton(
                                context,
                                provider,
                                TradeType.sell,
                                'SELL',
                                Icons.trending_down,
                                AppTheme.errorColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Basic Trade Information
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trade Details',
                          style: AppTheme.subheadingStyle,
                        ),
                        const SizedBox(height: 16),
                        
                        // Symbol
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Symbol',
                            hintText: 'e.g., AAPL, TSLA, EURUSD',
                            prefixIcon: Icons.currency_exchange,
                          ),
                          controller: TextEditingController(text: provider.symbol),
                          onChanged: provider.updateSymbol,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Entry Price
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Entry Price',
                            hintText: '0.00',
                            prefixIcon: Icons.attach_money,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final price = double.tryParse(value) ?? 0.0;
                            provider.updateEntryPrice(price);
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Quantity
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Quantity',
                            hintText: '0',
                            prefixIcon: Icons.shopping_cart,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final quantity = double.tryParse(value) ?? 0.0;
                            provider.updateQuantity(quantity);
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Account Balance
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Account Balance',
                            hintText: '0.00',
                            prefixIcon: Icons.account_balance_wallet,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final balance = double.tryParse(value) ?? 0.0;
                            provider.updateAccountBalance(balance);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Risk Management
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Risk Management',
                          style: AppTheme.subheadingStyle,
                        ),
                        const SizedBox(height: 16),
                        
                        // Stop Loss
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Stop Loss (Optional)',
                            hintText: '0.00',
                            prefixIcon: Icons.stop_circle,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final stopLoss = double.tryParse(value);
                            provider.updateStopLoss(stopLoss);
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Take Profit
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Take Profit (Optional)',
                            hintText: '0.00',
                            prefixIcon: Icons.trending_up,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            final takeProfit = double.tryParse(value);
                            provider.updateTakeProfit(takeProfit);
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Risk/Reward Display
                        if (provider.riskAmount != null || provider.riskRewardRatio != null)
                          _buildRiskRewardInfo(provider),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Notes
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes (Optional)',
                          style: AppTheme.subheadingStyle,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: AppTheme.inputDecoration(
                            labelText: 'Trade Notes',
                            hintText: 'Enter any additional notes about this trade...',
                            prefixIcon: Icons.note,
                          ),
                          maxLines: 3,
                          onChanged: provider.updateNotes,
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.isFormValid ? provider.addTrade : null,
                    style: AppTheme.primaryButtonStyle.copyWith(
                      minimumSize: const WidgetStatePropertyAll(Size(0, 50)),
                    ),
                    child: _buildSubmitButtonContent(provider),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Error Message
                if (provider.status == AddTradeStatus.error)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.errorColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.errorColor),
                    ),
                    child: Text(
                      provider.errorMessage,
                      style: TextStyle(color: AppTheme.errorColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                // Success Message
                if (provider.status == AddTradeStatus.success)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.successColor),
                    ),
                    child: Text(
                      'Trade added successfully!',
                      style: TextStyle(color: AppTheme.successColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeButton(
    BuildContext context,
    AddTradeProvider provider,
    TradeType type,
    String label,
    IconData icon,
    Color color,
  ) {
    final isSelected = provider.type == type;
    
    return GestureDetector(
      onTap: () => provider.updateType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : AppTheme.textSecondaryColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : AppTheme.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskRewardInfo(AddTradeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Risk Analysis',
            style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          if (provider.riskAmount != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Risk Amount:', style: AppTheme.captionStyle),
                Text(
                  '\$${provider.riskAmount!.toStringAsFixed(2)}',
                  style: AppTheme.numberStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
          if (provider.riskRewardRatio != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Risk/Reward Ratio:', style: AppTheme.captionStyle),
                Text(
                  provider.riskRewardRatio!.toStringAsFixed(2),
                  style: AppTheme.numberStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmitButtonContent(AddTradeProvider provider) {
    switch (provider.status) {
      case AddTradeStatus.loading:
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text('Adding Trade...'),
          ],
        );
      default:
        return const Text('Add Trade');
    }
  }
}
