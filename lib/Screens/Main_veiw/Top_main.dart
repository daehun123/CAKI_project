import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Components/Mainpagesearchbox.dart';

@override
PreferredSizeWidget Apptop(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF8A9352),
    title: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'CAKI',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    ),
    bottom: searchBox(context),
  );
}

