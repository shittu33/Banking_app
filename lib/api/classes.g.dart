// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferResult _$TransferResultFromJson(Map<String, dynamic> json) {
  return TransferResult(
    json['error'] as bool,
    json['message'] as String,
    json['balance'] as int,
    (json['transaction'] as List<dynamic>)
        .map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TransferResultToJson(TransferResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'balance': instance.balance,
      'transaction': instance.transaction.map((e) => e?.toJson()).toList(),
    };

TransactionsResult _$TransactionsResultFromJson(Map<String, dynamic> json) {
  return TransactionsResult(
    json['error'] as bool,
    json['message'] as String,
    (json['transactions'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : Transaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TransactionsResultToJson(TransactionsResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'transactions': instance.transactions?.map((e) => e?.toJson()).toList(),
    };

TransactionResult _$TransactionResultFromJson(Map<String, dynamic> json) {
  return TransactionResult(
    json['error'] as bool,
    json['message'] as String,
    (json['transaction'] as List<dynamic>)
        .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TransactionResultToJson(TransactionResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'transaction': instance.transaction.map((e) => e.toJson()).toList(),
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    json['senderNumber'] as String,
    json['senderName'] as String,
    json['recipientNumber'] as String,
    json['recipientName'] as String?,
    json['amount'] as String,
    json['type'] as String,
    json['time'] as String,
  );
}

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'senderNumber': instance.senderNumber,
      'senderName': instance.senderName,
      'recipientNumber': instance.recipientNumber,
      'recipientName': instance.recipientName,
      'amount': instance.amount,
      'type': instance.type,
      'time': instance.time,
    };

UsersResult _$UsersResultFromJson(Map<String, dynamic> json) {
  return UsersResult(
    json['error'] as bool,
    json['message'] as String,
    (json['users'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UsersResultToJson(UsersResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'users': instance.users?.map((e) => e?.toJson()).toList(),
    };

UserResult _$UserResultFromJson(Map<String, dynamic> json) {
  return UserResult(
    json['error'] as bool,
    json['message'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResultToJson(UserResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'user': instance.user?.toJson(),
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as String,
    json['accountNumber'] as String,
    json['balance'] as String,
    json['created'] as String,
    json['password'] as String,
    json['name'] as String,
    json['role'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'accountNumber': instance.accountNumber,
      'balance': instance.balance,
      'created': instance.created,
      'password': instance.password,
      'name': instance.name,
      'role': instance.role,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) {
  return LoginResult(
    json['error'] as bool,
    json['message'] as String,
    json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

SignUpResult _$SignUpResultFromJson(Map<String, dynamic> json) {
  return SignUpResult(
    json['error'] as bool,
    json['message'] as String,
    json['data'] == null
        ? null
        : User.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignUpResultToJson(SignUpResult instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return AuthUser(
    json['accountNumber'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'password': instance.password,
    };

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return Summary(
    json['totalBalance'] as String,
    json['numUser'] as String,
    json['numTransactions'] as String,
  );
}

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'totalBalance': instance.totalBalance,
      'numUser': instance.numUser,
      'numTransactions': instance.numTransactions,
    };

RegParam _$RegParamFromJson(Map<String, dynamic> json) {
  return RegParam(
    json['accountNumber'] as String,
    json['name'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$RegParamToJson(RegParam instance) => <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'name': instance.name,
      'password': instance.password,
    };

PayParam _$PayParamFromJson(Map<String, dynamic> json) {
  return PayParam(
    json['sender'] as String,
    json['to'] as String,
    json['amount'] as int,
  );
}

Map<String, dynamic> _$PayParamToJson(PayParam instance) => <String, dynamic>{
      'sender': instance.sender,
      'to': instance.to,
      'amount': instance.amount,
    };

DepositParam _$DepositParamFromJson(Map<String, dynamic> json) {
  return DepositParam(
    json['sender'] as String,
    json['amount'] as int,
  );
}

Map<String, dynamic> _$DepositParamToJson(DepositParam instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'amount': instance.amount,
    };

TransactionsParam _$TransactionsParamFromJson(Map<String, dynamic> json) {
  return TransactionsParam(
    limit: json['limit'] as int?,
    orderBy: json['orderBy'] as String?,
    order: json['order'] as String?,
  );
}

Map<String, dynamic> _$TransactionsParamToJson(TransactionsParam instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'orderBy': instance.orderBy,
      'order': instance.order,
    };
