import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practical_task/routes/routes.dart';
import 'package:practical_task/styles/app_theme.dart';
import 'package:practical_task/utils/app_utils.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyA1t2W2ZbUfGIYZPpOREyK_5wFEWEaGpVw',
      appId: '1:414420569074:android:f3f2b8ffafd782d8f3796b',
      messagingSenderId: '',
      projectId: 'practicaltask-41dca',
    ),
  );
  await AppUtils.initDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        Locale("hi"),
        Locale("en"),
      ],
      initialRoute: AppUtils.initialRout,
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      getPages: Routes.pages,
    );
  }
}
