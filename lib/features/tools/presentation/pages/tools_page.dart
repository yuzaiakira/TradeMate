import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Trading Tools',
              style: AppTheme.headingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon!',
              style: AppTheme.captionStyle,
            ),
            const SizedBox(height: 16),
            Text(
              'This page will contain various\ntrading tools and calculators.',
              style: AppTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
