import 'dart:html';

import 'package:caki_project/Components/location.dart';
import 'package:flutter/widgets.dart';

class MainProvider with ChangeNotifier{
  main_Location _main_location = main_Location(null, null);
  main_Location get location => _main_location;


}