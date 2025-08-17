import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';

class TradeListPage extends StatelessWidget {
  const TradeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.list_alt,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Trade List',
              style: AppTheme.headingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon!',
              style: AppTheme.captionStyle,
            ),
            const SizedBox(height: 16),
            Text(
              'This page will show all your trades\nwith filtering and sorting options.',
              style: AppTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
