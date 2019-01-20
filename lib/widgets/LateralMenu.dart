import 'package:flutter/material.dart';

import 'package:movies_streams/theme/ColorPalette.dart';
import 'package:movies_streams/widgets/MenuSection.dart';

const iconColor = Colors.white;

class LateralMenu extends StatelessWidget {
  LateralMenu({Function onMenuSelected}) {
    this.onMenuSelected = onMenuSelected ?? (MenuSection menu) {};
  }

  Function onMenuSelected;

  Widget _renderMenuButtonDivisor() {
    return new Container(
      color: Colors.white.withOpacity(0.2),
      height: 1.0,
    );
  }

  _onHomeSelected() {
    this.onMenuSelected(MenuSection.sort);
  }

  _onChatSelected() {
    this.onMenuSelected(MenuSection.filter);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: ColorPalette.pageBackgroundGray,
        width: 140.0,
        child: new SafeArea(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            this._renderMenuButtonDivisor(),
//            new MenuButton(icon: new Icon(null, color: iconColor), onSelect: this._onHomeSelected),

            new FlatButton(
                padding: new EdgeInsets.all( 30.0),
                onPressed: () {
                  this._onHomeSelected();
                },
                child: new Text(
                  'Sort',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(1.0)),
                )),

            this._renderMenuButtonDivisor(),
//            new MenuButton(
//                icon: new Icon(null, color: iconColor),
//                onSelect: this._onChatSelected),

            new FlatButton(
                padding: new EdgeInsets.all( 30.0),
                onPressed: () {
                  this._onChatSelected();
                },
                child: new Text(
                  'Liners',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(1.0)),
                )),

            this._renderMenuButtonDivisor()
          ],
        )));
  }
}
