import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../add_trade/domain/entities/trade.dart';

class TradeCard extends StatelessWidget {
  final Trade trade;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TradeCard({
    super.key,
    required this.trade,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with symbol, status, and actions
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              trade.symbol,
                              style: AppTheme.bodyStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildStatusChip(trade.status),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDateTime(trade.datetime),
                          style: AppTheme.captionStyle.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action buttons
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit();
                          break;
                        case 'delete':
                          onDelete();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Trade details
              Row(
                children: [
                  Expanded(
                    child: _buildDetailColumn('Entry', '\$${trade.entryPrice.toStringAsFixed(2)}'),
                  ),
                  if (trade.side != null) ...[
                    Expanded(
                      child: _buildDetailColumn('Side', trade.side!.name.toUpperCase()),
                    ),
                  ],
                  if (trade.quantity > 0) ...[
                    Expanded(
                      child: _buildDetailColumn('Quantity', trade.quantity.toStringAsFixed(4)),
                    ),
                  ],
                ],
              ),
              
              // PnL and rating row
              if (trade.pnl != null || trade.rating != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (trade.pnl != null) ...[
                      Expanded(
                        child: _buildPnLIndicator(trade.pnl!),
                      ),
                    ],
                    if (trade.rating != null) ...[
                      const SizedBox(width: 12),
                      _buildRatingIndicator(trade.rating!),
                    ],
                  ],
                ),
              ],
              
              // Additional info
              if (trade.memo?.isNotEmpty == true || trade.exchanges?.isNotEmpty == true) ...[
                const SizedBox(height: 12),
                if (trade.exchanges?.isNotEmpty == true) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.swap_horiz,
                        size: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trade.exchanges!,
                        style: AppTheme.captionStyle.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
                if (trade.memo?.isNotEmpty == true) ...[
                  const SizedBox(height: 4),
                  Text(
                    trade.memo!,
                    style: AppTheme.captionStyle.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(TradeStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case TradeStatus.open:
        backgroundColor = AppTheme.warningColor;
        textColor = Colors.white;
        text = 'OPEN';
        break;
      case TradeStatus.closed:
        backgroundColor = AppTheme.bullishColor;
        textColor = Colors.white;
        text = 'CLOSED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: AppTheme.labelStyle.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.captionStyle.copyWith(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTheme.bodyStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPnLIndicator(double pnl) {
    final isPositive = pnl > 0;
    final color = isPositive ? AppTheme.bullishColor : AppTheme.bearishColor;
    final icon = isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            '\$${pnl.toStringAsFixed(2)}',
            style: AppTheme.captionStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingIndicator(int rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 14,
            color: Colors.amber,
          ),
          const SizedBox(width: 4),
          Text(
            '$rating',
            style: AppTheme.captionStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
