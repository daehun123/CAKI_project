import 'package:caki_project/Components/constants.dart';
import 'package:caki_project/Screens/Categorie/components/board_list_cheaper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class CheaperScreen extends StatelessWidget {
  const CheaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BFYB'),
          backgroundColor: kColor,
        ),
        body: BoardList_cheaper(),
        bottomNavigationBar: Bottom()
    );
  }
}
