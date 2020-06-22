import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChipCategory extends StatelessWidget {
  
  final String category;
  final Function(String) onDeleteCategory;
  ChipCategory({@required this.category, @required this.onDeleteCategory});
  
  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 2.0,
      backgroundColor: Colors.grey,
      label: Text(category),
      deleteIcon: Icon(FontAwesomeIcons.timesCircle, size: 20,),
      onDeleted: () => onDeleteCategory(category),
    );
  }
}