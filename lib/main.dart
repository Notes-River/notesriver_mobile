import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:notesriver_mobile/constrance/ThemeData.dart';
import 'package:notesriver_mobile/screens/favorite_screen.dart';
import 'package:notesriver_mobile/screens/genreadlist_screen.dart';
import 'package:notesriver_mobile/screens/home_screen.dart';
import 'package:notesriver_mobile/screens/login_screen.dart';
import 'package:notesriver_mobile/screens/pdf_view.dart';
import 'package:notesriver_mobile/screens/postgen_screen.dart';
import 'package:notesriver_mobile/screens/profile_screen.dart';
import 'package:notesriver_mobile/screens/readlist_screen.dart';
import 'package:notesriver_mobile/screens/signup_screen.dart';
import 'package:notesriver_mobile/screens/splash_screen.dart';
import 'package:notesriver_mobile/screens/subscription_screen.dart';
import 'package:notesriver_mobile/screens/verification_screen.dart';
import 'package:notesriver_mobile/src/bindings/genReadlist_binding.dart';
import 'package:notesriver_mobile/src/bindings/get_readlist_bindings.dart';
import 'package:notesriver_mobile/src/bindings/home_bindings.dart';
import 'package:notesriver_mobile/src/bindings/initial_bindings.dart';
import 'package:notesriver_mobile/src/bindings/login_bindings.dart';
import 'package:notesriver_mobile/src/bindings/notes_create_bindings.dart';
import 'package:notesriver_mobile/src/bindings/pdf_bindings.dart';
import 'package:notesriver_mobile/src/bindings/profile_bindings.dart';
import 'package:notesriver_mobile/src/bindings/registration_bindings.dart';
import 'package:notesriver_mobile/src/bindings/verification_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      title: CustomThemes.appName,
      theme: CustomThemes.lightTheme,
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          binding: HomeBindings(),
        ),
        GetPage(
          name: '/pdf',
          page: () => PdfView(),
          binding: PdfBinder(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupScreen(),
          binding: RegistrationBindings(),
        ),
        GetPage(
          name: '/verify',
          page: () => VerifcationScreen(),
          binding: VerificationBindings(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileScreens(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: '/subs',
          page: () => SubscriptionScreen(),
        ),
        GetPage(
          name: '/fav',
          page: () => FavoriteScreen(),
        ),
        GetPage(
          name: '/read-list',
          page: () => ReadListScreen(),
          binding: ReadlistUtilsBinding(),
        ),
        GetPage(
          name: '/gen-readlist',
          page: () => GenReadListScreen(),
          binding: CreateReadListBinding(),
        ),
        GetPage(
          name: '/gen-notes',
          page: () => PostGenScreen(),
          binding: NotesCreateBindings(),
        )
      ],
      initialRoute: '/splash',
    );
  }
}
