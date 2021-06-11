import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:veegil_test/api/api.dart';
import 'package:veegil_test/api/classes.dart';
import 'package:veegil_test/api/error.dart';

class ApiDao {
  late Dio dio;
  late ApiClient client;

  ApiDao() {
    dio = Dio();
    // dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    client = ApiClient(dio);
  }

  Future<HttpResponse<Summary>> getSummary()=>client.getSummary();

  Future<HttpResponse<TransactionsResult>> getTransactions(
          {TransactionsParam? param}) =>
      client.getTransactions(param?.limit,param?.orderBy,param?.order,);

  Future<HttpResponse<TransactionResult>> getTransaction(String accountNumber,
          {String? deposit}) =>
      client.getTransaction(accountNumber, deposit ?? "false");

  Future<HttpResponse<TransactionResult>> getWithdrawal(String accountNumber) =>
      client.getWithdrawal(accountNumber);

  Future<HttpResponse<UsersResult>> getUsers({String? search}) =>
      client.getUsers(search);

  Future<HttpResponse<UserResult>> getUser(String accountNumber) =>
      client.getUser(accountNumber);

  // Future<HttpResponse<UsersResult?>> getUserResult() => client.getUsers();

  Future<HttpResponse<LoginResult>> loginUser(AuthUser authUser) =>
      client.loginUser(authUser);

  Future<HttpResponse<SignUpResult>> signUpUser(RegParam regParam) =>
      client.signUpUser(regParam);

  Future<HttpResponse<TransferResult>> withdraw(DepositParam payParam) =>
      client.withdraw(payParam);

  Future<HttpResponse<TransferResult>> transfer(PayParam payParam) =>
      client.transfer(payParam);

  Future<HttpResponse<TransferResult>> deposit(DepositParam param) =>
      client.deposit(param);
}
