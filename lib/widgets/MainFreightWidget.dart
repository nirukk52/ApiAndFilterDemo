import 'package:flutter/material.dart';
import 'package:movies_streams/models/MainFreightCard.dart';
import 'package:movies_streams/models/Rate.dart';

class MainFreightWidget extends StatelessWidget {
  MainFreightWidget({
    Key key,
    @required this.mainFreightCard,
  }) : super(key: key);

  final MainFreightCard mainFreightCard;

  @override
  Widget build(BuildContext context) {
    if (mainFreightCard.originCharge == null &&
        mainFreightCard.destinationCharge == null)
      return this.freightNoCharge();
    else if (mainFreightCard.originCharge == null) {
      return this.freightDestinationCharge(mainFreightCard.destinationCharge);
    } else if (mainFreightCard.destinationCharge == null) {
      return this.freightOriginCharges(mainFreightCard.originCharge);
    } else {
      return this.freightAllCharges(
          mainFreightCard.originCharge, mainFreightCard.destinationCharge);
    }
  }

  Widget freightAllCharges(Rate originCharge, Rate destinationCharge) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    title: Text(
                        mainFreightCard.mainFreight.subVendor.subVendorName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(mainFreightCard.mainFreight.expiry,
                        style: TextStyle(fontStyle: FontStyle.italic))),
                ListTile(
                    leading: new Icon(
                      Icons.directions_boat,
                    ),
                    title: Text(mainFreightCard.mainFreight.legName),
                    trailing: Text(
                        destinationCharge.legCurrency +
                            " " +
                            mainFreightCard.mainFreight.legTotalCost.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))),
                ListTile(
                  leading: new Icon(
                    Icons.arrow_upward,
                  ),
                  title: Text(originCharge.legName),
                  trailing: Text(
                      destinationCharge.legCurrency +
                          " " +
                          originCharge.legTotalCost.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: new Icon(
                    Icons.arrow_downward,
                  ),
                  title: Text(destinationCharge.legName),
                  trailing: Text(
                      destinationCharge.legCurrency +
                          " " +
                          destinationCharge.legTotalCost.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                new Divider(),
                this.schedule(),
                this.totalCost(),
                this.details()
              ],
            ),
          ),
        ),
      );

  Widget freightOriginCharges(Rate originCharge) => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    title: Text(
                        mainFreightCard.mainFreight.subVendor.subVendorName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(mainFreightCard.mainFreight.expiry,
                        style: TextStyle(fontStyle: FontStyle.italic))),
                ListTile(
                    leading: new Icon(
                      Icons.directions_boat,
                    ),
                    title: Text(mainFreightCard.mainFreight.legName),
                    trailing: Text(
                        mainFreightCard.mainFreight.legCurrency +
                            " " +
                            mainFreightCard.mainFreight.legTotalCost.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))),
                ListTile(
                  leading: new Icon(
                    Icons.arrow_upward,
                  ),
                  title: Text(originCharge.legName),
                  trailing: Text(
                      originCharge.legCurrency +
                          " " +
                          originCharge.legTotalCost.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                new Divider(),
                this.schedule(),
                this.totalCost(),
                this.details()
              ],
            ),
          ),
        ),
      );

  Widget freightDestinationCharge(Rate destinationCharge) => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    title: Text(
                        mainFreightCard.mainFreight.subVendor.subVendorName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(mainFreightCard.mainFreight.expiry,
                        style: TextStyle(fontStyle: FontStyle.italic))),
                ListTile(
                    leading: new Icon(
                      Icons.directions_boat,
                    ),
                    title: Text(mainFreightCard.mainFreight.legName),
                    trailing: Text(
                        mainFreightCard.mainFreight.legCurrency +
                            " " +
                            mainFreightCard.mainFreight.legTotalCost.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))),
                ListTile(
                  leading: new Icon(
                    Icons.arrow_downward,
                  ),
                  title: Text(destinationCharge.legName),
                  trailing: Text(
                      destinationCharge.legCurrency +
                          " " +
                          destinationCharge.legTotalCost.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                new Divider(),
                this.schedule(),
                this.totalCost(),
                this.details()
              ],
            ),
          ),
        ),
      );

  Widget freightNoCharge() => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                    title: Text(
                        mainFreightCard.mainFreight.subVendor.subVendorName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(mainFreightCard.mainFreight.expiry,
                        style: TextStyle(fontStyle: FontStyle.italic))),
                ListTile(
                    leading: new Icon(
                      Icons.directions_boat,
                    ),
                    title: Text(mainFreightCard.mainFreight.legName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                        mainFreightCard.mainFreight.legCurrency +
                            " " +
                            mainFreightCard.mainFreight.legTotalCost.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))),
                new Divider(),
                this.schedule(),
                this.totalCost(),
                this.details()
              ],
            ),
          ),
        ),
      );

  Widget details() => Card(
        elevation: 0.0,
        child: new Row(
          children: [
            new Expanded(
              child: new Container(
                child: new Text("Details"),
                color: Colors.grey.shade600,
              ),
              flex: 5,
            ),
            new Expanded(
              child: new Container(
                child: new Text("Book Now"),
                color: Colors.deepOrange.shade600,
              ),
              flex: 5,
            ),
          ],
        ),
      );

  Widget totalCost() => Container(
        color: Colors.grey.shade300,
        child: ListTile(
          title:
              Text("TOTAL COST", style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(mainFreightCard.totalCharge.toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );

  Widget schedule() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListTile(
              leading: new Icon(
                Icons.threesixty,
              ),
              title: Text(mainFreightCard.mainFreight.schedule[0].transitTime),
              trailing: Text(mainFreightCard.mainFreight.schedule[0].viaPort)),
          ListTile(
              leading: new Icon(
                Icons.access_time,
              ),
              title: Text(getDateTime(
                          mainFreightCard.mainFreight.schedule[0].departureTime)
                      .day
                      .toString() +
                  "-" +
                  getDateTime(
                          mainFreightCard.mainFreight.schedule[0].departureTime)
                      .month
                      .toString() +
                  "-" +
                  getDateTime(
                          mainFreightCard.mainFreight.schedule[0].departureTime)
                      .year
                      .toString()),
              trailing: Text("MORE")),
        ],
      );

  DateTime getDateTime(String stringDate) => DateTime.parse(stringDate);
}
