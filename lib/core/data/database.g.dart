// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TradesTable extends Trades with TableInfo<$TradesTable, Trade> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TradesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
    'tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datetimeMeta = const VerificationMeta(
    'datetime',
  );
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
    'datetime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangesMeta = const VerificationMeta(
    'exchanges',
  );
  @override
  late final GeneratedColumn<String> exchanges = GeneratedColumn<String>(
    'exchanges',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryTypeMeta = const VerificationMeta(
    'entryType',
  );
  @override
  late final GeneratedColumn<String> entryType = GeneratedColumn<String>(
    'entry_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strategiesMeta = const VerificationMeta(
    'strategies',
  );
  @override
  late final GeneratedColumn<String> strategies = GeneratedColumn<String>(
    'strategies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
    'side',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryPriceMeta = const VerificationMeta(
    'entryPrice',
  );
  @override
  late final GeneratedColumn<double> entryPrice = GeneratedColumn<double>(
    'entry_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMarginMeta = const VerificationMeta(
    'positionMargin',
  );
  @override
  late final GeneratedColumn<double> positionMargin = GeneratedColumn<double>(
    'position_margin',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leverageMeta = const VerificationMeta(
    'leverage',
  );
  @override
  late final GeneratedColumn<double> leverage = GeneratedColumn<double>(
    'leverage',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderTypeMeta = const VerificationMeta(
    'orderType',
  );
  @override
  late final GeneratedColumn<String> orderType = GeneratedColumn<String>(
    'order_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeFrameMeta = const VerificationMeta(
    'timeFrame',
  );
  @override
  late final GeneratedColumn<String> timeFrame = GeneratedColumn<String>(
    'time_frame',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryFeeRateMeta = const VerificationMeta(
    'entryFeeRate',
  );
  @override
  late final GeneratedColumn<double> entryFeeRate = GeneratedColumn<double>(
    'entry_fee_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryMentalStatesMeta = const VerificationMeta(
    'entryMentalStates',
  );
  @override
  late final GeneratedColumn<String> entryMentalStates =
      GeneratedColumn<String>(
        'entry_mental_states',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _entryScreenshotMeta = const VerificationMeta(
    'entryScreenshot',
  );
  @override
  late final GeneratedColumn<String> entryScreenshot = GeneratedColumn<String>(
    'entry_screenshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checklistMeta = const VerificationMeta(
    'checklist',
  );
  @override
  late final GeneratedColumn<String> checklist = GeneratedColumn<String>(
    'checklist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stopLossPriceMeta = const VerificationMeta(
    'stopLossPrice',
  );
  @override
  late final GeneratedColumn<double> stopLossPrice = GeneratedColumn<double>(
    'stop_loss_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takeProfitPriceMeta = const VerificationMeta(
    'takeProfitPrice',
  );
  @override
  late final GeneratedColumn<double> takeProfitPrice = GeneratedColumn<double>(
    'take_profit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualExitPriceMeta = const VerificationMeta(
    'actualExitPrice',
  );
  @override
  late final GeneratedColumn<double> actualExitPrice = GeneratedColumn<double>(
    'actual_exit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _marginClosedPercentMeta =
      const VerificationMeta('marginClosedPercent');
  @override
  late final GeneratedColumn<double> marginClosedPercent =
      GeneratedColumn<double>(
        'margin_closed_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _exitTypeMeta = const VerificationMeta(
    'exitType',
  );
  @override
  late final GeneratedColumn<String> exitType = GeneratedColumn<String>(
    'exit_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exitFeeRateMeta = const VerificationMeta(
    'exitFeeRate',
  );
  @override
  late final GeneratedColumn<double> exitFeeRate = GeneratedColumn<double>(
    'exit_fee_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exitDatetimeMeta = const VerificationMeta(
    'exitDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> exitDatetime = GeneratedColumn<DateTime>(
    'exit_datetime',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exitMentalStatesMeta = const VerificationMeta(
    'exitMentalStates',
  );
  @override
  late final GeneratedColumn<String> exitMentalStates = GeneratedColumn<String>(
    'exit_mental_states',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exitScreenshotMeta = const VerificationMeta(
    'exitScreenshot',
  );
  @override
  late final GeneratedColumn<String> exitScreenshot = GeneratedColumn<String>(
    'exit_screenshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
    'memo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackingsMeta = const VerificationMeta(
    'trackings',
  );
  @override
  late final GeneratedColumn<String> trackings = GeneratedColumn<String>(
    'trackings',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mistakesMeta = const VerificationMeta(
    'mistakes',
  );
  @override
  late final GeneratedColumn<String> mistakes = GeneratedColumn<String>(
    'mistakes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferAmountMeta = const VerificationMeta(
    'transferAmount',
  );
  @override
  late final GeneratedColumn<double> transferAmount = GeneratedColumn<double>(
    'transfer_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferScreenshotMeta =
      const VerificationMeta('transferScreenshot');
  @override
  late final GeneratedColumn<String> transferScreenshot =
      GeneratedColumn<String>(
        'transfer_screenshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exitPriceMeta = const VerificationMeta(
    'exitPrice',
  );
  @override
  late final GeneratedColumn<double> exitPrice = GeneratedColumn<double>(
    'exit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stopLossMeta = const VerificationMeta(
    'stopLoss',
  );
  @override
  late final GeneratedColumn<double> stopLoss = GeneratedColumn<double>(
    'stop_loss',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takeProfitMeta = const VerificationMeta(
    'takeProfit',
  );
  @override
  late final GeneratedColumn<double> takeProfit = GeneratedColumn<double>(
    'take_profit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pnlMeta = const VerificationMeta('pnl');
  @override
  late final GeneratedColumn<double> pnl = GeneratedColumn<double>(
    'pnl',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pnlPercentMeta = const VerificationMeta(
    'pnlPercent',
  );
  @override
  late final GeneratedColumn<double> pnlPercent = GeneratedColumn<double>(
    'pnl_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _riskRewardRatioMeta = const VerificationMeta(
    'riskRewardRatio',
  );
  @override
  late final GeneratedColumn<double> riskRewardRatio = GeneratedColumn<double>(
    'risk_reward_ratio',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryDateMeta = const VerificationMeta(
    'entryDate',
  );
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
    'entry_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exitDateMeta = const VerificationMeta(
    'exitDate',
  );
  @override
  late final GeneratedColumn<DateTime> exitDate = GeneratedColumn<DateTime>(
    'exit_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _screenshotPathMeta = const VerificationMeta(
    'screenshotPath',
  );
  @override
  late final GeneratedColumn<String> screenshotPath = GeneratedColumn<String>(
    'screenshot_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountBalanceMeta = const VerificationMeta(
    'accountBalance',
  );
  @override
  late final GeneratedColumn<double> accountBalance = GeneratedColumn<double>(
    'account_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskAmountMeta = const VerificationMeta(
    'riskAmount',
  );
  @override
  late final GeneratedColumn<double> riskAmount = GeneratedColumn<double>(
    'risk_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _achievedRMeta = const VerificationMeta(
    'achievedR',
  );
  @override
  late final GeneratedColumn<double> achievedR = GeneratedColumn<double>(
    'achieved_r',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tradeDurationMeta = const VerificationMeta(
    'tradeDuration',
  );
  @override
  late final GeneratedColumn<int> tradeDuration = GeneratedColumn<int>(
    'trade_duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tag,
    datetime,
    exchanges,
    entryType,
    symbol,
    strategies,
    side,
    entryPrice,
    positionMargin,
    leverage,
    orderType,
    timeFrame,
    entryFeeRate,
    entryMentalStates,
    entryScreenshot,
    checklist,
    stopLossPrice,
    takeProfitPrice,
    actualExitPrice,
    marginClosedPercent,
    exitType,
    exitFeeRate,
    exitDatetime,
    exitMentalStates,
    exitScreenshot,
    rating,
    memo,
    trackings,
    mistakes,
    transferAmount,
    transferScreenshot,
    type,
    status,
    exitPrice,
    quantity,
    stopLoss,
    takeProfit,
    pnl,
    pnlPercent,
    riskRewardRatio,
    entryDate,
    exitDate,
    notes,
    screenshotPath,
    accountBalance,
    riskAmount,
    achievedR,
    tradeDuration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trades';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trade> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
        _tagMeta,
        tag.isAcceptableOrUnknown(data['tag']!, _tagMeta),
      );
    }
    if (data.containsKey('datetime')) {
      context.handle(
        _datetimeMeta,
        datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta),
      );
    } else if (isInserting) {
      context.missing(_datetimeMeta);
    }
    if (data.containsKey('exchanges')) {
      context.handle(
        _exchangesMeta,
        exchanges.isAcceptableOrUnknown(data['exchanges']!, _exchangesMeta),
      );
    }
    if (data.containsKey('entry_type')) {
      context.handle(
        _entryTypeMeta,
        entryType.isAcceptableOrUnknown(data['entry_type']!, _entryTypeMeta),
      );
    }
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
    }
    if (data.containsKey('strategies')) {
      context.handle(
        _strategiesMeta,
        strategies.isAcceptableOrUnknown(data['strategies']!, _strategiesMeta),
      );
    }
    if (data.containsKey('side')) {
      context.handle(
        _sideMeta,
        side.isAcceptableOrUnknown(data['side']!, _sideMeta),
      );
    }
    if (data.containsKey('entry_price')) {
      context.handle(
        _entryPriceMeta,
        entryPrice.isAcceptableOrUnknown(data['entry_price']!, _entryPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_entryPriceMeta);
    }
    if (data.containsKey('position_margin')) {
      context.handle(
        _positionMarginMeta,
        positionMargin.isAcceptableOrUnknown(
          data['position_margin']!,
          _positionMarginMeta,
        ),
      );
    }
    if (data.containsKey('leverage')) {
      context.handle(
        _leverageMeta,
        leverage.isAcceptableOrUnknown(data['leverage']!, _leverageMeta),
      );
    }
    if (data.containsKey('order_type')) {
      context.handle(
        _orderTypeMeta,
        orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta),
      );
    }
    if (data.containsKey('time_frame')) {
      context.handle(
        _timeFrameMeta,
        timeFrame.isAcceptableOrUnknown(data['time_frame']!, _timeFrameMeta),
      );
    }
    if (data.containsKey('entry_fee_rate')) {
      context.handle(
        _entryFeeRateMeta,
        entryFeeRate.isAcceptableOrUnknown(
          data['entry_fee_rate']!,
          _entryFeeRateMeta,
        ),
      );
    }
    if (data.containsKey('entry_mental_states')) {
      context.handle(
        _entryMentalStatesMeta,
        entryMentalStates.isAcceptableOrUnknown(
          data['entry_mental_states']!,
          _entryMentalStatesMeta,
        ),
      );
    }
    if (data.containsKey('entry_screenshot')) {
      context.handle(
        _entryScreenshotMeta,
        entryScreenshot.isAcceptableOrUnknown(
          data['entry_screenshot']!,
          _entryScreenshotMeta,
        ),
      );
    }
    if (data.containsKey('checklist')) {
      context.handle(
        _checklistMeta,
        checklist.isAcceptableOrUnknown(data['checklist']!, _checklistMeta),
      );
    }
    if (data.containsKey('stop_loss_price')) {
      context.handle(
        _stopLossPriceMeta,
        stopLossPrice.isAcceptableOrUnknown(
          data['stop_loss_price']!,
          _stopLossPriceMeta,
        ),
      );
    }
    if (data.containsKey('take_profit_price')) {
      context.handle(
        _takeProfitPriceMeta,
        takeProfitPrice.isAcceptableOrUnknown(
          data['take_profit_price']!,
          _takeProfitPriceMeta,
        ),
      );
    }
    if (data.containsKey('actual_exit_price')) {
      context.handle(
        _actualExitPriceMeta,
        actualExitPrice.isAcceptableOrUnknown(
          data['actual_exit_price']!,
          _actualExitPriceMeta,
        ),
      );
    }
    if (data.containsKey('margin_closed_percent')) {
      context.handle(
        _marginClosedPercentMeta,
        marginClosedPercent.isAcceptableOrUnknown(
          data['margin_closed_percent']!,
          _marginClosedPercentMeta,
        ),
      );
    }
    if (data.containsKey('exit_type')) {
      context.handle(
        _exitTypeMeta,
        exitType.isAcceptableOrUnknown(data['exit_type']!, _exitTypeMeta),
      );
    }
    if (data.containsKey('exit_fee_rate')) {
      context.handle(
        _exitFeeRateMeta,
        exitFeeRate.isAcceptableOrUnknown(
          data['exit_fee_rate']!,
          _exitFeeRateMeta,
        ),
      );
    }
    if (data.containsKey('exit_datetime')) {
      context.handle(
        _exitDatetimeMeta,
        exitDatetime.isAcceptableOrUnknown(
          data['exit_datetime']!,
          _exitDatetimeMeta,
        ),
      );
    }
    if (data.containsKey('exit_mental_states')) {
      context.handle(
        _exitMentalStatesMeta,
        exitMentalStates.isAcceptableOrUnknown(
          data['exit_mental_states']!,
          _exitMentalStatesMeta,
        ),
      );
    }
    if (data.containsKey('exit_screenshot')) {
      context.handle(
        _exitScreenshotMeta,
        exitScreenshot.isAcceptableOrUnknown(
          data['exit_screenshot']!,
          _exitScreenshotMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('memo')) {
      context.handle(
        _memoMeta,
        memo.isAcceptableOrUnknown(data['memo']!, _memoMeta),
      );
    }
    if (data.containsKey('trackings')) {
      context.handle(
        _trackingsMeta,
        trackings.isAcceptableOrUnknown(data['trackings']!, _trackingsMeta),
      );
    }
    if (data.containsKey('mistakes')) {
      context.handle(
        _mistakesMeta,
        mistakes.isAcceptableOrUnknown(data['mistakes']!, _mistakesMeta),
      );
    }
    if (data.containsKey('transfer_amount')) {
      context.handle(
        _transferAmountMeta,
        transferAmount.isAcceptableOrUnknown(
          data['transfer_amount']!,
          _transferAmountMeta,
        ),
      );
    }
    if (data.containsKey('transfer_screenshot')) {
      context.handle(
        _transferScreenshotMeta,
        transferScreenshot.isAcceptableOrUnknown(
          data['transfer_screenshot']!,
          _transferScreenshotMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('exit_price')) {
      context.handle(
        _exitPriceMeta,
        exitPrice.isAcceptableOrUnknown(data['exit_price']!, _exitPriceMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('stop_loss')) {
      context.handle(
        _stopLossMeta,
        stopLoss.isAcceptableOrUnknown(data['stop_loss']!, _stopLossMeta),
      );
    }
    if (data.containsKey('take_profit')) {
      context.handle(
        _takeProfitMeta,
        takeProfit.isAcceptableOrUnknown(data['take_profit']!, _takeProfitMeta),
      );
    }
    if (data.containsKey('pnl')) {
      context.handle(
        _pnlMeta,
        pnl.isAcceptableOrUnknown(data['pnl']!, _pnlMeta),
      );
    }
    if (data.containsKey('pnl_percent')) {
      context.handle(
        _pnlPercentMeta,
        pnlPercent.isAcceptableOrUnknown(data['pnl_percent']!, _pnlPercentMeta),
      );
    }
    if (data.containsKey('risk_reward_ratio')) {
      context.handle(
        _riskRewardRatioMeta,
        riskRewardRatio.isAcceptableOrUnknown(
          data['risk_reward_ratio']!,
          _riskRewardRatioMeta,
        ),
      );
    }
    if (data.containsKey('entry_date')) {
      context.handle(
        _entryDateMeta,
        entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_entryDateMeta);
    }
    if (data.containsKey('exit_date')) {
      context.handle(
        _exitDateMeta,
        exitDate.isAcceptableOrUnknown(data['exit_date']!, _exitDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('screenshot_path')) {
      context.handle(
        _screenshotPathMeta,
        screenshotPath.isAcceptableOrUnknown(
          data['screenshot_path']!,
          _screenshotPathMeta,
        ),
      );
    }
    if (data.containsKey('account_balance')) {
      context.handle(
        _accountBalanceMeta,
        accountBalance.isAcceptableOrUnknown(
          data['account_balance']!,
          _accountBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountBalanceMeta);
    }
    if (data.containsKey('risk_amount')) {
      context.handle(
        _riskAmountMeta,
        riskAmount.isAcceptableOrUnknown(data['risk_amount']!, _riskAmountMeta),
      );
    }
    if (data.containsKey('achieved_r')) {
      context.handle(
        _achievedRMeta,
        achievedR.isAcceptableOrUnknown(data['achieved_r']!, _achievedRMeta),
      );
    }
    if (data.containsKey('trade_duration')) {
      context.handle(
        _tradeDurationMeta,
        tradeDuration.isAcceptableOrUnknown(
          data['trade_duration']!,
          _tradeDurationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trade map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trade(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag'],
      ),
      datetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}datetime'],
      )!,
      exchanges: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exchanges'],
      ),
      entryType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_type'],
      ),
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      strategies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}strategies'],
      ),
      side: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}side'],
      ),
      entryPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}entry_price'],
      )!,
      positionMargin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}position_margin'],
      ),
      leverage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}leverage'],
      ),
      orderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_type'],
      ),
      timeFrame: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_frame'],
      ),
      entryFeeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}entry_fee_rate'],
      ),
      entryMentalStates: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_mental_states'],
      ),
      entryScreenshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_screenshot'],
      ),
      checklist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checklist'],
      ),
      stopLossPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stop_loss_price'],
      ),
      takeProfitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}take_profit_price'],
      ),
      actualExitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_exit_price'],
      ),
      marginClosedPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}margin_closed_percent'],
      ),
      exitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exit_type'],
      ),
      exitFeeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exit_fee_rate'],
      ),
      exitDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}exit_datetime'],
      ),
      exitMentalStates: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exit_mental_states'],
      ),
      exitScreenshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exit_screenshot'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      memo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo'],
      ),
      trackings: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trackings'],
      ),
      mistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mistakes'],
      ),
      transferAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}transfer_amount'],
      ),
      transferScreenshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_screenshot'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      exitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exit_price'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      stopLoss: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stop_loss'],
      ),
      takeProfit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}take_profit'],
      ),
      pnl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pnl'],
      ),
      pnlPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pnl_percent'],
      ),
      riskRewardRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}risk_reward_ratio'],
      ),
      entryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date'],
      )!,
      exitDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}exit_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      screenshotPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}screenshot_path'],
      ),
      accountBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}account_balance'],
      )!,
      riskAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}risk_amount'],
      ),
      achievedR: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}achieved_r'],
      ),
      tradeDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trade_duration'],
      ),
    );
  }

  @override
  $TradesTable createAlias(String alias) {
    return $TradesTable(attachedDatabase, alias);
  }
}

