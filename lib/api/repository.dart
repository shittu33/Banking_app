import 'package:retrofit/retrofit.dart';
import 'package:veegil_test/api/classes.dart';
import 'package:veegil_test/api/dio.dart';
import 'package:veegil_test/api/error.dart';

class ApiRepository {
  final dao = ApiDao();

  Future<HttpResponse<Summary>> getSummary() => dao.getSummary();

  Future<HttpResponse<UsersResult>> getUsers(String? search) =>
      dao.getUsers(search: search);

  Future<HttpResponse<UserResult>> getUser(String accountNumber) =>
      dao.getUser(accountNumber);

  // Future<HttpResponse<UsersResult?>> getUserResult() => dao.getUserResult();

  Future<HttpResponse<TransactionsResult>> getTransactions(
          {TransactionsParam? param}) =>
      dao.getTransactions(param: param);

  Future<HttpResponse<TransactionResult>> getTransaction(String accountNumber,
          {String? deposit}) =>
      dao.getTransaction(accountNumber, deposit: deposit ?? "false");

  Future<HttpResponse<TransactionResult>> getWithdrawal(String accountNumber) =>
      dao.getWithdrawal(accountNumber);

  Future<HttpResponse<LoginResult>> loginUser(AuthUser authUser) =>
      dao.loginUser(authUser);

  Future<HttpResponse<SignUpResult>> signUpUser(RegParam regParam) =>
      dao.signUpUser(regParam);

  Future<HttpResponse<TransferResult>> withdraw(DepositParam payParam) =>
      dao.withdraw(payParam);

  Future<HttpResponse<TransferResult>> transfer(PayParam payParam) =>
      dao.transfer(payParam);

  Future<HttpResponse<TransferResult>> deposit(DepositParam param) =>
      dao.deposit(param);
}
