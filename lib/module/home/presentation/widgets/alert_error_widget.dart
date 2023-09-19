import 'package:emergency_map/core/constants/app_images.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_text.dart';

class AlertErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onFetchLocation;

  const AlertErrorWidget({
    super.key,
    required this.message,
    required this.onFetchLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteOverlay,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Image(
                height: 50,
                image: AssetImage(
                  AppImages.warning,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                AppText.operationFailed,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: onFetchLocation,
                child: const Text(
                  AppText.tryAgain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
