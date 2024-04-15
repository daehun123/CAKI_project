import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class CheaperScreen extends StatelessWidget {
  const CheaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cheaper'),
          backgroundColor: Color(0xFF8A9352),
        ),
        bottomNavigationBar: Bottom()
    );
  }
}
