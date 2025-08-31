import 'package:flutter_test/flutter_test.dart';
import 'lib/core/data/database.dart';
import 'lib/core/utils/database_fix.dart';

void main() {
  group('Database Migration Tests', () {
    test('Database should have balance_at_entry column after migration', () async {
      // Create a test database
      final database = TradeMateDatabase();
      
      // Trigger migration
      await database.triggerMigration();
      
      // Verify the column exists
      final hasColumn = await database.hasBalanceAtEntryColumn();
      
      expect(hasColumn, isTrue, reason: 'balance_at_entry column should exist after migration');
      
      // Clean up
      await database.close();
    });
    
    test('DatabaseFix utility should work correctly', () async {
      // Test schema verification
      final isValid = await DatabaseFix.verifyDatabaseSchema();
      expect(isValid, isTrue, reason: 'Database schema should be valid after migration');
    });
  });
}
