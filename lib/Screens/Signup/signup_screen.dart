import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/background.dart';
import 'Components/signup_form.dart';

class Signup_Screen extends StatelessWidget {
  const Signup_Screen({super.key});


  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: SignUp(),
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        SignupForm(),
      ],
    );
  }
}
