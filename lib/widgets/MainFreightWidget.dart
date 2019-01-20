import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/blocs/MainFreightBloc.dart';
import 'package:movies_streams/models/Rate.dart';

class MainFreightWidget extends StatelessWidget {
  MainFreightWidget({
    Key key,
    this.rate,
    this.allRates,
  }) : super(key: key);

  final Rate rate;
  final List<Rate> allRates;

  @override
  Widget build(BuildContext context) {
    final MainFreightBloc bloc = BlocProvider.of<MainFreightBloc>(context);
    return StreamBuilder(
      stream: bloc.outAllRates,
      // Display as many FavoriteWidgets
      builder: (BuildContext context, AsyncSnapshot<List<Rate>> snapshot) {
        if (snapshot.hasData) {
          List<Rate> l2FclRateList = snapshot.data
              .where((rate) =>
                  rate.legCode == "l2_fcl" &&
                  rate.subVendorId == this.rate.subVendorId)
              .toList();
          List<Rate> l4FclRateList = snapshot.data
              .where((rate) =>
                  rate.legCode == "l4_fcl" &&
                  rate.subVendorId == this.rate.subVendorId)
              .toList();
          Rate originCharge;
          Rate destinationCharge;
          if (l2FclRateList.length > 0) {
            originCharge = l2FclRateList[0];
          }
          if (l4FclRateList.length > 0) {
            destinationCharge = l4FclRateList[0];
          }
          if (originCharge == null && destinationCharge == null)
            return this.freightNoCharge();
          else if (originCharge == null) {
            return this.freightDestinationCharge(destinationCharge);
          } else if (destinationCharge == null) {
            return this.freightOrginCharges(originCharge);
          } else {
            return this.freightAllCharges(originCharge, destinationCharge);
          }
        }

        return Container();
      },
    );
  }

  Widget freightAllCharges(Rate originCharge, Rate destinationCharge) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    title: Text(rate.subVendor.subVendorName),
                    subtitle: Text(rate.expiry)),
                ListTile(
                    leading: new Icon(
                      Icons.access_time,
                    ),
                    title: Text(rate.legName),
                    trailing: Text(rate.legTotalCost.toString())),
                ListTile(
                  leading: new Icon(
                    Icons.access_time,
                  ),
                  title: Text(originCharge.legName),
                  trailing: Text(originCharge.legTotalCost.toString()),
                ),
                ListTile(
                  leading: new Icon(
                    Icons.access_time,
                  ),
                  title: Text(destinationCharge.legName),
                  trailing: Text(destinationCharge.legTotalCost.toString()),
                ),
                new Divider(),
//                Card(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].transitTime),
//                          subtitle: Text(rate.schedule[0].viaPort)),
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].departureTime),
//                          trailing: Text("MORE")),
//                    ],
//                  ),
//                ),
                Card(
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text("TOTAL COST"),
                    subtitle: Text(""),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget freightOrginCharges(Rate originCharge) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    title: Text(rate.subVendor.subVendorName),
                    subtitle: Text(rate.expiry)),
                ListTile(
                    leading: new Icon(
                      Icons.access_time,
                    ),
                    title: Text(rate.legName),
                    trailing: Text(rate.legTotalCost.toString())),
                ListTile(
                  leading: new Icon(
                    Icons.access_time,
                  ),
                  title: Text(originCharge.legName),
                  trailing: Text(originCharge.legTotalCost.toString()),
                ),
                new Divider(),
//                Card(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].transitTime),
//                          subtitle: Text(rate.schedule[0].viaPort)),
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].departureTime),
//                          trailing: Text("MORE")),
//                    ],
//                  ),
//                ),
                Card(
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text("TOTAL COST"),
                    subtitle: Text(""),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget freightDestinationCharge(Rate destinationCharge) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    title: Text(rate.subVendor.subVendorName),
                    subtitle: Text(rate.expiry)),
                ListTile(
                    leading: new Icon(
                      Icons.access_time,
                    ),
                    title: Text(rate.legName),
                    trailing: Text(rate.legTotalCost.toString())),
                ListTile(
                  leading: new Icon(
                    Icons.access_time,
                  ),
                  title: Text(destinationCharge.legName),
                  trailing: Text(destinationCharge.legTotalCost.toString()),
                ),
                new Divider(),
//                Card(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].transitTime),
//                          subtitle: Text(rate.schedule[0].viaPort)),
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].departureTime),
//                          trailing: Text("MORE")),
//                    ],
//                  ),
//                ),
                Card(
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text("TOTAL COST"),
                    subtitle: Text(""),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget freightNoCharge() => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                    contentPadding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    title: Text(rate.subVendor.subVendorName),
                    subtitle: Text(rate.expiry)),
                ListTile(
                    leading: new Icon(
                      Icons.access_time,
                    ),
                    title: Text(rate.legName),
                    trailing: Text(rate.legTotalCost.toString())),
                new Divider(),
//                Card(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].transitTime),
//                          subtitle: Text(rate.schedule[0].viaPort)),
//                      ListTile(
//                          leading: new Icon(
//                            Icons.access_time,
//                          ),
//                          title: Text(rate.schedule[0].departureTime),
//                          trailing: Text("MORE")),
//                    ],
//                  ),
//                ),
                Card(
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text("TOTAL COST"),
                    subtitle: Text(""),
                  ),
                )
              ],
            ),
          ),
        ),
      );

}
