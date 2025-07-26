import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoriesProvider extends ChangeNotifier {
  final String _dataUrl =
      'https://raw.githubusercontent.com/jsarr11/menu-json/refs/heads/main/menu.json';

  List<Categories> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Categories> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_dataUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> categoriesJson = jsonData['categories'];

        _categories = categoriesJson
            .map((categoryJson) => Categories.fromJson(categoryJson))
            .toList();

        // **Sort categories by display_order**
        _categories.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

        // **Sort products by id within each category**
        for (var category in _categories) {
          category.products.sort((a, b) => a.id.compareTo(b.id));
        }
      } else {
        _errorMessage = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
