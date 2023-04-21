import 'package:get/get.dart';
import 'package:karzhy_frontend/core/controllers/auth_controller.dart';
import 'package:karzhy_frontend/core/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {

  late AuthController _authController;

  AuthRepoImpl() {
    _authController = Get.find<AuthController>();
  }

  @override
  Future<bool> login(String email, String password) async {
    return await _authController.login(email, password);
  }

  @override
  Future<bool> register(String email, String password) async {
    return await _authController.register(email, password);
  }

}