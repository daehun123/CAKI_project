import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String? selectedItem;
  const ResultScreen({Key? key, this.selectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Center(
        child: Text(
          selectedItem ?? 'No item selected',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}