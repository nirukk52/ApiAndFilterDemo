import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/blocs/MainFreightBloc.dart';
import 'package:movies_streams/models/MainFreightCard.dart';
import 'package:movies_streams/models/Rate.dart';
import 'package:movies_streams/screen/FreightsFilterScreen.dart';
import 'package:movies_streams/widgets/FilterButton.dart';
import 'package:movies_streams/widgets/MainFreightWidget.dart';

class FreightsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainFreightBloc bloc = BlocProvider.of<MainFreightBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rates Page'),
        actions: <Widget>[
          // Icon that gives direct access to the filters
          // It also displays "real-time" the number of sub_filters_selected
          FilterButton(child: const Icon(Icons.more_horiz)),
        ],
      ),
      body:
//    StreamBuilder(
//        stream: bloc.outAllRates,
//        // Display as many FavoriteWidgets
//        builder: (BuildContext context, AsyncSnapshot<List<Rate>> allRates) {
//          if (allRates.hasData) {
          StreamBuilder(
        stream: bloc.outMainFreightCards,
        // Display as many FavoriteWidgets
        builder:
            (BuildContext context, AsyncSnapshot<List<MainFreightCard>> mainFreights) {
          if (mainFreights.hasData) {
            return ListView.builder(
              itemCount: mainFreights.data.length,
              itemBuilder: (BuildContext context, int index) {
                return MainFreightWidget(
                  mainFreightCard: mainFreights.data[index],
                );
              },
            );
          }
          return Container();
        },
      ),
//          }
//          return Container();
//        },
//      ),
      endDrawer: FreightsFilterScreen(),
    );
  }
}
