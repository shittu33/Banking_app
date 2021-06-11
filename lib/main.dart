import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retrofit/dio.dart';
import 'package:veegil_test/api/classes.dart';
import 'package:veegil_test/api/repository.dart';
import 'package:veegil_test/constants.dart';
import 'package:veegil_test/screens/profile/profile_screen.dart';
import 'package:veegil_test/screens/signup_screen.dart';
import './screens/login_screen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: LoginScreen(
        onLogin: (actNo, password) async {
          if (isEmptyField([actNo, password])) return;
          await performLogin(actNo, password, context);
        },
        onAbsentAccount: () {
          pushToScreen(SignUpScreen(
            onSignUp: (regParam) async {
              if (isEmptyField(
                  [regParam.accountNumber, regParam.name, regParam.password]))
                return;
              await signUp(regParam, context);
            },
            onAlreadyRegister: () {
              Navigator.pop(context);
            },
          ));
        },
      )),
      // body: Center(child:Account()),
    );
  }

  Future performLogin(String actNo, String pass, BuildContext context) async {
    print("start");
    HttpResponse<LoginResult> loginRes =
        await ApiRepository().loginUser(AuthUser(actNo, pass));
    bool? error = loginRes.data.error;
    var statusCode = loginRes.response.statusCode;
    var isResultOk = statusCode == HttpStatus.ok;
    if (isResultOk) {
      print("The error is $error");
      User? user = loginRes.data.data;
      if (error == true)
        print("there are some database error");
      else
        print(user!.toJson());

      Fluttertoast.showToast(
          msg: error == true
              ? "there are some database error"
              : "Logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: TPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      if (error == false) pushToScreen(Profile(user: user!));
    } else {
      print("The code is $statusCode");
      var message = loginRes.data.message;
      bool isNoUserFound = (statusCode == HttpStatus.created);
      bool isNotMatched = (statusCode == HttpStatus.partialContent);
      bool noInput = statusCode == HttpStatus.multiStatus;
      AwesomeDialog(
        context: context,
        showCloseIcon: !isNoUserFound,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.ERROR,
        btnOkText: isNoUserFound ? "Click to register" : "Try again",
        btnCancelText: "Try again",
        title: 'Failure!',
        desc: isNoUserFound || isNotMatched || noInput
            ? message
            : 'Something went wrong,\n we Can\'t log you in',
        btnOkOnPress: isNoUserFound
            ? () {
                pushToScreen(SignUpScreen());
              }
            : null,
      )..show();
    }
  }

  Future<void> signUp(RegParam regParam, BuildContext context) async {
    HttpResponse<SignUpResult>? signUpResult =
        await ApiRepository().signUpUser(regParam);
    var statusCode = signUpResult.response.statusCode;
    bool? error = signUpResult.data.error;
    var isResultOk = statusCode == HttpStatus.ok;
    if (isResultOk) {
      print("The error is $error");
      User? user = signUpResult.data.data;
      if (error == true)
        print("There are some database error here");
      else
        print(user!.toJson());
      Fluttertoast.showToast(
          msg: error == true
              ? "there are some database error"
              : "Signed up successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: TPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      if (error == false) pushToScreen(Profile(user: user!));
    } else {
      print("The code is $statusCode");
      var message = signUpResult.data.message;
      bool isFailed = statusCode == HttpStatus.partialContent;
      bool alreadyExist = (statusCode == HttpStatus.alreadyReported);
      bool noInput = statusCode == HttpStatus.multiStatus;
      AwesomeDialog(
        context: context,
        showCloseIcon: !isFailed,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.ERROR,
        btnOkText: "Try again",
        btnCancelText: "Try again",
        title: 'Failure!',
        desc: alreadyExist || noInput
            ? message
            : 'Something went wrong,\n we Can\'t  unable to register you',
      )..show();
    }
  }

  bool isEmptyField(List<String> fields) {
    for (String field in fields)
      if (field.isEmpty) {
        Fluttertoast.showToast(
            msg: "make sure you filled all the form fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: TPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        return true;
      }
    return false;
  }

  void pushToScreen(Widget screen) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return screen;
          },
        ),
      );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
