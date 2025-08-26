import '../database.dart';
import 'package:drift/drift.dart';

abstract class UserDefinedValuesRepository {
  Future<List<String>> getValues(String category);
  Future<List<String>> getDefaultValues(String category);
  Future<void> addValue(String category, String value);
  Future<void> removeValue(String category, String value);
  Future<void> setDefaultValue(String category, String value, bool isDefault);
  Future<void> initializeDefaultValues();
}

class UserDefinedValuesRepositoryImpl implements UserDefinedValuesRepository {
  final TradeMateDatabase database;

  UserDefinedValuesRepositoryImpl(this.database);

  @override
  Future<List<String>> getValues(String category) async {
    try {
      final values = await database.getUserDefinedValues(category);
      return values.map((v) => v.value).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<String>> getDefaultValues(String category) async {
    try {
      final values = await database.getDefaultValues(category);
      return values.map((v) => v.value).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addValue(String category, String value) async {
    try {
      final now = DateTime.now();
      await database.insertUserDefinedValue(
        UserDefinedValuesCompanion(
          category: Value(category),
          value: Value(value),
          isDefault: const Value(false),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    } catch (e) {
      // Value might already exist, ignore
    }
  }

  @override
  Future<void> removeValue(String category, String value) async {
    try {
      final values = await database.getUserDefinedValues(category);
      final valueToDelete = values.where((v) => v.value == value).firstOrNull;
      if (valueToDelete != null) {
        await database.deleteUserDefinedValue(valueToDelete.id);
      }
    } catch (e) {
      // Ignore errors
    }
  }

  @override
  Future<void> setDefaultValue(String category, String value, bool isDefault) async {
    try {
      await database.setDefaultValue(category, value, isDefault);
    } catch (e) {
      // Ignore errors
    }
  }

  @override
  Future<void> initializeDefaultValues() async {
    // Initialize with default values if they don't exist
    await _initializeCategory('exchanges', [
      'Binance',
      'Coinbase',
      'Kraken',
      'Kucoin',
      'Bybit',
      'OKX',
      'Gate.io',
      'Huobi',
    ]);

    await _initializeCategory('symbols', [
      'BTCUSDT',
      'ETHUSDT',
      'BNBUSDT',
      'ADAUSDT',
      'SOLUSDT',
      'DOTUSDT',
      'LINKUSDT',
      'MATICUSDT',
    ]);

    await _initializeCategory('strategies', [
      'Swing Trading',
      'Day Trading',
      'Scalping',
      'Position Trading',
      'Trend Following',
      'Mean Reversion',
      'Breakout Trading',
      'Grid Trading',
    ]);

    await _initializeCategory('entryFeeRates', [
      '0.001',
      '0.002',
      '0.005',
      '0.01',
      '0.02',
      '0.05',
    ]);

    await _initializeCategory('entryMentalStates', [
      'Confident',
      'Nervous',
      'Excited',
      'Calm',
      'Anxious',
      'Focused',
      'Relaxed',
      'Stressed',
    ]);

    await _initializeCategory('exitFeeRates', [
      '0.001',
      '0.002',
      '0.005',
      '0.01',
      '0.02',
      '0.05',
    ]);

    await _initializeCategory('exitMentalStates', [
      'Satisfied',
      'Disappointed',
      'Relieved',
      'Excited',
      'Calm',
      'Stressed',
      'Happy',
      'Frustrated',
    ]);

    await _initializeCategory('trackings', [
      'Price Action',
      'Volume',
      'Indicators',
      'News',
      'Sentiment',
      'Order Flow',
      'Market Structure',
      'Support/Resistance',
    ]);

    await _initializeCategory('mistakes', [
      'FOMO',
      'Revenge Trading',
      'Over-leveraging',
      'No Stop Loss',
      'Emotional Trading',
      'Overtrading',
      'Not Following Plan',
      'None',
    ]);

    await _initializeCategory('checklist', [
      'Check market trend',
      'Set stop loss',
      'Set take profit',
      'Check risk/reward ratio',
      'Verify position size',
      'Check news/events',
      'Review trading plan',
      'Check market volatility',
      'Verify entry price',
      'Check trading volume',
      'Review technical indicators',
      'Check support/resistance levels',
      'Verify leverage settings',
      'Check account balance',
      'Review previous trades',
    ]);
  }

  Future<void> _initializeCategory(String category, List<String> defaultValues) async {
    try {
      final existingValues = await getValues(category);
      if (existingValues.isEmpty) {
        final now = DateTime.now();
        for (final value in defaultValues) {
          await database.insertUserDefinedValue(
            UserDefinedValuesCompanion(
              category: Value(category),
              value: Value(value),
              isDefault: const Value(false),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
        }
      }
    } catch (e) {
      // Ignore errors
    }
  }
}
