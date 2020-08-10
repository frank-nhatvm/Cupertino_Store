import 'package:flutter/foundation.dart' as foundation;
import 'product.dart';
import 'product_repository.dart';

double _saleTaxRate = 0.06;
double _shippingCostItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  List<Product> _availableProducts;
  Category _selectedCategory = Category.all;
  final _productInCart = <int, int>{};

  Map<int, int> get productsInCart {
    return Map.from(_productInCart);
  }

  int get totalCartQuantity {
    return _productInCart.values.fold(0, (previousValue, element) {
      return previousValue + element;
    });
  }

  Category get selectedCategory {
    return _selectedCategory;
  }

  double get subtotalCost {
    return _productInCart.keys.map((id) {
      return getProductById(id).price * _productInCart[id];
    }).fold(0, (previousValue, element) {
      return previousValue + element;
    });
  }

  double get shippingCost{
    return _shippingCostItem * totalCartQuantity;
  }

  double get tax{
    return subtotalCost * _saleTaxRate;
  }

  double get totalCost{
    return subtotalCost + shippingCost + tax;
  }

  List<Product> getProduct(){
    if(_availableProducts == null){
      return [];
    }

    if(_selectedCategory == Category.all){
      return List.from(_availableProducts);
    }
    else{
      return _availableProducts.where((element) => element.category == _selectedCategory).toList();
    }
  }

  List<Product> search(String searchTerm){
    return _availableProducts.where((element){
      return element.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }

  void addProductToCart(int productId){
    if(!_productInCart.containsKey(productId)){
      _productInCart[productId] = 1;
    }
    else{
      _productInCart[productId]++;
    }
    notifyListeners();
  }

  void removeItemFromCart(int productId){
    if(_productInCart.containsKey(productId)){
      if(_productInCart[productId] == 1){
        _productInCart.remove(productId);
      }
      else{
        _productInCart[productId]--;
      }
    }
  }

  Product getProductById(int id) {
    return _availableProducts.firstWhere((element) => element.id == id);
  }

  void clearCart() {
    _productInCart.clear();
    notifyListeners();
  }

  void loadProduct() {
    _availableProducts = ProductsRepository.loadProducts(Category.all);
    notifyListeners();
  }

  void setCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
