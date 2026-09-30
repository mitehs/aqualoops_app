# AquaLoop — Complete Project Documentation

**Project Name:** AquaLoop — Pure Water Delivery App
**Type:** Mobile Application (Flutter)
**Purpose:** Online water product ordering system with three user roles — Customer, Admin and Supplier
**Status:** ✅ `flutter analyze` → No issues found · `flutter test` → All tests passed

---

## 1. Project Overview

AquaLoop is a water-delivery e-commerce app. A customer orders water (20L can, 1L, 500ml bottles),
an admin manages the store (products, customers, suppliers, reports), and a supplier delivers the
orders and tracks earnings — all inside **one Flutter application**.

| Role | What they can do |
|------|------------------|
| **Customer** | Browse products → add to cart → checkout → track order → manage profile |
| **Admin** | Add/edit/delete products, view customers, add suppliers, view reports, settings |
| **Supplier** | Accept orders, update delivery status, view route/stops, see earnings |

> **Important:** This version is **UI only**. There is **no database and no API** — all data is
> demo data held in memory (it resets when the app restarts). This was the project requirement.

---

## 2. Technology Stack

| Item | Version / Name |
|------|----------------|
| Framework | Flutter 3.41.9 (stable) |
| Language | Dart (SDK `^3.11.5`) |
| IDE | **Visual Studio Code** (+ Dart/Flutter extension) |
| State Management | **Provider** `^6.1.2` |
| Other packages | `cupertino_icons` only — **no backend packages** |
| Lints | `flutter_lints ^6.0.0` |
| Test | `flutter_test` (1 widget test) |
| Platforms in project | Android, Windows, Web, Test |

**Total code:** 54 Dart files · ~9,900 lines

| Folder | Files | Lines |
|--------|------:|------:|
| `lib/screens` | 32 | 8,606 |
| `lib/widgets` | 6 | 385 |
| `lib/services` | 3 | 272 |
| `lib/providers` | 4 | 227 |
| `lib/models` | 5 | 202 |
| `lib/utils` | 3 | 187 |
| `lib/main.dart` | 1 | 32 |

Screen groups: **auth 5** (660) · **customer 11** (2,481) · **admin 9** (3,056) · **supplier 7** (2,409)

---

## 3. Folder Structure (what is where)

```
lib/
├── main.dart                  → App entry: MultiProvider + MaterialApp + routes
│
├── models/                    → Data classes (what a Product / User / Order looks like)
│   ├── product.dart           → Product (id, name, price, stock, category, rating) + fromJson/toJson
│   ├── user.dart              → User (name, email, phone, role customer|admin|supplier)
│   ├── cart.dart              → CartItem (product + quantity + total)
│   ├── order.dart             → Order + CartOrderItem (status: Placed → Delivered)
│   └── supplier.dart          → Supplier (name, route, phone, vehicle, earnings, available)
│
├── services/                  → Where data comes from (DEMO only — no real API/DB)
│   ├── api_service.dart       → 5 demo products, 4 customers, 3 suppliers + add/update/delete
│   ├── auth_service.dart      → login/register/logout against demo credentials (in memory)
│   └── storage_service.dart   → Simple key/value memory store (no shared_preferences)
│
├── providers/                 → State (ChangeNotifier) — the app's "brain"
│   ├── auth_provider.dart     → isLoading, error, user, login(), register(), logout()
│   ├── product_provider.dart  → products, search/category filter, load/add/update/delete
│   ├── cart_provider.dart     → items, add/increase/decrease/remove, total, itemCount, clear
│   └── order_provider.dart    → placed orders list + placeOrder()
│
├── widgets/                   → Reusable UI pieces
│   ├── custom_button.dart     → CustomButton (label, onPressed, isLoading, isOutlined, icon, color)
│   ├── custom_textfield.dart  → CustomTextField (label, hint, icon, obscure, validator…)
│   ├── bottom_navbar.dart     → BottomNavBar + BottomNavItem (+ selectedColor)
│   ├── status_chip.dart       → StatusChip (Active/Pending/Delivered colour pill)
│   ├── product_card.dart      → Product card → opens ProductDetailsScreen
│   └── category_card.dart     → Category tile on Home
│
├── utils/                     → App-wide settings
│   ├── app_colors.dart        → ALL colours (teal customer, purple admin, green supplier)
│   ├── app_routes.dart        → Named route for every screen (26 routes)
│   └── constants.dart         → App name, ₹ currency, delivery charge, demo logins
│
└── screens/                   → The 32 UI screens
    ├── auth/      (5)  splash, login, register, forgot_password, otp
    ├── customer/ (11)  home, product, product_details, cart, checkout, order_success,
    │                    my_orders, track_order, profile, address, notifications
    ├── admin/      (9)  admin_login, admin_dashboard, customers, products, add_product,
    │                    suppliers, add_supplier, reports, settings
    └── supplier/   (7)  supplier_login, supplier_register, supplier_dashboard,
                         supplier_orders, order_details, delivery, earnings
```

