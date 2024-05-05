import 'package:caki_project/Components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Main_veiw/Bottom_main.dart';

class ClassicScreen extends StatelessWidget {
  List<String> board_data = ['1', '2', '3'];
  ClassicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Classic'),
          backgroundColor: kColor,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: board_data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        maximumSize: const Size(double.infinity, 100),
                        minimumSize: const Size(double.infinity, 100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            "assets/Img/intro_under.png",
                            fit: BoxFit.fill,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(board_data[index]),
                        ],
                      )),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: Bottom());
  }
}
