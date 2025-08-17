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
  static const VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String> symbol = GeneratedColumn<String>(
    'symbol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    symbol,
    type,
    status,
    entryPrice,
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
    if (data.containsKey('symbol')) {
      context.handle(
        _symbolMeta,
        symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta),
      );
    } else if (isInserting) {
      context.missing(_symbolMeta);
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
    if (data.containsKey('entry_price')) {
      context.handle(
        _entryPriceMeta,
        entryPrice.isAcceptableOrUnknown(data['entry_price']!, _entryPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_entryPriceMeta);
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
      symbol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      entryPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}entry_price'],
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
  final String symbol;
  final String type;
  final String status;
  final double entryPrice;
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
    required this.symbol,
    required this.type,
    required this.status,
    required this.entryPrice,
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
    map['symbol'] = Variable<String>(symbol);
    map['type'] = Variable<String>(type);
    map['status'] = Variable<String>(status);
    map['entry_price'] = Variable<double>(entryPrice);
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
      symbol: Value(symbol),
      type: Value(type),
      status: Value(status),
      entryPrice: Value(entryPrice),
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
      symbol: serializer.fromJson<String>(json['symbol']),
      type: serializer.fromJson<String>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      entryPrice: serializer.fromJson<double>(json['entryPrice']),
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
      'symbol': serializer.toJson<String>(symbol),
      'type': serializer.toJson<String>(type),
      'status': serializer.toJson<String>(status),
      'entryPrice': serializer.toJson<double>(entryPrice),
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
    String? symbol,
    String? type,
    String? status,
    double? entryPrice,
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
    symbol: symbol ?? this.symbol,
    type: type ?? this.type,
    status: status ?? this.status,
    entryPrice: entryPrice ?? this.entryPrice,
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
      symbol: data.symbol.present ? data.symbol.value : this.symbol,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      entryPrice: data.entryPrice.present
          ? data.entryPrice.value
          : this.entryPrice,
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
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('entryPrice: $entryPrice, ')
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
  int get hashCode => Object.hash(
    id,
    symbol,
    type,
    status,
    entryPrice,
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
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trade &&
          other.id == this.id &&
          other.symbol == this.symbol &&
          other.type == this.type &&
          other.status == this.status &&
          other.entryPrice == this.entryPrice &&
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
  final Value<String> symbol;
  final Value<String> type;
  final Value<String> status;
  final Value<double> entryPrice;
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
    this.symbol = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.entryPrice = const Value.absent(),
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
    required String symbol,
    required String type,
    required String status,
    required double entryPrice,
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
  }) : symbol = Value(symbol),
       type = Value(type),
       status = Value(status),
       entryPrice = Value(entryPrice),
       quantity = Value(quantity),
       entryDate = Value(entryDate),
       accountBalance = Value(accountBalance);
  static Insertable<Trade> custom({
    Expression<int>? id,
    Expression<String>? symbol,
    Expression<String>? type,
    Expression<String>? status,
    Expression<double>? entryPrice,
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
      if (symbol != null) 'symbol': symbol,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (entryPrice != null) 'entry_price': entryPrice,
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
    Value<String>? symbol,
    Value<String>? type,
    Value<String>? status,
    Value<double>? entryPrice,
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
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      status: status ?? this.status,
      entryPrice: entryPrice ?? this.entryPrice,
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
    if (symbol.present) {
      map['symbol'] = Variable<String>(symbol.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (entryPrice.present) {
      map['entry_price'] = Variable<double>(entryPrice.value);
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
          ..write('symbol: $symbol, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('entryPrice: $entryPrice, ')
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
    accountTransactions,
    tradeStatisticsTable,
  ];
}

typedef $$TradesTableCreateCompanionBuilder =
    TradesCompanion Function({
      Value<int> id,
      required String symbol,
      required String type,
      required String status,
      required double entryPrice,
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
      Value<String> symbol,
      Value<String> type,
      Value<String> status,
      Value<double> entryPrice,
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

  ColumnFilters<String> get symbol => $composableBuilder(
    column: $table.symbol,
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

  ColumnFilters<double> get entryPrice => $composableBuilder(
    column: $table.entryPrice,
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

  ColumnOrderings<String> get symbol => $composableBuilder(
    column: $table.symbol,
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

  ColumnOrderings<double> get entryPrice => $composableBuilder(
    column: $table.entryPrice,
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

  GeneratedColumn<String> get symbol =>
      $composableBuilder(column: $table.symbol, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get entryPrice => $composableBuilder(
    column: $table.entryPrice,
    builder: (column) => column,
  );

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
                Value<String> symbol = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> entryPrice = const Value.absent(),
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
                symbol: symbol,
                type: type,
                status: status,
                entryPrice: entryPrice,
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
                required String symbol,
                required String type,
                required String status,
                required double entryPrice,
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
                symbol: symbol,
                type: type,
                status: status,
                entryPrice: entryPrice,
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
  $$AccountTransactionsTableTableManager get accountTransactions =>
      $$AccountTransactionsTableTableManager(_db, _db.accountTransactions);
  $$TradeStatisticsTableTableTableManager get tradeStatisticsTable =>
      $$TradeStatisticsTableTableTableManager(_db, _db.tradeStatisticsTable);
}
