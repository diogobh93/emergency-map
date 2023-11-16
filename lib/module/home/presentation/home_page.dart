import 'package:flutter/material.dart';
import '../../../core/constants/app_text.dart';
import 'controller/controller.dart';
import 'widgets/loading_widget.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.controller.getCurrentGeolocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeState>(
      valueListenable: widget.controller.state,
      builder: (BuildContext context, HomeState state, Widget? child) {
        switch (state.runtimeType) {
          case HomeStateLoading:
            return const LoadingWidget();
          case HomeStateSuccess:
            return GoogleMapsWidget(
              onFetchLocation: () => widget.controller.getCurrentGeolocation(),
              coordinates: widget.controller.coordinates.value,
              markers: widget.controller.marker.value,
            );
          case HomeStateError:
            return AlertErrorWidget(
              message: state.message,
              onFetchLocation: () => widget.controller.getCurrentGeolocation(),
            );
          default:
            return AlertErrorWidget(
              message: AppText.genericError,
              onFetchLocation: () => widget.controller.getCurrentGeolocation(),
            );
        }
      },
    );
  }
}
