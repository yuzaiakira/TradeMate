import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/navigation_service.dart';
import 'core/data/database.dart';
import 'core/data/repositories/user_defined_values_repository.dart';
import 'core/providers/user_defined_values_provider.dart';
import 'features/add_trade/data/repositories/trade_repository_impl.dart';
import 'features/add_trade/domain/repositories/trade_repository.dart';
import 'features/add_trade/domain/usecases/add_trade_usecase.dart';
import 'features/add_trade/domain/usecases/get_trades_usecase.dart';
import 'features/add_trade/domain/usecases/get_trades_paginated_usecase.dart';
import 'features/add_trade/domain/usecases/get_trades_count_usecase.dart';
import 'features/add_trade/domain/usecases/get_trade_statistics_optimized_usecase.dart';
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
        Provider<GetTradesPaginatedUseCase>(
          create: (context) => GetTradesPaginatedUseCase(
            context.read<TradeRepository>(),
          ),
        ),
        Provider<GetTradesCountUseCase>(
          create: (context) => GetTradesCountUseCase(
            context.read<TradeRepository>(),
          ),
        ),
        Provider<GetTradeStatisticsOptimizedUseCase>(
          create: (context) => GetTradeStatisticsOptimizedUseCase(
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
          create: (context) {
            final provider = AddTradeProvider(
              context.read<AddTradeUseCase>(),
            );
            // Set up callback to refresh trade list when a trade is added
            provider.setOnTradeAddedCallback(() {
              // Use a post-frame callback to ensure the provider is available
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.read<TradeListProvider>().refreshSilently();
                }
              });
            });
            return provider;
          },
        ),
        ChangeNotifierProvider<EditTradeProvider>(
          create: (context) {
            final provider = EditTradeProvider(
              updateTradeUseCase: context.read<UpdateTradeUseCase>(),
              getTradesUseCase: context.read<GetTradesUseCase>(),
            );
            // Set up callback to refresh trade list when a trade is updated
            provider.setOnTradeUpdatedCallback(() {
              // Use a post-frame callback to ensure the provider is available
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.read<TradeListProvider>().refreshSilently();
                }
              });
            });
            return provider;
          },
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
          create: (context) {
            final provider = TradeListProvider(
              getTradesUseCase: context.read<GetTradesUseCase>(),
              getTradesPaginatedUseCase: context.read<GetTradesPaginatedUseCase>(),
              getTradesCountUseCase: context.read<GetTradesCountUseCase>(),
              getTradeStatisticsOptimizedUseCase: context.read<GetTradeStatisticsOptimizedUseCase>(),
              deleteTradeUseCase: context.read<DeleteTradeUseCase>(),
            );
            // Set up callback to show feedback when trades are refreshed
            provider.setOnTradesRefreshedCallback(() {
              // Use a post-frame callback to ensure the context is available
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Trade list updated'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              });
            });
            return provider;
          },
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
  int currentIndex = 0;
  late List<Widget> _pages;

  // Navigation callback function
  void navigateToTab(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        currentIndex = index;
      });
      
      // Refresh trade list when navigating to it
      if (index == 2) { // Trade List tab
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<TradeListProvider>().loadTrades();
        });
      }
      
      // Refresh home statistics when navigating to home
      if (index == 0) { // Home tab
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<HomeProvider>().loadStatistics();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    
    // Set up navigation service callback
    NavigationService().setNavigateToTabCallback(navigateToTab);
    
    // Initialize pages with navigation callback
    _pages = [
      const HomePage(),
      const AddTradePage(),
      TradeListPage(onNavigateToTab: navigateToTab),
      const ToolsPage(),
    ];
    
    // Load statistics when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (didPop) return; // App is already popping
        
        // If not on home tab, navigate to home instead of exiting
        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });
          
          // Show feedback to user
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Navigated to Home'),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          // Refresh home statistics when navigating to home
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeProvider>().loadStatistics();
          });
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          
          // Reset add trade provider when navigating to add trade tab
          if (index == 1) { // Add Trade tab
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AddTradeProvider>().reset();
            });
          }
          
          // Refresh trade list when navigating to it
          if (index == 2) { // Trade List tab
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TradeListProvider>().loadTrades();
            });
          }
          
          // Refresh home statistics when navigating to home
          if (index == 0) { // Home tab
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<HomeProvider>().loadStatistics();
            });
          }
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
      ),
    );
  }
}
