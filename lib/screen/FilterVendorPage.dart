import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/blocs/MainFreightBloc.dart';
import 'package:movies_streams/models/QuoteFilter.dart';
import 'package:movies_streams/models/Rate.dart';
import 'package:movies_streams/models/SubFilter.dart';
import 'package:movies_streams/theme/ColorPalette.dart';
import 'package:movies_streams/widgets/SearchBar.dart';

class FilterVendorPage extends StatelessWidget {
  FilterVendorPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainFreightBloc quotesBloc = BlocProvider.of<MainFreightBloc>(context);
    return new Container(
        color: ColorPalette.pageBackgroundWhite,
        child: new SafeArea(
          child: new Column(
            children: <Widget>[
              new SearchBar(
                onChange: (text) {
                  print(text);
                },
              ),
              new Expanded(
                  child: StreamBuilder(
                    stream: quotesBloc.outQuoteFilters,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuoteFilter> snapshot) {
                      if (snapshot.hasData && snapshot.data.subVendors != null) {
                        // Ugly, but okay for now. Later individual itemView should be made.!
                        return new ListView.builder(
                            itemCount: snapshot.data.subVendors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new Container(
                                child: new Column(
                                  children: <Widget>[
                                    new CheckboxListTile(
                                        value: snapshot.data.subVendors[index].isActive,
                                        title: new Text(
                                            snapshot.data.subVendors[index].filterKey),
                                        controlAffinity:
                                        ListTileControlAffinity.leading,
                                        onChanged: (bool val) {
                                          quotesBloc.handleAddSubVendor(index, val);
                                        })
                                  ],
                                ),
                              );
                            });
                      }
                      return Container();
                    },
                  ))
            ],
          ),
        ));
  }
}
