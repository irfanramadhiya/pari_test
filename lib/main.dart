import 'package:flutter/material.dart';
import 'package:pari_test/viewmodels/add_viewmodel.dart';
import 'package:pari_test/viewmodels/detail_viewmodel.dart';
import 'package:pari_test/viewmodels/edit_viewmodel.dart';
import 'package:pari_test/viewmodels/home_viewmodel.dart';
import 'package:pari_test/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => DetailViewModel()),
        ChangeNotifierProvider(create: (_) => AddViewModel()),
        ChangeNotifierProvider(create: (_) => EditViewModel())
      ],
      child: const MaterialApp(
        title: "PARI Test",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: HomeView(),
          ),
        ),
      ),
    );
  }
}
