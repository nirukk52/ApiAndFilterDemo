//
//  LoadStat.dart
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 13, 2019

class LoadStat {  
  int tgp;

  LoadStat.fromJSON(Map<String, dynamic> parsedJson) {    
    this.tgp = parsedJson['20GP'];
  }
}