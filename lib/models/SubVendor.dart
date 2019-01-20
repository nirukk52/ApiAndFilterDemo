//
//  SubVendor.dart
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 13, 2019

class SubVendor {  
  String subVendorName;    
  String carrierCode;

  SubVendor.fromJSON(Map<String, dynamic> parsedJson) {    
    this.subVendorName = parsedJson['sub_vendor_name'];
    this.carrierCode = parsedJson['carrier_code'];
  }
}