---

## 4. How the App Works (Architecture)

**MVC / layered pattern with Provider:**

```
   SCREEN (UI)  ──watch──▶  PROVIDER (state)  ──calls──▶  SERVICE (demo data)  ──returns──▶  MODEL (data)
        │                                                                    │
        └──────────uses──────── WIDGET (buttons, cards) ─────────────────────┘
```

1. **Screen** builds the UI and reads values with `context.watch<AuthProvider>()`.
2. **Provider** holds the data and calls `notifyListeners()` → UI rebuilds automatically.
3. **Service** returns demo data after a short simulated delay (`AppConstants.demoDelay`).
4. **Model** is the shape of the data.

**Registration in `lib/main.dart`:**

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => OrderProvider()),
  ],
  child: MaterialApp(
    onGenerateRoute: AppRoutes.onGenerateRoute,  // named routes
    home: const SplashScreen(),                  // starting screen
  ),
)
```

**Example (real code) — adding to cart:**

```dart
// product_details_screen.dart
Provider.of<CartProvider>(context, listen: false).addToCart(product, quantity: quantity);
// → CartProvider changes → every screen showing the cart rebuilds by itself
```

---

## 5. Screen-by-Screen: Buttons and Where They Go

### 5.1 Auth (`lib/screens/auth/`)

| Screen | Buttons / Elements | Action |
|--------|--------------------|--------|
| **splash_screen** | — (3 second timer) | Already logged in → `HomeScreen`, else → `LoginScreen` |
| **login_screen** | `LOGIN` | Calls `AuthProvider.login()` → loading spinner → `HomeScreen`; on failure shows red SnackBar |
| | `Forgot Password?` | → `ForgotPasswordScreen` |
| | `Create Account` | → `RegisterScreen` |
| | `ADMIN` (Staff Login) | named route → `AdminLoginScreen` |
| | `SUPPLIER` (Staff Login) | named route → `SupplierLogin` |
| **register_screen** | `CREATE ACCOUNT` | validates + password match → `HomeScreen` (clears back stack) |
| | `Login` link | → `LoginScreen` |
| **forgot_password_screen** | `Send OTP` | → `OtpScreen` |
| **otp_screen** | `VERIFY` | shows SnackBar → pops back to login |

### 5.2 Customer (`lib/screens/customer/`)

| Screen | Buttons / Elements | Action |
|--------|--------------------|--------|
| **home_screen** | Bottom nav: Home / Products / Cart / Orders / Profile | switches the 5 tabs |
| | 🔔 cart icon (top) | → `CartScreen` |
| | Search box | filters the product list live |
| | Category cards (4) | → `ProductScreen` (that category) |
| | `See All` / banner / section header | → `ProductScreen` |
| | Product card tap | → `ProductDetailsScreen` |
| **product_screen** | Search + category chips | filter products; card tap → `ProductDetailsScreen` |
| **product_details_screen** | `+` / `−` | changes quantity |
| | `ADD TO CART` | adds to `CartProvider` + green SnackBar |
| | `BUY NOW` | adds to cart → straight to `CheckoutScreen` |
| **cart_screen** | `+` / `−` per item | increase / decrease quantity |
| | 🗑 delete icon | removes item from cart |
| | `Proceed to Checkout` | → `CheckoutScreen` |
| | Empty cart view | button → `ProductScreen` |
| **checkout_screen** | Address field + payment options | cash / UPI selection |
| | `PLACE ORDER` | validates address → saves order in `OrderProvider` → clears cart → `OrderSuccessScreen` (with real order no.) |
| **order_success_screen** | `TRACK ORDER` | → `TrackOrderScreen` |
| | `CONTINUE SHOPPING` | → `HomeScreen` |
| **my_orders_screen** | Order card tap | → `TrackOrderScreen` (that order) |
| | Empty state | "No orders yet" |
| **track_order_screen** | — | status timeline: Placed → Accepted → Out for Delivery → Delivered |
| **profile_screen** | Header | shows logged-in user name/email from `AuthProvider` |
| | `Delivery Address` | → `AddressScreen` |
| | `Notifications` | → `NotificationsScreen` |
| | `Help & Support` | SnackBar with support number |
| | `Log Out` | confirmation dialog → clears session → `LoginScreen` |
| **address_screen** | Save address | SnackBar + back |
| **notifications_screen** | — | demo notification list |

### 5.3 Admin (`lib/screens/admin/`) — purple theme

| Screen | Buttons / Elements | Action |
|--------|--------------------|--------|
| **admin_login_screen** | `LOGIN` (prefilled `admin@aqualoops.in` / `admin123`) | validates → `AdminDashboard`; wrong details → red error banner |
| | `← Back to Customer Login` | pops back |
| **admin_dashboard** | Bottom nav: Dashboard / Customers / Products / Suppliers / Reports | switches tabs (`IndexedStack`, keeps state) |
| | Logout icon (header) | → `AdminLoginScreen` |
| | Quick action **Add Product** | → `AddProductScreen` |
| | Quick action **Settings** | → `SettingsScreen` |
| | Recent orders | demo list with status chips |
| **customers_screen** | Search box | filters by name / email / phone |
| | Customer row tap | bottom sheet: phone, address, orders, total spent + `Block` |
| **products_screen** | Search + category chips | filter |
| | ✏️ edit icon | → `AddProductScreen` in **edit mode** (fields prefilled) |
| | 🗑 delete icon | confirmation dialog → removes product from the list |
| | FAB `+` | → `AddProductScreen` (new) |
| **add_product_screen** | Image placeholder | SnackBar "Image picker coming soon" |
| | `SAVE PRODUCT` / `UPDATE PRODUCT` | full form validation → pop + success SnackBar |
| **suppliers_screen** | Search box | by name / route / phone |
| | Filter chips `All / Active / Inactive` (with counts) | filters the list |
| | Supplier card tap | bottom sheet: phone, email, vehicle, earnings, **Available** switch, `Call` / `Message` buttons |
| | FAB `➕ Add Supplier` | → `AddSupplierScreen` → the new supplier **appears at the top of the list** |
| **add_supplier_screen** | `ADD SUPPLIER` | validates form → returns `Supplier` to the list + SnackBar |
| **reports_screen** | Period chips (Today / Week / Month / Year) | changes all numbers + bar chart |
| | `EXPORT REPORT` | SnackBar confirmation |
| **settings_screen** | Notifications / Dark Mode / Auto Accept switches | toggle (visual) |
| | Store Information / Delivery Charges / Payment / Change Password tiles | info dialog |
| | `Logout` | confirmation dialog → `AdminLoginScreen` |

### 5.4 Supplier (`lib/screens/supplier/`) — green theme

| Screen | Buttons / Elements | Action |
|--------|--------------------|--------|
| **supplier_login** | `LOGIN` (prefilled `supplier@aqualoops.in` / `supplier123`) | → `SupplierDashboard` |
| | `New supplier? Create Account` | → `SupplierRegister` |
| | `← Back to Customer Login` | pops back |
| **supplier_register** | `CREATE ACCOUNT` | validates + password match → `SupplierDashboard` (clears back stack) + SnackBar |
| | `Login` link | back to `SupplierLogin` |
| **supplier_dashboard** | Bottom nav: Dashboard / Orders / Delivery / Earnings | switches tabs |
| | Logout icon (header) | → `SupplierLogin` |
| | `Navigate` on current stop | SnackBar |
| **supplier_orders** | Filter chips All / Pending / Delivered | filters 7 demo orders |
| | Order card tap | → `OrderDetails` (with order id, customer, amount, status) |
| **order_details** | `ACCEPT ORDER` (if Pending) | SnackBar + back |
| | `MARK AS DELIVERED` | SnackBar + back |
| | 📞 call icon | SnackBar |
| | Status timeline | Placed → Accepted → Out for Delivery → Delivered |
| **delivery_screen** | `START DELIVERY` ⇄ `COMPLETE STOP` | toggles the active state |
| | Stops list | done ✔ green / current highlighted |
| | Call / message / navigate icons | SnackBars |
| **earnings_screen** | `WITHDRAW EARNINGS` | confirmation dialog → SnackBar |
| | Weekly bar chart | built with `Row`/`Column`/`Container` (no chart package) |

---

## 6. Complete Navigation Flow

```
                                  ┌──────────────────────────────────────────┐
                                  │            SplashScreen (3s)             │
                                  └───────────────┬──────────────────────────┘
                                    logged in?    │
                              yes ─────────┐      └──────── no ─────────┐
                                           ▼                            ▼
                                   ┌──────────────┐            ┌───────────────┐
                                   │  HomeScreen  │◀── LOGIN ──│  LoginScreen  │
                                   └──────┬───────┘            └──────┬────────┘
                                          │                           │
      ┌──────────┬──────────┬─────────────┼───────────┐     ┌─────────┼──────────────┐
      ▼          ▼          ▼             ▼           ▼     ▼         ▼              ▼
   Products     Cart      Orders       Profile   (Search) Forgot   Register    Staff Login
      │          │          │             │                 │         │         ┌─────┴─────┐
      ▼          ▼          ▼             ├─Address         ▼         ▼         ▼           ▼
  ProductDetails │          │             └─Notifications   OTP    HomeScreen  ADMIN     SUPPLIER
   ├ ADD TO CART │          │                                       (clears)     │           │
   └ BUY NOW ────┤          │                                                   ▼           ▼
                 ▼          ▼                                             AdminLogin   SupplierLogin
             Checkout    TrackOrder                                       │    │         │    │
                 │                                                        ▼    ▼         ▼    ▼
                 ▼                                                     Dashboard  back  Dashboard  Create
          OrderSuccess ─ Track Order ─ Home                                │              │     Account
                                                                                 ┌──────┴───────┬─────────┐
                                                                                 ▼             ▼         ▼
                                                                              Customers    Products  Suppliers
                                                                                             │         │
                                                                                             ▼         ▼
                                                                                       Add Product  Add Supplier
                                                                            └ also: Reports · Settings → logout

