import 'package:esgi_project/components/card_event.dart';
import 'package:esgi_project/controllers/user_controller.dart';
import 'package:esgi_project/models/event.dart';
import 'package:esgi_project/routes.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';

class MapEvent extends StatefulWidget {
  final List<Event> listEvent;
  MapEvent(this.listEvent, {Key key}) : super(key: key);

  @override
  _MapEventState createState() => _MapEventState();
}

class _MapEventState extends State<MapEvent> {
  final MapController _mapController = MapController();
  int _indexMarker = -1;
  bool _showInfoEvent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: checkLocation(),
              zoom: 11.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                "https://api.mapbox.com/styles/v1/{style}/tiles/256/{z}/{x}/{y}?access_token={accessToken}",
                additionalOptions: {
                  'style': "wemouv/ckc9798x02vgc1ipjusua5lbm",
                  'accessToken':
                  'pk.eyJ1Ijoid2Vtb3V2IiwiYSI6ImNqcGgxN21tZjBwYWgzcWxxZ242NHd5NjkifQ.dbudKtF6QmygxeD1osCvbA',
                },
              ),
              MarkerLayerOptions(
                markers: List.generate(
                  UserController.to.user.location != null ? widget.listEvent.length + 1 : widget.listEvent.length,
                  (index) {
                    if (UserController.to.user.location != null && index == widget.listEvent.length)
                      return Marker(
                        width: 45.0,
                        height: 45.0,
                        point: LatLng(
                          UserController.to.user.location["latitude"],
                          UserController.to.user.location["longitude"],
                        ),
                        builder: (ctx) => Container(
                          child: Icon(
                            Icons.my_location,
                            color: Colors.redAccent,
                            size: 35,
                          ),
                        ),
                      );
                    return Marker(
                      width: index == _indexMarker ? 200.0 : 45.0,
                      height: index == _indexMarker ? 150.0 : 45.0,
                      point: LatLng(
                        widget.listEvent[index].location["latitude"],
                        widget.listEvent[index].location["longitude"],
                      ),
                      builder: (ctx) => Container(
                        child: _buildMarker(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _buildBackgroundList(),
          Align(alignment: Alignment.bottomCenter, child: _buildListEvent()),
        ],
      ),
    );
  }

  LatLng checkLocation() {
    if (UserController.to.user.location == null)
      return LatLng(
        widget.listEvent[0].location["latitude"],
        widget.listEvent[0].location["longitude"],
      );
    return LatLng(
      UserController.to.user.location["latitude"],
      UserController.to.user.location["longitude"],
    );
  }

  Widget _buildMarker(int index) {
    if (index == _indexMarker) {
      if (_showInfoEvent)
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.location_on),
              color: _indexMarker == index
                  ? Colors.greenAccent[400]
                  : Colors.deepPurpleAccent,
              iconSize: 45.0,
              onPressed: () {
                setState(() {
                  _showInfoEvent = !_showInfoEvent;
                });
              },
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        widget.listEvent[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () {
                        Get.toNamed(Router.eventDetailRoute,
                            arguments: widget.listEvent[index]);
                      })
                ],
              ),
            ),
          ],
        );
      else
        return IconButton(
          icon: Icon(Icons.location_on),
          color: _indexMarker == index
              ? Colors.greenAccent[400]
              : Colors.deepPurpleAccent,
          iconSize: 45.0,
          onPressed: () {
            setState(() {
              _showInfoEvent = !_showInfoEvent;
            });
          },
        );
    }
    return IconButton(
      icon: Icon(Icons.location_on),
      color: _indexMarker == index
          ? Colors.greenAccent[400]
          : Colors.deepPurpleAccent,
      iconSize: 45.0,
      onPressed: () {
        setState(() {
          _showInfoEvent = true;
          _indexMarker = index;
        });
      },
    );
  }

  Widget _buildBackgroundList() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ConstantColor.white,
                Color(0xff85847c),
                ConstantColor.backgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      ),
    );
  }

  Widget _buildListEvent() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 100,
        child: ListView.builder(
          itemCount: widget.listEvent.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 20),
              child: CardEvent(
                widget.listEvent[index],
                height: 75,
                width: 275,
                onTap: () {
                  setState(() {
                    _indexMarker = index;
                    _showInfoEvent = true;
                    _mapController.move(
                      LatLng(
                        widget.listEvent[index].location["latitude"],
                        widget.listEvent[index].location["longitude"],
                      ),
                      13.0,
                    );
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
