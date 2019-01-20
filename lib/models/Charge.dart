//
//  Charge.dart
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 13, 2019

class Charge {  
  String chargeBasis;    
  int chargeCost;    
  String chargeCurrency;    
  String chargeDescription;    
  String chargeId;    
  String chargeName;    
  String containerType;    
  double customerCurrencyCost;    
  String globalChargeId;    
  String id;    
  int legCurrencyCost;
  String legMetaId;    
  String minimumChargeCost;    
  int perUnitRate;    
  String totalUnits;    

  Charge.fromJSON(Map<String, dynamic> parsedJson) {    
    this.chargeBasis = parsedJson['charge_basis'];
    this.chargeCost = parsedJson['charge_cost'];
    this.chargeCurrency = parsedJson['charge_currency'];
    this.chargeDescription = parsedJson['charge_description'];
    this.chargeId = parsedJson['charge_id'];
    this.chargeName = parsedJson['charge_name'];
    this.containerType = parsedJson['container_type'];
    this.customerCurrencyCost = parsedJson['customer_currency_cost'] as double;
    this.globalChargeId = parsedJson['global_charge_id'];
    this.id = parsedJson['id'];    
   // this.legCurrencyCost = (parsedJson['leg_currency_cost']);
    this.legMetaId = parsedJson['leg_meta_id'];
    this.minimumChargeCost = parsedJson['minimum_charge_cost'];
    this.perUnitRate = parsedJson['per_unit_rate'];
    this.totalUnits = parsedJson['total_units'];
  }
}