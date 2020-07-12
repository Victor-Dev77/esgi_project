import 'dart:io';
import 'package:esgi_project/components/favorite_btn.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/utils/constant.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:esgi_project/components/hero_image_network.dart';
import 'package:esgi_project/components/icon_with_title.dart';

class EventDetail extends StatelessWidget {
  final Event event = Get.arguments as Event;
  bool _error;

  @override
  Widget build(BuildContext context) {
    _error = event == null;
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
          child: Text(Localization.errorMissingParam.tr, style: Get.textTheme.headline2,),
        ),
      ),
    );
  }

  Scaffold _buildScreen() {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (ctx, _) {
              return _buildSliverAppBar();
            },
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30),
                    _buildBlocDateDistance(),
                    _buildBlocTitle(),
                    _buildBlocContent(),
                    _buildBlocAddress(),
                  ],
                ),
              ),
            ),
          ),
          _buildBlocOverlayFavorite(),
        ],
      )),
    );
  }

  List<Widget> _buildSliverAppBar() {
    return <Widget>[
      SliverAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ConstantColor.backgroundColor,
          ),
          onPressed: () => Get.back(),
        ),
        expandedHeight: Get.height * 0.65,
        floating: false,
        pinned: true,
        snap: false,
        elevation: 50,
        backgroundColor: ConstantColor.white,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            event.title == "" ? Localization.noTitleEvent.tr : event.title,
            style: TextStyle(
                fontWeight:
                    event.title == "" ? FontWeight.normal : FontWeight.bold,
                fontStyle:
                    event.title == "" ? FontStyle.italic : FontStyle.normal,
                fontSize: 16,
                color: ConstantColor.white),
          ),
          background: _buildPictureBloc(),
        ),
      ),
    ];
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
    return HeroImageNetwork(
      tag: "picture-${event.id}",
      imageUrl: event.pictures[index],
      justImage: true,
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
                      ? ConstantColor.white
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

  Widget _buildBlocDateDistance() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconWithTitle(
                icon: Constant.dateIcon,
                title: event.dateStart == ""
                    ? Localization.noBeginDateEvent.tr
                    : event.dateStart,
                color: ConstantColor.white,
              ),
              SizedBox(height: 5),
              IconWithTitle(
                  icon: Constant.dateIcon,
                  title: event.dateEnd == ""
                      ? Localization.noEndDateEvent.tr
                      : event.dateEnd,
                color: ConstantColor.white,
              )
            ],
          ),
          if (event.distanceBW != null)
            IconWithTitle(
              icon: Constant.placeIcon,
              spaceBW: 2,
              title: "${event.distanceBW}km",
            ),
        ],
      ),
    );
  }

  Widget _buildBlocTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Text(
        event.title == "" ? Localization.noTitleEvent.tr : event.title,
        style: TextStyle(
          fontWeight: event.title == "" ? FontWeight.normal : FontWeight.bold,
          fontStyle: event.title == "" ? FontStyle.italic : FontStyle.normal,
          fontSize: 20,
          color: ConstantColor.white
        ),
      ),
    );
  }

  Widget _buildBlocContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Text(
        event.content == ""
            ? Localization.noDescriptionEvent.tr
            : event.content,
        style: TextStyle(
          fontStyle: event.content == "" ? FontStyle.italic : FontStyle.normal,
          fontSize: 16,
            color: ConstantColor.white
        ),
      ),
    );
  }

  Widget _buildBlocAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: IconWithTitle(
        icon: Constant.placeIcon,
        title: event.address == ""
            ? Localization.noAddressEvent.tr
            : event.address,
      ),
    );
  }

  Widget _buildBlocOverlayFavorite() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ConstantColor.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
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
                    color: ConstantColor.backgroundColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  event.price == 0
                      ? Localization.freeTitle.tr
                      : "${event.price}€",
                  style: TextStyle(
                    color: ConstantColor.backgroundColor,
                    fontWeight:
                        event.price == 0 ? FontWeight.bold : FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            _buildBtnFavorite(),
          ],
        ),
      ),
    );
  }

  Widget _buildBtnFavorite() {
    if (event.userId != UserController.to.user.id)
      return GetBuilder<UserController>(
        builder: (controller) {
          return FavoriteBtn(
            event: event,
            enabled: controller.isFavorite(event),
          );
        },
      );
    return Container();
  }
}
