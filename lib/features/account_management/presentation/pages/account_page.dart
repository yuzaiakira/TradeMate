import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_theme.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
import '../widgets/balance_card.dart';
import '../widgets/account_statistics.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    // Load account data when page is opened
    context.read<AccountBloc>().add(const LoadAccountBalance());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Management',
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, size: 20),
            onPressed: () {
              context.read<AccountBloc>().add(const LoadAccountBalance());
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AccountInitial || state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
                strokeWidth: 2,
              ),
            );
          }

          if (state is AccountError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading account',
                    style: AppTheme.subheadingStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppTheme.captionStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AccountBloc>().add(const LoadAccountBalance());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }



          if (state is AccountLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AccountBloc>().add(const LoadAccountBalance());
              },
              color: AppTheme.primaryColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Overview Card
                    BalanceCard(balance: state.balance),
                    
                    const SizedBox(height: 12),
                    

                    
                    // Account Statistics
                    AccountStatistics(
                      totalDeposits: state.totalDeposits,
                      totalWithdrawals: state.totalWithdrawals,
                      totalTradePnL: state.totalTradePnL,
                    ),
                    
                    const SizedBox(height: 12),
                    

                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }


}


