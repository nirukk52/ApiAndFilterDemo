import 'package:movies_streams/models/ResultData.dart';
//part 'rootmodal.g.dart';

//@JsonSerializable()
class RootModel {
  ResultData resultData;

  RootModel(this.resultData);

//  factory RootModel.fromJSON(Map<String, dynamic> response)
//      : resultData = ResultData.fromJson(response['author']);

  RootModel.fromJSON(Map<String, dynamic> json)
      : resultData = ResultData.fromJSON(json['result_data']);

//  : resultData = response['result_data'];
//      : resultData = (parsedJson["result_data"])
//      .map((item) => ResultData.fromJSON(item)).toList();

}
