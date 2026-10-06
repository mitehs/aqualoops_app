import 'package:aqualoops_app/models/cart.dart';
import 'package:aqualoops_app/models/order.dart';
import 'package:aqualoops_app/models/product.dart';
import 'package:aqualoops_app/models/user.dart';

// ============================================================================
// All the data of the app lives here as simple global variables.
// Screens just read these variables and call setState() when something
// changes.
// ============================================================================

// ----------------------------- LOGGED IN USER ------------------------------
User? loggedInUser;

// --------------------------------- PRODUCTS --------------------------------
List<Product> allProducts = [
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

// ---------------------------------- CART -----------------------------------
List<CartItem> cartItems = [];

double getCartTotal() {
  double amount = 0;
  for (CartItem item in cartItems) {
    amount += item.product.price * item.quantity;
  }
  return amount;
}

// Adds a product to the cart. If it is already there the quantity grows.
void addToCart(Product product, int quantity) {
  bool found = false;
  for (CartItem item in cartItems) {
    if (item.product.id == product.id) {
      item.quantity = item.quantity + quantity;
      found = true;
      break;
    }
  }
  if (!found) {
    cartItems.add(CartItem(product: product, quantity: quantity));
  }
}

void increaseQuantity(int index) {
  cartItems[index].quantity++;
}

void decreaseQuantity(int index) {
  if (cartItems[index].quantity > 1) {
    cartItems[index].quantity--;
  }
}

void removeFromCart(int index) {
  cartItems.removeAt(index);
}

void clearCart() {
  cartItems.clear();
}

// --------------------------------- ORDERS ----------------------------------
List<Order> orders = [];

void placeOrder({
  required List<CartOrderItem> items,
  required double total,
  required String address,
  required String paymentMethod,
}) {
  Order order = Order(
    id: '#AQ${1001 + orders.length}',
    date: DateTime.now(),
    items: items,
    total: total,
    address: address,
    paymentMethod: paymentMethod,
  );
  orders.insert(0, order);
}
