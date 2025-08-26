import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ChecklistWidget extends StatefulWidget {
  final List<String> selectedItems;
  final List<String> availableItems;
  final Function(List<String>) onSelectionChanged;
  final String? label;
  final String? hint;

  const ChecklistWidget({
    super.key,
    required this.selectedItems,
    required this.availableItems,
    required this.onSelectionChanged,
    this.label,
    this.hint,
  });

  @override
  State<ChecklistWidget> createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showAllItems = false;

  List<String> get filteredItems {
    if (_searchQuery.isEmpty) {
      return widget.availableItems;
    }
    return widget.availableItems
        .where((item) => item.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<String> get displayedItems {
    if (_showAllItems) {
      return filteredItems;
    }
    // Show selected items first, then up to 3 more items
    final selected = filteredItems.where((item) => widget.selectedItems.contains(item)).toList();
    final unselected = filteredItems.where((item) => !widget.selectedItems.contains(item)).take(3).toList();
    return [...selected, ...unselected];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Search bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search checklist items...',
            hintText: widget.hint ?? 'Type to search items',
            prefixIcon: const Icon(
              Icons.search,
              color: AppTheme.textSecondaryColor,
              size: 20,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppTheme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: AppTheme.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: AppTheme.surfaceColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            labelStyle: const TextStyle(
              color: AppTheme.textSecondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: const TextStyle(
              color: AppTheme.textTertiaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),

        const SizedBox(height: 12),

        // Checklist items
        if (widget.availableItems.isEmpty)
          _buildEmptyState()
        else
          _buildChecklistItems(),

        // Show more/less button
        if (filteredItems.length > 4 && !_searchQuery.isNotEmpty) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _showAllItems = !_showAllItems;
              });
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _showAllItems ? Icons.expand_less : Icons.expand_more,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  _showAllItems ? 'Show less' : 'Show more',
                  style: AppTheme.captionStyle.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],

        // Selected items summary
        if (widget.selectedItems.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${widget.selectedItems.length} item${widget.selectedItems.length == 1 ? '' : 's'} selected',
                    style: AppTheme.captionStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onSelectionChanged([]);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    'Clear all',
                    style: AppTheme.captionStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Icon(
            Icons.checklist,
            size: 32,
            color: AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            'No checklist items available',
            style: AppTheme.bodyStyle.copyWith(
              color: AppTheme.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Go to Manage Values to add checklist items',
            style: AppTheme.captionStyle.copyWith(
              color: AppTheme.textTertiaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItems() {
    return Column(
      children: displayedItems.map((item) {
        final isSelected = widget.selectedItems.contains(item);
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppTheme.primaryColor.withValues(alpha: 0.1)
                : AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected 
                  ? AppTheme.primaryColor.withValues(alpha: 0.3)
                  : AppTheme.borderColor,
            ),
          ),
          child: CheckboxListTile(
            value: isSelected,
            onChanged: (bool? value) {
              final newSelection = List<String>.from(widget.selectedItems);
              if (value == true) {
                if (!newSelection.contains(item)) {
                  newSelection.add(item);
                }
              } else {
                newSelection.remove(item);
              }
              widget.onSelectionChanged(newSelection);
            },
            title: Text(
              item,
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: AppTheme.primaryColor,
            checkColor: Colors.white,
          ),
        );
      }).toList(),
    );
  }
}
