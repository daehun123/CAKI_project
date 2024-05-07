import 'package:caki_project/Screens/Main_veiw/Bottom_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IngredientScreen extends StatelessWidget {
  const IngredientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('재료별 추천'),
      ),
      bottomNavigationBar: Bottom(),
    );
  }
}
