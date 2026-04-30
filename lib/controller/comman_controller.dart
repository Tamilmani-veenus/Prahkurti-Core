import 'package:get_storage/get_storage.dart';

import '../controller/logincontroller.dart';
import '../controller/menu_controller.dart';
import '../provider/common_provider.dart';
import 'package:get/get.dart';

import '../utilities/baseutitiles.dart';


class CommanController extends GetxController {

  RxInt deleteMode=0.obs;
  RxInt editMode=0.obs;
  RxInt addMode=0.obs;

  LoginController loginController = Get.put(LoginController());
  Menu_Controller menuController = Get.put(Menu_Controller());

  Future getControllEntryListRights() async {
    deleteMode.value=0;
    editMode.value=0;
    await CommonProvider.getSubControllerRightsEntryList(menuController.formMenuId.value).then((value) async {
      if (value != null) {
        if (value.success == true) {
          final result = value.result!;
          deleteMode.value = (result.allowDelete ?? false) ? 1 : 0;
          editMode.value = (result.allowEdit ?? false) ? 1 : 0;
          addMode.value = (result.allowAdd ?? false) ? 1 : 0;
          return value;
        }
        else {
          BaseUtitiles.showToast(value.message ?? 'Something went wrong..');
        }
      }
      else {
        BaseUtitiles.showToast('Something went wrong..');
      }
    });
  }
}


