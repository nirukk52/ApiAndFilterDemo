import 'dart:async';
import 'dart:collection';

import 'package:movies_streams/api/FreightApi.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/models/MainFreightCard.dart';
import 'package:movies_streams/models/QuoteFilter.dart';
import 'package:movies_streams/models/Rate.dart';
import 'package:movies_streams/models/SubFilter.dart';
import 'package:rxdart/rxdart.dart';

class MainFreightBloc implements BlocBase {


  ///
  /// Unique list of all Main Freight.
  ///
  List<MainFreightCard> mainFreightCard = List<MainFreightCard>();

  QuoteFilter quoteFilter = new QuoteFilter();



  // ##########  STREAMS  ##############
  ///
  /// Interface that allows to get the list of all Main Freight.
  ///
  BehaviorSubject<List<MainFreightCard>> mainFreightController =
      new BehaviorSubject<List<MainFreightCard>>(seedValue: []);

  Sink<List<MainFreightCard>> get inMainFreightCards => mainFreightController.sink;

  Stream<List<MainFreightCard>> get outMainFreightCards =>
      mainFreightController.stream;

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
    mainFreightCard.clear();
    api.getResultData().then((result) {
      createMainFreightCardList(result.rates);
      createFilterObjects();
      notifyQuotesChanged();
    });
  }

  void dispose() {
    mainFreightController.close();
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
    // The new filter.
    inQuoteFilters.add(quoteFilter);
  }

  void notifyQuotesChanged() {
    // Send to whomever is interested...
    // The new list of all quotes.
    inMainFreightCards.add(UnmodifiableListView(mainFreightCard));
  }

  void createMainFreightCardList(List<Rate> allRates) {
    List<Rate> mainFreights =
        allRates.where((rate) => rate.legCode == "l3_fcl").toList();
    List<Rate> charges =
        allRates.where((rate) => rate.legCode != "l3_fcl").toList();

    for (int i = 0; i < mainFreights.length; i++) {
      MainFreightCard mainFreightCard = new MainFreightCard();
      Rate mainFreight = mainFreights[i];
      mainFreightCard.totalCharge = mainFreight.legTotalCost;
      List<Rate> l2FclRateList = charges
          .where((rate) =>
              rate.legCode == "l2_fcl" &&
              rate.subVendorId == mainFreight.subVendorId)
          .toList();
      List<Rate> l4FclRateList = charges
          .where((rate) =>
              rate.legCode == "l4_fcl" &&
              rate.subVendorId == mainFreight.subVendorId)
          .toList();
      Rate originCharge;
      Rate destinationCharge;
      if (l2FclRateList.length > 0) {
        originCharge = l2FclRateList[0];
        mainFreightCard.totalCharge = (mainFreightCard.totalCharge + originCharge.legTotalCost);
      }
      if (l4FclRateList.length > 0) {
        destinationCharge = l4FclRateList[0];
        mainFreightCard.totalCharge = (mainFreightCard.totalCharge + destinationCharge.legTotalCost);
      }
      mainFreightCard.mainFreight = mainFreight;
      mainFreightCard.originCharge = originCharge;
      mainFreightCard.destinationCharge = destinationCharge;


      this.mainFreightCard.add(mainFreightCard);
    }
  }

  void createFilterObjects() {
    Set<SubFilter> allSubVendor = new Set<SubFilter>();

    for (int i = 0; i < mainFreightCard.length; i++) {
      allSubVendor.add(new SubFilter(
          mainFreightCard[i].mainFreight.subVendor.subVendorName, false));
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
    mainFreightCard.clear();
    notifyQuotesChanged();

    List<SubFilter> activeSubVendors = quoteFilter.subVendors
        .where((subVendor) => subVendor.isActive)
        .toList();

    api.getResultData().then((result) {
      createMainFreightCardList(result.rates);

      if (activeSubVendors.length > 0) {
        mainFreightCard.retainWhere((mainFreightCard) => activeSubVendors.any(
            (subFilter) =>
                subFilter.filterKey ==
                mainFreightCard.mainFreight.subVendor.subVendorName));
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
          mainFreightCard
              .sort((a, b) => a.totalCharge.compareTo(b.totalCharge));
        }
        break;
      case SortOrder.DESC:
        {
          mainFreightCard
              .sort((a, b) => b.totalCharge.compareTo(a.totalCharge));
        }
        break;
      default:
        {}
        break;
    }
    notifyQuotesChanged();
  }
}
