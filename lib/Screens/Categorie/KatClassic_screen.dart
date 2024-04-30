import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class ClassicScreen extends StatelessWidget {
  const ClassicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Classic'),
          backgroundColor: Color(0xFF8A9352),
        ),
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: const Column(
            children: [
              Text('data'),
              Text('data')
            ],
          ),
        ),
        bottomNavigationBar: Bottom());
  }
}