Supplier Dashboard ─┬─ Orders ── Order Details (Accept / Mark Delivered)
                    ├─ Delivery (Start / Complete stop)
                    └─ Earnings (Withdraw)          logout → SupplierLogin
```

---

## 7. Named Routes (`lib/utils/app_routes.dart`)

Every screen can also be opened by name: `Navigator.pushNamed(context, AppRoutes.adminLogin)`

| Group | Route names |
|-------|-------------|
| Auth | `/splash` `/login` `/register` `/forgot-password` `/otp` |
| Customer | `/home` `/cart` `/checkout` `/orders` `/profile` `/track-order` `/address` `/notifications` |
| Admin | `/admin/login` `/admin/dashboard` `/admin/customers` `/admin/products` `/admin/products/add` `/admin/suppliers` `/admin/suppliers/add` `/admin/reports` `/admin/settings` |
| Supplier | `/supplier/login` `/supplier/register` `/supplier/dashboard` `/supplier/orders` `/supplier/orders/details` `/supplier/delivery` `/supplier/earnings` |

---

## 8. Demo Credentials & Demo Data

| Role | Email | Password |
|------|-------|----------|
| Customer | any email (e.g. `user@example.com`) | any password ≥ 6 chars |
| **Admin** | `admin@aqualoops.in` | `admin123` |
| **Supplier** | `supplier@aqualoops.in` | `supplier123` |

*Defined in `lib/utils/constants.dart`.*

Demo data (resets on restart):
- **Products:** 5 (20L ₹30, 1L ₹20, 500ml ₹10, Premium 20L ₹40, 5L ₹25)
- **Customers:** 6 demo entries in Admin → Customers
- **Suppliers:** 5 in Admin → Suppliers, 3 in `ApiService`
- **Orders:** created live by the customer flow (cart → checkout)

---

## 9. How to Run (VS Code)

1. Install **Flutter** and **VS Code** with the *Dart* and *Flutter* extensions.
2. `File → Open Folder…` → `C:\new flutter\aqualoops_app`
3. Open terminal in VS Code (`Ctrl` + `` ` ``) and run:
   ```bash
   flutter pub get
   ```
