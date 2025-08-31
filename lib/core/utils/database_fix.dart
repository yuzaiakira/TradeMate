import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../data/database.dart';
import 'logger.dart';

/// Utility class to fix database issues
class DatabaseFix {
  /// Force recreate the database file to resolve schema issues
  static Future<void> forceRecreateDatabase() async {
    try {
      Logger.info('Force recreating database file...');
      
      // Get the database file path
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'trademate.db'));
      
      // Delete the existing database file
      if (await file.exists()) {
        await file.delete();
        Logger.info('Database file deleted successfully');
      }
      
      // Create a new database instance to trigger onCreate
      final database = TradeMateDatabase();
      
      // Test the connection
      await database.getTradesCount();
      
      Logger.info('Database recreated successfully');
    } catch (e) {
      Logger.error('Error recreating database: $e', e);
      rethrow;
    }
  }
  
  /// Check if the database has the required columns
  static Future<bool> verifyDatabaseSchema() async {
    try {
      final database = TradeMateDatabase();
      
      // Check if balance_at_entry column exists
      final hasColumn = await database.hasBalanceAtEntryColumn();
      
      if (hasColumn) {
        Logger.info('Database schema is correct - balance_at_entry column exists');
        return true;
      } else {
        Logger.warning('Database schema is missing balance_at_entry column');
        return false;
      }
    } catch (e) {
      Logger.error('Error verifying database schema: $e', e);
      return false;
    }
  }
  
  /// Manual migration to add missing columns
  static Future<void> manualMigration() async {
    try {
      Logger.info('Starting manual migration...');
      
      final database = TradeMateDatabase();
      
      // Check if column exists
      final hasColumn = await database.hasBalanceAtEntryColumn();
      
      if (!hasColumn) {
        Logger.info('Adding balance_at_entry column manually...');
        
        // Add the column manually
        await database.customStatement(
          'ALTER TABLE trades ADD COLUMN balance_at_entry REAL'
        );
        
        Logger.info('balance_at_entry column added successfully');
      } else {
        Logger.info('balance_at_entry column already exists');
      }
      
    } catch (e) {
      Logger.error('Error during manual migration: $e', e);
      rethrow;
    }
  }
}
