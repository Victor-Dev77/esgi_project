import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogListLanguage extends StatefulWidget {
  final List<Locale> listLanguages;
  final Function(String) onCategorySelected;
  DialogListLanguage({
    @required this.listLanguages,
    @required this.onCategorySelected,
  });

  @override
  _DialogListLanguageState createState() => _DialogListLanguageState();
}

class _DialogListLanguageState extends State<DialogListLanguage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: widget.listLanguages.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String language = widget.listLanguages[index].countryCode;
          return InkWell(
            onTap: () => _setLanguage(widget.listLanguages[index]),
            child: ListTile(
              title: Text(
                language,
                style: TextStyle(fontSize: 16),
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
  }
}
