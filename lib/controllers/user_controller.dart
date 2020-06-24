import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/repositorys/firebase_firestore_repository.dart';
import 'package:get/get.dart';
import 'package:esgi_project/models/user.dart';

class UserController extends GetController {

  static UserController get to => Get.find();

  FirebaseFirestoreRepository _bddRepo = FirebaseFirestoreRepository.to;

  User _user;
  User get user => this._user;

  List<Event> _favorites;
  List<Event> get favorites => this._favorites;

  initUser(User user) async {
    _user = user;
    _favorites = await _bddRepo.getMyFavoritesEvents(user.id);
    update();
  }

  addFavorite(Event event) {
    if (_favorites == null)
      _favorites = [];
    int indexEventInFavorite = _favorites.indexWhere((elem) => elem.id == event.id);
    if (indexEventInFavorite == -1)
      _addFavoriteEvent(event);
    else 
      _deleteFavoriteEvent(indexEventInFavorite, event);
  }

  _addFavoriteEvent(Event event) async {
    _favorites.add(event);
    await _bddRepo.addFavoriteEvent(_user.id, event.toMap());
    update();
  }

  _deleteFavoriteEvent(int index, Event event) async {
    _favorites.removeAt(index);
    await _bddRepo.deleteFavoriteEvent(_user.id, event.id);
    update();
  }

  bool isFavorite(Event event) {
    return _favorites.indexWhere((elem) => elem.id == event.id) != -1;
  }

}