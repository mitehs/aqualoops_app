import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  final List<Product> _products = [];
  bool _isLoading = false;
  String _searchText = '';
  String _selectedCategory = 'All';

  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String get searchText => _searchText;
  String get selectedCategory => _selectedCategory;

  List<String> get categories {
    final names = _products.map((item) => item.category).toSet().toList();
    names.sort();
    return ['All', ...names];
  }

  // Products filtered by search text + selected category
  List<Product> get filteredProducts {
    return _products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
            _searchText.toLowerCase(),
          );
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Product? findById(int id) {
    for (final product in _products) {
      if (product.id == id) return product;
    }
    return null;
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _products
      ..clear()
      ..addAll(await _apiService.getProducts());

    _isLoading = false;
    notifyListeners();
  }

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _apiService.addProduct(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _apiService.updateProduct(product);
    await loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await _apiService.deleteProduct(id);
    await loadProducts();
  }
}
