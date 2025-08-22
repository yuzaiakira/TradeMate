import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/providers/user_defined_values_provider.dart';

class ManageValuesPage extends StatefulWidget {
  const ManageValuesPage({super.key});

  @override
  State<ManageValuesPage> createState() => _ManageValuesPageState();
}

class _ManageValuesPageState extends State<ManageValuesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  final Map<String, Map<String, dynamic>> _categories = {
    'symbols': {
      'title': 'Trading Pairs',
      'icon': Icons.currency_exchange,
      'description': 'Manage your trading pairs (e.g., BTC/USDT, ETH/USD)',
      'hint': 'Add new trading pair...',
    },
    'exchanges': {
      'title': 'Exchanges',
      'icon': Icons.swap_horiz,
      'description': 'Manage your trading exchanges (e.g., Binance, Coinbase)',
      'hint': 'Add new exchange...',
    },
    'strategies': {
      'title': 'Strategies',
      'icon': Icons.trending_up,
      'description': 'Manage your trading strategies (e.g., Swing, Scalping)',
      'hint': 'Add new strategy...',
    },
    'entryFeeRates': {
      'title': 'Entry Fee Rates',
      'icon': Icons.percent,
      'description': 'Manage your entry fee rates (e.g., 0.1%, 0.2%)',
      'hint': 'Add new fee rate...',
    },
    'exitFeeRates': {
      'title': 'Exit Fee Rates',
      'icon': Icons.percent,
      'description': 'Manage your exit fee rates (e.g., 0.1%, 0.2%)',
      'hint': 'Add new fee rate...',
    },
    'entryMentalStates': {
      'title': 'Entry Mental States',
      'icon': Icons.psychology,
      'description':
          'Manage your entry mental states (e.g., Confident, Nervous)',
      'hint': 'Add new mental state...',
    },
    'exitMentalStates': {
      'title': 'Exit Mental States',
      'icon': Icons.psychology,
      'description':
          'Manage your exit mental states (e.g., Satisfied, Regretful)',
      'hint': 'Add new mental state...',
    },
    'trackings': {
      'title': 'Analysis Methods',
      'icon': Icons.track_changes,
      'description':
          'Manage your analysis methods (e.g., Technical, Fundamental)',
      'hint': 'Add new analysis method...',
    },
    'mistakes': {
      'title': 'Mistake Types',
      'icon': Icons.error,
      'description':
          'Manage your mistake categories (e.g., FOMO, Over-leveraged)',
      'hint': 'Add new mistake type...',
    },
  };

  @override
  void initState() {
    super.initState();
    // Load all values when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserDefinedValuesProvider>().loadAllValues();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Values',
          style: AppTheme.subheadingStyle.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded, size: 20),
            onPressed: () => _showHelpDialog(context),
            tooltip: 'Help',
          ),
        ],
      ),
      body: Consumer<UserDefinedValuesProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Search and filter section
              _buildSearchSection(),

              // Categories grid
              Expanded(
                child: _selectedCategory == null
                    ? _buildCategoriesGrid(provider)
                    : _buildValuesList(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderColor, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search values...',
              hintText: 'Type to search across all categories',
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
                _searchQuery = value.toLowerCase();
              });
            },
          ),

          if (_selectedCategory != null) ...[
            const SizedBox(height: 12),
            // Back button
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selectedCategory = null;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    _categories[_selectedCategory!]!['title'],
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(UserDefinedValuesProvider provider) {
    final filteredCategories = _categories.entries.where((entry) {
      if (_searchQuery.isEmpty) return true;
      return entry.value['title'].toLowerCase().contains(_searchQuery) ||
          entry.value['description'].toLowerCase().contains(_searchQuery);
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) {
        final category = filteredCategories[index];
        final categoryKey = category.key;
        final categoryData = category.value;

        return _buildCategoryCard(categoryKey, categoryData, provider);
      },
    );
  }

  Widget _buildCategoryCard(
    String categoryKey,
    Map<String, dynamic> categoryData,
    UserDefinedValuesProvider provider,
  ) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = categoryKey;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    categoryData['icon'],
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      categoryData['title'],
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                categoryData['description'],
                style: AppTheme.captionStyle.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              FutureBuilder<List<String>>(
                future: provider.getValues(categoryKey),
                builder: (context, snapshot) {
                  final count = snapshot.data?.length ?? 0;
                  return Row(
                    children: [
                      Icon(
                        Icons.list,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$count items',
                        style: AppTheme.captionStyle.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValuesList(UserDefinedValuesProvider provider) {
    final categoryData = _categories[_selectedCategory!]!;

    return FutureBuilder<List<String>>(
      future: provider.getValues(_selectedCategory!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final values = snapshot.data ?? [];
        final filteredValues = values.where((value) {
          if (_searchQuery.isEmpty) return true;
          return value.toLowerCase().contains(_searchQuery);
        }).toList();

        return Column(
          children: [
            // Add new value section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                border: Border(
                  bottom: BorderSide(color: AppTheme.borderColor, width: 1),
                ),
              ),
              child: _buildAddValueSection(provider, categoryData),
            ),

            // Values list
            Expanded(
              child: filteredValues.isEmpty
                  ? _buildEmptyState(categoryData)
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: filteredValues.length,
                      itemBuilder: (context, index) {
                        return _buildValueItem(filteredValues[index], provider);
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddValueSection(
    UserDefinedValuesProvider provider,
    Map<String, dynamic> categoryData,
  ) {
    final TextEditingController addController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: addController,
            decoration: AppTheme.inputDecoration(
              labelText: 'Add new ${categoryData['title'].toLowerCase()}',
              hintText: categoryData['hint'],
              prefixIcon: Icons.add,
            ),
            onSubmitted: (value) async {
              if (value.trim().isNotEmpty) {
                await provider.addValue(_selectedCategory!, value.trim());
                addController.clear();
                setState(() {}); // Refresh the list
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () async {
            final value = addController.text.trim();
            if (value.isNotEmpty) {
              await provider.addValue(_selectedCategory!, value);
              addController.clear();
              setState(() {}); // Refresh the list
            }
          },
          style: AppTheme.primaryButtonStyle,
          child: const Text('Add'),
        ),
      ],
    );
  }

  Widget _buildValueItem(String value, UserDefinedValuesProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: AppTheme.cardDecoration,
      child: ListTile(
        leading: Icon(
          _categories[_selectedCategory!]!['icon'],
          color: AppTheme.primaryColor,
          size: 20,
        ),
        title: Text(
          value,
          style: AppTheme.bodyStyle.copyWith(color: AppTheme.textPrimaryColor),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () => _showDeleteDialog(value, provider),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Map<String, dynamic> categoryData) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            categoryData['icon'],
            size: 64,
            color: AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No ${categoryData['title'].toLowerCase()} yet',
            style: AppTheme.bodyStyle.copyWith(
              color: AppTheme.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first ${categoryData['title'].toLowerCase()} above',
            style: AppTheme.captionStyle.copyWith(
              color: AppTheme.textTertiaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(String value, UserDefinedValuesProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Value'),
        content: Text('Are you sure you want to delete "$value"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await provider.removeValue(_selectedCategory!, value);
              if (mounted && context.mounted) {
                Navigator.of(context).pop();
                setState(() {}); // Refresh the list
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help_outline, color: AppTheme.primaryColor, size: 24),
            const SizedBox(width: 8),
            const Text('Manage Values'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This page helps you manage all your custom values used in the trade form.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• View all categories of values'),
              Text('• Add new values to any category'),
              Text('• Remove unwanted values'),
              Text('• Search across all values'),
              Text('• Values are automatically saved'),
              SizedBox(height: 16),
              Text(
                'Categories:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Trading Pairs (BTC/USDT, ETH/USD)'),
              Text('• Exchanges (Binance, Coinbase)'),
              Text('• Strategies (Swing, Scalping)'),
              Text('• Fee Rates (0.1%, 0.2%)'),
              Text('• Mental States (Confident, Nervous)'),
              Text('• Analysis Methods (Technical, Fundamental)'),
              Text('• Mistake Types (FOMO, Over-leveraged)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
