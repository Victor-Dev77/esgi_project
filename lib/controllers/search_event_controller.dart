import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:esgi_project/routes.dart';
import 'package:get/get.dart';

class SearchEventController extends GetController {

  static SearchEventController get to => Get.find();

  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  List<Event> _popularEvent;
  List<Event> get popularEvent => this._popularEvent;

  List<Event> _searchEvent;
  List<Event> get searchEvent => this._searchEvent;

  @override
  void onInit() async {
    super.onInit();
    _popularEvent = await _bddRepo.getPopularEvents();
    update();
  }

  searchByCategory(String category) async {
    Get.toNamed(Router.searchResultRoute);
    _searchEvent = await _bddRepo.getEventsWithCategory(category);
    update();
  }

}