import 'package:clinikk/features/home/controllers/home_controller.dart';
import 'package:clinikk/features/home/view/base_layout.dart';
import 'package:clinikk/shared/global_controllers/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeHandler()),
        ChangeNotifierProvider(create: (context) => HomeController()),
      ],
      child: MaterialApp(
        home: BaseLayout(),
      ),
    );
  }
}
