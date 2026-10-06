import 'package:flutter/material.dart';

// Auth
import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/otp_screen.dart';
import '../screens/auth/set_new_password_screen.dart';

// Customer
import '../screens/customer/home_screen.dart';
import '../screens/customer/cart_screen.dart';
import '../screens/customer/checkout_screen.dart';
import '../screens/customer/my_orders_screen.dart';
import '../screens/customer/profile_screen.dart';
import '../screens/customer/track_order_screen.dart';
import '../screens/customer/address_screen.dart';
import '../screens/customer/notifications_screen.dart';

// Admin
import '../screens/admin/admin_login_screen.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/customers_screen.dart';
import '../screens/admin/products_screen.dart';
import '../screens/admin/add_product_screen.dart';
import '../screens/admin/suppliers_screen.dart';
import '../screens/admin/add_supplier_screen.dart';
import '../screens/admin/reports_screen.dart';
import '../screens/admin/settings_screen.dart';

// Supplier
import '../screens/supplier/supplier_login.dart';
import '../screens/supplier/supplier_register.dart';
import '../screens/supplier/supplier_dashboard.dart';
import '../screens/supplier/supplier_orders.dart';
import '../screens/supplier/order_details.dart';
import '../screens/supplier/delivery_screen.dart';
import '../screens/supplier/earnings_screen.dart';

class AppRoutes {
  AppRoutes._();

  // Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String setNewPassword = '/set-new-password';

  // Customer
  static const String home = '/home';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String myOrders = '/orders';
  static const String profile = '/profile';
  static const String trackOrder = '/track-order';
  static const String address = '/address';
  static const String notifications = '/notifications';

  // Admin
  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminCustomers = '/admin/customers';
  static const String adminProducts = '/admin/products';
  static const String adminAddProduct = '/admin/products/add';
  static const String adminSuppliers = '/admin/suppliers';
  static const String adminAddSupplier = '/admin/suppliers/add';
  static const String adminReports = '/admin/reports';
  static const String adminSettings = '/admin/settings';

  // Supplier
  static const String supplierLogin = '/supplier/login';
  static const String supplierRegister = '/supplier/register';
  static const String supplierDashboard = '/supplier/dashboard';
  static const String supplierOrders = '/supplier/orders';
  static const String supplierOrderDetails = '/supplier/orders/details';
  static const String supplierDelivery = '/supplier/delivery';
  static const String supplierEarnings = '/supplier/earnings';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth
      case splash:
        return _page(const SplashScreen());
      case login:
        return _page(const LoginScreen());
      case register:
        return _page(const RegisterScreen());
      case forgotPassword:
        return _page(ForgotPasswordScreen());
      case otp:
        return _page(const OtpScreen());
      case setNewPassword:
        return _page(const SetNewPasswordScreen());

      // Customer
      case home:
        return _page(const HomeScreen());
      case cart:
        return _page(const CartScreen());
      case checkout:
        return _page(const CheckoutScreen());
      case myOrders:
        return _page(const MyOrdersScreen());
      case profile:
        return _page(const ProfileScreen());
      case trackOrder:
        return _page(const TrackOrderScreen());
      case address:
        return _page(const AddressScreen());
      case notifications:
        return _page(const NotificationsScreen());

      // Admin
      case adminLogin:
        return _page(const AdminLoginScreen());
      case adminDashboard:
        return _page(const AdminDashboard());
      case adminCustomers:
        return _page(const CustomersScreen());
      case adminProducts:
        return _page(const ProductsScreen());
      case adminAddProduct:
        return _page(const AddProductScreen());
      case adminSuppliers:
        return _page(const SuppliersScreen());
      case adminAddSupplier:
        return _page(const AddSupplierScreen());
      case adminReports:
        return _page(const ReportsScreen());
      case adminSettings:
        return _page(const SettingsScreen());

      // Supplier
      case supplierLogin:
        return _page(const SupplierLogin());
      case supplierRegister:
        return _page(const SupplierRegister());
      case supplierDashboard:
        return _page(const SupplierDashboard());
      case supplierOrders:
        return _page(const SupplierOrders());
      case supplierOrderDetails:
        return _page(const OrderDetails());
      case supplierDelivery:
        return _page(const DeliveryScreen());
      case supplierEarnings:
        return _page(const EarningsScreen());

      default:
        return _page(const SplashScreen());
    }
  }

  static MaterialPageRoute<void> _page(Widget screen) {
    return MaterialPageRoute<void>(builder: (_) => screen);
  }
}
