import 'package:caki_project/Screens/Login/Components/social_login.dart';
import 'package:flutter/material.dart';

import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Login_Screen();
                },
              ),
            );
          },
          child: Text(
            'Login'.toUpperCase(),
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Signup_Screen();
                },
              ),
            );
          },
          child: Text(
            'Sign Up'.toUpperCase(),
          ),
        ),

      ],
    );
  }
}
