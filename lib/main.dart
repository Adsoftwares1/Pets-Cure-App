import 'package:flutter/material.dart';
import 'package:mvvm_practice_app/utils/routes/routes.dart';
import 'package:mvvm_practice_app/utils/routes/routes_names.dart';
import 'package:mvvm_practice_app/view/auth_ui/LoginScreen.dart';
import 'package:mvvm_practice_app/view/users_ui/all_doctors.dart';
import 'package:mvvm_practice_app/view/users_ui/all_hospitals.dart';
import 'package:mvvm_practice_app/view_model/auth_view_model.dart';
import 'package:mvvm_practice_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pets App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),

        // it will be used later
        // initialRoute: RoutesName.splash,
        // onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
