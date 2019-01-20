import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/blocs/MainFreightBloc.dart';
import 'package:movies_streams/models/QuoteFilter.dart';
import 'package:movies_streams/screen/FilterVendorPage.dart';
import 'package:movies_streams/theme/ColorPalette.dart';
import 'package:movies_streams/widgets/LateralMenu.dart';
import 'package:movies_streams/widgets/MenuSection.dart';

class FreightsFilterScreen extends StatefulWidget {
  FreightsFilterScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _FreightsFilterScreenState();
  }
}

class _FreightsFilterScreenState extends State<FreightsFilterScreen> {
  MenuSection _currentPage = MenuSection.sort;

  MainFreightBloc quotesBloc;

  Set<SortOrder> allSortOrder =
      new Set.from([SortOrder.NORMAL, SortOrder.ASC, SortOrder.DESC]);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // As the context of not yet available at initState() level,
    // if not yet initialized, we get the list of all genres
    // and retrieve the currently selected one, as well as the
    // filter parameters
    quotesBloc = BlocProvider.of<MainFreightBloc>(context);
    setState(() {});
  }

  Widget renderSortDropDown() {}

  Widget _getPage() {
    switch (this._currentPage) {
      case MenuSection.sort:
        return StreamBuilder(
          stream: quotesBloc.outQuoteFilters,
          builder: (BuildContext context, AsyncSnapshot<QuoteFilter> snapshot) {
            if (snapshot.hasData && snapshot.data.sortOrder != null) {
              // Ugly, but okay for now. Later individual itemView should be made.!
              return new Container(
                  color: ColorPalette.pageBackgroundWhite,
                  width: double.infinity,
                  padding: new EdgeInsets.all(20.0),
                  child: new DropdownButton<SortOrder>(
                      items: allSortOrder.map((SortOrder sortOrder) {
                        return DropdownMenuItem<SortOrder>(
                          value: sortOrder,
                          child: new Text(sortOrder.toString()),
                        );
                      }).toList(),
                      value: snapshot.data.sortOrder,
                      onChanged: (SortOrder newSubVendor) {
                        quotesBloc.handleSortOrder(newSubVendor);
                        // setState(() {});
                      }));
            }
            return Container();
          },
        );

      case MenuSection.filter:
        return new FilterVendorPage();
      default:
        return null;
    }
  }

  _onMenuChanged(MenuSection section) {
    this.setState(() {
      this._currentPage = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: new Container(
        child: new Row(
          children: <Widget>[
            new LateralMenu(
              onMenuSelected: this._onMenuChanged,
            ),
            new Expanded(
              child: this._getPage(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          //
          // When the user accepts the changes to the filters,
          // we need to send the new filters to the MainFreightBloc filters sink.
          //
          quotesBloc.handleFilters();
          // close the screen
          Navigator.of(context).pop();
        },
      ),
    );
    // }
  }

}
