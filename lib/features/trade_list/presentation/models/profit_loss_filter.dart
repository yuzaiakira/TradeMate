enum ProfitLossFilter {
  all,
  profitable,
  losing,
  breakeven,
}

extension ProfitLossFilterExtension on ProfitLossFilter {
  String get displayName {
    switch (this) {
      case ProfitLossFilter.all:
        return 'All';
      case ProfitLossFilter.profitable:
        return 'Profitable';
      case ProfitLossFilter.losing:
        return 'Losing';
      case ProfitLossFilter.breakeven:
        return 'Breakeven';
    }
  }
  
  String get name {
    switch (this) {
      case ProfitLossFilter.all:
        return 'all';
      case ProfitLossFilter.profitable:
        return 'profitable';
      case ProfitLossFilter.losing:
        return 'losing';
      case ProfitLossFilter.breakeven:
        return 'breakeven';
    }
  }
}
