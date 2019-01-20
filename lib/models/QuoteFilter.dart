import 'package:movies_streams/models/SubFilter.dart';
import 'package:tuple/tuple.dart';

class QuoteFilter {
  SortOrder sortOrder = SortOrder.NORMAL;
  List<SubFilter> subVendors = List<SubFilter>();
  bool filterApplied = false;

  QuoteFilter();
}

enum SortOrder { NORMAL, ASC, DESC }
