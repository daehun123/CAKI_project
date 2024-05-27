import 'package:caki_project/Screens/Categorie/components/board_list_simple.dart';
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
          backgroundColor: Color(0xFF8A9352),
        ),
        body: BoardList_simple(),
        bottomNavigationBar: Bottom()
    );
  }
}
