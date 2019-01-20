import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/blocs/MainFreightBloc.dart';
import 'package:movies_streams/models/QuoteFilter.dart';
import 'package:movies_streams/screen/FreightsFilterScreen.dart';
import 'package:movies_streams/theme/ColorPalette.dart';

class FilterButton extends StatelessWidget {
  FilterButton({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MainFreightBloc bloc = BlocProvider.of<MainFreightBloc>(context);
    return RaisedButton(
      color: ColorPalette.pageBackgroundWhite,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return FreightsFilterScreen();
        }));
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [
          child,
          Positioned(
            top: -12.0,
            right: -6.0,
            child: Material(
              type: MaterialType.circle,
              elevation: 2.0,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: StreamBuilder<QuoteFilter>(
                  stream: bloc.outQuoteFilters,
//                  initialData: ,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuoteFilter> snapshot) {
                    if (snapshot.hasData && snapshot.data.subVendors != null) {
                      return Text(
                        snapshot.data.subVendors
                            .where((subVendor) => subVendor.isActive)
                            .toList()
                            .length
                            .toString(),
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
