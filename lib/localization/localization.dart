import 'package:esgi_project/localization/languages/english_language.dart';
import 'package:esgi_project/localization/languages/french_language.dart';

class Localization {

  static final translation = {
    "en_US": EnglishLanguage.translation,
    "fr_FR": FrenchLanguage.translation,
  };

  static const String allEventTitle = "all_events";
  static const String popularEventTitle = "popular_events";
  static const String noEventTitle = "no_events";
  static const String barCategory = "bar_category";
  static const String nightClubCategory = "nightclub_category";
  static const String concertCategory = "concert_category";
  static const String festivalCategory = "festival_category";
  static const String museumCategory = "museum_category";
  static const String noCategory = "no_category";
  static const String locationCheckTitle = "location_check";
  static const String welcomeTitle = "welcome";
  static const String myBookingsTitle = "my_bookings";
  static const String myFavoriteTitle = "my_favorites";
  static const String favoriteTitle = "favorites";
  static const String noFavoriteTitle = "no_favorites";
  static const String myEventsTitle = "my_events";
  static const String logout = "logout";
  static const String filterTitle = "filters";
  static const String nameEvent = "name_event";
  static const String dateEvent = "date_event";
  static const String typeEvent = "type_event";
  static const String distanceEvent = "distance_event";
  static const String eventTitle = "events";
  static const String noTitleEvent = "no_title";
  static const String dateTitle = "date";
  static const String beginDateEvent = "begin_date";
  static const String noBeginDateEvent = "no_begin_date";
  static const String endDateEvent = "end_date";
  static const String noEndDateEvent = "no_end_date";
  static const String descriptionEvent = "content";
  static const String noDescriptionEvent = "no_content";
  static const String addressEvent = "address_event";
  static const String noAddressEvent = "no_address";
  static const String confirmAddressEvent = "confirm_address";
  static const String confirmAddressNameEvent = "confirm_address_name";
  static const String priceTitle = "price";
  static const String freeTitle = "free";
  static const String noPicturesTitle = "no_pictures";
  static const String addEvent = "add_event";
  static const String explainAddEventForm = "explain_add_form";
  static const String yourEmail = "your_email";
  static const String yourNickname = "your_nickname";
  static const String yourPassword = "your_password";
  static const String isOrganizerTitle = "is_organizer";
  static const String signUpTitle = "signup";
  static const String signInTitle = "signin";
  static const String yes = "yes";
  static const String no = "no";
  static const String distanceTitle = "distance";
  static const String deleteEventTitle = "delete";
  static const String confirmDeleteEvent = "confirm_delete";
  static const String languageTitle = "language";


  static const String errorMissingParam = "error_missing_param";
  static const String errorAddress = "error_address";
  static const String errorEmail = "error_email";
  static const String errorPassword = "error_password";
  static const String errorPseudo = "error_pseudo";
}