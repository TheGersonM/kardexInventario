import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/start_page.dart';
import 'pages/inputs_page.dart';
import 'pages/outputs_page.dart';
import 'pages/sales_page.dart';
import 'pages/shopping_page.dart';
import 'pages/articles_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      // home: HomePage(),
      initialRoute: 'start', //esta es la ruta principal
      routes: {
        'home': (context) =>  Home_Page(),
        'start': (context) =>   StartPage(),
        'inputs': (context) =>  const InputsPage(),
        'outputs': (context) =>  const OutputsPage(),
        'sales': (context) =>  const SalesPage(),
        'shopping': (context) =>  const ShoppingPage(),
        'articles': (context) =>   ArticlesPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        
        return MaterialPageRoute(
          builder: (context) => PageNotFound(ruta: settings.name),
        );
      },
    );
  }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({
    super.key,
    this.ruta = 'No-found',
  });

  final String? ruta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('La ruta "$ruta" no existe')));
  }
}