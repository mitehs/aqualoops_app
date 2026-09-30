import '../models/product.dart';
import '../models/user.dart';
import '../utils/constants.dart';

/// Demo data source for the UI.
///
/// NOTE: This project is UI only - there is no database and no real API.
/// Every method below returns local demo data after a short delay so the
/// screens behave exactly like they would with a real backend.
/// Replace the bodies of these methods with real HTTP calls later.
class ApiService {
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;
  ApiService._();

  // ---------------------------------------------------------------
  // PRODUCTS
  // ---------------------------------------------------------------
  final List<Product> _products = [
    Product(
      id: 1,
      name: '20L Mineral Water',
      description: 'Pure mineral water for your daily needs.',
      price: 30,
      image: '',
      stock: 100,
      category: '20L',
      rating: 4.8,
    ),
    Product(
      id: 2,
      name: '1L Water Bottle',
      description: 'Fresh drinking water in a convenient bottle.',
      price: 20,
      image: '',
      stock: 150,
      category: '1L',
      rating: 4.7,
    ),
    Product(
      id: 3,
      name: '500ml Water Bottle',
      description: 'Fresh and pure drinking water.',
      price: 10,
      image: '',
      stock: 200,
      category: '500ml',
      rating: 4.6,
    ),
    Product(
      id: 4,
      name: '20L Premium Water',
      description: 'Premium quality drinking water.',
      price: 40,
      image: '',
      stock: 80,
      category: '20L',
      rating: 4.9,
    ),
    Product(
      id: 5,
      name: '5L Water Can',
      description: 'Handy can for homes and offices.',
      price: 25,
      image: '',
      stock: 120,
      category: '5L',
      rating: 4.5,
    ),
  ];

  Future<List<Product>> getProducts() async {
    await Future.delayed(AppConstants.demoDelay);
    return List.unmodifiable(_products);
  }

  Future<void> addProduct(Product product) async {
    await Future.delayed(AppConstants.demoDelay);
    _products.add(product);
  }

  Future<void> updateProduct(Product product) async {
    await Future.delayed(AppConstants.demoDelay);
    final index = _products.indexWhere((item) => item.id == product.id);
    if (index != -1) _products[index] = product;
  }

  Future<void> deleteProduct(int id) async {
    await Future.delayed(AppConstants.demoDelay);
    _products.removeWhere((item) => item.id == id);
  }

  // ---------------------------------------------------------------
  // USERS (customers / suppliers)
  // ---------------------------------------------------------------
  final List<User> _customers = [
    User(
      id: 1,
      name: 'Rahul Sharma',
      email: 'rahul@example.com',
      phone: '9876543210',
      role: 'customer',
      address: 'MG Road, Bengaluru',
    ),
    User(
      id: 2,
      name: 'Priya Verma',
      email: 'priya@example.com',
      phone: '9876543211',
      role: 'customer',
      address: 'Park Street, Kolkata',
    ),
    User(
      id: 3,
      name: 'Amit Patel',
      email: 'amit@example.com',
      phone: '9876543212',
      role: 'customer',
      address: 'CG Road, Ahmedabad',
    ),
    User(
      id: 4,
      name: 'Sneha Iyer',
      email: 'sneha@example.com',
      phone: '9876543213',
      role: 'customer',
      address: 'Anna Nagar, Chennai',
    ),
  ];

  final List<User> _suppliers = [
    User(
      id: 101,
      name: 'Ravi Kumar',
      email: 'ravi@aqualoops.in',
      phone: '9911223344',
      role: 'supplier',
      address: 'Bengaluru North Route',
    ),
    User(
      id: 102,
      name: 'Suresh Babu',
      email: 'suresh@aqualoops.in',
      phone: '9911223355',
      role: 'supplier',
      address: 'Bengaluru South Route',
    ),
    User(
      id: 103,
      name: 'Manoj Gupta',
      email: 'manoj@aqualoops.in',
      phone: '9911223366',
      role: 'supplier',
      address: 'Hyderabad Route',
    ),
  ];

  Future<List<User>> getCustomers() async {
    await Future.delayed(AppConstants.demoDelay);
    return List.unmodifiable(_customers);
  }

  Future<List<User>> getSuppliers() async {
    await Future.delayed(AppConstants.demoDelay);
    return List.unmodifiable(_suppliers);
  }
}
