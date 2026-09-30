class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'AquaLoop';
  static const String appTagline = 'Pure Water Delivery';
  static const String appVersion = '1.0.0';

  // Currency
  static const String currency = '₹';

  // Delivery
  static const double deliveryCharge = 20.0;
  static const double freeDeliveryAbove = 299.0;

  // OTP
  static const int otpLength = 6;

  // Support
  static const String supportEmail = 'support@aqualoops.in';
  static const String supportPhone = '+91 98765 43210';
  static const String website = 'www.aqualoops.in';

  // Demo credentials (UI only - no database)
  static const String demoCustomerEmail = 'user@example.com';
  static const String demoCustomerPassword = '123456';
  static const String demoAdminEmail = 'admin@aqualoops.in';
  static const String demoAdminPassword = 'admin123';
  static const String demoSupplierEmail = 'supplier@aqualoops.in';
  static const String demoSupplierPassword = 'supplier123';

  // Simulated loading time for demo services
  static const Duration demoDelay = Duration(milliseconds: 600);
}
