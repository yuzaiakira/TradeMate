import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_theme.dart';
import 'core/data/database.dart';
import 'core/data/repositories/user_defined_values_repository.dart';
import 'core/providers/user_defined_values_provider.dart';
import 'features/add_trade/data/repositories/trade_repository_impl.dart';
import 'features/add_trade/domain/repositories/trade_repository.dart';
import 'features/add_trade/domain/usecases/add_trade_usecase.dart';
import 'features/add_trade/domain/usecases/get_trades_usecase.dart';
import 'features/add_trade/domain/usecases/delete_trade_usecase.dart';
import 'features/add_trade/domain/usecases/update_trade_usecase.dart';
import 'features/add_trade/presentation/provider/add_trade_provider.dart';
import 'features/add_trade/presentation/provider/edit_trade_provider.dart';
import 'features/trade_list/presentation/provider/trade_list_provider.dart';
import 'features/home/data/repositories/statistics_repository_impl.dart';
import 'features/home/domain/repositories/statistics_repository.dart';
import 'features/home/domain/usecases/get_statistics_usecase.dart';
import 'features/home/presentation/provider/home_provider.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/add_trade/presentation/pages/add_trade_page.dart';
import 'features/trade_list/presentation/pages/trade_list_page.dart';
import 'features/tools/presentation/pages/tools_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = TradeMateDatabase();
  
  runApp(TradeMateApp(database: database));
}

class TradeMateApp extends StatelessWidget {
  final TradeMateDatabase database;

  const TradeMateApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Database
        Provider<TradeMateDatabase>.value(value: database),
        
        // Repositories
        Provider<TradeRepository>(
          create: (context) => TradeRepositoryImpl(database),
        ),
        Provider<StatisticsRepository>(
          create: (context) => StatisticsRepositoryImpl(database),
        ),
        Provider<UserDefinedValuesRepository>(
          create: (context) => UserDefinedValuesRepositoryImpl(database),
        ),
        
        // Use cases
        Provider<AddTradeUseCase>(
          create: (context) => AddTradeUseCase(
            context.read<TradeRepository>(),
          ),
        ),
        Provider<GetTradesUseCase>(
          create: (context) => GetTradesUseCase(
            context.read<TradeRepository>(),
          ),
        ),
        Provider<DeleteTradeUseCase>(
          create: (context) => DeleteTradeUseCase(
            context.read<TradeRepository>(),
          ),
        ),
        Provider<UpdateTradeUseCase>(
          create: (context) => UpdateTradeUseCase(
            context.read<TradeRepository>(),
          ),
        ),
        Provider<GetStatisticsUseCase>(
          create: (context) => GetStatisticsUseCase(
            context.read<StatisticsRepository>(),
          ),
        ),
        
        // Providers
        ChangeNotifierProvider<AddTradeProvider>(
          create: (context) => AddTradeProvider(
            context.read<AddTradeUseCase>(),
          ),
        ),
        ChangeNotifierProvider<EditTradeProvider>(
          create: (context) => EditTradeProvider(
            updateTradeUseCase: context.read<UpdateTradeUseCase>(),
            getTradesUseCase: context.read<GetTradesUseCase>(),
          ),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(
            context.read<GetStatisticsUseCase>(),
          ),
        ),
        ChangeNotifierProvider<UserDefinedValuesProvider>(
          create: (context) => UserDefinedValuesProvider(
            context.read<UserDefinedValuesRepository>(),
          ),
        ),
        ChangeNotifierProvider<TradeListProvider>(
          create: (context) => TradeListProvider(
            getTradesUseCase: context.read<GetTradesUseCase>(),
            deleteTradeUseCase: context.read<DeleteTradeUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TradeMate',
        theme: AppTheme.lightTheme,
        home: const MainNavigationPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AddTradePage(),
    const TradeListPage(),
    const ToolsPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Load statistics when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Trade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Trade List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Tools',
          ),
        ],
      ),
    );
  }
}
