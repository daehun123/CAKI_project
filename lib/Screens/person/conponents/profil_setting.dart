import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/person/Personscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Welcome/welcome_screen.dart';

class ProfilSetting extends StatelessWidget {
  final setting_formkey = GlobalKey<FormState>();
  String? pwCheck;
  ProfilSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonScreen()),
            );
          },
        ),
        title: Text('설정'),
        backgroundColor: kColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: setting_formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: const Color(0xFF8A9352),
                    onSaved: (email) {},
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    cursorColor: const Color(0xFF8A9352),
                    decoration: const InputDecoration(
                      hintText: 'NickName',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  // child: TextField(
                  //   textInputAction: TextInputAction.next,
                  //   obscureText: true,
                  //   cursorColor: Color(0xFF8A9352),
                  //   decoration: InputDecoration(
                  //     hintText: 'Pw',
                  //     prefixIcon: Padding(
                  //       padding: EdgeInsets.all(16.0),
                  //       child: Icon(Icons.lock),
                  //     ),
                  //   ),
                  // ),
                  child: Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.lock,
                            color: kColor,
                          )),
                      const Text(
                        '**************',
                      ),
                      Spacer(flex: 8,),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('변경'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: kColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    cursorColor: const Color(0xFF8A9352),
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: '\n자기소개란',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.discord_outlined),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 8,
                      child: ElevatedButton(
                        onPressed: () {
                          if (setting_formkey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const Welcome_Screen()),
                                (route) => false);
                          }
                        },
                        child: Text('변경'.toUpperCase()),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                        flex: 8,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('로그아웃'))),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