4. Choose a device: bottom-right status bar → *Windows* / *Chrome* / Android emulator.
5. Press **F5** (or Run → Start Debugging), or type:
   ```bash
   flutter run
   ```

**Quick test path:**
`Splash → Login → Home → tap product → ADD TO CART → Cart → Checkout → PLACE ORDER → Track Order`

**Check the code quality any time:**
```bash
flutter analyze     # → No issues found!
flutter test        # → All tests passed!
```

---

## 10. Viva / Report — Frequently Asked Questions

**Q. Why is there no database or API?**
A. The requirement for this project was **UI design only**. All data is demo data inside
`services/`. The service layer exists precisely so a real backend can be added later without
changing any screen.

**Q. How would you connect a real backend?**
A. Add `http` to `pubspec.yaml`, then replace the body of a service method, e.g. in
`api_service.dart`:
```dart
Future<List<Product>> getProducts() async {
  final response = await http.get(Uri.parse('$baseUrl/products'));
  return (jsonDecode(response.body) as List).map((j) => Product.fromJson(j)).toList();
}
```
`Product.fromJson` already exists, so **no screen changes are needed**.

**Q. Why Provider for state management?**
A. It is simple, official Dart/Flutter friendly, and avoids passing data down through many
constructors. Here 4 `ChangeNotifier`s (auth, product, cart, order) drive the whole app.

