import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments_app_assignment/features/auth/presentation/providers/auth_provider.dart';
import 'package:comments_app_assignment/features/home/data/repo/comment_repo_impl.dart';
import 'package:comments_app_assignment/features/home/domain/repository/comment_repo_interface.dart';
import 'package:comments_app_assignment/features/home/presentation/providers/comment_provider.dart';
import 'package:comments_app_assignment/firebase_options.dart';
import 'package:comments_app_assignment/utils/firebase_app_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'app_provider.dart';
import 'core/routes/app_pages_router.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/theme_app.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/repository/auth_repo_interface.dart';
import 'utils/shared_prefs.dart';

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> main() async {
  final NavigationService navigationService = NavigationService();
  runZonedGuarded<Future<void>>(
    () async {
      await initFirebase();
      final remoteConfigService =
          FirebaseRemoteConfigService(FirebaseRemoteConfig.instance);
      await remoteConfigService.initialize();
      AuthRepositoryInterface authRepository = AuthRepositoryImpl(
        firestore: FirebaseFirestore.instance,
        firebaseAuth: FirebaseAuth.instance,
        storage: FirebaseStorage.instance,
      );
      CommentRepositoryInterface commentRepository = CommentRepositoryImpl();
      final sharedPreferencesService = SharedPreferencesService();
      runApp(
        MultiProvider(
          providers: [
            Provider<NavigationService>.value(value: navigationService),
            ChangeNotifierProvider(
              create: (_) => UserAuthProvider(
                authRepository,
                navigationService,
                sharedPreferencesService,
              )..checkAuthStatus(),
            ),
            ChangeNotifierProvider(
              create: (_) =>
                  CommentProvider(commentRepository, remoteConfigService),
            ),
          ],
          child: MyApp(
            navigationService: navigationService,
            remoteConfigService: remoteConfigService,
          ),
        ),
      );
    },
    (error, stack) {
      /* FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    ); */
    },
  );
}

class MyApp extends StatefulWidget {
  final NavigationService navigationService;
  final FirebaseRemoteConfigService remoteConfigService;

  const MyApp(
      {super.key,
      required this.navigationService,
      required this.remoteConfigService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        widget.navigationService.replaceAllWith(Routes.loginview);
        Fluttertoast.showToast(msg: "");
      } else {
        widget.navigationService.replaceAllWith(Routes.homeview);
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 779),
      minTextAdapt: true,
      builder: (_, __) {
        return Consumer<UserAuthProvider>(
          builder: (context, authProvider, _) {
            return MaterialApp(
              title: 'Comments App',
              debugShowCheckedModeBanner: false,
              navigatorKey: widget.navigationService.navigatorKey,
              theme: buildMyTheme(context),
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: authProvider.isAuthenticated
                  ? Routes.homeview
                  : Routes.loginview,
            );
          },
        );
      },
    );
  }
}
