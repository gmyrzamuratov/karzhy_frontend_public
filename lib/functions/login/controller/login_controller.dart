import 'package:get/get.dart';
import 'package:karzhy_frontend/core/repository/auth_repo.dart';
import 'package:karzhy_frontend/core/repository/auth_repo_impl.dart';

class LoginController extends GetxController {

  late AuthRepo _authRepo;

  LoginController() {
    _authRepo = Get.put(AuthRepoImpl());
  }

  RxBool isLoading = false.obs;
  RxBool isLogged = false.obs;

  void login(String username, String password) async {
    final result = await _authRepo.login(username, password);
    isLogged = result.obs;
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }

}