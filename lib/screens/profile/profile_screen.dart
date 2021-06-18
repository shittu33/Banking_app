import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retrofit/dio.dart';
import 'package:veegil_test/api/bloc.dart';
import 'package:veegil_test/api/classes.dart';
import 'package:veegil_test/api/config.dart';
import 'package:veegil_test/screens/profile/components.dart';
import 'package:veegil_test/widget/editText.dart';
import '../../constants.dart';
import '../../widget/dashboard/app_drawer.dart';

class Profile extends StatefulWidget {
  final User user;

  Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _screenIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiBloc? apiBloc;

  // AdminBloc? adminBloc;
  TransactionType _transactionType = TransactionType.transfer;
  bool isAdmin = false;
  int _limit = 10;
  String _orderBy = CREATED;
  String _order = DESC;

  TransactionBloc get transBloc => apiBloc as TransactionBloc;

  AdminBloc get adminBloc => apiBloc as AdminBloc;

  @override
  void initState() {
    super.initState();
    var user = widget.user;
    isAdmin = user.role.isNotEmpty && user.role == "admin";

    print(isAdmin ? "THis is for Admin" : "Just a User");

    if (isAdmin)
      apiBloc = AdminBloc(actNo: user.accountNumber);
    else
      apiBloc = TransactionBloc(user.accountNumber);
  }

  switchScreen(int index) {
    setState(() {
      if (index == 0)
        _transactionType = TransactionType.transfer;
      else if (index == 1)
        _transactionType =
            isAdmin ? TransactionType.user : TransactionType.deposit;
      else
        _transactionType = TransactionType.withdraw;
      _screenIndex = index;
    });
  }

