import 'package:json_annotation/json_annotation.dart';

part 'classes.g.dart';

@JsonSerializable(explicitToJson: true)
class TransferResult {
  bool error;
  String message;
  int balance;
  List<Transaction?> transaction;


  TransferResult(this.error, this.message, this.balance, this.transaction);

  factory TransferResult.fromJson(Map<String, dynamic> json) =>
      _$TransferResultFromJson(json);

  Map<String, dynamic> toJson() => _$TransferResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransactionsResult {
  bool error;
  String message;
  List<Transaction?>? transactions;


  TransactionsResult(this.error, this.message, this.transactions);

  factory TransactionsResult.fromJson(Map<String, dynamic> json) =>
      _$TransactionsResultFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransactionResult {
  bool error;
  String message;
  List<Transaction> transaction;

  TransactionResult(this.error, this.message, this.transaction);

  factory TransactionResult.fromJson(Map<String, dynamic> json) =>
      _$TransactionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResultToJson(this);
}

@JsonSerializable()
class Transaction {
  String senderNumber;
  String senderName;
  String recipientNumber;
  String? recipientName;
  String amount;
  String type;
  @JsonValue("time")
  String time;

  Transaction(this.senderNumber, this.senderName, this.recipientNumber,
      this.recipientName, this.amount, this.type, this.time);

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UsersResult {
  bool error;
  String message;
  List<User?>? users;

  UsersResult(this.error, this.message, this.users);

  factory UsersResult.fromJson(Map<String, dynamic> json) =>
      _$UsersResultFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserResult {
  bool error;
  String message;
  User? user;

  UserResult(this.error, this.message, this.user);

  factory UserResult.fromJson(Map<String, dynamic> json) =>
      _$UserResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserResultToJson(this);
}

@JsonSerializable()
class User {
  String id;
  String accountNumber;
  String balance;
  String created;
  String password;
  String name;
  String role;

  User(this.id, this.accountNumber, this.balance, this.created, this.password,
      this.name, this.role);


  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginResult {
  bool error;
  String message;
  User? data;

  LoginResult(this.error, this.message, this.data);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUpResult {
  bool error;
  String message;
  User? data;

  SignUpResult(this.error, this.message, this.data);

  factory SignUpResult.fromJson(Map<String, dynamic> json) =>
      _$SignUpResultFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResultToJson(this);
}

@JsonSerializable()
class AuthUser {
  String accountNumber;
  String password;

  AuthUser(this.accountNumber, this.password);

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}

@JsonSerializable()
class Summary {
  String totalBalance;
  String numUser;
  String numTransactions;
// int totalBalance;
//   int numUser;
//   int numTransactions;

  Summary(this.totalBalance, this.numUser, this.numTransactions);

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);
}

@JsonSerializable()
class RegParam {
  String accountNumber;
  String name;
  String password;

  RegParam(this.accountNumber, this.name, this.password);

  factory RegParam.fromJson(Map<String, dynamic> json) =>
      _$RegParamFromJson(json);

  Map<String, dynamic> toJson() => _$RegParamToJson(this);
}

@JsonSerializable()
class PayParam {
  String sender;
  String to;
  int amount;


  PayParam(this.sender, this.to, this.amount);

  factory PayParam.fromJson(Map<String, dynamic> json) =>
      _$PayParamFromJson(json);

  Map<String, dynamic> toJson() => _$PayParamToJson(this);
}

@JsonSerializable()
class DepositParam {
  String sender;
  int amount;


  DepositParam(this.sender, this.amount);

  factory DepositParam.fromJson(Map<String, dynamic> json) =>
      _$DepositParamFromJson(json);

  Map<String, dynamic> toJson() => _$DepositParamToJson(this);
}

@JsonSerializable()
class TransactionsParam {
  int? limit;
  String? orderBy;
  String? order;


  TransactionsParam({this.limit, this.orderBy, this.order});

  factory TransactionsParam.fromJson(Map<String, dynamic> json) =>
      _$TransactionsParamFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsParamToJson(this);
}
