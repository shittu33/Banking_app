import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:veegil_test/api/classes.dart';
import 'package:veegil_test/api/config.dart';
import 'package:veegil_test/constants.dart';

class Header extends StatelessWidget {
  final TransactionType transactionType;
  final Function()? onToggleDrawer;
  final Function(TransactionType transactionType) onFloatPressed;
  final String? name;
  final Widget? centerChild;

  final bool? isAdmin;

  const Header({
    Key? key,
    this.onToggleDrawer,
    required this.onFloatPressed,
    this.name,
    this.centerChild,
    this.transactionType: TransactionType.transfer,  this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDeposit = transactionType == TransactionType.deposit;
    var isUser = transactionType == TransactionType.user;
    var isTransfer = transactionType == TransactionType.transfer;
    // var is = transactionType == TransactionType.transfer;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Card(
            margin: EdgeInsets.all(0.0),
            elevation: 1.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            child: Container(
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [TPrimaryColor, TPrimaryColor2])),
                padding: EdgeInsets.all(5.0),
                // color: Color(0xFF015FFF),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: onToggleDrawer,
                        ),
                        Text(isAdmin==true?"Admin's Dashboard":"${name ?? "User"}'s Transaction",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300)),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showAboutDialog(
                                context: context, applicationName: "Dash Out!");
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 35.0),
                    Center(
                      child: Container(
                        height: 132,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.0),
                          child: centerChild,
                        ),
                      ),
                    ),
                    // SizedBox(height: 35.0),
                  ],
                )),
          ),
        ),
        FloatingActionButton.extended(
            onPressed: () => onFloatPressed(transactionType /*deposit*/),
            label: Text(
                isDeposit
                    ? "Deposit Money"
                    : isUser
                        ? "Add User"
                        : isTransfer
                            ? "Send Money"
                            : "Withdraw Money",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            icon: Icon(Icons.attach_money, color: TPrimaryColor2))
      ],
    );
  }
}

class SummaryView extends StatelessWidget {
  const SummaryView({
    Key? key,
    required this.summaryStream,
  }) : super(key: key);

  final Stream<HttpResponse<Summary>>? summaryStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HttpResponse<Summary>>(
        stream: summaryStream,
        builder: (context, snapshot) {
          var data = snapshot.data!.data;
          var totalDeposited = data.totalBalance;
          var shortBalance = totalDeposited.length > 3
              ? "${totalDeposited.substring(0, 2)}K+"
              : totalDeposited;
          var transactions = data.numTransactions;
          var shortTrans = transactions.length > 3
              ? "${transactions.substring(0, 2)}K+"
              : transactions;
          return snapshot.hasError
              ? CircularProgressIndicator()
              : Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        flex: 1,
                        child: SummaryItem(
                            text1: "#$shortBalance", text2: "Deposited")),
                    Expanded(
                        flex: 1,
                        child:
                            SummaryItem(text1: data.numUser, text2: "Joined")),
                    Expanded(
                        flex: 1,
                        child: SummaryItem(
                            text1: shortTrans, text2: "Transactions")),
                  ],
                );
        });
  }
}

class SummaryItem extends StatelessWidget {
  final String text1;
  final String text2;

