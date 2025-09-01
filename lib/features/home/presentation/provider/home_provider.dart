import 'package:flutter/foundation.dart';
import '../../domain/entities/trade_statistics.dart';
import '../../../../core/usecases/get_shared_statistics_usecase.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider with ChangeNotifier {
  final GetSharedStatisticsUseCase getSharedStatisticsUseCase;

  HomeProvider(this.getSharedStatisticsUseCase);

  HomeStatus _status = HomeStatus.initial;
  String _errorMessage = '';
  TradeStatistics? _statistics;

  HomeStatus get status => _status;
  String get errorMessage => _errorMessage;
  TradeStatistics? get statistics => _statistics;

  Future<void> loadStatistics() async {
    try {
      _status = HomeStatus.loading;
      notifyListeners();

      _statistics = await getSharedStatisticsUseCase.getHomeStatistics();
      _status = HomeStatus.loaded;
      _errorMessage = '';
      
      notifyListeners();
    } catch (e) {
      _status = HomeStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void refresh() {
    loadStatistics();
  }

  void reset() {
    _status = HomeStatus.initial;
    _errorMessage = '';
    _statistics = null;
    notifyListeners();
  }
}
