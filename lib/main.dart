import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/core/configs/theme/app_theme.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';
import 'package:spotify/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify/presentation/choose%20mode/bloc/theme_cubit.dart';
import 'package:spotify/presentation/choose%20mode/pages/choose_mode.dart';
import 'package:spotify/presentation/intro/pages/get_started.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:spotify/presentation/splash/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify/service.locator.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initalizedDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            routes: {
              '/get_started': (context) => const GetStartedPage(),
              '/choose_mode': (context) => const ChooseModePage(),
              '/signin_or_signup': (context) => const SignupOrSigninPage(),
              '/signup': (context) => SignupPage(),
              '/signin': (context) => SignInPage(),
              '/root': (context) => const HomePage(),
            },
            home: const SplashPage()),
      ),
    );
  }
}
