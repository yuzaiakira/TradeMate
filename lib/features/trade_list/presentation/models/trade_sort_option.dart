enum TradeSortOption {
  dateDesc,
  dateAsc,
  symbolAsc,
  symbolDesc,
  pnlDesc,
  pnlAsc,
  ratingDesc,
  ratingAsc,
}

extension TradeSortOptionExtension on TradeSortOption {
  String get displayName {
    switch (this) {
      case TradeSortOption.dateDesc:
        return 'Date (Newest)';
      case TradeSortOption.dateAsc:
        return 'Date (Oldest)';
      case TradeSortOption.symbolAsc:
        return 'Symbol (A-Z)';
      case TradeSortOption.symbolDesc:
        return 'Symbol (Z-A)';
      case TradeSortOption.pnlDesc:
        return 'PnL (Highest)';
      case TradeSortOption.pnlAsc:
        return 'PnL (Lowest)';
      case TradeSortOption.ratingDesc:
        return 'Rating (Highest)';
      case TradeSortOption.ratingAsc:
        return 'Rating (Lowest)';
    }
  }
}
