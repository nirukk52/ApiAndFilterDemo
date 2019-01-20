import 'package:movies_streams/models/Rate.dart';

class ResultData {
  String id;
  List<Rate> rates;

  ResultData(this.id, this.rates);

  ResultData.fromJSON(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'] as String;
    this.rates = (parsedJson['rates'] as List)
        .map((rate) => Rate.fromJSON(rate))
        .toList();
  }

}
