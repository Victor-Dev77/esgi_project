import 'package:esgi_project/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogListCategory extends StatefulWidget {
  final List<String> listCategorySelected;
  final Function(String) onCategorySelected, onCategoryUnselected;
  DialogListCategory({
    Key key,
    this.listCategorySelected,
    @required this.onCategorySelected,
    @required this.onCategoryUnselected,
  })  : assert(onCategorySelected != null),
        assert(onCategoryUnselected != null),
        super(key: key);

  @override
  _DialogListCategoryState createState() => _DialogListCategoryState();
}

class _DialogListCategoryState extends State<DialogListCategory> {
  Map<String, bool> _mapCategory = {};

  @override
  void initState() {
    super.initState();
    Constant.category.forEach((category) {
      if (widget.listCategorySelected == null)
        _mapCategory[category["title"]] = false;
      else
        _mapCategory[category["title"]] =
            widget.listCategorySelected.contains(category["title"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: Constant.category.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String category = Constant.category[index]["title"];
          return CheckboxListTile(
            value: _mapCategory[category] == true,
            title: Text(
              category,
              style: Get.textTheme.bodyText1,
            ),
            onChanged: (value) {
              setState(() {
                _mapCategory[category] = value;
              });
              if (value)
                widget.onCategorySelected(category);
              else
                widget.onCategoryUnselected(category);
            },
          );
        },
      ),
    );
  }
}
