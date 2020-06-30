import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esgi_project/components/favorite_btn.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';


class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  Event event;
  bool _error;

  @override
  void initState() {
    super.initState();
    event = Get.arguments as Event;
    _error = (event == null);
  }

  @override
  Widget build(BuildContext context) {
    return _checkError();
  }

  Scaffold _checkError() {
    if (_error) return _buildError();
    return _buildScreen();
  }

  Scaffold _buildError() {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(Localization.errorMissingParam.tr),
        ),
      ),
    );
  }

  Scaffold _buildScreen() {
    //TODO: rendre code propre - separer dans des fonction ou widget
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: ConstantColor.white,
                    ),
                    onPressed: () => Get.back(),
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * 0.65,
                  floating: false,
                  pinned: true,
                  snap: false,
                  elevation: 50,
                  backgroundColor: ConstantColor.primaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      event.title == ""
                          ? Localization.noTitleEvent.tr
                          : event.title,
                      style: TextStyle(
                          fontWeight: event.title == ""
                              ? FontWeight.normal
                              : FontWeight.bold,
                          fontStyle: event.title == ""
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: 16,
                          color: ConstantColor.white),
                    ),
                    background: _buildPictureBloc(),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.date_range, color: Colors.orange),
                                  SizedBox(width: 5),
                                  Text(event.dateStart == ""
                                      ? Localization.noBeginDateEvent.tr
                                      : event.dateStart),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.date_range, color: Colors.orange),
                                  SizedBox(width: 5),
                                  Text(event.dateEnd == ""
                                      ? Localization.noEndDateEvent.tr
                                      : event.dateEnd),
                                ],
                              ),
                            ],
                          ),
                          if (event.distanceBW != null)
                            Row(
                              children: <Widget>[
                                Icon(Icons.place, color: Colors.blueAccent),
                                SizedBox(width: 2),
                                Text("${event.distanceBW}km"),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: Text(
                        event.title == ""
                            ? Localization.noTitleEvent.tr
                            : event.title,
                        style: TextStyle(
                          fontWeight: event.title == ""
                              ? FontWeight.normal
                              : FontWeight.bold,
                          fontStyle: event.title == ""
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      child: Text(
                        event.content == ""
                            ? Localization.noDescriptionEvent.tr
                            : event.content,
                        style: TextStyle(
                          fontStyle: event.content == ""
                              ? FontStyle.italic
                              : FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.place, color: Colors.blueAccent),
                          SizedBox(width: 5),
                          Text(event.address == ""
                              ? Localization.noAddressEvent.tr
                              : event.address),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              padding: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Localization.priceTitle.tr,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.price == 0
                            ? Localization.freeTitle.tr
                            : "${event.price}€",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: event.price == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  //TODO: remplacer par MaterialButton ou Material ou RawButton ou jsais pas...
                  _buildBtnFavorite(),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _buildPictureBloc() {
    if (event.pictures.length == 0) {
      return Center(
        child: Text(Localization.noPicturesTitle.tr),
      );
    }
    return Swiper(
      key: UniqueKey(),
      physics: ScrollPhysics(),
      loop: false,
      itemCount: event.pictures.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildPictureImage(index);
      },
      pagination: SwiperCustomPagination(builder: (context, config) {
        return _buildCustomPagination(config);
      }),
    );
  }

  Widget _buildPictureImage(int index) {
    if (event.preview) {
      File file = File(event.pictures[index]);
      return Image.file(file, fit: BoxFit.cover);
    }
    return Hero(
      tag: "picture-${event.id}",
      child: CachedNetworkImage(
        imageUrl: event.pictures[index],
        fit: BoxFit.cover,
        useOldImageOnUrlChange: true,
        placeholder: (context, url) => CupertinoActivityIndicator(
          radius: 20,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget _buildCustomPagination(SwiperPluginConfig config) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 8, left: 25, right: 25),
        child: Row(
          children: List.generate(
            6,
            (index) => Expanded(
              child: Container(
                height: 3,
                margin: EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: config.activeIndex == index
                      ? ConstantColor.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtnFavorite() {
    if (event.userId != UserController.to.user.id)
      return FavoriteBtn(
        event: event,
        enabled: UserController.to.isFavorite(event),
      );
    return Container();
  }
}
