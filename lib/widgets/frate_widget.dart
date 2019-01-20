import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/models/Rate.dart';

class FRateWidget extends StatelessWidget {
  FRateWidget({
    Key key,
    this.rate,
  }) : super(key: key);

  final Rate rate;

  @override
  Widget build(BuildContext context) {
    // final FavoriteBloc bloc = BlocProvider.of<FavoriteBloc>(context);
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("LinearLayout Example"),
        ),
        body: new Container(
          color: Colors.yellowAccent,
          child: new Container(
            child: new Column(
              children: [
                new Expanded(
                  child: new Container(
                    child: new Icon(
                      Icons.access_time,
                      size: 50.0,
                    ),
                    color: Colors.red,
                  ),
                  flex: 2,
                ),
                new Expanded(
                  child: new Container(
                    child: new Icon(
                      Icons.pie_chart,
                      size: 100.0,
                    ),
                    color: Colors.blue,
                  ),
                  flex: 4,
                ),
                new Expanded(
                  child: new Container(
                    child: new Icon(
                      Icons.email,
                      size: 50.0,
                    ),
                    color: Colors.green,
                  ),
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