  @override
  void dispose() {
    apiBloc?.dispose();
    // adminBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(onToggleDrawer: toggleDrawer),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Header(
                  name: widget.user.name,
                  isAdmin:isAdmin,
                  centerChild: isAdmin
                      ? SummaryView(summaryStream: adminBloc.summary)
                      : UserDetailScreen(stream: transBloc.user),
                  transactionType: _transactionType,
                  onToggleDrawer: () => toggleDrawer(),
                  onFloatPressed: (type) => type == TransactionType.user
                      ? showPaymentDialog(context, type: type,
                          onSignUpResult: (signUpParam) {
                          adminBloc.addUser(signUpParam,
                              onResult: (res) => displayResultFbk(res));
                        })
                      : showPaymentDialog(context, type: type,
                          onTransResult: (payParam) {
                          switch (type) {
                            case TransactionType.deposit:
                              apiBloc?.deposit(
                                  DepositParam(
                                      payParam.sender, payParam.amount),
                                  onResult: (res) => displayResultFbk(res));
                              break;
                            case TransactionType.withdraw:
                              apiBloc?.withdraw(
                                  DepositParam(
                                      payParam.sender, payParam.amount),
                                  onResult: (result) {
                                displayResultFbk(result);
                              });
                              break;
                            case TransactionType.transfer:
                              apiBloc?.transfer(payParam, onResult: (result) {
                                displayResultFbk(result);
                              });
                              break;
                            case TransactionType.user:
                              // TODO: Handle this case.
                              break;
                          }
                        }),
                ),
                // DefaultTabController(
                //   length: 3,
                //   initialIndex: _screenIndex,
                //   child:
                IndexedStack(
                  //Body
                  index: _screenIndex,
                  children: [
                    isAdmin
                        ? Column(
                            children: [
                              TransactionFilter(
                                  onPress: (filter) =>
                                      performFilter(filter, context)),
                              ListScreen(stream: adminBloc.transactions),
                            ],
                          )
                        : ListScreen(stream: transBloc.transaction),
                    isAdmin
                        ? ListScreen(
                            stream: adminBloc.users,
                            type: TransactionType.deposit)
                        : ListScreen(
                            stream: (transBloc.deposits),
                            type: TransactionType.deposit),
                    isAdmin
                        ? Center(
                            child: UserDetailScreen(
                            stream: adminBloc.user,
                            isAdmin: true,
                            depositClick: () => showPaymentDialog(context,
                                type: TransactionType.deposit,
                                onTransResult: (payParam) {
                                  apiBloc?.deposit(
                                      DepositParam(
                                          payParam.sender, payParam.amount),
                                      onResult: (res) => displayResultFbk(res));
                                }),
                          ))
                        : ListScreen(
                            stream: transBloc.withdrawal,
                            type: TransactionType.withdraw),
                  ],
                ),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          onTap: (index) {
            switchScreen(index);
          },
          selectedItemColor: kPrimaryColor,
          selectedFontSize: 15,
          unselectedItemColor: TPrimaryColor,
          currentIndex: _screenIndex,
          items: [
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.transfer_within_a_station, color: TPrimaryColor),
                label: isAdmin ? "Transactions" : "Transfer"),
            BottomNavigationBarItem(
                icon: Icon(isAdmin ?Icons.group_rounded:Icons.attach_money, color: TPrimaryColor),
                label: isAdmin ? "Users" : "Deposit"),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.monetization_on_outlined, color: TPrimaryColor),
                label: isAdmin ? "Profile" : "Withdraw"),
          ],
        ),
      ),
    );
  }

  void performFilter(String filter, BuildContext context) {
    switch (filter) {
      case 'limit':
        showLimitDialog(context, onLimit: (limit) {
          setState(() {
            _limit = limit.toInt;
          });
          adminBloc.filterTransactions(TransactionsParam(
              limit: _limit, orderBy: _orderBy, order: _order));
        });
        break;
      case ASC:
      case DESC:
        setState(() {
          _order = filter;
        });
        break;
      default:
        setState(() {
          _orderBy = filter;
        });
    }
    adminBloc.filterTransactions(
        TransactionsParam(limit: _limit, orderBy: _orderBy, order: _order));
  }

  void displayResultFbk<T>(HttpResponse<T> result) {
    var res = result.data;
    signUpResult() => res as SignUpResult;
    Fluttertoast.showToast(
        msg: res is TransferResult ? res.message : signUpResult().message,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: TPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    print(res is TransferResult ? res.message : signUpResult().toJson());
  }

  AwesomeDialog showPaymentDialog(BuildContext context,
      {Function(PayParam payParam)? onTransResult,
      Function(RegParam param)? onSignUpResult,
      TransactionType type: TransactionType.transfer}) {
    var amountController = TextEditingController();
    var toController = TextEditingController();

    var numController = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();

    String tittle() {
      switch (type) {
        case TransactionType.deposit:
          return "Deposit Money";
        case TransactionType.withdraw:
          return "Withdraw Money";
        case TransactionType.transfer:
          return "Transfer Money";
        case TransactionType.user:
          return "Add User";
      }
    }

    var isTransfer = type == TransactionType.transfer;
    var isAddUser = type == TransactionType.user;
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Center(
          child: isAddUser
              ? Flex(
                  direction: Axis.vertical,
                  children: [
                    dialogTittle(tittle),
                    EditText(
                      type: TextInputType.number,
                      controller: numController,
                      hint: "Account Number",
                    ),
                    EditText(
                      type: TextInputType.name,
                      controller: nameController,
                      hint: "Name",
                    ),
                    EditText(
                      passwordField: true,
                      hint: "Password",
                      controller: passController,
                    ),
                  ],
                )
              : Flex(
                  direction: Axis.vertical,
                  children: [
                    dialogTittle(tittle),
                    Divider(),
                    if (isTransfer)
                      EditText(
                        type: TextInputType.number,
                        controller: toController,
                        hint: "Recipient Number",
                      ),
                    EditText(
                      type: TextInputType.number,
                      controller: amountController,
                      hint: "Amount",
                    ),
                  ],
                )),
      btnOkText: isTransfer ? "Transfer" : "Continue",
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: () => onTransResult != null
          ? onTransResult(PayParam(
              widget.user.accountNumber,
              isTransfer ? toController.text : widget.user.accountNumber,
              amountController.text.toInt))
          : onSignUpResult != null
              ? onSignUpResult(RegParam(
                  numController.text, nameController.text, passController.text))
              : () {},
    )..show();
  }

  Text dialogTittle(String tittle()) {
    return Text(tittle(),
        style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold));
  }

  AwesomeDialog showLimitDialog(BuildContext context,
      {required Function(String limit) onLimit}) {
    var limitController = TextEditingController();

    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Center(
          child: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            EditText(
              type: TextInputType.number,
              controller: limitController,
              hint: "Maximum limit",
            ),
          ],
        ),
      )),
      btnOkText: "Continue",
      btnOkOnPress: () => onLimit(limitController.text),
    )..show();
  }

  toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}

extension StringToNumber on String {
  int get toInt => num.parse(this.trim()).toInt();
}