class Trade extends DataClass implements Insertable<Trade> {
  final int id;
  final String? tag;
  final DateTime datetime;
  final String? exchanges;
  final String? entryType;
  final String symbol;
  final String? strategies;
  final String? side;
  final double entryPrice;
  final double? positionMargin;
  final double? leverage;
  final String? orderType;
  final String? timeFrame;
  final double? entryFeeRate;
  final String? entryMentalStates;
  final String? entryScreenshot;
  final String? checklist;
  final double? stopLossPrice;
  final double? takeProfitPrice;
  final double? actualExitPrice;
  final double? marginClosedPercent;
  final String? exitType;
  final double? exitFeeRate;
  final DateTime? exitDatetime;
  final String? exitMentalStates;
  final String? exitScreenshot;
  final int? rating;
  final String? memo;
  final String? trackings;
  final String? mistakes;
  final double? transferAmount;
  final String? transferScreenshot;
  final String type;
  final String status;
  final double? exitPrice;
  final double quantity;
  final double? stopLoss;
  final double? takeProfit;
  final double? pnl;
  final double? pnlPercent;
  final double? riskRewardRatio;
  final DateTime entryDate;
  final DateTime? exitDate;
  final String? notes;
  final String? screenshotPath;
  final double accountBalance;
  final double? riskAmount;
  final double? achievedR;
  final int? tradeDuration;
  const Trade({
    required this.id,
    this.tag,
    required this.datetime,
    this.exchanges,
    this.entryType,
    required this.symbol,
    this.strategies,
    this.side,
    required this.entryPrice,
    this.positionMargin,
    this.leverage,
    this.orderType,
    this.timeFrame,
    this.entryFeeRate,
    this.entryMentalStates,
    this.entryScreenshot,
    this.checklist,
    this.stopLossPrice,
    this.takeProfitPrice,
    this.actualExitPrice,
    this.marginClosedPercent,
    this.exitType,
    this.exitFeeRate,
    this.exitDatetime,
    this.exitMentalStates,
    this.exitScreenshot,
    this.rating,
    this.memo,
    this.trackings,
    this.mistakes,
    this.transferAmount,
    this.transferScreenshot,
    required this.type,
    required this.status,
    this.exitPrice,
    required this.quantity,
    this.stopLoss,
    this.takeProfit,
    this.pnl,
    this.pnlPercent,
    this.riskRewardRatio,
    required this.entryDate,
    this.exitDate,
    this.notes,
    this.screenshotPath,
    required this.accountBalance,
    this.riskAmount,
    this.achievedR,
    this.tradeDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    map['datetime'] = Variable<DateTime>(datetime);
    if (!nullToAbsent || exchanges != null) {
      map['exchanges'] = Variable<String>(exchanges);
    }
    if (!nullToAbsent || entryType != null) {
      map['entry_type'] = Variable<String>(entryType);
    }
    map['symbol'] = Variable<String>(symbol);
    if (!nullToAbsent || strategies != null) {
      map['strategies'] = Variable<String>(strategies);
    }
    if (!nullToAbsent || side != null) {
      map['side'] = Variable<String>(side);
    }
    map['entry_price'] = Variable<double>(entryPrice);
    if (!nullToAbsent || positionMargin != null) {
      map['position_margin'] = Variable<double>(positionMargin);
    }
    if (!nullToAbsent || leverage != null) {
      map['leverage'] = Variable<double>(leverage);
    }
    if (!nullToAbsent || orderType != null) {
      map['order_type'] = Variable<String>(orderType);
    }
    if (!nullToAbsent || timeFrame != null) {
      map['time_frame'] = Variable<String>(timeFrame);
    }
    if (!nullToAbsent || entryFeeRate != null) {
      map['entry_fee_rate'] = Variable<double>(entryFeeRate);
    }
    if (!nullToAbsent || entryMentalStates != null) {
      map['entry_mental_states'] = Variable<String>(entryMentalStates);
    }
    if (!nullToAbsent || entryScreenshot != null) {
      map['entry_screenshot'] = Variable<String>(entryScreenshot);
    }
    if (!nullToAbsent || checklist != null) {
      map['checklist'] = Variable<String>(checklist);
    }
    if (!nullToAbsent || stopLossPrice != null) {
      map['stop_loss_price'] = Variable<double>(stopLossPrice);
    }
    if (!nullToAbsent || takeProfitPrice != null) {
      map['take_profit_price'] = Variable<double>(takeProfitPrice);
    }
    if (!nullToAbsent || actualExitPrice != null) {
      map['actual_exit_price'] = Variable<double>(actualExitPrice);
    }
    if (!nullToAbsent || marginClosedPercent != null) {
      map['margin_closed_percent'] = Variable<double>(marginClosedPercent);
    }
    if (!nullToAbsent || exitType != null) {
      map['exit_type'] = Variable<String>(exitType);
    }
    if (!nullToAbsent || exitFeeRate != null) {
      map['exit_fee_rate'] = Variable<double>(exitFeeRate);
    }
    if (!nullToAbsent || exitDatetime != null) {
      map['exit_datetime'] = Variable<DateTime>(exitDatetime);
    }
    if (!nullToAbsent || exitMentalStates != null) {
      map['exit_mental_states'] = Variable<String>(exitMentalStates);
    }
    if (!nullToAbsent || exitScreenshot != null) {
      map['exit_screenshot'] = Variable<String>(exitScreenshot);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    if (!nullToAbsent || trackings != null) {
      map['trackings'] = Variable<String>(trackings);
    }
    if (!nullToAbsent || mistakes != null) {
      map['mistakes'] = Variable<String>(mistakes);
    }
    if (!nullToAbsent || transferAmount != null) {
      map['transfer_amount'] = Variable<double>(transferAmount);
    }
    if (!nullToAbsent || transferScreenshot != null) {
      map['transfer_screenshot'] = Variable<String>(transferScreenshot);
    }
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || exitPrice != null) {
      map['exit_price'] = Variable<double>(exitPrice);
    }
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || stopLoss != null) {
      map['stop_loss'] = Variable<double>(stopLoss);
    }
    if (!nullToAbsent || takeProfit != null) {
      map['take_profit'] = Variable<double>(takeProfit);
    }
    if (!nullToAbsent || pnl != null) {
      map['pnl'] = Variable<double>(pnl);
    }
    if (!nullToAbsent || pnlPercent != null) {
      map['pnl_percent'] = Variable<double>(pnlPercent);
    }
    if (!nullToAbsent || riskRewardRatio != null) {
      map['risk_reward_ratio'] = Variable<double>(riskRewardRatio);
    }
    map['entry_date'] = Variable<DateTime>(entryDate);
    if (!nullToAbsent || exitDate != null) {
      map['exit_date'] = Variable<DateTime>(exitDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || screenshotPath != null) {
      map['screenshot_path'] = Variable<String>(screenshotPath);
    }
    map['account_balance'] = Variable<double>(accountBalance);
    if (!nullToAbsent || riskAmount != null) {
      map['risk_amount'] = Variable<double>(riskAmount);
    }
    if (!nullToAbsent || achievedR != null) {
      map['achieved_r'] = Variable<double>(achievedR);
    }
    if (!nullToAbsent || tradeDuration != null) {
      map['trade_duration'] = Variable<int>(tradeDuration);
    }
    return map;
  }

  TradesCompanion toCompanion(bool nullToAbsent) {
    return TradesCompanion(
      id: Value(id),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      datetime: Value(datetime),
      exchanges: exchanges == null && nullToAbsent
          ? const Value.absent()
          : Value(exchanges),
      entryType: entryType == null && nullToAbsent
          ? const Value.absent()
          : Value(entryType),
      symbol: Value(symbol),
      strategies: strategies == null && nullToAbsent
          ? const Value.absent()
          : Value(strategies),
      side: side == null && nullToAbsent ? const Value.absent() : Value(side),
      entryPrice: Value(entryPrice),
      positionMargin: positionMargin == null && nullToAbsent
          ? const Value.absent()
          : Value(positionMargin),
      leverage: leverage == null && nullToAbsent
          ? const Value.absent()
          : Value(leverage),
      orderType: orderType == null && nullToAbsent
          ? const Value.absent()
          : Value(orderType),
      timeFrame: timeFrame == null && nullToAbsent
          ? const Value.absent()
          : Value(timeFrame),
      entryFeeRate: entryFeeRate == null && nullToAbsent
          ? const Value.absent()
          : Value(entryFeeRate),
      entryMentalStates: entryMentalStates == null && nullToAbsent
          ? const Value.absent()
          : Value(entryMentalStates),
      entryScreenshot: entryScreenshot == null && nullToAbsent
          ? const Value.absent()
          : Value(entryScreenshot),
      checklist: checklist == null && nullToAbsent
          ? const Value.absent()
          : Value(checklist),
      stopLossPrice: stopLossPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(stopLossPrice),
      takeProfitPrice: takeProfitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(takeProfitPrice),
      actualExitPrice: actualExitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(actualExitPrice),
      marginClosedPercent: marginClosedPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(marginClosedPercent),
      exitType: exitType == null && nullToAbsent
          ? const Value.absent()
          : Value(exitType),
      exitFeeRate: exitFeeRate == null && nullToAbsent
          ? const Value.absent()
          : Value(exitFeeRate),
      exitDatetime: exitDatetime == null && nullToAbsent
          ? const Value.absent()
          : Value(exitDatetime),
      exitMentalStates: exitMentalStates == null && nullToAbsent
          ? const Value.absent()
          : Value(exitMentalStates),
      exitScreenshot: exitScreenshot == null && nullToAbsent
          ? const Value.absent()
          : Value(exitScreenshot),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      trackings: trackings == null && nullToAbsent
          ? const Value.absent()
          : Value(trackings),
      mistakes: mistakes == null && nullToAbsent
          ? const Value.absent()
          : Value(mistakes),
      transferAmount: transferAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(transferAmount),
      transferScreenshot: transferScreenshot == null && nullToAbsent
          ? const Value.absent()
          : Value(transferScreenshot),
      type: Value(type),
      status: Value(status),
      exitPrice: exitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(exitPrice),
      quantity: Value(quantity),
      stopLoss: stopLoss == null && nullToAbsent
          ? const Value.absent()
          : Value(stopLoss),
      takeProfit: takeProfit == null && nullToAbsent
          ? const Value.absent()
          : Value(takeProfit),
      pnl: pnl == null && nullToAbsent ? const Value.absent() : Value(pnl),
      pnlPercent: pnlPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(pnlPercent),
      riskRewardRatio: riskRewardRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(riskRewardRatio),
      entryDate: Value(entryDate),
      exitDate: exitDate == null && nullToAbsent
          ? const Value.absent()
          : Value(exitDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      screenshotPath: screenshotPath == null && nullToAbsent
          ? const Value.absent()
          : Value(screenshotPath),
      accountBalance: Value(accountBalance),
      riskAmount: riskAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(riskAmount),
      achievedR: achievedR == null && nullToAbsent
          ? const Value.absent()
          : Value(achievedR),
      tradeDuration: tradeDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(tradeDuration),
    );
  }

  factory Trade.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trade(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String?>(json['tag']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
      exchanges: serializer.fromJson<String?>(json['exchanges']),
      entryType: serializer.fromJson<String?>(json['entryType']),
      symbol: serializer.fromJson<String>(json['symbol']),
      strategies: serializer.fromJson<String?>(json['strategies']),
      side: serializer.fromJson<String?>(json['side']),
      entryPrice: serializer.fromJson<double>(json['entryPrice']),
      positionMargin: serializer.fromJson<double?>(json['positionMargin']),
      leverage: serializer.fromJson<double?>(json['leverage']),
      orderType: serializer.fromJson<String?>(json['orderType']),
      timeFrame: serializer.fromJson<String?>(json['timeFrame']),
      entryFeeRate: serializer.fromJson<double?>(json['entryFeeRate']),
      entryMentalStates: serializer.fromJson<String?>(
        json['entryMentalStates'],
      ),
      entryScreenshot: serializer.fromJson<String?>(json['entryScreenshot']),
      checklist: serializer.fromJson<String?>(json['checklist']),
      stopLossPrice: serializer.fromJson<double?>(json['stopLossPrice']),
      takeProfitPrice: serializer.fromJson<double?>(json['takeProfitPrice']),
      actualExitPrice: serializer.fromJson<double?>(json['actualExitPrice']),
      marginClosedPercent: serializer.fromJson<double?>(
        json['marginClosedPercent'],
      ),
      exitType: serializer.fromJson<String?>(json['exitType']),
      exitFeeRate: serializer.fromJson<double?>(json['exitFeeRate']),
      exitDatetime: serializer.fromJson<DateTime?>(json['exitDatetime']),
      exitMentalStates: serializer.fromJson<String?>(json['exitMentalStates']),
      exitScreenshot: serializer.fromJson<String?>(json['exitScreenshot']),
      rating: serializer.fromJson<int?>(json['rating']),
      memo: serializer.fromJson<String?>(json['memo']),
      trackings: serializer.fromJson<String?>(json['trackings']),
      mistakes: serializer.fromJson<String?>(json['mistakes']),
      transferAmount: serializer.fromJson<double?>(json['transferAmount']),
      transferScreenshot: serializer.fromJson<String?>(
        json['transferScreenshot'],
      ),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      exitPrice: serializer.fromJson<double?>(json['exitPrice']),
      quantity: serializer.fromJson<double>(json['quantity']),
      stopLoss: serializer.fromJson<double?>(json['stopLoss']),
      takeProfit: serializer.fromJson<double?>(json['takeProfit']),
      pnl: serializer.fromJson<double?>(json['pnl']),
      pnlPercent: serializer.fromJson<double?>(json['pnlPercent']),
      riskRewardRatio: serializer.fromJson<double?>(json['riskRewardRatio']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
      exitDate: serializer.fromJson<DateTime?>(json['exitDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      screenshotPath: serializer.fromJson<String?>(json['screenshotPath']),
      accountBalance: serializer.fromJson<double>(json['accountBalance']),
      riskAmount: serializer.fromJson<double?>(json['riskAmount']),
      achievedR: serializer.fromJson<double?>(json['achievedR']),
      tradeDuration: serializer.fromJson<int?>(json['tradeDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String?>(tag),
      'datetime': serializer.toJson<DateTime>(datetime),
      'exchanges': serializer.toJson<String?>(exchanges),
      'entryType': serializer.toJson<String?>(entryType),
      'symbol': serializer.toJson<String>(symbol),
      'strategies': serializer.toJson<String?>(strategies),
      'side': serializer.toJson<String?>(side),
      'entryPrice': serializer.toJson<double>(entryPrice),
      'positionMargin': serializer.toJson<double?>(positionMargin),
      'leverage': serializer.toJson<double?>(leverage),
      'orderType': serializer.toJson<String?>(orderType),
      'timeFrame': serializer.toJson<String?>(timeFrame),
      'entryFeeRate': serializer.toJson<double?>(entryFeeRate),
      'entryMentalStates': serializer.toJson<String?>(entryMentalStates),
      'entryScreenshot': serializer.toJson<String?>(entryScreenshot),
      'checklist': serializer.toJson<String?>(checklist),
      'stopLossPrice': serializer.toJson<double?>(stopLossPrice),
      'takeProfitPrice': serializer.toJson<double?>(takeProfitPrice),
      'actualExitPrice': serializer.toJson<double?>(actualExitPrice),
      'marginClosedPercent': serializer.toJson<double?>(marginClosedPercent),
      'exitType': serializer.toJson<String?>(exitType),
      'exitFeeRate': serializer.toJson<double?>(exitFeeRate),
      'exitDatetime': serializer.toJson<DateTime?>(exitDatetime),
      'exitMentalStates': serializer.toJson<String?>(exitMentalStates),
      'exitScreenshot': serializer.toJson<String?>(exitScreenshot),
      'rating': serializer.toJson<int?>(rating),
      'memo': serializer.toJson<String?>(memo),
      'trackings': serializer.toJson<String?>(trackings),
      'mistakes': serializer.toJson<String?>(mistakes),
      'transferAmount': serializer.toJson<double?>(transferAmount),
      'transferScreenshot': serializer.toJson<String?>(transferScreenshot),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'exitPrice': serializer.toJson<double?>(exitPrice),
      'quantity': serializer.toJson<double>(quantity),
      'stopLoss': serializer.toJson<double?>(stopLoss),
      'takeProfit': serializer.toJson<double?>(takeProfit),
      'pnl': serializer.toJson<double?>(pnl),
      'pnlPercent': serializer.toJson<double?>(pnlPercent),
      'riskRewardRatio': serializer.toJson<double?>(riskRewardRatio),
      'entryDate': serializer.toJson<DateTime>(entryDate),
      'exitDate': serializer.toJson<DateTime?>(exitDate),
      'notes': serializer.toJson<String?>(notes),
      'screenshotPath': serializer.toJson<String?>(screenshotPath),
      'accountBalance': serializer.toJson<double>(accountBalance),
      'riskAmount': serializer.toJson<double?>(riskAmount),
      'achievedR': serializer.toJson<double?>(achievedR),
      'tradeDuration': serializer.toJson<int?>(tradeDuration),
    };
  }

  Trade copyWith({
    int? id,
    Value<String?> tag = const Value.absent(),
    DateTime? datetime,
    Value<String?> exchanges = const Value.absent(),
    Value<String?> entryType = const Value.absent(),
    String? symbol,
    Value<String?> strategies = const Value.absent(),
    Value<String?> side = const Value.absent(),
    double? entryPrice,
    Value<double?> positionMargin = const Value.absent(),
    Value<double?> leverage = const Value.absent(),
    Value<String?> orderType = const Value.absent(),
    Value<String?> timeFrame = const Value.absent(),
    Value<double?> entryFeeRate = const Value.absent(),
    Value<String?> entryMentalStates = const Value.absent(),
    Value<String?> entryScreenshot = const Value.absent(),
    Value<String?> checklist = const Value.absent(),
    Value<double?> stopLossPrice = const Value.absent(),
    Value<double?> takeProfitPrice = const Value.absent(),
    Value<double?> actualExitPrice = const Value.absent(),
    Value<double?> marginClosedPercent = const Value.absent(),
    Value<String?> exitType = const Value.absent(),
    Value<double?> exitFeeRate = const Value.absent(),
    Value<DateTime?> exitDatetime = const Value.absent(),
    Value<String?> exitMentalStates = const Value.absent(),
    Value<String?> exitScreenshot = const Value.absent(),
    Value<int?> rating = const Value.absent(),
    Value<String?> memo = const Value.absent(),
    Value<String?> trackings = const Value.absent(),
    Value<String?> mistakes = const Value.absent(),
    Value<double?> transferAmount = const Value.absent(),
    Value<String?> transferScreenshot = const Value.absent(),
    String? type,
    String? status,
    Value<double?> exitPrice = const Value.absent(),
    double? quantity,
    Value<double?> stopLoss = const Value.absent(),
    Value<double?> takeProfit = const Value.absent(),
    Value<double?> pnl = const Value.absent(),
    Value<double?> pnlPercent = const Value.absent(),
    Value<double?> riskRewardRatio = const Value.absent(),
    DateTime? entryDate,
    Value<DateTime?> exitDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> screenshotPath = const Value.absent(),
    double? accountBalance,
    Value<double?> riskAmount = const Value.absent(),
    Value<double?> achievedR = const Value.absent(),
    Value<int?> tradeDuration = const Value.absent(),
  }) => Trade(
    id: id ?? this.id,
    tag: tag.present ? tag.value : this.tag,
    datetime: datetime ?? this.datetime,
    exchanges: exchanges.present ? exchanges.value : this.exchanges,
    entryType: entryType.present ? entryType.value : this.entryType,
    symbol: symbol ?? this.symbol,
    strategies: strategies.present ? strategies.value : this.strategies,
    side: side.present ? side.value : this.side,
    entryPrice: entryPrice ?? this.entryPrice,
    positionMargin: positionMargin.present
        ? positionMargin.value
        : this.positionMargin,
    leverage: leverage.present ? leverage.value : this.leverage,
    orderType: orderType.present ? orderType.value : this.orderType,
    timeFrame: timeFrame.present ? timeFrame.value : this.timeFrame,
    entryFeeRate: entryFeeRate.present ? entryFeeRate.value : this.entryFeeRate,
    entryMentalStates: entryMentalStates.present
        ? entryMentalStates.value
        : this.entryMentalStates,
    entryScreenshot: entryScreenshot.present
        ? entryScreenshot.value
        : this.entryScreenshot,
    checklist: checklist.present ? checklist.value : this.checklist,
    stopLossPrice: stopLossPrice.present
        ? stopLossPrice.value
        : this.stopLossPrice,
    takeProfitPrice: takeProfitPrice.present
        ? takeProfitPrice.value
        : this.takeProfitPrice,
    actualExitPrice: actualExitPrice.present
        ? actualExitPrice.value
        : this.actualExitPrice,
    marginClosedPercent: marginClosedPercent.present
        ? marginClosedPercent.value
        : this.marginClosedPercent,
    exitType: exitType.present ? exitType.value : this.exitType,
    exitFeeRate: exitFeeRate.present ? exitFeeRate.value : this.exitFeeRate,
    exitDatetime: exitDatetime.present ? exitDatetime.value : this.exitDatetime,
    exitMentalStates: exitMentalStates.present
        ? exitMentalStates.value
        : this.exitMentalStates,
    exitScreenshot: exitScreenshot.present
        ? exitScreenshot.value
        : this.exitScreenshot,
    rating: rating.present ? rating.value : this.rating,
    memo: memo.present ? memo.value : this.memo,
    trackings: trackings.present ? trackings.value : this.trackings,
    mistakes: mistakes.present ? mistakes.value : this.mistakes,
    transferAmount: transferAmount.present
        ? transferAmount.value
        : this.transferAmount,
    transferScreenshot: transferScreenshot.present
        ? transferScreenshot.value
        : this.transferScreenshot,
    type: type ?? this.type,
    status: status ?? this.status,
    exitPrice: exitPrice.present ? exitPrice.value : this.exitPrice,
    quantity: quantity ?? this.quantity,
    stopLoss: stopLoss.present ? stopLoss.value : this.stopLoss,
    takeProfit: takeProfit.present ? takeProfit.value : this.takeProfit,
    pnl: pnl.present ? pnl.value : this.pnl,
    pnlPercent: pnlPercent.present ? pnlPercent.value : this.pnlPercent,
    riskRewardRatio: riskRewardRatio.present
        ? riskRewardRatio.value
        : this.riskRewardRatio,
    entryDate: entryDate ?? this.entryDate,
    exitDate: exitDate.present ? exitDate.value : this.exitDate,
    notes: notes.present ? notes.value : this.notes,
    screenshotPath: screenshotPath.present
        ? screenshotPath.value
        : this.screenshotPath,
    accountBalance: accountBalance ?? this.accountBalance,
    riskAmount: riskAmount.present ? riskAmount.value : this.riskAmount,
    achievedR: achievedR.present ? achievedR.value : this.achievedR,
    tradeDuration: tradeDuration.present
        ? tradeDuration.value
        : this.tradeDuration,
  );
  Trade copyWithCompanion(TradesCompanion data) {
    return Trade(
      id: data.id.present ? data.id.value : this.id,
      tag: data.tag.present ? data.tag.value : this.tag,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
      exchanges: data.exchanges.present ? data.exchanges.value : this.exchanges,
      entryType: data.entryType.present ? data.entryType.value : this.entryType,
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      strategies: data.strategies.present
          ? data.strategies.value
          : this.strategies,
      side: data.side.present ? data.side.value : this.side,
      entryPrice: data.entryPrice.present
          ? data.entryPrice.value
          : this.entryPrice,
      positionMargin: data.positionMargin.present
          ? data.positionMargin.value
          : this.positionMargin,
      leverage: data.leverage.present ? data.leverage.value : this.leverage,
      orderType: data.orderType.present ? data.orderType.value : this.orderType,
      timeFrame: data.timeFrame.present ? data.timeFrame.value : this.timeFrame,
      entryFeeRate: data.entryFeeRate.present
          ? data.entryFeeRate.value
          : this.entryFeeRate,
      entryMentalStates: data.entryMentalStates.present
          ? data.entryMentalStates.value
          : this.entryMentalStates,
      entryScreenshot: data.entryScreenshot.present
          ? data.entryScreenshot.value
          : this.entryScreenshot,
      checklist: data.checklist.present ? data.checklist.value : this.checklist,
      stopLossPrice: data.stopLossPrice.present
          ? data.stopLossPrice.value
          : this.stopLossPrice,
      takeProfitPrice: data.takeProfitPrice.present
          ? data.takeProfitPrice.value
          : this.takeProfitPrice,
      actualExitPrice: data.actualExitPrice.present
          ? data.actualExitPrice.value
          : this.actualExitPrice,
      marginClosedPercent: data.marginClosedPercent.present
          ? data.marginClosedPercent.value
          : this.marginClosedPercent,
      exitType: data.exitType.present ? data.exitType.value : this.exitType,
      exitFeeRate: data.exitFeeRate.present
          ? data.exitFeeRate.value
          : this.exitFeeRate,
      exitDatetime: data.exitDatetime.present
          ? data.exitDatetime.value
          : this.exitDatetime,
      exitMentalStates: data.exitMentalStates.present
          ? data.exitMentalStates.value
          : this.exitMentalStates,
      exitScreenshot: data.exitScreenshot.present
          ? data.exitScreenshot.value
          : this.exitScreenshot,
      rating: data.rating.present ? data.rating.value : this.rating,
      memo: data.memo.present ? data.memo.value : this.memo,
      trackings: data.trackings.present ? data.trackings.value : this.trackings,
      mistakes: data.mistakes.present ? data.mistakes.value : this.mistakes,
      transferAmount: data.transferAmount.present
          ? data.transferAmount.value
          : this.transferAmount,
      transferScreenshot: data.transferScreenshot.present
          ? data.transferScreenshot.value
          : this.transferScreenshot,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      exitPrice: data.exitPrice.present ? data.exitPrice.value : this.exitPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      stopLoss: data.stopLoss.present ? data.stopLoss.value : this.stopLoss,
      takeProfit: data.takeProfit.present
          ? data.takeProfit.value
          : this.takeProfit,
      pnl: data.pnl.present ? data.pnl.value : this.pnl,
      pnlPercent: data.pnlPercent.present
          ? data.pnlPercent.value
          : this.pnlPercent,
      riskRewardRatio: data.riskRewardRatio.present
          ? data.riskRewardRatio.value
          : this.riskRewardRatio,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
      exitDate: data.exitDate.present ? data.exitDate.value : this.exitDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      screenshotPath: data.screenshotPath.present
          ? data.screenshotPath.value
          : this.screenshotPath,
      accountBalance: data.accountBalance.present
          ? data.accountBalance.value
          : this.accountBalance,
      riskAmount: data.riskAmount.present
          ? data.riskAmount.value
          : this.riskAmount,
      achievedR: data.achievedR.present ? data.achievedR.value : this.achievedR,
      tradeDuration: data.tradeDuration.present
          ? data.tradeDuration.value
          : this.tradeDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trade(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('datetime: $datetime, ')
          ..write('exchanges: $exchanges, ')
          ..write('entryType: $entryType, ')
          ..write('symbol: $symbol, ')
          ..write('strategies: $strategies, ')
          ..write('side: $side, ')
          ..write('entryPrice: $entryPrice, ')
          ..write('positionMargin: $positionMargin, ')
          ..write('leverage: $leverage, ')
          ..write('orderType: $orderType, ')
          ..write('timeFrame: $timeFrame, ')
          ..write('entryFeeRate: $entryFeeRate, ')
          ..write('entryMentalStates: $entryMentalStates, ')
          ..write('entryScreenshot: $entryScreenshot, ')
          ..write('checklist: $checklist, ')
          ..write('stopLossPrice: $stopLossPrice, ')
          ..write('takeProfitPrice: $takeProfitPrice, ')
          ..write('actualExitPrice: $actualExitPrice, ')
          ..write('marginClosedPercent: $marginClosedPercent, ')
          ..write('exitType: $exitType, ')
          ..write('exitFeeRate: $exitFeeRate, ')
          ..write('exitDatetime: $exitDatetime, ')
          ..write('exitMentalStates: $exitMentalStates, ')
          ..write('exitScreenshot: $exitScreenshot, ')
          ..write('rating: $rating, ')
          ..write('memo: $memo, ')
          ..write('trackings: $trackings, ')
          ..write('mistakes: $mistakes, ')
          ..write('transferAmount: $transferAmount, ')
          ..write('transferScreenshot: $transferScreenshot, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('exitPrice: $exitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('stopLoss: $stopLoss, ')
          ..write('takeProfit: $takeProfit, ')
          ..write('pnl: $pnl, ')
          ..write('pnlPercent: $pnlPercent, ')
          ..write('riskRewardRatio: $riskRewardRatio, ')
          ..write('entryDate: $entryDate, ')
          ..write('exitDate: $exitDate, ')
          ..write('notes: $notes, ')
          ..write('screenshotPath: $screenshotPath, ')
          ..write('accountBalance: $accountBalance, ')
          ..write('riskAmount: $riskAmount, ')
          ..write('achievedR: $achievedR, ')
          ..write('tradeDuration: $tradeDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    tag,
    datetime,
    exchanges,
    entryType,
    symbol,
    strategies,
    side,
    entryPrice,
    positionMargin,
    leverage,
    orderType,
    timeFrame,
    entryFeeRate,
    entryMentalStates,
    entryScreenshot,
    checklist,
    stopLossPrice,
    takeProfitPrice,
    actualExitPrice,
    marginClosedPercent,
    exitType,
    exitFeeRate,
    exitDatetime,
    exitMentalStates,
    exitScreenshot,
    rating,
    memo,
    trackings,
    mistakes,
    transferAmount,
    transferScreenshot,
    type,
    status,
    exitPrice,
    quantity,
    stopLoss,
    takeProfit,
    pnl,
    pnlPercent,
    riskRewardRatio,
    entryDate,
    exitDate,
    notes,
    screenshotPath,
    accountBalance,
    riskAmount,
    achievedR,
    tradeDuration,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trade &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.datetime == this.datetime &&
          other.exchanges == this.exchanges &&
          other.entryType == this.entryType &&
          other.symbol == this.symbol &&
          other.strategies == this.strategies &&
          other.side == this.side &&
          other.entryPrice == this.entryPrice &&
          other.positionMargin == this.positionMargin &&
          other.leverage == this.leverage &&
          other.orderType == this.orderType &&
          other.timeFrame == this.timeFrame &&
          other.entryFeeRate == this.entryFeeRate &&
          other.entryMentalStates == this.entryMentalStates &&
          other.entryScreenshot == this.entryScreenshot &&
          other.checklist == this.checklist &&
          other.stopLossPrice == this.stopLossPrice &&
          other.takeProfitPrice == this.takeProfitPrice &&
          other.actualExitPrice == this.actualExitPrice &&
          other.marginClosedPercent == this.marginClosedPercent &&
          other.exitType == this.exitType &&
          other.exitFeeRate == this.exitFeeRate &&
          other.exitDatetime == this.exitDatetime &&
          other.exitMentalStates == this.exitMentalStates &&
          other.exitScreenshot == this.exitScreenshot &&
          other.rating == this.rating &&
          other.memo == this.memo &&
          other.trackings == this.trackings &&
          other.mistakes == this.mistakes &&
          other.transferAmount == this.transferAmount &&
          other.transferScreenshot == this.transferScreenshot &&
          other.type == this.type &&
          other.status == this.status &&
          other.exitPrice == this.exitPrice &&
          other.quantity == this.quantity &&
          other.stopLoss == this.stopLoss &&
          other.takeProfit == this.takeProfit &&
          other.pnl == this.pnl &&
          other.pnlPercent == this.pnlPercent &&
          other.riskRewardRatio == this.riskRewardRatio &&
          other.entryDate == this.entryDate &&
          other.exitDate == this.exitDate &&
          other.notes == this.notes &&
          other.screenshotPath == this.screenshotPath &&
          other.accountBalance == this.accountBalance &&
          other.riskAmount == this.riskAmount &&
          other.achievedR == this.achievedR &&
          other.tradeDuration == this.tradeDuration);
}

class TradesCompanion extends UpdateCompanion<Trade> {
  final Value<int> id;
  final Value<String?> tag;
  final Value<DateTime> datetime;
  final Value<String?> exchanges;
  final Value<String?> entryType;
  final Value<String> symbol;
  final Value<String?> strategies;
  final Value<String?> side;
  final Value<double> entryPrice;
  final Value<double?> positionMargin;
  final Value<double?> leverage;
  final Value<String?> orderType;
  final Value<String?> timeFrame;
  final Value<double?> entryFeeRate;
  final Value<String?> entryMentalStates;
  final Value<String?> entryScreenshot;
  final Value<String?> checklist;
  final Value<double?> stopLossPrice;
  final Value<double?> takeProfitPrice;
  final Value<double?> actualExitPrice;
  final Value<double?> marginClosedPercent;
  final Value<String?> exitType;
  final Value<double?> exitFeeRate;
  final Value<DateTime?> exitDatetime;
  final Value<String?> exitMentalStates;
  final Value<String?> exitScreenshot;
  final Value<int?> rating;
  final Value<String?> memo;
  final Value<String?> trackings;
  final Value<String?> mistakes;
  final Value<double?> transferAmount;
  final Value<String?> transferScreenshot;
  final Value<String> type;
  final Value<String> status;
  final Value<double?> exitPrice;
  final Value<double> quantity;
  final Value<double?> stopLoss;
  final Value<double?> takeProfit;
  final Value<double?> pnl;
  final Value<double?> pnlPercent;
  final Value<double?> riskRewardRatio;
  final Value<DateTime> entryDate;
  final Value<DateTime?> exitDate;
  final Value<String?> notes;
  final Value<String?> screenshotPath;
  final Value<double> accountBalance;
  final Value<double?> riskAmount;
  final Value<double?> achievedR;
  final Value<int?> tradeDuration;
  const TradesCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.datetime = const Value.absent(),
    this.exchanges = const Value.absent(),
    this.entryType = const Value.absent(),
    this.symbol = const Value.absent(),
    this.strategies = const Value.absent(),
    this.side = const Value.absent(),
    this.entryPrice = const Value.absent(),
    this.positionMargin = const Value.absent(),
    this.leverage = const Value.absent(),
    this.orderType = const Value.absent(),
    this.timeFrame = const Value.absent(),
    this.entryFeeRate = const Value.absent(),
    this.entryMentalStates = const Value.absent(),
    this.entryScreenshot = const Value.absent(),
    this.checklist = const Value.absent(),
    this.stopLossPrice = const Value.absent(),
    this.takeProfitPrice = const Value.absent(),
    this.actualExitPrice = const Value.absent(),
    this.marginClosedPercent = const Value.absent(),
    this.exitType = const Value.absent(),
    this.exitFeeRate = const Value.absent(),
    this.exitDatetime = const Value.absent(),
    this.exitMentalStates = const Value.absent(),
    this.exitScreenshot = const Value.absent(),
    this.rating = const Value.absent(),
    this.memo = const Value.absent(),
    this.trackings = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.transferAmount = const Value.absent(),
    this.transferScreenshot = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.exitPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.stopLoss = const Value.absent(),
    this.takeProfit = const Value.absent(),
    this.pnl = const Value.absent(),
    this.pnlPercent = const Value.absent(),
    this.riskRewardRatio = const Value.absent(),
    this.entryDate = const Value.absent(),
    this.exitDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.screenshotPath = const Value.absent(),
    this.accountBalance = const Value.absent(),
    this.riskAmount = const Value.absent(),
    this.achievedR = const Value.absent(),
    this.tradeDuration = const Value.absent(),
  });
  TradesCompanion.insert({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    required DateTime datetime,
    this.exchanges = const Value.absent(),
    this.entryType = const Value.absent(),
    required String symbol,
    this.strategies = const Value.absent(),
    this.side = const Value.absent(),
    required double entryPrice,
    this.positionMargin = const Value.absent(),
    this.leverage = const Value.absent(),
    this.orderType = const Value.absent(),
    this.timeFrame = const Value.absent(),
    this.entryFeeRate = const Value.absent(),
    this.entryMentalStates = const Value.absent(),
    this.entryScreenshot = const Value.absent(),
    this.checklist = const Value.absent(),
    this.stopLossPrice = const Value.absent(),
    this.takeProfitPrice = const Value.absent(),
    this.actualExitPrice = const Value.absent(),
    this.marginClosedPercent = const Value.absent(),
    this.exitType = const Value.absent(),
    this.exitFeeRate = const Value.absent(),
    this.exitDatetime = const Value.absent(),
    this.exitMentalStates = const Value.absent(),
    this.exitScreenshot = const Value.absent(),
    this.rating = const Value.absent(),
    this.memo = const Value.absent(),
    this.trackings = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.transferAmount = const Value.absent(),
    this.transferScreenshot = const Value.absent(),
    required String type,
    required String status,
    this.exitPrice = const Value.absent(),
    required double quantity,
    this.stopLoss = const Value.absent(),
    this.takeProfit = const Value.absent(),
    this.pnl = const Value.absent(),
    this.pnlPercent = const Value.absent(),
    this.riskRewardRatio = const Value.absent(),
    required DateTime entryDate,
    this.exitDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.screenshotPath = const Value.absent(),
    required double accountBalance,
    this.riskAmount = const Value.absent(),
    this.achievedR = const Value.absent(),
    this.tradeDuration = const Value.absent(),
  }) : datetime = Value(datetime),
       symbol = Value(symbol),
       entryPrice = Value(entryPrice),
       type = Value(type),
       status = Value(status),
       quantity = Value(quantity),
       entryDate = Value(entryDate),
       accountBalance = Value(accountBalance);
  static Insertable<Trade> custom({
    Expression<int>? id,
    Expression<String>? tag,
    Expression<DateTime>? datetime,
    Expression<String>? exchanges,
    Expression<String>? entryType,
    Expression<String>? symbol,
    Expression<String>? strategies,
    Expression<String>? side,
    Expression<double>? entryPrice,
    Expression<double>? positionMargin,
    Expression<double>? leverage,
    Expression<String>? orderType,
    Expression<String>? timeFrame,
    Expression<double>? entryFeeRate,
    Expression<String>? entryMentalStates,
    Expression<String>? entryScreenshot,
    Expression<String>? checklist,
    Expression<double>? stopLossPrice,
    Expression<double>? takeProfitPrice,
    Expression<double>? actualExitPrice,
    Expression<double>? marginClosedPercent,
    Expression<String>? exitType,
    Expression<double>? exitFeeRate,
    Expression<DateTime>? exitDatetime,
    Expression<String>? exitMentalStates,
    Expression<String>? exitScreenshot,
    Expression<int>? rating,
    Expression<String>? memo,
    Expression<String>? trackings,
    Expression<String>? mistakes,
    Expression<double>? transferAmount,
    Expression<String>? transferScreenshot,
    Expression<String>? type,
    Expression<String>? status,
    Expression<double>? exitPrice,
    Expression<double>? quantity,
    Expression<double>? stopLoss,
    Expression<double>? takeProfit,
    Expression<double>? pnl,
    Expression<double>? pnlPercent,
    Expression<double>? riskRewardRatio,
    Expression<DateTime>? entryDate,
    Expression<DateTime>? exitDate,
    Expression<String>? notes,
    Expression<String>? screenshotPath,
    Expression<double>? accountBalance,
    Expression<double>? riskAmount,
    Expression<double>? achievedR,
    Expression<int>? tradeDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (datetime != null) 'datetime': datetime,
      if (exchanges != null) 'exchanges': exchanges,
      if (entryType != null) 'entry_type': entryType,
      if (symbol != null) 'symbol': symbol,
      if (strategies != null) 'strategies': strategies,
      if (side != null) 'side': side,
      if (entryPrice != null) 'entry_price': entryPrice,
      if (positionMargin != null) 'position_margin': positionMargin,
      if (leverage != null) 'leverage': leverage,
      if (orderType != null) 'order_type': orderType,
      if (timeFrame != null) 'time_frame': timeFrame,
      if (entryFeeRate != null) 'entry_fee_rate': entryFeeRate,
      if (entryMentalStates != null) 'entry_mental_states': entryMentalStates,
      if (entryScreenshot != null) 'entry_screenshot': entryScreenshot,
      if (checklist != null) 'checklist': checklist,
      if (stopLossPrice != null) 'stop_loss_price': stopLossPrice,
      if (takeProfitPrice != null) 'take_profit_price': takeProfitPrice,
      if (actualExitPrice != null) 'actual_exit_price': actualExitPrice,
      if (marginClosedPercent != null)
        'margin_closed_percent': marginClosedPercent,
      if (exitType != null) 'exit_type': exitType,
      if (exitFeeRate != null) 'exit_fee_rate': exitFeeRate,
      if (exitDatetime != null) 'exit_datetime': exitDatetime,
      if (exitMentalStates != null) 'exit_mental_states': exitMentalStates,
      if (exitScreenshot != null) 'exit_screenshot': exitScreenshot,
      if (rating != null) 'rating': rating,
      if (memo != null) 'memo': memo,
      if (trackings != null) 'trackings': trackings,
      if (mistakes != null) 'mistakes': mistakes,
      if (transferAmount != null) 'transfer_amount': transferAmount,
      if (transferScreenshot != null) 'transfer_screenshot': transferScreenshot,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (exitPrice != null) 'exit_price': exitPrice,
      if (quantity != null) 'quantity': quantity,
      if (stopLoss != null) 'stop_loss': stopLoss,
      if (takeProfit != null) 'take_profit': takeProfit,
      if (pnl != null) 'pnl': pnl,
      if (pnlPercent != null) 'pnl_percent': pnlPercent,
      if (riskRewardRatio != null) 'risk_reward_ratio': riskRewardRatio,
      if (entryDate != null) 'entry_date': entryDate,
      if (exitDate != null) 'exit_date': exitDate,
      if (notes != null) 'notes': notes,
      if (screenshotPath != null) 'screenshot_path': screenshotPath,
      if (accountBalance != null) 'account_balance': accountBalance,
      if (riskAmount != null) 'risk_amount': riskAmount,
      if (achievedR != null) 'achieved_r': achievedR,
      if (tradeDuration != null) 'trade_duration': tradeDuration,
    });
  }

  TradesCompanion copyWith({
    Value<int>? id,
    Value<String?>? tag,
    Value<DateTime>? datetime,
    Value<String?>? exchanges,
    Value<String?>? entryType,
    Value<String>? symbol,
    Value<String?>? strategies,
    Value<String?>? side,
    Value<double>? entryPrice,
    Value<double?>? positionMargin,
    Value<double?>? leverage,
    Value<String?>? orderType,
    Value<String?>? timeFrame,
    Value<double?>? entryFeeRate,
    Value<String?>? entryMentalStates,
    Value<String?>? entryScreenshot,
    Value<String?>? checklist,
    Value<double?>? stopLossPrice,
    Value<double?>? takeProfitPrice,
    Value<double?>? actualExitPrice,
    Value<double?>? marginClosedPercent,
    Value<String?>? exitType,
    Value<double?>? exitFeeRate,
    Value<DateTime?>? exitDatetime,
    Value<String?>? exitMentalStates,
    Value<String?>? exitScreenshot,
    Value<int?>? rating,
    Value<String?>? memo,
    Value<String?>? trackings,
    Value<String?>? mistakes,
    Value<double?>? transferAmount,
    Value<String?>? transferScreenshot,
    Value<String>? type,
    Value<String>? status,
    Value<double?>? exitPrice,
    Value<double>? quantity,
    Value<double?>? stopLoss,
    Value<double?>? takeProfit,
    Value<double?>? pnl,
    Value<double?>? pnlPercent,
    Value<double?>? riskRewardRatio,
    Value<DateTime>? entryDate,
    Value<DateTime?>? exitDate,
    Value<String?>? notes,
    Value<String?>? screenshotPath,
    Value<double>? accountBalance,
    Value<double?>? riskAmount,
    Value<double?>? achievedR,
    Value<int?>? tradeDuration,
  }) {
    return TradesCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      datetime: datetime ?? this.datetime,
      exchanges: exchanges ?? this.exchanges,
      entryType: entryType ?? this.entryType,
      symbol: symbol ?? this.symbol,
      strategies: strategies ?? this.strategies,
      side: side ?? this.side,
      entryPrice: entryPrice ?? this.entryPrice,
      positionMargin: positionMargin ?? this.positionMargin,
      leverage: leverage ?? this.leverage,
      orderType: orderType ?? this.orderType,
      timeFrame: timeFrame ?? this.timeFrame,
      entryFeeRate: entryFeeRate ?? this.entryFeeRate,
      entryMentalStates: entryMentalStates ?? this.entryMentalStates,
      entryScreenshot: entryScreenshot ?? this.entryScreenshot,
      checklist: checklist ?? this.checklist,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      actualExitPrice: actualExitPrice ?? this.actualExitPrice,
      marginClosedPercent: marginClosedPercent ?? this.marginClosedPercent,
      exitType: exitType ?? this.exitType,
      exitFeeRate: exitFeeRate ?? this.exitFeeRate,
      exitDatetime: exitDatetime ?? this.exitDatetime,
      exitMentalStates: exitMentalStates ?? this.exitMentalStates,
      exitScreenshot: exitScreenshot ?? this.exitScreenshot,
      rating: rating ?? this.rating,
      memo: memo ?? this.memo,
      trackings: trackings ?? this.trackings,
      mistakes: mistakes ?? this.mistakes,
      transferAmount: transferAmount ?? this.transferAmount,
      transferScreenshot: transferScreenshot ?? this.transferScreenshot,
      type: type ?? this.type,
      status: status ?? this.status,
      exitPrice: exitPrice ?? this.exitPrice,
      quantity: quantity ?? this.quantity,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit: takeProfit ?? this.takeProfit,
      pnl: pnl ?? this.pnl,
      pnlPercent: pnlPercent ?? this.pnlPercent,
      riskRewardRatio: riskRewardRatio ?? this.riskRewardRatio,
      entryDate: entryDate ?? this.entryDate,
      exitDate: exitDate ?? this.exitDate,
      notes: notes ?? this.notes,
      screenshotPath: screenshotPath ?? this.screenshotPath,
      accountBalance: accountBalance ?? this.accountBalance,
      riskAmount: riskAmount ?? this.riskAmount,
      achievedR: achievedR ?? this.achievedR,
      tradeDuration: tradeDuration ?? this.tradeDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    if (exchanges.present) {
      map['exchanges'] = Variable<String>(exchanges.value);
    }
    if (entryType.present) {
      map['entry_type'] = Variable<String>(entryType.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (strategies.present) {
      map['strategies'] = Variable<String>(strategies.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (entryPrice.present) {
      map['entry_price'] = Variable<double>(entryPrice.value);
    }
    if (positionMargin.present) {
      map['position_margin'] = Variable<double>(positionMargin.value);
    }
    if (leverage.present) {
      map['leverage'] = Variable<double>(leverage.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (timeFrame.present) {
      map['time_frame'] = Variable<String>(timeFrame.value);
    }
    if (entryFeeRate.present) {
      map['entry_fee_rate'] = Variable<double>(entryFeeRate.value);
    }
    if (entryMentalStates.present) {
      map['entry_mental_states'] = Variable<String>(entryMentalStates.value);
    }
    if (entryScreenshot.present) {
      map['entry_screenshot'] = Variable<String>(entryScreenshot.value);
    }
    if (checklist.present) {
      map['checklist'] = Variable<String>(checklist.value);
    }
    if (stopLossPrice.present) {
      map['stop_loss_price'] = Variable<double>(stopLossPrice.value);
    }
    if (takeProfitPrice.present) {
      map['take_profit_price'] = Variable<double>(takeProfitPrice.value);
    }
    if (actualExitPrice.present) {
      map['actual_exit_price'] = Variable<double>(actualExitPrice.value);
    }
    if (marginClosedPercent.present) {
      map['margin_closed_percent'] = Variable<double>(
        marginClosedPercent.value,
      );
    }
    if (exitType.present) {
      map['exit_type'] = Variable<String>(exitType.value);
    }
    if (exitFeeRate.present) {
      map['exit_fee_rate'] = Variable<double>(exitFeeRate.value);
    }
    if (exitDatetime.present) {
      map['exit_datetime'] = Variable<DateTime>(exitDatetime.value);
    }
    if (exitMentalStates.present) {
      map['exit_mental_states'] = Variable<String>(exitMentalStates.value);
    }
    if (exitScreenshot.present) {
      map['exit_screenshot'] = Variable<String>(exitScreenshot.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (trackings.present) {
      map['trackings'] = Variable<String>(trackings.value);
    }
    if (mistakes.present) {
      map['mistakes'] = Variable<String>(mistakes.value);
    }
    if (transferAmount.present) {
      map['transfer_amount'] = Variable<double>(transferAmount.value);
    }
    if (transferScreenshot.present) {
      map['transfer_screenshot'] = Variable<String>(transferScreenshot.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (exitPrice.present) {
      map['exit_price'] = Variable<double>(exitPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (stopLoss.present) {
      map['stop_loss'] = Variable<double>(stopLoss.value);
    }
    if (takeProfit.present) {
      map['take_profit'] = Variable<double>(takeProfit.value);
    }
    if (pnl.present) {
      map['pnl'] = Variable<double>(pnl.value);
    }
    if (pnlPercent.present) {
      map['pnl_percent'] = Variable<double>(pnlPercent.value);
    }
    if (riskRewardRatio.present) {
      map['risk_reward_ratio'] = Variable<double>(riskRewardRatio.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
    }
    if (exitDate.present) {
      map['exit_date'] = Variable<DateTime>(exitDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (screenshotPath.present) {
      map['screenshot_path'] = Variable<String>(screenshotPath.value);
    }
    if (accountBalance.present) {
      map['account_balance'] = Variable<double>(accountBalance.value);
    }
    if (riskAmount.present) {
      map['risk_amount'] = Variable<double>(riskAmount.value);
    }
    if (achievedR.present) {
      map['achieved_r'] = Variable<double>(achievedR.value);
    }
    if (tradeDuration.present) {
      map['trade_duration'] = Variable<int>(tradeDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TradesCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('datetime: $datetime, ')
          ..write('exchanges: $exchanges, ')
          ..write('entryType: $entryType, ')
          ..write('symbol: $symbol, ')
          ..write('strategies: $strategies, ')
          ..write('side: $side, ')
          ..write('entryPrice: $entryPrice, ')
          ..write('positionMargin: $positionMargin, ')
          ..write('leverage: $leverage, ')
          ..write('orderType: $orderType, ')
          ..write('timeFrame: $timeFrame, ')
          ..write('entryFeeRate: $entryFeeRate, ')
          ..write('entryMentalStates: $entryMentalStates, ')
          ..write('entryScreenshot: $entryScreenshot, ')
          ..write('checklist: $checklist, ')
          ..write('stopLossPrice: $stopLossPrice, ')
          ..write('takeProfitPrice: $takeProfitPrice, ')
          ..write('actualExitPrice: $actualExitPrice, ')
          ..write('marginClosedPercent: $marginClosedPercent, ')
          ..write('exitType: $exitType, ')
          ..write('exitFeeRate: $exitFeeRate, ')
          ..write('exitDatetime: $exitDatetime, ')
          ..write('exitMentalStates: $exitMentalStates, ')
          ..write('exitScreenshot: $exitScreenshot, ')
          ..write('rating: $rating, ')
          ..write('memo: $memo, ')
          ..write('trackings: $trackings, ')
          ..write('mistakes: $mistakes, ')
          ..write('transferAmount: $transferAmount, ')
          ..write('transferScreenshot: $transferScreenshot, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('exitPrice: $exitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('stopLoss: $stopLoss, ')
          ..write('takeProfit: $takeProfit, ')
          ..write('pnl: $pnl, ')
          ..write('pnlPercent: $pnlPercent, ')
          ..write('riskRewardRatio: $riskRewardRatio, ')
          ..write('entryDate: $entryDate, ')
          ..write('exitDate: $exitDate, ')
          ..write('notes: $notes, ')
          ..write('screenshotPath: $screenshotPath, ')
          ..write('accountBalance: $accountBalance, ')
          ..write('riskAmount: $riskAmount, ')
          ..write('achievedR: $achievedR, ')
          ..write('tradeDuration: $tradeDuration')
          ..write(')'))
        .toString();
  }
}

class $UserDefinedValuesTable extends UserDefinedValues
    with TableInfo<$UserDefinedValuesTable, UserDefinedValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserDefinedValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    value,
    isDefault,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_defined_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserDefinedValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDefinedValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDefinedValue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserDefinedValuesTable createAlias(String alias) {
    return $UserDefinedValuesTable(attachedDatabase, alias);
  }
}

class UserDefinedValue extends DataClass
    implements Insertable<UserDefinedValue> {
  final int id;
  final String category;
  final String value;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserDefinedValue({
    required this.id,
    required this.category,
    required this.value,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['value'] = Variable<String>(value);
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserDefinedValuesCompanion toCompanion(bool nullToAbsent) {
    return UserDefinedValuesCompanion(
      id: Value(id),
      category: Value(category),
      value: Value(value),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserDefinedValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDefinedValue(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      value: serializer.fromJson<String>(json['value']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'value': serializer.toJson<String>(value),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserDefinedValue copyWith({
    int? id,
    String? category,
    String? value,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserDefinedValue(
    id: id ?? this.id,
    category: category ?? this.category,
    value: value ?? this.value,
    isDefault: isDefault ?? this.isDefault,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserDefinedValue copyWithCompanion(UserDefinedValuesCompanion data) {
    return UserDefinedValue(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      value: data.value.present ? data.value.value : this.value,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDefinedValue(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('value: $value, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, category, value, isDefault, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDefinedValue &&
          other.id == this.id &&
          other.category == this.category &&
          other.value == this.value &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserDefinedValuesCompanion extends UpdateCompanion<UserDefinedValue> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> value;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserDefinedValuesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.value = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserDefinedValuesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String value,
    this.isDefault = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : category = Value(category),
       value = Value(value),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserDefinedValue> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? value,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (value != null) 'value': value,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserDefinedValuesCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<String>? value,
    Value<bool>? isDefault,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserDefinedValuesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      value: value ?? this.value,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserDefinedValuesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('value: $value, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AccountTransactionsTable extends AccountTransactions
    with TableInfo<$AccountTransactionsTable, AccountTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, amount, date, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $AccountTransactionsTable createAlias(String alias) {
    return $AccountTransactionsTable(attachedDatabase, alias);
  }
}

class AccountTransaction extends DataClass
    implements Insertable<AccountTransaction> {
  final int id;
  final String type;
  final double amount;
  final DateTime date;
  final String? notes;
  const AccountTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  AccountTransactionsCompanion toCompanion(bool nullToAbsent) {
    return AccountTransactionsCompanion(
      id: Value(id),
      type: Value(type),
      amount: Value(amount),
      date: Value(date),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory AccountTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountTransaction(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  AccountTransaction copyWith({
    int? id,
    String? type,
    double? amount,
    DateTime? date,
    Value<String?> notes = const Value.absent(),
  }) => AccountTransaction(
    id: id ?? this.id,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    notes: notes.present ? notes.value : this.notes,
  );
  AccountTransaction copyWithCompanion(AccountTransactionsCompanion data) {
    return AccountTransaction(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountTransaction(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, amount, date, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountTransaction &&
          other.id == this.id &&
          other.type == this.type &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.notes == this.notes);
}

class AccountTransactionsCompanion extends UpdateCompanion<AccountTransaction> {
  final Value<int> id;
  final Value<String> type;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> notes;
  const AccountTransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.notes = const Value.absent(),
  });
  AccountTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required double amount,
    required DateTime date,
    this.notes = const Value.absent(),
  }) : type = Value(type),
       amount = Value(amount),
       date = Value(date);
  static Insertable<AccountTransaction> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (notes != null) 'notes': notes,
    });
  }

  AccountTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String?>? notes,
  }) {
    return AccountTransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $TradeStatisticsTableTable extends TradeStatisticsTable
    with TableInfo<$TradeStatisticsTableTable, TradeStatisticsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TradeStatisticsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _totalTradesMeta = const VerificationMeta(
    'totalTrades',
  );
  @override
  late final GeneratedColumn<double> totalTrades = GeneratedColumn<double>(
    'total_trades',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _winningTradesMeta = const VerificationMeta(
    'winningTrades',
  );
  @override
  late final GeneratedColumn<double> winningTrades = GeneratedColumn<double>(
    'winning_trades',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _losingTradesMeta = const VerificationMeta(
    'losingTrades',
  );
  @override
  late final GeneratedColumn<double> losingTrades = GeneratedColumn<double>(
    'losing_trades',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breakevenTradesMeta = const VerificationMeta(
    'breakevenTrades',
  );
  @override
  late final GeneratedColumn<double> breakevenTrades = GeneratedColumn<double>(
    'breakeven_trades',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openPositionsMeta = const VerificationMeta(
    'openPositions',
  );
  @override
  late final GeneratedColumn<double> openPositions = GeneratedColumn<double>(
    'open_positions',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgAchievedRMeta = const VerificationMeta(
    'avgAchievedR',
  );
  @override
  late final GeneratedColumn<double> avgAchievedR = GeneratedColumn<double>(
    'avg_achieved_r',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgTradeDurationMeta = const VerificationMeta(
    'avgTradeDuration',
  );
  @override
  late final GeneratedColumn<double> avgTradeDuration = GeneratedColumn<double>(
    'avg_trade_duration',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overallPnlMeta = const VerificationMeta(
    'overallPnl',
  );
  @override
  late final GeneratedColumn<double> overallPnl = GeneratedColumn<double>(
    'overall_pnl',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avgPnlMeta = const VerificationMeta('avgPnl');
  @override
  late final GeneratedColumn<double> avgPnl = GeneratedColumn<double>(
    'avg_pnl',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAccountGrowthMeta =
      const VerificationMeta('totalAccountGrowth');
  @override
  late final GeneratedColumn<double> totalAccountGrowth =
      GeneratedColumn<double>(
        'total_account_growth',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _totalDepositsMeta = const VerificationMeta(
    'totalDeposits',
  );
  @override
  late final GeneratedColumn<double> totalDeposits = GeneratedColumn<double>(
    'total_deposits',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalWithdrawalsMeta = const VerificationMeta(
    'totalWithdrawals',
  );
  @override
  late final GeneratedColumn<double> totalWithdrawals = GeneratedColumn<double>(
    'total_withdrawals',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentAccountBalanceMeta =
      const VerificationMeta('currentAccountBalance');
  @override
  late final GeneratedColumn<double> currentAccountBalance =
      GeneratedColumn<double>(
        'current_account_balance',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalTrades,
    winningTrades,
    losingTrades,
    breakevenTrades,
    openPositions,
    avgAchievedR,
    avgTradeDuration,
    overallPnl,
    avgPnl,
    totalAccountGrowth,
    totalDeposits,
    totalWithdrawals,
    currentAccountBalance,
    lastUpdated,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trade_statistics_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TradeStatisticsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_trades')) {
      context.handle(
        _totalTradesMeta,
        totalTrades.isAcceptableOrUnknown(
          data['total_trades']!,
          _totalTradesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalTradesMeta);
    }
    if (data.containsKey('winning_trades')) {
      context.handle(
        _winningTradesMeta,
        winningTrades.isAcceptableOrUnknown(
          data['winning_trades']!,
          _winningTradesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_winningTradesMeta);
    }
    if (data.containsKey('losing_trades')) {
      context.handle(
        _losingTradesMeta,
        losingTrades.isAcceptableOrUnknown(
          data['losing_trades']!,
          _losingTradesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_losingTradesMeta);
    }
    if (data.containsKey('breakeven_trades')) {
      context.handle(
        _breakevenTradesMeta,
        breakevenTrades.isAcceptableOrUnknown(
          data['breakeven_trades']!,
          _breakevenTradesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_breakevenTradesMeta);
    }
    if (data.containsKey('open_positions')) {
      context.handle(
        _openPositionsMeta,
        openPositions.isAcceptableOrUnknown(
          data['open_positions']!,
          _openPositionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openPositionsMeta);
    }
    if (data.containsKey('avg_achieved_r')) {
      context.handle(
        _avgAchievedRMeta,
        avgAchievedR.isAcceptableOrUnknown(
          data['avg_achieved_r']!,
          _avgAchievedRMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_avgAchievedRMeta);
    }
    if (data.containsKey('avg_trade_duration')) {
      context.handle(
        _avgTradeDurationMeta,
        avgTradeDuration.isAcceptableOrUnknown(
          data['avg_trade_duration']!,
          _avgTradeDurationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_avgTradeDurationMeta);
    }
    if (data.containsKey('overall_pnl')) {
      context.handle(
        _overallPnlMeta,
        overallPnl.isAcceptableOrUnknown(data['overall_pnl']!, _overallPnlMeta),
      );
    } else if (isInserting) {
      context.missing(_overallPnlMeta);
    }
    if (data.containsKey('avg_pnl')) {
      context.handle(
        _avgPnlMeta,
        avgPnl.isAcceptableOrUnknown(data['avg_pnl']!, _avgPnlMeta),
      );
    } else if (isInserting) {
      context.missing(_avgPnlMeta);
    }
    if (data.containsKey('total_account_growth')) {
      context.handle(
        _totalAccountGrowthMeta,
        totalAccountGrowth.isAcceptableOrUnknown(
          data['total_account_growth']!,
          _totalAccountGrowthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAccountGrowthMeta);
    }
    if (data.containsKey('total_deposits')) {
      context.handle(
        _totalDepositsMeta,
        totalDeposits.isAcceptableOrUnknown(
          data['total_deposits']!,
          _totalDepositsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDepositsMeta);
    }
    if (data.containsKey('total_withdrawals')) {
      context.handle(
        _totalWithdrawalsMeta,
        totalWithdrawals.isAcceptableOrUnknown(
          data['total_withdrawals']!,
          _totalWithdrawalsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalWithdrawalsMeta);
    }
    if (data.containsKey('current_account_balance')) {
      context.handle(
        _currentAccountBalanceMeta,
        currentAccountBalance.isAcceptableOrUnknown(
          data['current_account_balance']!,
          _currentAccountBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentAccountBalanceMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TradeStatisticsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TradeStatisticsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalTrades: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_trades'],
      )!,
      winningTrades: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}winning_trades'],
      )!,
      losingTrades: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}losing_trades'],
      )!,
      breakevenTrades: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}breakeven_trades'],
      )!,
      openPositions: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}open_positions'],
      )!,
      avgAchievedR: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_achieved_r'],
      )!,
      avgTradeDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_trade_duration'],
      )!,
      overallPnl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}overall_pnl'],
      )!,
      avgPnl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_pnl'],
      )!,
      totalAccountGrowth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_account_growth'],
      )!,
      totalDeposits: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_deposits'],
      )!,
      totalWithdrawals: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_withdrawals'],
      )!,
      currentAccountBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_account_balance'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $TradeStatisticsTableTable createAlias(String alias) {
    return $TradeStatisticsTableTable(attachedDatabase, alias);
  }
}

class TradeStatisticsTableData extends DataClass
    implements Insertable<TradeStatisticsTableData> {
  final int id;
  final double totalTrades;
  final double winningTrades;
  final double losingTrades;
  final double breakevenTrades;
  final double openPositions;
  final double avgAchievedR;
  final double avgTradeDuration;
  final double overallPnl;
  final double avgPnl;
  final double totalAccountGrowth;
  final double totalDeposits;
  final double totalWithdrawals;
  final double currentAccountBalance;
  final DateTime lastUpdated;
  const TradeStatisticsTableData({
    required this.id,
    required this.totalTrades,
    required this.winningTrades,
    required this.losingTrades,
    required this.breakevenTrades,
    required this.openPositions,
    required this.avgAchievedR,
    required this.avgTradeDuration,
    required this.overallPnl,
    required this.avgPnl,
    required this.totalAccountGrowth,
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.currentAccountBalance,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_trades'] = Variable<double>(totalTrades);
    map['winning_trades'] = Variable<double>(winningTrades);
    map['losing_trades'] = Variable<double>(losingTrades);
    map['breakeven_trades'] = Variable<double>(breakevenTrades);
    map['open_positions'] = Variable<double>(openPositions);
    map['avg_achieved_r'] = Variable<double>(avgAchievedR);
    map['avg_trade_duration'] = Variable<double>(avgTradeDuration);
    map['overall_pnl'] = Variable<double>(overallPnl);
    map['avg_pnl'] = Variable<double>(avgPnl);
    map['total_account_growth'] = Variable<double>(totalAccountGrowth);
    map['total_deposits'] = Variable<double>(totalDeposits);
    map['total_withdrawals'] = Variable<double>(totalWithdrawals);
    map['current_account_balance'] = Variable<double>(currentAccountBalance);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  TradeStatisticsTableCompanion toCompanion(bool nullToAbsent) {
    return TradeStatisticsTableCompanion(
      id: Value(id),
      totalTrades: Value(totalTrades),
      winningTrades: Value(winningTrades),
      losingTrades: Value(losingTrades),
      breakevenTrades: Value(breakevenTrades),
      openPositions: Value(openPositions),
      avgAchievedR: Value(avgAchievedR),
      avgTradeDuration: Value(avgTradeDuration),
      overallPnl: Value(overallPnl),
      avgPnl: Value(avgPnl),
      totalAccountGrowth: Value(totalAccountGrowth),
      totalDeposits: Value(totalDeposits),
      totalWithdrawals: Value(totalWithdrawals),
      currentAccountBalance: Value(currentAccountBalance),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory TradeStatisticsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TradeStatisticsTableData(
      id: serializer.fromJson<int>(json['id']),
      totalTrades: serializer.fromJson<double>(json['totalTrades']),
      winningTrades: serializer.fromJson<double>(json['winningTrades']),
      losingTrades: serializer.fromJson<double>(json['losingTrades']),
      breakevenTrades: serializer.fromJson<double>(json['breakevenTrades']),
      openPositions: serializer.fromJson<double>(json['openPositions']),
      avgAchievedR: serializer.fromJson<double>(json['avgAchievedR']),
      avgTradeDuration: serializer.fromJson<double>(json['avgTradeDuration']),
      overallPnl: serializer.fromJson<double>(json['overallPnl']),
      avgPnl: serializer.fromJson<double>(json['avgPnl']),
      totalAccountGrowth: serializer.fromJson<double>(
        json['totalAccountGrowth'],
      ),
      totalDeposits: serializer.fromJson<double>(json['totalDeposits']),
      totalWithdrawals: serializer.fromJson<double>(json['totalWithdrawals']),
      currentAccountBalance: serializer.fromJson<double>(
        json['currentAccountBalance'],
      ),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalTrades': serializer.toJson<double>(totalTrades),
      'winningTrades': serializer.toJson<double>(winningTrades),
      'losingTrades': serializer.toJson<double>(losingTrades),
      'breakevenTrades': serializer.toJson<double>(breakevenTrades),
      'openPositions': serializer.toJson<double>(openPositions),
      'avgAchievedR': serializer.toJson<double>(avgAchievedR),
      'avgTradeDuration': serializer.toJson<double>(avgTradeDuration),
      'overallPnl': serializer.toJson<double>(overallPnl),
      'avgPnl': serializer.toJson<double>(avgPnl),
      'totalAccountGrowth': serializer.toJson<double>(totalAccountGrowth),
      'totalDeposits': serializer.toJson<double>(totalDeposits),
      'totalWithdrawals': serializer.toJson<double>(totalWithdrawals),
      'currentAccountBalance': serializer.toJson<double>(currentAccountBalance),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  TradeStatisticsTableData copyWith({
    int? id,
    double? totalTrades,
    double? winningTrades,
    double? losingTrades,
    double? breakevenTrades,
    double? openPositions,
    double? avgAchievedR,
    double? avgTradeDuration,
    double? overallPnl,
    double? avgPnl,
    double? totalAccountGrowth,
    double? totalDeposits,
    double? totalWithdrawals,
    double? currentAccountBalance,
    DateTime? lastUpdated,
  }) => TradeStatisticsTableData(
    id: id ?? this.id,
    totalTrades: totalTrades ?? this.totalTrades,
    winningTrades: winningTrades ?? this.winningTrades,
    losingTrades: losingTrades ?? this.losingTrades,
    breakevenTrades: breakevenTrades ?? this.breakevenTrades,
    openPositions: openPositions ?? this.openPositions,
    avgAchievedR: avgAchievedR ?? this.avgAchievedR,
    avgTradeDuration: avgTradeDuration ?? this.avgTradeDuration,
    overallPnl: overallPnl ?? this.overallPnl,
    avgPnl: avgPnl ?? this.avgPnl,
    totalAccountGrowth: totalAccountGrowth ?? this.totalAccountGrowth,
    totalDeposits: totalDeposits ?? this.totalDeposits,
    totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
    currentAccountBalance: currentAccountBalance ?? this.currentAccountBalance,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  TradeStatisticsTableData copyWithCompanion(
    TradeStatisticsTableCompanion data,
  ) {
    return TradeStatisticsTableData(
      id: data.id.present ? data.id.value : this.id,
      totalTrades: data.totalTrades.present
          ? data.totalTrades.value
          : this.totalTrades,
      winningTrades: data.winningTrades.present
          ? data.winningTrades.value
          : this.winningTrades,
      losingTrades: data.losingTrades.present
          ? data.losingTrades.value
          : this.losingTrades,
      breakevenTrades: data.breakevenTrades.present
          ? data.breakevenTrades.value
          : this.breakevenTrades,
      openPositions: data.openPositions.present
          ? data.openPositions.value
          : this.openPositions,
      avgAchievedR: data.avgAchievedR.present
          ? data.avgAchievedR.value
          : this.avgAchievedR,
      avgTradeDuration: data.avgTradeDuration.present
          ? data.avgTradeDuration.value
          : this.avgTradeDuration,
      overallPnl: data.overallPnl.present
          ? data.overallPnl.value
          : this.overallPnl,
      avgPnl: data.avgPnl.present ? data.avgPnl.value : this.avgPnl,
      totalAccountGrowth: data.totalAccountGrowth.present
          ? data.totalAccountGrowth.value
          : this.totalAccountGrowth,
      totalDeposits: data.totalDeposits.present
          ? data.totalDeposits.value
          : this.totalDeposits,
      totalWithdrawals: data.totalWithdrawals.present
          ? data.totalWithdrawals.value
          : this.totalWithdrawals,
      currentAccountBalance: data.currentAccountBalance.present
          ? data.currentAccountBalance.value
          : this.currentAccountBalance,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TradeStatisticsTableData(')
          ..write('id: $id, ')
          ..write('totalTrades: $totalTrades, ')
          ..write('winningTrades: $winningTrades, ')
          ..write('losingTrades: $losingTrades, ')
          ..write('breakevenTrades: $breakevenTrades, ')
          ..write('openPositions: $openPositions, ')
          ..write('avgAchievedR: $avgAchievedR, ')
          ..write('avgTradeDuration: $avgTradeDuration, ')
          ..write('overallPnl: $overallPnl, ')
          ..write('avgPnl: $avgPnl, ')
          ..write('totalAccountGrowth: $totalAccountGrowth, ')
          ..write('totalDeposits: $totalDeposits, ')
          ..write('totalWithdrawals: $totalWithdrawals, ')
          ..write('currentAccountBalance: $currentAccountBalance, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalTrades,
    winningTrades,
    losingTrades,
    breakevenTrades,
    openPositions,
    avgAchievedR,
    avgTradeDuration,
    overallPnl,
    avgPnl,
    totalAccountGrowth,
    totalDeposits,
    totalWithdrawals,
    currentAccountBalance,
    lastUpdated,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TradeStatisticsTableData &&
          other.id == this.id &&
          other.totalTrades == this.totalTrades &&
          other.winningTrades == this.winningTrades &&
          other.losingTrades == this.losingTrades &&
          other.breakevenTrades == this.breakevenTrades &&
          other.openPositions == this.openPositions &&
          other.avgAchievedR == this.avgAchievedR &&
          other.avgTradeDuration == this.avgTradeDuration &&
          other.overallPnl == this.overallPnl &&
          other.avgPnl == this.avgPnl &&
          other.totalAccountGrowth == this.totalAccountGrowth &&
          other.totalDeposits == this.totalDeposits &&
          other.totalWithdrawals == this.totalWithdrawals &&
          other.currentAccountBalance == this.currentAccountBalance &&
          other.lastUpdated == this.lastUpdated);
}

class TradeStatisticsTableCompanion
    extends UpdateCompanion<TradeStatisticsTableData> {
  final Value<int> id;
  final Value<double> totalTrades;
  final Value<double> winningTrades;
  final Value<double> losingTrades;
  final Value<double> breakevenTrades;
  final Value<double> openPositions;
  final Value<double> avgAchievedR;
  final Value<double> avgTradeDuration;
  final Value<double> overallPnl;
  final Value<double> avgPnl;
  final Value<double> totalAccountGrowth;
  final Value<double> totalDeposits;
  final Value<double> totalWithdrawals;
  final Value<double> currentAccountBalance;
  final Value<DateTime> lastUpdated;
  const TradeStatisticsTableCompanion({
    this.id = const Value.absent(),
    this.totalTrades = const Value.absent(),
    this.winningTrades = const Value.absent(),
    this.losingTrades = const Value.absent(),
    this.breakevenTrades = const Value.absent(),
    this.openPositions = const Value.absent(),
    this.avgAchievedR = const Value.absent(),
    this.avgTradeDuration = const Value.absent(),
    this.overallPnl = const Value.absent(),
    this.avgPnl = const Value.absent(),
    this.totalAccountGrowth = const Value.absent(),
    this.totalDeposits = const Value.absent(),
    this.totalWithdrawals = const Value.absent(),
    this.currentAccountBalance = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  TradeStatisticsTableCompanion.insert({
    this.id = const Value.absent(),
    required double totalTrades,
    required double winningTrades,
    required double losingTrades,
    required double breakevenTrades,
    required double openPositions,
    required double avgAchievedR,
    required double avgTradeDuration,
    required double overallPnl,
    required double avgPnl,
    required double totalAccountGrowth,
    required double totalDeposits,
    required double totalWithdrawals,
    required double currentAccountBalance,
    required DateTime lastUpdated,
  }) : totalTrades = Value(totalTrades),
       winningTrades = Value(winningTrades),
       losingTrades = Value(losingTrades),
       breakevenTrades = Value(breakevenTrades),
       openPositions = Value(openPositions),
       avgAchievedR = Value(avgAchievedR),
       avgTradeDuration = Value(avgTradeDuration),
       overallPnl = Value(overallPnl),
       avgPnl = Value(avgPnl),
       totalAccountGrowth = Value(totalAccountGrowth),
       totalDeposits = Value(totalDeposits),
       totalWithdrawals = Value(totalWithdrawals),
       currentAccountBalance = Value(currentAccountBalance),
       lastUpdated = Value(lastUpdated);
  static Insertable<TradeStatisticsTableData> custom({
    Expression<int>? id,
    Expression<double>? totalTrades,
    Expression<double>? winningTrades,
    Expression<double>? losingTrades,
    Expression<double>? breakevenTrades,
    Expression<double>? openPositions,
    Expression<double>? avgAchievedR,
    Expression<double>? avgTradeDuration,
    Expression<double>? overallPnl,
    Expression<double>? avgPnl,
    Expression<double>? totalAccountGrowth,
    Expression<double>? totalDeposits,
    Expression<double>? totalWithdrawals,
    Expression<double>? currentAccountBalance,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalTrades != null) 'total_trades': totalTrades,
      if (winningTrades != null) 'winning_trades': winningTrades,
      if (losingTrades != null) 'losing_trades': losingTrades,
      if (breakevenTrades != null) 'breakeven_trades': breakevenTrades,
      if (openPositions != null) 'open_positions': openPositions,
      if (avgAchievedR != null) 'avg_achieved_r': avgAchievedR,
      if (avgTradeDuration != null) 'avg_trade_duration': avgTradeDuration,
      if (overallPnl != null) 'overall_pnl': overallPnl,
      if (avgPnl != null) 'avg_pnl': avgPnl,
      if (totalAccountGrowth != null)
        'total_account_growth': totalAccountGrowth,
      if (totalDeposits != null) 'total_deposits': totalDeposits,
      if (totalWithdrawals != null) 'total_withdrawals': totalWithdrawals,
      if (currentAccountBalance != null)
        'current_account_balance': currentAccountBalance,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  TradeStatisticsTableCompanion copyWith({
    Value<int>? id,
    Value<double>? totalTrades,
    Value<double>? winningTrades,
    Value<double>? losingTrades,
    Value<double>? breakevenTrades,
    Value<double>? openPositions,
    Value<double>? avgAchievedR,
    Value<double>? avgTradeDuration,
    Value<double>? overallPnl,
    Value<double>? avgPnl,
    Value<double>? totalAccountGrowth,
    Value<double>? totalDeposits,
    Value<double>? totalWithdrawals,
    Value<double>? currentAccountBalance,
    Value<DateTime>? lastUpdated,
  }) {
    return TradeStatisticsTableCompanion(
      id: id ?? this.id,
      totalTrades: totalTrades ?? this.totalTrades,
      winningTrades: winningTrades ?? this.winningTrades,
      losingTrades: losingTrades ?? this.losingTrades,
      breakevenTrades: breakevenTrades ?? this.breakevenTrades,
      openPositions: openPositions ?? this.openPositions,
      avgAchievedR: avgAchievedR ?? this.avgAchievedR,
      avgTradeDuration: avgTradeDuration ?? this.avgTradeDuration,
      overallPnl: overallPnl ?? this.overallPnl,
      avgPnl: avgPnl ?? this.avgPnl,
      totalAccountGrowth: totalAccountGrowth ?? this.totalAccountGrowth,
      totalDeposits: totalDeposits ?? this.totalDeposits,
      totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
      currentAccountBalance:
          currentAccountBalance ?? this.currentAccountBalance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalTrades.present) {
      map['total_trades'] = Variable<double>(totalTrades.value);
    }
    if (winningTrades.present) {
      map['winning_trades'] = Variable<double>(winningTrades.value);
    }
    if (losingTrades.present) {
      map['losing_trades'] = Variable<double>(losingTrades.value);
    }
    if (breakevenTrades.present) {
      map['breakeven_trades'] = Variable<double>(breakevenTrades.value);
    }
    if (openPositions.present) {
      map['open_positions'] = Variable<double>(openPositions.value);
    }
    if (avgAchievedR.present) {
      map['avg_achieved_r'] = Variable<double>(avgAchievedR.value);
    }
    if (avgTradeDuration.present) {
      map['avg_trade_duration'] = Variable<double>(avgTradeDuration.value);
    }
    if (overallPnl.present) {
      map['overall_pnl'] = Variable<double>(overallPnl.value);
    }
    if (avgPnl.present) {
      map['avg_pnl'] = Variable<double>(avgPnl.value);
    }
    if (totalAccountGrowth.present) {
      map['total_account_growth'] = Variable<double>(totalAccountGrowth.value);
    }
    if (totalDeposits.present) {
      map['total_deposits'] = Variable<double>(totalDeposits.value);
    }
    if (totalWithdrawals.present) {
      map['total_withdrawals'] = Variable<double>(totalWithdrawals.value);
    }
    if (currentAccountBalance.present) {
      map['current_account_balance'] = Variable<double>(
        currentAccountBalance.value,
      );
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TradeStatisticsTableCompanion(')
          ..write('id: $id, ')
          ..write('totalTrades: $totalTrades, ')
          ..write('winningTrades: $winningTrades, ')
          ..write('losingTrades: $losingTrades, ')
          ..write('breakevenTrades: $breakevenTrades, ')
          ..write('openPositions: $openPositions, ')
          ..write('avgAchievedR: $avgAchievedR, ')
          ..write('avgTradeDuration: $avgTradeDuration, ')
          ..write('overallPnl: $overallPnl, ')
          ..write('avgPnl: $avgPnl, ')
          ..write('totalAccountGrowth: $totalAccountGrowth, ')
          ..write('totalDeposits: $totalDeposits, ')
          ..write('totalWithdrawals: $totalWithdrawals, ')
          ..write('currentAccountBalance: $currentAccountBalance, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

abstract class _$TradeMateDatabase extends GeneratedDatabase {
  _$TradeMateDatabase(QueryExecutor e) : super(e);
  $TradeMateDatabaseManager get managers => $TradeMateDatabaseManager(this);
  late final $TradesTable trades = $TradesTable(this);
  late final $UserDefinedValuesTable userDefinedValues =
      $UserDefinedValuesTable(this);
  late final $AccountTransactionsTable accountTransactions =
      $AccountTransactionsTable(this);
  late final $TradeStatisticsTableTable tradeStatisticsTable =
      $TradeStatisticsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trades,
    userDefinedValues,
    accountTransactions,
    tradeStatisticsTable,
  ];
}

typedef $$TradesTableCreateCompanionBuilder =
    TradesCompanion Function({
      Value<int> id,
      Value<String?> tag,
      required DateTime datetime,
      Value<String?> exchanges,
      Value<String?> entryType,
      required String symbol,
      Value<String?> strategies,
      Value<String?> side,
      required double entryPrice,
      Value<double?> positionMargin,
      Value<double?> leverage,
      Value<String?> orderType,
      Value<String?> timeFrame,
      Value<double?> entryFeeRate,
      Value<String?> entryMentalStates,
      Value<String?> entryScreenshot,
      Value<String?> checklist,
      Value<double?> stopLossPrice,
      Value<double?> takeProfitPrice,
      Value<double?> actualExitPrice,
      Value<double?> marginClosedPercent,
      Value<String?> exitType,
      Value<double?> exitFeeRate,
      Value<DateTime?> exitDatetime,
      Value<String?> exitMentalStates,
      Value<String?> exitScreenshot,
      Value<int?> rating,
      Value<String?> memo,
      Value<String?> trackings,
      Value<String?> mistakes,
      Value<double?> transferAmount,
      Value<String?> transferScreenshot,
      required String type,
      required String status,
      Value<double?> exitPrice,
      required double quantity,
      Value<double?> stopLoss,
      Value<double?> takeProfit,
      Value<double?> pnl,
      Value<double?> pnlPercent,
      Value<double?> riskRewardRatio,
      required DateTime entryDate,
      Value<DateTime?> exitDate,
      Value<String?> notes,
      Value<String?> screenshotPath,
      required double accountBalance,
      Value<double?> riskAmount,
      Value<double?> achievedR,
      Value<int?> tradeDuration,
    });
typedef $$TradesTableUpdateCompanionBuilder =
    TradesCompanion Function({
      Value<int> id,
      Value<String?> tag,
      Value<DateTime> datetime,
      Value<String?> exchanges,
      Value<String?> entryType,
      Value<String> symbol,
      Value<String?> strategies,
      Value<String?> side,
      Value<double> entryPrice,
      Value<double?> positionMargin,
      Value<double?> leverage,
      Value<String?> orderType,
      Value<String?> timeFrame,
      Value<double?> entryFeeRate,
      Value<String?> entryMentalStates,
      Value<String?> entryScreenshot,
      Value<String?> checklist,
      Value<double?> stopLossPrice,
      Value<double?> takeProfitPrice,
      Value<double?> actualExitPrice,
      Value<double?> marginClosedPercent,
      Value<String?> exitType,
      Value<double?> exitFeeRate,
      Value<DateTime?> exitDatetime,
      Value<String?> exitMentalStates,
      Value<String?> exitScreenshot,
      Value<int?> rating,
      Value<String?> memo,
      Value<String?> trackings,
      Value<String?> mistakes,
      Value<double?> transferAmount,
      Value<String?> transferScreenshot,
      Value<String> type,
      Value<String> status,
      Value<double?> exitPrice,
      Value<double> quantity,
      Value<double?> stopLoss,
      Value<double?> takeProfit,
      Value<double?> pnl,
      Value<double?> pnlPercent,
      Value<double?> riskRewardRatio,
      Value<DateTime> entryDate,
      Value<DateTime?> exitDate,
      Value<String?> notes,
      Value<String?> screenshotPath,
      Value<double> accountBalance,
      Value<double?> riskAmount,
      Value<double?> achievedR,
      Value<int?> tradeDuration,
    });

class $$TradesTableFilterComposer
    extends Composer<_$TradeMateDatabase, $TradesTable> {
  $$TradesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get datetime => $composableBuilder(
    column: $table.datetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exchanges => $composableBuilder(
    column: $table.exchanges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryType => $composableBuilder(
    column: $table.entryType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get strategies => $composableBuilder(
    column: $table.strategies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get entryPrice => $composableBuilder(
    column: $table.entryPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get positionMargin => $composableBuilder(
    column: $table.positionMargin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get leverage => $composableBuilder(
    column: $table.leverage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeFrame => $composableBuilder(
    column: $table.timeFrame,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get entryFeeRate => $composableBuilder(
    column: $table.entryFeeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryMentalStates => $composableBuilder(
    column: $table.entryMentalStates,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryScreenshot => $composableBuilder(
    column: $table.entryScreenshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checklist => $composableBuilder(
    column: $table.checklist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stopLossPrice => $composableBuilder(
    column: $table.stopLossPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get takeProfitPrice => $composableBuilder(
    column: $table.takeProfitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualExitPrice => $composableBuilder(
    column: $table.actualExitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get marginClosedPercent => $composableBuilder(
    column: $table.marginClosedPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exitType => $composableBuilder(
    column: $table.exitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exitFeeRate => $composableBuilder(
    column: $table.exitFeeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get exitDatetime => $composableBuilder(
    column: $table.exitDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exitMentalStates => $composableBuilder(
    column: $table.exitMentalStates,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exitScreenshot => $composableBuilder(
    column: $table.exitScreenshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackings => $composableBuilder(
    column: $table.trackings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get transferAmount => $composableBuilder(
    column: $table.transferAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferScreenshot => $composableBuilder(
    column: $table.transferScreenshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exitPrice => $composableBuilder(
    column: $table.exitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stopLoss => $composableBuilder(
    column: $table.stopLoss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get takeProfit => $composableBuilder(
    column: $table.takeProfit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pnl => $composableBuilder(
    column: $table.pnl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pnlPercent => $composableBuilder(
    column: $table.pnlPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get riskRewardRatio => $composableBuilder(
    column: $table.riskRewardRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get exitDate => $composableBuilder(
    column: $table.exitDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get screenshotPath => $composableBuilder(
    column: $table.screenshotPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accountBalance => $composableBuilder(
    column: $table.accountBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get riskAmount => $composableBuilder(
    column: $table.riskAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get achievedR => $composableBuilder(
    column: $table.achievedR,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tradeDuration => $composableBuilder(
    column: $table.tradeDuration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TradesTableOrderingComposer
    extends Composer<_$TradeMateDatabase, $TradesTable> {
  $$TradesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get datetime => $composableBuilder(
    column: $table.datetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exchanges => $composableBuilder(
    column: $table.exchanges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryType => $composableBuilder(
    column: $table.entryType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get strategies => $composableBuilder(
    column: $table.strategies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get entryPrice => $composableBuilder(
    column: $table.entryPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get positionMargin => $composableBuilder(
    column: $table.positionMargin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get leverage => $composableBuilder(
    column: $table.leverage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderType => $composableBuilder(
    column: $table.orderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeFrame => $composableBuilder(
    column: $table.timeFrame,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get entryFeeRate => $composableBuilder(
    column: $table.entryFeeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryMentalStates => $composableBuilder(
    column: $table.entryMentalStates,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryScreenshot => $composableBuilder(
    column: $table.entryScreenshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checklist => $composableBuilder(
    column: $table.checklist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stopLossPrice => $composableBuilder(
    column: $table.stopLossPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get takeProfitPrice => $composableBuilder(
    column: $table.takeProfitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualExitPrice => $composableBuilder(
    column: $table.actualExitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get marginClosedPercent => $composableBuilder(
    column: $table.marginClosedPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exitType => $composableBuilder(
    column: $table.exitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exitFeeRate => $composableBuilder(
    column: $table.exitFeeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get exitDatetime => $composableBuilder(
    column: $table.exitDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exitMentalStates => $composableBuilder(
    column: $table.exitMentalStates,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exitScreenshot => $composableBuilder(
    column: $table.exitScreenshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memo => $composableBuilder(
    column: $table.memo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackings => $composableBuilder(
    column: $table.trackings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get transferAmount => $composableBuilder(
    column: $table.transferAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferScreenshot => $composableBuilder(
    column: $table.transferScreenshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exitPrice => $composableBuilder(
    column: $table.exitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stopLoss => $composableBuilder(
    column: $table.stopLoss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get takeProfit => $composableBuilder(
    column: $table.takeProfit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pnl => $composableBuilder(
    column: $table.pnl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pnlPercent => $composableBuilder(
    column: $table.pnlPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get riskRewardRatio => $composableBuilder(
    column: $table.riskRewardRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get exitDate => $composableBuilder(
    column: $table.exitDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get screenshotPath => $composableBuilder(
    column: $table.screenshotPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accountBalance => $composableBuilder(
    column: $table.accountBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get riskAmount => $composableBuilder(
    column: $table.riskAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get achievedR => $composableBuilder(
    column: $table.achievedR,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tradeDuration => $composableBuilder(
    column: $table.tradeDuration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TradesTableAnnotationComposer
    extends Composer<_$TradeMateDatabase, $TradesTable> {
  $$TradesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<DateTime> get datetime =>
      $composableBuilder(column: $table.datetime, builder: (column) => column);

  GeneratedColumn<String> get exchanges =>
      $composableBuilder(column: $table.exchanges, builder: (column) => column);

  GeneratedColumn<String> get entryType =>
      $composableBuilder(column: $table.entryType, builder: (column) => column);

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get strategies => $composableBuilder(
    column: $table.strategies,
    builder: (column) => column,
  );

  GeneratedColumn<String> get side =>
      $composableBuilder(column: $table.side, builder: (column) => column);

  GeneratedColumn<double> get entryPrice => $composableBuilder(
    column: $table.entryPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get positionMargin => $composableBuilder(
    column: $table.positionMargin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get leverage =>
      $composableBuilder(column: $table.leverage, builder: (column) => column);

  GeneratedColumn<String> get orderType =>
      $composableBuilder(column: $table.orderType, builder: (column) => column);

  GeneratedColumn<String> get timeFrame =>
      $composableBuilder(column: $table.timeFrame, builder: (column) => column);

  GeneratedColumn<double> get entryFeeRate => $composableBuilder(
    column: $table.entryFeeRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entryMentalStates => $composableBuilder(
    column: $table.entryMentalStates,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entryScreenshot => $composableBuilder(
    column: $table.entryScreenshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checklist =>
      $composableBuilder(column: $table.checklist, builder: (column) => column);

  GeneratedColumn<double> get stopLossPrice => $composableBuilder(
    column: $table.stopLossPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get takeProfitPrice => $composableBuilder(
    column: $table.takeProfitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualExitPrice => $composableBuilder(
    column: $table.actualExitPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get marginClosedPercent => $composableBuilder(
    column: $table.marginClosedPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exitType =>
      $composableBuilder(column: $table.exitType, builder: (column) => column);

  GeneratedColumn<double> get exitFeeRate => $composableBuilder(
    column: $table.exitFeeRate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get exitDatetime => $composableBuilder(
    column: $table.exitDatetime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exitMentalStates => $composableBuilder(
    column: $table.exitMentalStates,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exitScreenshot => $composableBuilder(
    column: $table.exitScreenshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<String> get trackings =>
      $composableBuilder(column: $table.trackings, builder: (column) => column);

  GeneratedColumn<String> get mistakes =>
      $composableBuilder(column: $table.mistakes, builder: (column) => column);

  GeneratedColumn<double> get transferAmount => $composableBuilder(
    column: $table.transferAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transferScreenshot => $composableBuilder(
    column: $table.transferScreenshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get exitPrice =>
      $composableBuilder(column: $table.exitPrice, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get stopLoss =>
      $composableBuilder(column: $table.stopLoss, builder: (column) => column);

  GeneratedColumn<double> get takeProfit => $composableBuilder(
    column: $table.takeProfit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pnl =>
      $composableBuilder(column: $table.pnl, builder: (column) => column);

  GeneratedColumn<double> get pnlPercent => $composableBuilder(
    column: $table.pnlPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get riskRewardRatio => $composableBuilder(
    column: $table.riskRewardRatio,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get exitDate =>
      $composableBuilder(column: $table.exitDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get screenshotPath => $composableBuilder(
    column: $table.screenshotPath,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accountBalance => $composableBuilder(
    column: $table.accountBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get riskAmount => $composableBuilder(
    column: $table.riskAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get achievedR =>
      $composableBuilder(column: $table.achievedR, builder: (column) => column);

  GeneratedColumn<int> get tradeDuration => $composableBuilder(
    column: $table.tradeDuration,
    builder: (column) => column,
  );
}

class $$TradesTableTableManager
    extends
        RootTableManager<
          _$TradeMateDatabase,
          $TradesTable,
          Trade,
          $$TradesTableFilterComposer,
          $$TradesTableOrderingComposer,
          $$TradesTableAnnotationComposer,
          $$TradesTableCreateCompanionBuilder,
          $$TradesTableUpdateCompanionBuilder,
          (Trade, BaseReferences<_$TradeMateDatabase, $TradesTable, Trade>),
          Trade,
          PrefetchHooks Function()
        > {
  $$TradesTableTableManager(_$TradeMateDatabase db, $TradesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TradesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TradesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TradesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                Value<DateTime> datetime = const Value.absent(),
                Value<String?> exchanges = const Value.absent(),
                Value<String?> entryType = const Value.absent(),
                Value<String> symbol = const Value.absent(),
                Value<String?> strategies = const Value.absent(),
                Value<String?> side = const Value.absent(),
                Value<double> entryPrice = const Value.absent(),
                Value<double?> positionMargin = const Value.absent(),
                Value<double?> leverage = const Value.absent(),
                Value<String?> orderType = const Value.absent(),
                Value<String?> timeFrame = const Value.absent(),
                Value<double?> entryFeeRate = const Value.absent(),
                Value<String?> entryMentalStates = const Value.absent(),
                Value<String?> entryScreenshot = const Value.absent(),
                Value<String?> checklist = const Value.absent(),
                Value<double?> stopLossPrice = const Value.absent(),
                Value<double?> takeProfitPrice = const Value.absent(),
                Value<double?> actualExitPrice = const Value.absent(),
                Value<double?> marginClosedPercent = const Value.absent(),
                Value<String?> exitType = const Value.absent(),
                Value<double?> exitFeeRate = const Value.absent(),
                Value<DateTime?> exitDatetime = const Value.absent(),
                Value<String?> exitMentalStates = const Value.absent(),
                Value<String?> exitScreenshot = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<String?> trackings = const Value.absent(),
                Value<String?> mistakes = const Value.absent(),
                Value<double?> transferAmount = const Value.absent(),
                Value<String?> transferScreenshot = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> exitPrice = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double?> stopLoss = const Value.absent(),
                Value<double?> takeProfit = const Value.absent(),
                Value<double?> pnl = const Value.absent(),
                Value<double?> pnlPercent = const Value.absent(),
                Value<double?> riskRewardRatio = const Value.absent(),
                Value<DateTime> entryDate = const Value.absent(),
                Value<DateTime?> exitDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> screenshotPath = const Value.absent(),
                Value<double> accountBalance = const Value.absent(),
                Value<double?> riskAmount = const Value.absent(),
                Value<double?> achievedR = const Value.absent(),
                Value<int?> tradeDuration = const Value.absent(),
              }) => TradesCompanion(
                id: id,
                tag: tag,
                datetime: datetime,
                exchanges: exchanges,
                entryType: entryType,
                symbol: symbol,
                strategies: strategies,
                side: side,
                entryPrice: entryPrice,
                positionMargin: positionMargin,
                leverage: leverage,
                orderType: orderType,
                timeFrame: timeFrame,
                entryFeeRate: entryFeeRate,
                entryMentalStates: entryMentalStates,
                entryScreenshot: entryScreenshot,
                checklist: checklist,
                stopLossPrice: stopLossPrice,
                takeProfitPrice: takeProfitPrice,
                actualExitPrice: actualExitPrice,
                marginClosedPercent: marginClosedPercent,
                exitType: exitType,
                exitFeeRate: exitFeeRate,
                exitDatetime: exitDatetime,
                exitMentalStates: exitMentalStates,
                exitScreenshot: exitScreenshot,
                rating: rating,
                memo: memo,
                trackings: trackings,
                mistakes: mistakes,
                transferAmount: transferAmount,
                transferScreenshot: transferScreenshot,
                type: type,
                status: status,
                exitPrice: exitPrice,
                quantity: quantity,
                stopLoss: stopLoss,
                takeProfit: takeProfit,
                pnl: pnl,
                pnlPercent: pnlPercent,
                riskRewardRatio: riskRewardRatio,
                entryDate: entryDate,
                exitDate: exitDate,
                notes: notes,
                screenshotPath: screenshotPath,
                accountBalance: accountBalance,
                riskAmount: riskAmount,
                achievedR: achievedR,
                tradeDuration: tradeDuration,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> tag = const Value.absent(),
                required DateTime datetime,
                Value<String?> exchanges = const Value.absent(),
                Value<String?> entryType = const Value.absent(),
                required String symbol,
                Value<String?> strategies = const Value.absent(),
                Value<String?> side = const Value.absent(),
                required double entryPrice,
                Value<double?> positionMargin = const Value.absent(),
                Value<double?> leverage = const Value.absent(),
                Value<String?> orderType = const Value.absent(),
                Value<String?> timeFrame = const Value.absent(),
                Value<double?> entryFeeRate = const Value.absent(),
                Value<String?> entryMentalStates = const Value.absent(),
                Value<String?> entryScreenshot = const Value.absent(),
                Value<String?> checklist = const Value.absent(),
                Value<double?> stopLossPrice = const Value.absent(),
                Value<double?> takeProfitPrice = const Value.absent(),
                Value<double?> actualExitPrice = const Value.absent(),
                Value<double?> marginClosedPercent = const Value.absent(),
                Value<String?> exitType = const Value.absent(),
                Value<double?> exitFeeRate = const Value.absent(),
                Value<DateTime?> exitDatetime = const Value.absent(),
                Value<String?> exitMentalStates = const Value.absent(),
                Value<String?> exitScreenshot = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> memo = const Value.absent(),
                Value<String?> trackings = const Value.absent(),
                Value<String?> mistakes = const Value.absent(),
                Value<double?> transferAmount = const Value.absent(),
                Value<String?> transferScreenshot = const Value.absent(),
                required String type,
                required String status,
                Value<double?> exitPrice = const Value.absent(),
                required double quantity,
                Value<double?> stopLoss = const Value.absent(),
                Value<double?> takeProfit = const Value.absent(),
                Value<double?> pnl = const Value.absent(),
                Value<double?> pnlPercent = const Value.absent(),
                Value<double?> riskRewardRatio = const Value.absent(),
                required DateTime entryDate,
                Value<DateTime?> exitDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> screenshotPath = const Value.absent(),
                required double accountBalance,
                Value<double?> riskAmount = const Value.absent(),
                Value<double?> achievedR = const Value.absent(),
                Value<int?> tradeDuration = const Value.absent(),
              }) => TradesCompanion.insert(
                id: id,
                tag: tag,
                datetime: datetime,
                exchanges: exchanges,
                entryType: entryType,
                symbol: symbol,
                strategies: strategies,
                side: side,
                entryPrice: entryPrice,
                positionMargin: positionMargin,
                leverage: leverage,
                orderType: orderType,
                timeFrame: timeFrame,
                entryFeeRate: entryFeeRate,
                entryMentalStates: entryMentalStates,
                entryScreenshot: entryScreenshot,
                checklist: checklist,
                stopLossPrice: stopLossPrice,
                takeProfitPrice: takeProfitPrice,
                actualExitPrice: actualExitPrice,
                marginClosedPercent: marginClosedPercent,
                exitType: exitType,
                exitFeeRate: exitFeeRate,
                exitDatetime: exitDatetime,
                exitMentalStates: exitMentalStates,
                exitScreenshot: exitScreenshot,
                rating: rating,
                memo: memo,
                trackings: trackings,
                mistakes: mistakes,
                transferAmount: transferAmount,
                transferScreenshot: transferScreenshot,
                type: type,
                status: status,
                exitPrice: exitPrice,
                quantity: quantity,
                stopLoss: stopLoss,
                takeProfit: takeProfit,
                pnl: pnl,
                pnlPercent: pnlPercent,
                riskRewardRatio: riskRewardRatio,
                entryDate: entryDate,
                exitDate: exitDate,
                notes: notes,
                screenshotPath: screenshotPath,
                accountBalance: accountBalance,
                riskAmount: riskAmount,
                achievedR: achievedR,
                tradeDuration: tradeDuration,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TradesTableProcessedTableManager =
    ProcessedTableManager<
      _$TradeMateDatabase,
      $TradesTable,
      Trade,
      $$TradesTableFilterComposer,
      $$TradesTableOrderingComposer,
      $$TradesTableAnnotationComposer,
      $$TradesTableCreateCompanionBuilder,
      $$TradesTableUpdateCompanionBuilder,
      (Trade, BaseReferences<_$TradeMateDatabase, $TradesTable, Trade>),
      Trade,
      PrefetchHooks Function()
    >;
typedef $$UserDefinedValuesTableCreateCompanionBuilder =
    UserDefinedValuesCompanion Function({
      Value<int> id,
      required String category,
      required String value,
      Value<bool> isDefault,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserDefinedValuesTableUpdateCompanionBuilder =
    UserDefinedValuesCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<String> value,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserDefinedValuesTableFilterComposer
    extends Composer<_$TradeMateDatabase, $UserDefinedValuesTable> {
  $$UserDefinedValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserDefinedValuesTableOrderingComposer
    extends Composer<_$TradeMateDatabase, $UserDefinedValuesTable> {
  $$UserDefinedValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserDefinedValuesTableAnnotationComposer
    extends Composer<_$TradeMateDatabase, $UserDefinedValuesTable> {
  $$UserDefinedValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserDefinedValuesTableTableManager
    extends
        RootTableManager<
          _$TradeMateDatabase,
          $UserDefinedValuesTable,
          UserDefinedValue,
          $$UserDefinedValuesTableFilterComposer,
          $$UserDefinedValuesTableOrderingComposer,
          $$UserDefinedValuesTableAnnotationComposer,
          $$UserDefinedValuesTableCreateCompanionBuilder,
          $$UserDefinedValuesTableUpdateCompanionBuilder,
          (
            UserDefinedValue,
            BaseReferences<
              _$TradeMateDatabase,
              $UserDefinedValuesTable,
              UserDefinedValue
            >,
          ),
          UserDefinedValue,
          PrefetchHooks Function()
        > {
  $$UserDefinedValuesTableTableManager(
    _$TradeMateDatabase db,
    $UserDefinedValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserDefinedValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserDefinedValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserDefinedValuesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserDefinedValuesCompanion(
                id: id,
                category: category,
                value: value,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String category,
                required String value,
                Value<bool> isDefault = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserDefinedValuesCompanion.insert(
                id: id,
                category: category,
                value: value,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserDefinedValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$TradeMateDatabase,
      $UserDefinedValuesTable,
      UserDefinedValue,
      $$UserDefinedValuesTableFilterComposer,
      $$UserDefinedValuesTableOrderingComposer,
      $$UserDefinedValuesTableAnnotationComposer,
      $$UserDefinedValuesTableCreateCompanionBuilder,
      $$UserDefinedValuesTableUpdateCompanionBuilder,
      (
        UserDefinedValue,
        BaseReferences<
          _$TradeMateDatabase,
          $UserDefinedValuesTable,
          UserDefinedValue
        >,
      ),
      UserDefinedValue,
      PrefetchHooks Function()
    >;
typedef $$AccountTransactionsTableCreateCompanionBuilder =
    AccountTransactionsCompanion Function({
      Value<int> id,
      required String type,
      required double amount,
      required DateTime date,
      Value<String?> notes,
    });
typedef $$AccountTransactionsTableUpdateCompanionBuilder =
    AccountTransactionsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<double> amount,
      Value<DateTime> date,
      Value<String?> notes,
    });

class $$AccountTransactionsTableFilterComposer
    extends Composer<_$TradeMateDatabase, $AccountTransactionsTable> {
  $$AccountTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountTransactionsTableOrderingComposer
    extends Composer<_$TradeMateDatabase, $AccountTransactionsTable> {
  $$AccountTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountTransactionsTableAnnotationComposer
    extends Composer<_$TradeMateDatabase, $AccountTransactionsTable> {
  $$AccountTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$AccountTransactionsTableTableManager
    extends
        RootTableManager<
          _$TradeMateDatabase,
          $AccountTransactionsTable,
          AccountTransaction,
          $$AccountTransactionsTableFilterComposer,
          $$AccountTransactionsTableOrderingComposer,
          $$AccountTransactionsTableAnnotationComposer,
          $$AccountTransactionsTableCreateCompanionBuilder,
          $$AccountTransactionsTableUpdateCompanionBuilder,
          (
            AccountTransaction,
            BaseReferences<
              _$TradeMateDatabase,
              $AccountTransactionsTable,
              AccountTransaction
            >,
          ),
          AccountTransaction,
          PrefetchHooks Function()
        > {
  $$AccountTransactionsTableTableManager(
    _$TradeMateDatabase db,
    $AccountTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AccountTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => AccountTransactionsCompanion(
                id: id,
                type: type,
                amount: amount,
                date: date,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required double amount,
                required DateTime date,
                Value<String?> notes = const Value.absent(),
              }) => AccountTransactionsCompanion.insert(
                id: id,
                type: type,
                amount: amount,
                date: date,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$TradeMateDatabase,
      $AccountTransactionsTable,
      AccountTransaction,
      $$AccountTransactionsTableFilterComposer,
      $$AccountTransactionsTableOrderingComposer,
      $$AccountTransactionsTableAnnotationComposer,
      $$AccountTransactionsTableCreateCompanionBuilder,
      $$AccountTransactionsTableUpdateCompanionBuilder,
      (
        AccountTransaction,
        BaseReferences<
          _$TradeMateDatabase,
          $AccountTransactionsTable,
          AccountTransaction
        >,
      ),
      AccountTransaction,
      PrefetchHooks Function()
    >;
typedef $$TradeStatisticsTableTableCreateCompanionBuilder =
    TradeStatisticsTableCompanion Function({
      Value<int> id,
      required double totalTrades,
      required double winningTrades,
      required double losingTrades,
      required double breakevenTrades,
      required double openPositions,
      required double avgAchievedR,
      required double avgTradeDuration,
      required double overallPnl,
      required double avgPnl,
      required double totalAccountGrowth,
      required double totalDeposits,
      required double totalWithdrawals,
      required double currentAccountBalance,
      required DateTime lastUpdated,
    });
typedef $$TradeStatisticsTableTableUpdateCompanionBuilder =
    TradeStatisticsTableCompanion Function({
      Value<int> id,
      Value<double> totalTrades,
      Value<double> winningTrades,
      Value<double> losingTrades,
      Value<double> breakevenTrades,
      Value<double> openPositions,
      Value<double> avgAchievedR,
      Value<double> avgTradeDuration,
      Value<double> overallPnl,
      Value<double> avgPnl,
      Value<double> totalAccountGrowth,
      Value<double> totalDeposits,
      Value<double> totalWithdrawals,
      Value<double> currentAccountBalance,
      Value<DateTime> lastUpdated,
    });

class $$TradeStatisticsTableTableFilterComposer
    extends Composer<_$TradeMateDatabase, $TradeStatisticsTableTable> {
  $$TradeStatisticsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalTrades => $composableBuilder(
    column: $table.totalTrades,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get winningTrades => $composableBuilder(
    column: $table.winningTrades,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get losingTrades => $composableBuilder(
    column: $table.losingTrades,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get breakevenTrades => $composableBuilder(
    column: $table.breakevenTrades,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get openPositions => $composableBuilder(
    column: $table.openPositions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgAchievedR => $composableBuilder(
    column: $table.avgAchievedR,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgTradeDuration => $composableBuilder(
    column: $table.avgTradeDuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get overallPnl => $composableBuilder(
    column: $table.overallPnl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgPnl => $composableBuilder(
    column: $table.avgPnl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAccountGrowth => $composableBuilder(
    column: $table.totalAccountGrowth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDeposits => $composableBuilder(
    column: $table.totalDeposits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalWithdrawals => $composableBuilder(
    column: $table.totalWithdrawals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentAccountBalance => $composableBuilder(
    column: $table.currentAccountBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TradeStatisticsTableTableOrderingComposer
    extends Composer<_$TradeMateDatabase, $TradeStatisticsTableTable> {
  $$TradeStatisticsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalTrades => $composableBuilder(
    column: $table.totalTrades,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get winningTrades => $composableBuilder(
    column: $table.winningTrades,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get losingTrades => $composableBuilder(
    column: $table.losingTrades,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get breakevenTrades => $composableBuilder(
    column: $table.breakevenTrades,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get openPositions => $composableBuilder(
    column: $table.openPositions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgAchievedR => $composableBuilder(
    column: $table.avgAchievedR,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgTradeDuration => $composableBuilder(
    column: $table.avgTradeDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get overallPnl => $composableBuilder(
    column: $table.overallPnl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgPnl => $composableBuilder(
    column: $table.avgPnl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAccountGrowth => $composableBuilder(
    column: $table.totalAccountGrowth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDeposits => $composableBuilder(
    column: $table.totalDeposits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalWithdrawals => $composableBuilder(
    column: $table.totalWithdrawals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentAccountBalance => $composableBuilder(
    column: $table.currentAccountBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TradeStatisticsTableTableAnnotationComposer
    extends Composer<_$TradeMateDatabase, $TradeStatisticsTableTable> {
  $$TradeStatisticsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get totalTrades => $composableBuilder(
    column: $table.totalTrades,
    builder: (column) => column,
  );

  GeneratedColumn<double> get winningTrades => $composableBuilder(
    column: $table.winningTrades,
    builder: (column) => column,
  );

  GeneratedColumn<double> get losingTrades => $composableBuilder(
    column: $table.losingTrades,
    builder: (column) => column,
  );

  GeneratedColumn<double> get breakevenTrades => $composableBuilder(
    column: $table.breakevenTrades,
    builder: (column) => column,
  );

  GeneratedColumn<double> get openPositions => $composableBuilder(
    column: $table.openPositions,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgAchievedR => $composableBuilder(
    column: $table.avgAchievedR,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgTradeDuration => $composableBuilder(
    column: $table.avgTradeDuration,
    builder: (column) => column,
  );

  GeneratedColumn<double> get overallPnl => $composableBuilder(
    column: $table.overallPnl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgPnl =>
      $composableBuilder(column: $table.avgPnl, builder: (column) => column);

  GeneratedColumn<double> get totalAccountGrowth => $composableBuilder(
    column: $table.totalAccountGrowth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalDeposits => $composableBuilder(
    column: $table.totalDeposits,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalWithdrawals => $composableBuilder(
    column: $table.totalWithdrawals,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentAccountBalance => $composableBuilder(
    column: $table.currentAccountBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$TradeStatisticsTableTableTableManager
    extends
        RootTableManager<
          _$TradeMateDatabase,
          $TradeStatisticsTableTable,
          TradeStatisticsTableData,
          $$TradeStatisticsTableTableFilterComposer,
          $$TradeStatisticsTableTableOrderingComposer,
          $$TradeStatisticsTableTableAnnotationComposer,
          $$TradeStatisticsTableTableCreateCompanionBuilder,
          $$TradeStatisticsTableTableUpdateCompanionBuilder,
          (
            TradeStatisticsTableData,
            BaseReferences<
              _$TradeMateDatabase,
              $TradeStatisticsTableTable,
              TradeStatisticsTableData
            >,
          ),
          TradeStatisticsTableData,
          PrefetchHooks Function()
        > {
  $$TradeStatisticsTableTableTableManager(
    _$TradeMateDatabase db,
    $TradeStatisticsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TradeStatisticsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TradeStatisticsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TradeStatisticsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> totalTrades = const Value.absent(),
                Value<double> winningTrades = const Value.absent(),
                Value<double> losingTrades = const Value.absent(),
                Value<double> breakevenTrades = const Value.absent(),
                Value<double> openPositions = const Value.absent(),
                Value<double> avgAchievedR = const Value.absent(),
                Value<double> avgTradeDuration = const Value.absent(),
                Value<double> overallPnl = const Value.absent(),
                Value<double> avgPnl = const Value.absent(),
                Value<double> totalAccountGrowth = const Value.absent(),
                Value<double> totalDeposits = const Value.absent(),
                Value<double> totalWithdrawals = const Value.absent(),
                Value<double> currentAccountBalance = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => TradeStatisticsTableCompanion(
                id: id,
                totalTrades: totalTrades,
                winningTrades: winningTrades,
                losingTrades: losingTrades,
                breakevenTrades: breakevenTrades,
                openPositions: openPositions,
                avgAchievedR: avgAchievedR,
                avgTradeDuration: avgTradeDuration,
                overallPnl: overallPnl,
                avgPnl: avgPnl,
                totalAccountGrowth: totalAccountGrowth,
                totalDeposits: totalDeposits,
                totalWithdrawals: totalWithdrawals,
                currentAccountBalance: currentAccountBalance,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double totalTrades,
                required double winningTrades,
                required double losingTrades,
                required double breakevenTrades,
                required double openPositions,
                required double avgAchievedR,
                required double avgTradeDuration,
                required double overallPnl,
                required double avgPnl,
                required double totalAccountGrowth,
                required double totalDeposits,
                required double totalWithdrawals,
                required double currentAccountBalance,
                required DateTime lastUpdated,
              }) => TradeStatisticsTableCompanion.insert(
                id: id,
                totalTrades: totalTrades,
                winningTrades: winningTrades,
                losingTrades: losingTrades,
                breakevenTrades: breakevenTrades,
                openPositions: openPositions,
                avgAchievedR: avgAchievedR,
                avgTradeDuration: avgTradeDuration,
                overallPnl: overallPnl,
                avgPnl: avgPnl,
                totalAccountGrowth: totalAccountGrowth,
                totalDeposits: totalDeposits,
                totalWithdrawals: totalWithdrawals,
                currentAccountBalance: currentAccountBalance,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TradeStatisticsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$TradeMateDatabase,
      $TradeStatisticsTableTable,
      TradeStatisticsTableData,
      $$TradeStatisticsTableTableFilterComposer,
      $$TradeStatisticsTableTableOrderingComposer,
      $$TradeStatisticsTableTableAnnotationComposer,
      $$TradeStatisticsTableTableCreateCompanionBuilder,
      $$TradeStatisticsTableTableUpdateCompanionBuilder,
      (
        TradeStatisticsTableData,
        BaseReferences<
          _$TradeMateDatabase,
          $TradeStatisticsTableTable,
          TradeStatisticsTableData
        >,
      ),
      TradeStatisticsTableData,
      PrefetchHooks Function()
    >;

class $TradeMateDatabaseManager {
  final _$TradeMateDatabase _db;
  $TradeMateDatabaseManager(this._db);
  $$TradesTableTableManager get trades =>
      $$TradesTableTableManager(_db, _db.trades);
  $$UserDefinedValuesTableTableManager get userDefinedValues =>
      $$UserDefinedValuesTableTableManager(_db, _db.userDefinedValues);
  $$AccountTransactionsTableTableManager get accountTransactions =>
      $$AccountTransactionsTableTableManager(_db, _db.accountTransactions);
  $$TradeStatisticsTableTableTableManager get tradeStatisticsTable =>
      $$TradeStatisticsTableTableTableManager(_db, _db.tradeStatisticsTable);
}
