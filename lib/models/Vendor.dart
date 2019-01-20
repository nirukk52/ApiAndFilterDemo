//
//  Vendor.dart
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 13, 2019

class Vendor {  
  String vendorName;    

  Vendor.fromJSON(Map<String, dynamic> parsedJson) {    
    this.vendorName = parsedJson['vendor_name'];
  }
}