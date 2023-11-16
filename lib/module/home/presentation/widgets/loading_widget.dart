import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColor.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
