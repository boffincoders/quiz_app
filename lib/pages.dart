import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quiz_app/Routes/appRoutes.dart';
import 'package:quiz_app/bindings/authenticationBindings/authenticationBinding.dart';
import 'package:quiz_app/bindings/homeScreenBinding.dart';
import 'package:quiz_app/screens/authentication/registrationAuthentication.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/selectDifficultyLevelScreen.dart';
import 'package:quiz_app/spashScreen.dart';

final List<GetPage> appPages = [
  GetPage(name: AppRoutes.Splash.name, page: () => SplashScreen()),
  GetPage(name: AppRoutes.LevelScreen.name, page: () => DifficultyLevelScreen()),
  GetPage(name: AppRoutes.Registration.name, page: () => Registrtaion(), binding: AuthenticationBinding()),
  GetPage(name: AppRoutes.Home.name, page: () => HomeScreen(),binding: HomeScreenBinding()),
];
