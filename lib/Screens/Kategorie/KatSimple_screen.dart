import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class SimpleScreen extends StatelessWidget {
  const SimpleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple'),
        ),
        bottomNavigationBar: Bottom()
    );
  }
}
