import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'theme/colors.dart';

class AuricApp extends StatelessWidget {
  const AuricApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auric',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AuricColors.background,
        fontFamily: 'SF Pro',
        colorScheme: ColorScheme.dark(
          primary: AuricColors.primary,
          secondary: AuricColors.secondary,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
