import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/functions.dart';
import 'package:get/get.dart';

class SearchEventController extends GetxController {

  static SearchEventController get to => Get.find();

  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  List<Event> _popularEvent;
  List<Event> get popularEvent => this._popularEvent;

  List<Event> _searchEvent;
  List<Event> get searchEvent => this._searchEvent;

  RESULT_FILTER _filter;
  String get filter {
    if (_filter == RESULT_FILTER.DATE)
      return Localization.dateTitle.tr;
    return Localization.distanceTitle.tr;
  }

  List<String> get listFilter => [Localization.dateTitle.tr, Localization.distanceTitle.tr];

  bool _showMapResult;
  bool get showMapResult => this._showMapResult;

  @override
  void onInit() async {
    super.onInit();
    _filter = RESULT_FILTER.DATE;
    _showMapResult = false;
    _popularEvent = await _bddRepo.getPopularEvents();
    update();
  }

  changeModeResult() {
    _showMapResult = !_showMapResult;
    update();
  }

  changeFilter(String filter) {
    if (filter == Localization.dateTitle.tr) {
      _filter = RESULT_FILTER.DATE;
      _filterByDate();
    }
    else {
      _filter = RESULT_FILTER.DISTANCE;
      _filterByDistance();
    }
    update();
  }

  // DATE END CROISSANT
  _filterByDate() =>  _searchEvent.sort((a, b) => differenceBWDateString(a.dateEnd, b.dateEnd, "dd/MM/yyyy HH:mm"));

  // DISTANCE CROISSANT
  _filterByDistance() => _searchEvent.sort((a, b) => a.distanceBW - b.distanceBW);
  

  searchByCategory(String category) async {
    Get.toNamed(Router.searchResultRoute);
    _searchEvent = await _bddRepo.getEventsWithCategory(category);
    changeFilter(filter); //TRIE LIST FONCTION DU FILTRE ACTUEL + REBUILD (UPDATE)
  }

  searchQueryEvent(Map<String, dynamic> search) async {
    // {date: 27/06/2020 21:16, category: [Concert, Festival], distance: 43}
    print(search);
    Get.back();
    _searchEvent = [];
    print(_searchEvent);
    Get.toNamed(Router.searchResultRoute);
    _searchEvent = await _bddRepo.searchQueryEvent(search);
    changeFilter(filter); //TRIE LIST FONCTION DU FILTRE ACTUEL + REBUILD (UPDATE)
    print(_searchEvent);
  }

}

enum RESULT_FILTER {
  DATE,
  DISTANCE,
}