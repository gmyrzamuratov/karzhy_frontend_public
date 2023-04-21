import 'package:get/get.dart';
import '../../../core/repository/auth_repo_impl.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AuthRepoImpl());
    Get.put(LoginController());
  }

}