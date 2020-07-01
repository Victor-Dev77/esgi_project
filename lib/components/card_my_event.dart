import 'package:esgi_project/components/card_event.dart';
import 'package:esgi_project/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyEventCard extends StatelessWidget {
  final Event event;
  final Widget trailingWidget;
  final VoidCallback trailingAction;
  MyEventCard(
    this.event, {
    Key key,
    @required this.trailingWidget,
    @required this.trailingAction,
  })  : assert(trailingWidget != null),
        assert(trailingAction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        CardEvent(
          event,
          height: 100,
          margin: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 30),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () => trailingAction(),
            child: trailingWidget,
          ),
          right: 15,
          top: 0,
        )
      ],
    );
  }
}
