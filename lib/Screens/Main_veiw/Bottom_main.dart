import 'package:flutter/material.dart';
import 'Components/MP_Arrowbt.dart';
import 'Components/MP_Hoombt.dart';
import 'Components/MP_Keepbt.dart';
import 'Components/MP_Personbt.dart';
import 'Components/MP_Searchbt.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MainpageSearchbt(),
          MainpageArrowbt(),
          MainpageHoombt(),
          MainpageKeepbt(),
          MainpagePersonbt()
        ],
      ),
    );
  }
}
