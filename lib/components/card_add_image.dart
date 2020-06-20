import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardAddImage extends StatefulWidget {
  final String image;
  final Function(File) imageLoad;
  final Function(File) imageRemove;
  CardAddImage({@required this.imageLoad, @required this.imageRemove, this.image});

  @override
  _CardAddImageState createState() => _CardAddImageState();
}

class _CardAddImageState extends State<CardAddImage> {
  File _image;
  ImagePicker _picker = ImagePicker();

  Future getImage() async {
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    var image = File(pickedFile.path);

    setState(() {
      _image = image;
    });
    widget.imageLoad(_image);
    print(image.path);
  }

  deleteImage() {
    _image.delete();
    widget.imageRemove(_image);
    setState(() {
      _image = null;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.image != null) {
      _image = File(widget.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_image == null) ? _noImage() : _withImage();
  }

  Widget _noImage() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: Color(0xffEFECE4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _withImage() {
    return GestureDetector(
      onTap: deleteImage,
      child: Container(
        width: 75,
        height: 75,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Color(0xffEFECE4),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(_image),
                  fit: BoxFit.cover
                )
              ),
            ),
            Positioned(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              bottom: -10,
              right: -10,
            ),
          ],
        ),
      ),
    );
  }
}
