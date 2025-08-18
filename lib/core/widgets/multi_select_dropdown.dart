import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onChanged;
  final Function(String) onAddNewValue;
  final bool allowMultiple;
  final String hintText;
  final bool showSearch;

  const MultiSelectDropdown({
    Key? key,
    required this.label,
    required this.prefixIcon,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    required this.onAddNewValue,
    this.allowMultiple = true,
    this.hintText = 'Select options',
    this.showSearch = true,
  }) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isDropdownOpen = false;
  List<String> _filteredOptions = [];
  String _newValue = '';

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _searchController.addListener(_filterOptions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _filterOptions() {
    final searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
      if (_isDropdownOpen) {
        _searchController.clear();
        _filteredOptions = widget.options;
      }
    });
  }

  void _selectValue(String value) {
    List<String> newSelectedValues = List.from(widget.selectedValues);
    
    if (widget.allowMultiple) {
      if (newSelectedValues.contains(value)) {
        newSelectedValues.remove(value);
      } else {
        newSelectedValues.add(value);
      }
    } else {
      newSelectedValues = [value];
    }
    
    widget.onChanged(newSelectedValues);
    
    if (!widget.allowMultiple) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  void _addNewValue() {
    if (_newValue.trim().isNotEmpty) {
      widget.onAddNewValue(_newValue.trim());
      _newValue = '';
      _searchController.clear();
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  String _getDisplayText() {
    if (widget.selectedValues.isEmpty) {
      return widget.hintText;
    }
    
    if (widget.selectedValues.length == 1) {
      return widget.selectedValues.first;
    }
    
    return '${widget.selectedValues.length} items selected';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.borderColor),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Icon(
                  widget.prefixIcon,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getDisplayText(),
                    style: TextStyle(
                      color: widget.selectedValues.isEmpty 
                          ? AppTheme.textSecondaryColor 
                          : AppTheme.textPrimaryColor,
                    ),
                  ),
                ),
                Icon(
                  _isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppTheme.textSecondaryColor,
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownOpen) ...[
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.borderColor),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showSearch) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: (_) => _addNewValue(),
                    ),
                  ),
                  const Divider(height: 1),
                ],
                if (widget.showSearch) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Add new value...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            onChanged: (value) => _newValue = value,
                            onSubmitted: (_) => _addNewValue(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addNewValue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                ],
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredOptions.length,
                    itemBuilder: (context, index) {
                      final option = _filteredOptions[index];
                      final isSelected = widget.selectedValues.contains(option);
                      
                      return ListTile(
                        dense: true,
                        title: Text(
                          option,
                          style: TextStyle(
                            color: isSelected 
                                ? AppTheme.primaryColor 
                                : AppTheme.textPrimaryColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        leading: Checkbox(
                          value: isSelected,
                          onChanged: (_) => _selectValue(option),
                          activeColor: AppTheme.primaryColor,
                        ),
                        onTap: () => _selectValue(option),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
