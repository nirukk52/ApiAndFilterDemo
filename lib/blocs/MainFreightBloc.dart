import 'dart:async';
import 'dart:collection';

import 'package:movies_streams/api/FreightApi.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/models/QuoteFilter.dart';
import 'package:movies_streams/models/Rate.dart';
import 'package:movies_streams/models/SubFilter.dart';
import 'package:rxdart/rxdart.dart';

class MainFreightBloc implements BlocBase {
  ///
  /// Unique list of all Main Freight.
  ///
  List<Rate> mainFreights = List<Rate>();

  List<Rate> allRates = List<Rate>();

  QuoteFilter quoteFilter = new QuoteFilter();

  // ##########  STREAMS  ##############
  ///
  /// Interface that allows to get the list of all Main Freight.
  ///
  BehaviorSubject<List<Rate>> mainFreightController =
      new BehaviorSubject<List<Rate>>(seedValue: []);

  Sink<List<Rate>> get inMainFreights => mainFreightController.sink;

  Stream<List<Rate>> get outMainFreights => mainFreightController.stream;

  ///
  /// Interface that allows to get the list of all rates.
  ///
  BehaviorSubject<List<Rate>> allRatesController =
      new BehaviorSubject<List<Rate>>(seedValue: []);

  Sink<List<Rate>> get inAllRates => allRatesController.sink;

  Stream<List<Rate>> get outAllRates => allRatesController.stream;

  ///
  /// We also want to handle changes to the filters.
  ///
  BehaviorSubject<List<SubFilter>> subVendorFilterController =
      BehaviorSubject<List<SubFilter>>();

  Sink<List<SubFilter>> get inSubVendorFilters =>
      subVendorFilterController.sink;

  Stream<List<SubFilter>> get outSubVendorFilters =>
      subVendorFilterController.stream;

  ///
  /// We also want to handle changes to the filters
  ///
  BehaviorSubject<QuoteFilter> _filtersController =
      BehaviorSubject<QuoteFilter>();

  Sink<QuoteFilter> get inQuoteFilters => _filtersController.sink;

  Stream<QuoteFilter> get outQuoteFilters => _filtersController.stream;

  ///
  /// Constructor
  ///
  MainFreightBloc() {
    mainFreights.clear();
    api.getResultData().then((result) {
      this.mainFreights.addAll(result.rates);
      inAllRates.add(mainFreights.where((rate) => rate.legCode != "l3_fcl").toList());
      mainFreights.retainWhere((rate) => rate.legCode == "l3_fcl");
      createFilterObjects();
      notifyQuotesChanged();
    });
  }

  void dispose() {
    mainFreightController.close();
    allRatesController.close();
    subVendorFilterController.close();
    _filtersController.close();
  }

  void getQuotes() {}

  // ############# HANDLING  #####################
  void handleAddSubVendor(int position, bool isActive) {
    quoteFilter.subVendors[position].isActive = isActive;
    notifyFilterChanged();
  }

  void handleSortOrder(SortOrder sortOrder) {
    quoteFilter.sortOrder = sortOrder;
    notifyFilterChanged();
  }

  void notifyFilterChanged() {
    // Send to whomever is interested...
    // The new list of all favorite movies.
    inQuoteFilters.add(quoteFilter);
  }

  void notifyQuotesChanged() {
    // Send to whomever is interested...
    // The new list of all favorite movies.
    inMainFreights.add(UnmodifiableListView(mainFreights));
  }

  void createFilterObjects() {
    Set<SubFilter> allSubVendor = new Set<SubFilter>();

    for (int i = 0; i < mainFreights.length; i++) {
      allSubVendor.add(new SubFilter(mainFreights[i].subVendor.subVendorName, false));
    }
    quoteFilter.sortOrder = SortOrder.NORMAL;
    quoteFilter.subVendors = new List();
    quoteFilter.subVendors.addAll(allSubVendor);

    notifyFilterChanged();
  }

  ///
  /// We want to set new filters.
  ///
  void handleFilters() {
    // we need to tell about a change so that we pick another filters.
    mainFreights.clear();
    notifyQuotesChanged();

    List<SubFilter> activeSubVendors = quoteFilter.subVendors
        .where((subVendor) => subVendor.isActive)
        .toList();

    api.getResultData().then((result) {
      mainFreights = result.rates;

      if (activeSubVendors.length > 0) {
        mainFreights.retainWhere((rate) => activeSubVendors.any((subFilter) =>
            subFilter.filterKey == rate.subVendor.subVendorName));
      }

      handleSort(quoteFilter.sortOrder);
    });
  }

  void handleSort(SortOrder sortOrder) {
    switch (sortOrder) {
      case SortOrder.NORMAL:
        {}
        break;
      case SortOrder.ASC:
        {
          mainFreights.sort((a, b) => a.legTotalCost.compareTo(b.legTotalCost));
        }
        break;
      case SortOrder.DESC:
        {
          mainFreights.sort((a, b) => b.legTotalCost.compareTo(a.legTotalCost));
        }
        break;
      default:
        {}
        break;
    }
    notifyQuotesChanged();
  }
}
