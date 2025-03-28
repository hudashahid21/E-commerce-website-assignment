import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'product_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'signup.dart';
import 'login.dart';
import 'cart_provider.dart';
import 'checkout_page.dart';
import 'order_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
         routes: {
      '/': (context) => HomePage(),
      '/product': (context) => ProductPage(),
      '/cart': (context) => CartPage(),
      '/profile': (context) => ProfilePage(),
      '/about': (context) => AboutUsPage(),
      '/contact': (context) => ContactUsPage(),
      '/signup': (context) => SignUpPage(),
      '/login': (context) => LoginPage(redirectTo: 'product_detail'),
      '/checkout': (context) => CheckoutPage(),
      '/orders': (context) => OrderListPage(), // ✅ Corrected
    },
    );
  }
}
