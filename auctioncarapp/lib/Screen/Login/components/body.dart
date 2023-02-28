import 'package:auctioncarapp/Screen/Home/home_screen.dart';
import 'package:auctioncarapp/Screen/Signup/signup_screen.dart';
import 'package:auctioncarapp/components/already_have_an_account_acheck.dart';
import 'package:auctioncarapp/components/or_divider.dart';
import 'package:auctioncarapp/components/rounded_button.dart';
import 'package:auctioncarapp/components/rounded_input_field.dart';
import 'package:auctioncarapp/components/rounded_password_field.dart';
import 'package:auctioncarapp/components/social_icon.dart';
import 'package:auctioncarapp/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Signup/components/background.dart';

class Body extends StatelessWidget {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.20,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
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
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () async {
                    _isSigningIn = true;

                    User? user =
                        await Authentication.signInWithGoogle(context: context);

                    _isSigningIn = false;
                    ;

                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
