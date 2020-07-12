import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogListLanguage extends StatelessWidget {
  final List<Locale> listLanguages;
  DialogListLanguage({
    Key key,
    @required this.listLanguages,
  })  : assert(listLanguages != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: listLanguages.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String language = listLanguages[index].countryCode;
          return InkWell(
            onTap: () => _setLanguage(listLanguages[index]),
            child: ListTile(
              title: Text(
                language,
                style: Get.textTheme.bodyText1,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          );
        },
      ),
    );
  }

  _setLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
    Constant.updateCategoryTranslation();
  }
}
