import 'package:emergency_map/core/constants/app_color.dart';
import 'package:emergency_map/core/settings/dependency_injector/injector_adapter.dart';
import 'package:flutter/material.dart';
import '../core/settings/dependency_injector/injector.dart';
import '../module/home/presentation/controller/home_controller.dart';
import '../module/home/presentation/home_page.dart';

class AppMainWidget extends StatelessWidget {
  const AppMainWidget({super.key});

  static final Injector _injector = InjectorAdapter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.darkGrey,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(
              controller: _injector.getInstance<HomeController>(),
            ),
      },
    );
  }
}
