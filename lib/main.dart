import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/custom_map/custom_map.dart';
import 'package:perfume_store/providers/admin_provider.dart';
import 'package:perfume_store/providers/auth_provider.dart';
import 'package:perfume_store/view/auth/signup_screen.dart';
import 'package:provider/provider.dart';

import 'app_router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) {
              return AuthProvider();
            },
          ),
          ChangeNotifierProvider<AdminProvider>(
            create: (context) {
              return AdminProvider();
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.appRouter.navigatorKey,
          home: Scaffold(
            body: SignUpScreen(),
          ),
        ));
  }
}
