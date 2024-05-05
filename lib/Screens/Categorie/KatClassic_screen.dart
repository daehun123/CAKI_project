import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/Categorie/components/board_list_classic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class ClassicScreen extends StatelessWidget {
  ClassicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Classic'),
          backgroundColor: kColor,
        ),
        body: BoardList(),
        bottomNavigationBar: Bottom());
  }
}
