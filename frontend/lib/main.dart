import 'package:flutter/material.dart';
import 'package:frontend/pages/list_bnbs.dart';
import 'package:frontend/pages/add_bnb.dart';
import 'package:frontend/pages/edit_bnb.dart';
import 'package:frontend/pages/bnb.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BnbsPage(title: 'WillingHost'),
      routes: {'/add-bnb': (context) => const AddBnbPage()},
      onGenerateRoute: (settings) {
        if (settings.name == '/edit-bnb') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => EditBnbPage(bnbId: args['id']),
          );
        } else if (settings.name == '/bnb-detail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => BnbDetailPage(bnbId: args['id']),
          );
        }
        return null;
      },
    );
  }
}