  const SummaryItem({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final stream;
  final bool? isAdmin;
  final Function()? depositClick;

  const UserDetailScreen({Key? key, this.stream, this.isAdmin: false, this.depositClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HttpResponse<UserResult>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            var user = snapshot.data!.data.user;
            double cardElevation = 1;
            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isAdmin == true) SizedBox(height: 33),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.attach_money,
                                size: 39, color:isAdmin==true?TPrimaryColor2: Colors.white),
                            Text("${user!.balance}",
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: isAdmin==true?TPrimaryColor2:Colors.white)),
                          ],
                        ),
                      ),
                      Text("Balance",
                          style: TextStyle(
                              fontSize: 37,
                              color: isAdmin==true?TPrimaryColor2:Colors.white,
                              fontWeight: FontWeight.w300)),
                      if (isAdmin == true) SizedBox(height: 13),
                      if (isAdmin == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 0),
                          child: Column(
                            children: [
                              Card(
                                child: ListTile(
                                  leading: Text("JOINED ON:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: TPrimaryColor2,
                                          fontWeight: FontWeight.w300)),
                                  title: Text(user.created),
                                ),
                              ),
                              Divider(),
                              Card(
                                child: ListTile(
                                  leading: Text("AccountNumber:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: TPrimaryColor2,
                                          fontWeight: FontWeight.w300)),
                                  title: Text(user.accountNumber),
                                ),
                              ),Divider(),
                              GestureDetector(
                                onTap: depositClick,
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.monetization_on,color: TPrimaryColor2,),
                                    title: Text("Deposit Money",style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: TPrimaryColor2)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
                : Text(snapshot.error.toString());
          }
        });
  }
}

class ListScreen<T> extends StatelessWidget {
  final Stream<HttpResponse<T>> stream;
  final TransactionType? type;

  const ListScreen(
      {Key? key, required this.stream, this.type: TransactionType.transfer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HttpResponse<T>>(
        stream: stream,
        //23490454136,8453464533545,8453464533545,4349045413652
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            T data = snapshot.data!.data;
            var items = (data is TransactionResult
                ? data.transaction
                : (data is TransactionsResult
                    ? data.transactions
                    : (data as UsersResult).users!));
            return snapshot.hasData
                ? Container(
                    margin: EdgeInsets.all(15.0),
                    child:
                        /*ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              Transaction item = items[index];
              return Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text("dsjkdfjsk"));
            })*/
                        Column(
                      children: items!
                          .map((item) => item is User
                              ? UserItem(user: item)
                              : TransactionItem(
                                  item: item as Transaction,
                                  type: type!,
                                ))
                          .toList(),
                    ),
                  )
                : Text(snapshot.error.toString());
          }
        });
  }
}

class TransactionItem extends StatelessWidget {
  final Transaction item;
  final TransactionType type;

  TransactionItem({required this.item, required this.type});

  @override
  Widget build(BuildContext context) {
    bool deposit = type == TransactionType.deposit;
    bool withdraw = type == TransactionType.withdraw;

    return Card(
      elevation: 1,
      margin: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: item.type == CREDIT ? Color(0xFFF7F7F9) : null),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: TPrimaryColor2,
            child: Icon(
              deposit
                  ? Icons.monetization_on_sharp
                  : item.type == CREDIT
                      ? Icons.transfer_within_a_station
                      : Icons.monetization_on_sharp,
              color: Colors.white,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  deposit || withdraw
                      ? item.time.split(" ")[0]
                      : item.type == CREDIT
                          ? item.senderName
                          : item.recipientName ?? item.senderName,
                  style: TextStyle(fontSize: 16.0)),
              Text(deposit ? item.time.split(" ")[1] : item.time,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("#${item.amount.toString()}",
                  style: TextStyle(fontSize: 16.0)),
              Text(deposit ? "deposit" : (withdraw ? "withdrawal" : item.type),
                  style: TextStyle(color: Colors.grey, fontSize: 14.0))
            ],
          ),
        ),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  final User user;

  UserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(color: Color(0xFFF7F7F9)),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: TPrimaryColor2,
            child: Icon(
              Icons.monetization_on_sharp,
              color: Colors.white,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.name, style: TextStyle(fontSize: 16.0)),
              Text(user.accountNumber,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0)),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("#${user.balance.toString()}",
                  style: TextStyle(fontSize: 16.0)),
              Text(user.created,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0))
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionFilter extends StatelessWidget {
  final Function(String filter) onPress;

  const TransactionFilter({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text("Filter Transaction By:",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w400)),
        Wrap(
          children: [SENDER, RECIPIENT, CREATED, ASC, DESC, "limit"]
              .map((filter) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      child: Chip(label: Text(filter)),
                      onTap: () => onPress(filter),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

enum TransactionType { deposit, user, withdraw, transfer }
