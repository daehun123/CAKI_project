import 'package:flutter/material.dart';

class RecentSearchesProvider extends ChangeNotifier {
  List<String> _recentSearches = [];

  List<String> get recentSearches => _recentSearches;

  void addRecentSearch(String query) {
    _recentSearches.insert(0, query);
    notifyListeners();
  }
}
