import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketvault/core/theme/app_theme.dart';
import 'package:pocketvault/widgets/CenterCircularProgressIndicator.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme_provider.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/screens/auth_login_screen.dart';
import 'features/bookmarks/providers/bookmark_provider.dart';
import 'features/home/screens/home_screen.dart';
import 'features/media/providers/media_provider.dart';
import 'features/shopping/providers/shopping_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ShoppingProvider()),
        ChangeNotifierProvider(create: (_) => MediaProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'PocketVault',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: Consumer<AuthProvider>(
            builder: (ctx, auth, _) => auth.isLoading
                ? const Scaffold(body: CenterCircularProgressIndicator())
                : auth.isAuthenticated
                ? const HomeScreen()
                : const LoginScreen(),
          ),
        );
      },
    );
  }
}
