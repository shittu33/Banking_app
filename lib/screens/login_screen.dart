import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:veegil_test/screens/signup_screen.dart';
import 'package:veegil_test/widget/already_have_an_account_acheck.dart';
import 'package:veegil_test/widget/rounded_button.dart';
import 'package:veegil_test/widget/rounded_input_field.dart';
import 'package:veegil_test/widget/rounded_password_field.dart';

import 'profile/profile_screen.dart';

class LoginScreen extends StatelessWidget {
  final void Function(String number, String password)? onLogin;
  final void Function()? onAbsentAccount;
  final TextEditingController? numController = TextEditingController();
  final TextEditingController? passController = TextEditingController();

  LoginScreen({
    Key? key,
    this.onLogin,
    this.onAbsentAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // Text(""),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: numController,
              hintText: "Account Number",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () => onLogin!(numController!.text, passController!.text),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: ()=>onAbsentAccount!(),
            ),
          ],
        ),
      ),
    ));
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.black,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
