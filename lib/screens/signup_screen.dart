import 'package:flutter/material.dart';
import 'package:veegil_test/api/classes.dart';
import 'profile/profile_screen.dart';
import './login_screen.dart';
import 'package:veegil_test/widget/already_have_an_account_acheck.dart';
import 'package:veegil_test/widget/rounded_button.dart';
import 'package:veegil_test/widget/rounded_input_field.dart';
import 'package:veegil_test/widget/rounded_password_field.dart';
import '../widget/Signup/or_divider.dart';
import '../widget/Signup/social_icon.dart';

import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatelessWidget {
  final void Function(RegParam regParam)? onSignUp;
  final void Function()? onAlreadyRegister;
  final TextEditingController? numController = TextEditingController();
  final TextEditingController? passController = TextEditingController();
  final TextEditingController? nameController = TextEditingController();

  SignUpScreen({Key? key, this.onSignUp, this.onAlreadyRegister})
      : super(key: key);

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
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              // Text("Img"),/*
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                controller: numController,
                hintText: "Account Number",
                onChanged: (value) {},
              ),
              RoundedInputField(
                inputType: TextInputType.name,
                controller: nameController,
                hintText: "Name",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: passController,
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () =>
                    onSignUp!(new RegParam(numController!.text,nameController!.text, passController!.text)),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: onAlreadyRegister ?? (){},
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
