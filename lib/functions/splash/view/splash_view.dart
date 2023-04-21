import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/core/controllers/auth_controller.dart';

import '../../home/view/home_view.dart';
import '../../login/view/login_view.dart';

class SplashView extends StatelessWidget {

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return OnBoard();
  }

  Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
    return Scaffold(
        body: Center(child: Text('Error: ${snapshot.error}')));
  }

  Scaffold waitingView() {
    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
              Text('Loading...'),
            ],
          ),
        ));
  }
}

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Get.find();

    return Obx(() {
      return _authController.user.value == null ? LoginView() : HomeView();
    });
  }
}