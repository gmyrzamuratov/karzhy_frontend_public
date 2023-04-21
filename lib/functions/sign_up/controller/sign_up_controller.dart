import 'package:get/get.dart';
import 'package:karzhy_frontend/core/repository/auth_repo.dart';
import 'package:karzhy_frontend/core/repository/auth_repo_impl.dart';

class SignUpController extends GetxController {

  late AuthRepo _authRepo;

  SignUpController() {
    _authRepo = Get.put(AuthRepoImpl());
  }

  RxBool isLoading = false.obs;
  RxBool isRegistered = false.obs;

  void register(String username, String password) async {
    final result = await _authRepo.register(username, password);
    isRegistered.value = result;
  }

  showLoading() {
    isLoading.toggle();
  }

  hideLoading() {
    isLoading.toggle();
  }

}