import 'package:caki_project/Screens/Categorie/components/board_list_expert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class ExpertScreen extends StatelessWidget {
  const ExpertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Expert'),
          backgroundColor: Color(0xFF8A9352),
        ),
        body: BoardList_expert(),
        bottomNavigationBar: Bottom()
    );
  }
}
