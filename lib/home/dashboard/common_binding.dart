import 'package:get/get.dart';
import '../../controller/site_location_controller.dart';

class CommonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiteLocationController>(() => SiteLocationController());
  }
}
