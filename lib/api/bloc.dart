import 'dart:async';

import 'package:retrofit/dio.dart';
import 'package:veegil_test/api/classes.dart';
import 'package:veegil_test/api/repository.dart';

import 'config.dart';

class TransactionBloc extends ApiBloc{
  final apiRepo = ApiRepository();
  final transactionController =
      StreamController<HttpResponse<TransactionResult>>.broadcast();

  final depositsController =
      StreamController<HttpResponse<TransactionResult>>.broadcast();

  final withdrawalController =
      StreamController<HttpResponse<TransactionResult>>.broadcast();

  final transferController =
      StreamController<HttpResponse<TransferResult>>.broadcast();

  final userController = StreamController<HttpResponse<UserResult>>.broadcast();

  get user => userController.stream;

  get transaction => transactionController.stream;

  get deposits => depositsController.stream;

  get withdrawal => withdrawalController.stream;

  TransactionBloc(String actNo) {
    getTransaction(actNo);
    getDepositTransaction(actNo);
    getWithdrawal(actNo);
    getUser(actNo);
  }

  dispose() {
    transactionController.close();
    transferController.close();
    depositsController.close();
    withdrawalController.close();
    userController.close();
  }

  getTransaction(String actNo) async {
    transactionController.sink.add(await apiRepo.getTransaction(actNo));
  }

  getDepositTransaction(String actNo) async {
    depositsController.sink
        .add(await apiRepo.getTransaction(actNo, deposit: "true"));
  }

  getWithdrawal(String actNo) async {
    withdrawalController.sink.add(await apiRepo.getWithdrawal(actNo));
  }

  getUser(String accountNumber) async {
    userController.sink.add(await apiRepo.getUser(accountNumber));
  }

  transfer(PayParam param,
      {Function(HttpResponse<TransferResult> result)? onResult}) async {
    await apiRepo.transfer(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getUser(param.sender);
    if (param.sender == param.to)
      getDepositTransaction(param.sender);
    else
      getTransaction(param.sender);
  }

  deposit(DepositParam param,
      {Function(HttpResponse<TransferResult> result)? onResult}) async {
    await apiRepo.deposit(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getUser(param.sender);
    getDepositTransaction(param.sender);
  }

  withdraw(DepositParam param,
      {Function(HttpResponse<TransferResult> result)? onResult}) async {
    await apiRepo.withdraw(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getUser(param.sender);
    getWithdrawal(param.sender);
  }
}

class AdminBloc  extends ApiBloc{
  final apiRepo = ApiRepository();
  final userController =
      StreamController<HttpResponse<UserResult>>.broadcast();
  final usersController =
      StreamController<HttpResponse<UsersResult>>.broadcast();
  final transactionsController =
      StreamController<HttpResponse<TransactionsResult>>.broadcast();
  final summaryController = StreamController<HttpResponse<Summary>>.broadcast();

  get users => usersController.stream;

  get user => userController.stream;

  get transactions => transactionsController.stream;

  get summary => summaryController.stream;

  AdminBloc({String? actNo}) {
    getSummary();
    getUsers();
    getUser(actNo??"");
    _getAllTransactionsWithTime();
  }

  dispose() {
    summaryController.close();
    usersController.close();
    userController.close();
    transactionsController.close();
  }
  getUser(String accountNumber) async {
    userController.sink.add(await apiRepo.getUser(accountNumber));
  }

  getUsers({String? search}) async {
    usersController.sink.add(await apiRepo.getUsers(search));
  }

  getTransactions({TransactionsParam? param}) async {
    transactionsController.sink
        .add(await apiRepo.getTransactions(param: param));
  }

  getSummary() async {
    summaryController.sink.add(await apiRepo.getSummary());
  }

  searchUser(String search) {
    getUsers(search: search);
  }

  filterTransactions(TransactionsParam param) {
    getTransactions(param: param);
  }

  transfer(PayParam param,
      {Function(HttpResponse<TransferResult> result)? onResult}) async {
    await apiRepo.transfer(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getSummary();
    _getAllTransactionsWithTime();
    getUsers();
    getUser(param.sender);
  }

  deposit(DepositParam param,
      {Function(HttpResponse<TransferResult> result)? onResult}) async {
    await apiRepo.deposit(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getSummary();
    _getAllTransactionsWithTime();
    getUsers();
    getUser(param.sender);
  }

  _getAllTransactionsWithTime() => getTransactions(param:TransactionsParam(orderBy: CREATED,order: DESC));

  withdraw(DepositParam param,
      {Function(HttpResponse<TransferResult> result)? onResult}) async {
    await apiRepo.withdraw(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getSummary();
    _getAllTransactionsWithTime();
    getUsers();
    getUser(param.sender);
  }

  addUser(RegParam param,
      {Function(HttpResponse<SignUpResult> result)? onResult}) async {
    await apiRepo.signUpUser(param).then((value) =>
        onResult != null ? onResult(value) : print("No Result handler"));
    getSummary();
    getUsers();
  }
}

abstract class ApiBloc {

  dispose();
  transfer(PayParam param,
      {Function(HttpResponse<TransferResult> result)? onResult});

  deposit(DepositParam param,
      {Function(HttpResponse<TransferResult> result)? onResult});

  withdraw(DepositParam param,
      {Function(HttpResponse<TransferResult> result)? onResult});
}
