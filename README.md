# TradeMate - Comprehensive Trading Journal App

A Flutter application for traders to record and analyze their trades, track performance, and make better trading decisions using statistical and graphical tools.

## Features

### 🏠 Home Dashboard
- **Account Growth Chart**: Visual representation of account performance over time
- **Trading Statistics**: Comprehensive overview of trading performance
  - Total Trades, Win Rate, Overall PnL
  - Average Achieved R, Open Positions, Account Balance
  - Detailed statistics with profit factor and trade duration analysis

### ➕ Add Trade
- **Trade Entry Form**: Complete trade recording with validation
- **Risk Management**: Stop loss and take profit calculations
- **Real-time Calculations**: Automatic risk/reward ratio and risk amount calculation
- **Trade Type Selection**: Support for both BUY and SELL trades

### 📋 Trade List (Coming Soon)
- View all trades with filtering and sorting options
- Trade details and performance analysis
- Export and sharing capabilities

### 🛠️ Tools (Coming Soon)
- Trading calculators and analysis tools
- Educational content and resources
- Advanced charting and technical analysis

## Architecture

This app follows **Clean Architecture** principles with a **Feature-first** organization:

```
lib/
├── core/                          # Shared/common code
│   ├── data/                      # Database setup
│   └── utils/                     # Theme and utilities
├── features/                      # All app features
│   ├── home/                      # Dashboard feature
│   ├── add_trade/                 # Trade entry feature
│   ├── trade_list/                # Trade list feature
│   └── tools/                     # Tools feature
└── main.dart                      # Entry point
```

### Technology Stack
- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Database**: Drift (SQLite)
- **Charts**: fl_chart
- **Architecture**: Clean Architecture + Dependency Injection

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd leemeenal
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate database code:
```bash
dart run build_runner build
```

4. Run the app:
```bash
flutter run
```

## Design System

The app follows a modern, minimal design with:
- **Primary Color**: Light blue (#37AFE1)
- **Typography**: Inter font family
- **Layout**: Card-based design with rounded corners
- **Theme**: Light theme with soft shadows and clean spacing

## Database Schema

### Trades Table
- Trade details (symbol, type, prices, quantities)
- Risk management (stop loss, take profit)
- Performance metrics (PnL, achieved R, duration)
- Timestamps and notes

### Account Transactions Table
- Deposits and withdrawals
- Transaction history and balance tracking

### Trade Statistics Table
- Cached statistics for performance
- Aggregated metrics and calculations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes following Clean Architecture principles
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please open an issue in the repository.