**Q. What is the difference between the three roles' screens?**
A. Same app, different entry: `LoginScreen` → Customer, `AdminLoginScreen` → Admin,
`SupplierLogin` → Supplier. Each has its own dashboard and bottom navigation.

**Q. Where are the colours defined?**
A. `lib/utils/app_colors.dart` — teal for customer, **purple `#7C3AED` for admin**,
**green `#16A34A` for supplier**. Changing a constant re-themes that whole section.

**Q. Which design patterns are used?**
A. Component/reusable widgets (`widgets/`), repository/service abstraction (`services/`),
observer pattern for state (`ChangeNotifier` + `Provider`), and named routing.

---

## 11. Complete File Index

| # | File | Purpose |
|---|------|---------|
| 1 | `lib/main.dart` | App entry, providers, theme, routes |
| 2 | `lib/models/product.dart` | Product data class |
| 3 | `lib/models/user.dart` | User data class (roles) |
| 4 | `lib/models/cart.dart` | CartItem data class |
| 5 | `lib/models/order.dart` | Order + CartOrderItem |
| 6 | `lib/models/supplier.dart` | Supplier data class |
| 7 | `lib/services/api_service.dart` | Demo products/customers/suppliers source |
| 8 | `lib/services/auth_service.dart` | Demo login/register/logout |
| 9 | `lib/services/storage_service.dart` | In-memory key/value store |
| 10 | `lib/providers/auth_provider.dart` | Login state, loading, errors |
| 11 | `lib/providers/product_provider.dart` | Product list + filters + CRUD |
| 12 | `lib/providers/cart_provider.dart` | Cart items, totals |
| 13 | `lib/providers/order_provider.dart` | Placed orders |
| 14 | `lib/utils/app_colors.dart` | Colour palette |
| 15 | `lib/utils/app_routes.dart` | 26 named routes |
| 16 | `lib/utils/constants.dart` | App constants & demo logins |
| 17 | `lib/widgets/custom_button.dart` | Reusable button |
| 18 | `lib/widgets/custom_textfield.dart` | Reusable text field |
| 19 | `lib/widgets/bottom_navbar.dart` | Reusable bottom navigation |
| 20 | `lib/widgets/status_chip.dart` | Status pill |
| 21 | `lib/widgets/product_card.dart` | Product card |
| 22 | `lib/widgets/category_card.dart` | Category card |
| 23–27 | `lib/screens/auth/*` (5) | Splash, Login, Register, Forgot password, OTP |
| 28–38 | `lib/screens/customer/*` (11) | Home, Products, Details, Cart, Checkout, Success, Orders, Track, Profile, Address, Notifications |
| 39–47 | `lib/screens/admin/*` (9) | Login, Dashboard, Customers, Products, Add Product, Suppliers, Add Supplier, Reports, Settings |
| 48–54 | `lib/screens/supplier/*` (7) | Login, Register, Dashboard, Orders, Order Details, Delivery, Earnings |

---

*Documentation generated for the AquaLoop Flutter project.*
