import 'package:esgi_project/controllers/search_event_controller.dart';
import 'package:esgi_project/controllers/squeleton_controller.dart';
import 'package:get/get.dart';

class SqueletonBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SqueletonController());
    Get.put(SearchEventController());
  }
}