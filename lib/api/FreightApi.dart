import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies_streams/models/Rate.dart';
import 'package:movies_streams/models/ResultData.dart';
import 'package:movies_streams/models/RootModel.dart';

class FreightApi {
  static const String baseUrl = "https://api.myjson.com/bins/k84yq";
  final _httpClient = new HttpClient();

  ///
  /// Returns the list of all rates
  ///
  Future<ResultData> getResultData() async {
    var response = await _getRequest(Uri.parse(baseUrl));
    ResultData resultData =
        new RootModel.fromJSON(json.decode(response)).resultData;
    return resultData;
  }

  ///
  /// Routine to invoke the Web Server to get answers
  ///
  Future<String> _getRequest(Uri uri) async {
    var request = await _httpClient.getUrl(uri);
    var response = await request.close();

    return response.transform(utf8.decoder).join();
  }

}

FreightApi api = FreightApi();
