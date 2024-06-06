import 'package:flutter/material.dart';

import '../../Components/background.dart';
import '../Login/Components/social_login.dart';
import 'Components/loginandsignup_btn.dart';
import 'Components/welcome_image.dart';

class Welcome_Screen extends StatelessWidget {
  const Welcome_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { return Future(() => false); },
      child: const Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Welcome_Image(),
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: LoginAndSignupBtn(),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Spacer(),
                    Naver_Login_btn(),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
