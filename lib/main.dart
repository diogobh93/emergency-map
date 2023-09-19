import 'package:emergency_map/app/app_main_widget.dart';
import 'package:flutter/material.dart';

import 'app/app_dependencies.dart';

void main() {
  AppDependencies().registerAppDependencies();
  runApp(const AppMainWidget());
}
