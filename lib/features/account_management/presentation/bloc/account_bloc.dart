import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/usecases/get_account_balance_usecase.dart';
import '../../domain/usecases/update_balance_usecase.dart';
import '../../domain/usecases/add_transaction_usecase.dart' as usecase;
import '../../../../core/usecases/usecase.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountBalance getAccountBalance;
  final UpdateBalance updateBalance;
  final usecase.AddTransaction addTransaction;
  final AccountRepository accountRepository;

  AccountBloc({
    required this.getAccountBalance,
    required this.updateBalance,
    required this.addTransaction,
    required this.accountRepository,
  }) : super(const AccountInitial()) {
    on<LoadAccountBalance>(_onLoadAccountBalance);
    on<UpdateAccountBalance>(_onUpdateAccountBalance);
    on<AddToBalance>(_onAddToBalance);
    on<AddTransaction>(_onAddTransaction);
    on<LoadTransactionHistory>(_onLoadTransactionHistory);
    on<ProcessTradeResult>(_onProcessTradeResult);
  }

  Future<void> _onLoadAccountBalance(
    LoadAccountBalance event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    try {
      final balance = await getAccountBalance(const NoParams());
      
      if (balance != null) {
        // Load recent transactions
        final transactions = await accountRepository.getTransactionHistory(limit: 10);
        
        // Load statistics
        final totalDeposits = await accountRepository.getTotalDeposits();
        final totalWithdrawals = await accountRepository.getTotalWithdrawals();
        final totalTradePnL = await accountRepository.getTotalTradePnL();

        emit(AccountLoaded(
          balance: balance,
          transactions: transactions,
          totalDeposits: totalDeposits,
          totalWithdrawals: totalWithdrawals,
          totalTradePnL: totalTradePnL,
        ));
      } else {
        emit(const AccountError(message: 'No account balance found'));
      }
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onUpdateAccountBalance(
    UpdateAccountBalance event,
    Emitter<AccountState> emit,
  ) async {
    try {
      await updateBalance(UpdateBalanceParams(
        newBalance: event.newBalance,
        note: event.note,
      ));
      
      // Reload account data
      add(const LoadAccountBalance());
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onAddToBalance(
    AddToBalance event,
    Emitter<AccountState> emit,
  ) async {
    final currentState = state;
    if (currentState is AccountLoaded) {
      try {
        final newBalance = currentState.balance.balance + event.amount;
        
        await updateBalance(UpdateBalanceParams(
          newBalance: newBalance,
          note: event.note,
        ));

        // Reload account data
        add(const LoadAccountBalance());
      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<AccountState> emit,
  ) async {
    try {
      await addTransaction(event.transaction);
      
      // Reload account data
      add(const LoadAccountBalance());
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> _onLoadTransactionHistory(
    LoadTransactionHistory event,
    Emitter<AccountState> emit,
  ) async {
    try {
      final transactions = await accountRepository.getTransactionHistory(
        fromDate: event.fromDate,
        toDate: event.toDate,
        type: event.type,
        limit: event.limit,
      );

      emit(TransactionHistoryLoaded(transactions: transactions));
    } catch (e) {
      emit(TransactionHistoryError(message: e.toString()));
    }
  }

  Future<void> _onProcessTradeResult(
    ProcessTradeResult event,
    Emitter<AccountState> emit,
  ) async {
    try {
      await accountRepository.processTradeResult(
        tradeId: event.tradeId,
        pnl: event.pnl,
        fees: event.fees,
        balanceBefore: event.balanceBefore,
      );

      // Reload account data
      add(const LoadAccountBalance());
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }
}
