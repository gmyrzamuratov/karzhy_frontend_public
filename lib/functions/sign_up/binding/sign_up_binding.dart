import 'package:get/get.dart';
import '../../../core/repository/auth_repo_impl.dart';
import '../controller/sign_up_controller.dart';

class SignUpBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AuthRepoImpl());
    Get.put(SignUpController());
  }

}