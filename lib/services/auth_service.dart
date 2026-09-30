import '../models/user.dart';
import '../utils/constants.dart';
import 'storage_service.dart';

/// Demo authentication service.
///
/// UI only - no database and no real API. Users are validated against the
/// demo credentials in `AppConstants`, and the signed in user is kept in
/// memory by [StorageService].
class AuthService {
  static final AuthService _instance = AuthService._();
  factory AuthService() => _instance;
  AuthService._();

  static const String _userKey = 'current_user';

  User? get currentUser {
    final data = StorageService.get<Map<String, dynamic>>(_userKey);
    if (data == null) return null;
    return User.fromJson(data);
  }

  bool get isLoggedIn => currentUser != null;

  /// Returns the signed in user, or throws with a friendly message.
  Future<User> login({
    required String email,
    required String password,
    String role = 'customer',
  }) async {
    await Future.delayed(AppConstants.demoDelay);

    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw 'Please enter email and password';
    }

    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    // Pick the demo account that matches the requested role.
    String name = 'User';
    String demoEmail = AppConstants.demoCustomerEmail;

    if (role == 'admin') {
      name = 'Admin';
      demoEmail = AppConstants.demoAdminEmail;
    } else if (role == 'supplier') {
      name = 'Supplier';
      demoEmail = AppConstants.demoSupplierEmail;
    }

    final user = User(
      id: role == 'customer' ? 1 : (role == 'admin' ? 900 : 101),
      name: name,
      email: email.trim(),
      phone: '9876543210',
      role: role,
      address: 'Bengaluru, India',
    );

    // Any email works for the customer flow, but admin / supplier emails
    // must match the demo credentials so the flow feels realistic.
    if (role != 'customer' && email.trim().toLowerCase() != demoEmail) {
      throw 'Invalid $role credentials';
    }

    _save(user);
    return user;
  }

  Future<User> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(AppConstants.demoDelay);

    if (name.trim().isEmpty || email.trim().isEmpty) {
      throw 'Please fill all fields';
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
      role: 'customer',
    );

    _save(user);
    return user;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    StorageService.remove(_userKey);
  }

  void _save(User user) {
    StorageService.set(_userKey, user.toJson());
  }
}
