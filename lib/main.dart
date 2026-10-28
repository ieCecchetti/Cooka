import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import 'package:cooka/screens/opening_screen.dart';
import 'package:cooka/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: Cooka()));
  });
}

class Cooka extends StatelessWidget {
  const Cooka({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cooka',
      theme: appTheme,
      home: const OpeningScreen(),
    );
  }
}
