import 'package:movies_streams/models/Charge.dart';
import 'package:movies_streams/models/LoadStat.dart';
import 'package:movies_streams/models/Schedule.dart';
import 'package:movies_streams/models/SubVendor.dart';
import 'package:movies_streams/models/Vendor.dart';

class Rate extends Object {
  String airline;
  String airlineCode;
  List<Charge> charges;
  String contractNumber;
  String createdBy;
  String expiry;
  String globalLegId;
  String id;
  String ifApplicableCharges;
  String inclusions;
  String legCode;
  String legCurrency;
  String legCurrencyCost;
  String legName;
  double legTotalCost;
  String legTotalCurrency;
  LoadStat loadStat;
  int manual;
  String otherCharges;
  String remarks;
  String resultId;
  List<Schedule> schedule;
  String serviceType;
  String slab;
  String slabCurrency;
  String slabRate;
  SubVendor subVendor;
  String subVendorId;
  String transitTime;
  Vendor vendor;
  String vendorId;
  String viaRoute;

  Rate.fromJSON(Map<String, dynamic> parsedJson) {
    this.airline = parsedJson['airline'];
    this.airlineCode = parsedJson['airline_code'];
    this.manual = parsedJson['manual'];
    this.charges = (parsedJson['charges'] as List)
        .map((json) => Charge.fromJSON(json))
        .toList();
    this.contractNumber = parsedJson['contract_number'];
    this.createdBy = parsedJson['created_by'];
    this.expiry = parsedJson['expiry'];
    this.globalLegId = parsedJson['global_leg_id'];
    this.id = parsedJson['id'];
    this.ifApplicableCharges = parsedJson['if_applicable_charges'];
    this.inclusions = parsedJson['inclusions'];
    this.legCode = parsedJson['leg_code'];
    this.legCurrency = parsedJson['leg_currency'];
    this.legCurrencyCost = parsedJson['leg_currency_cost'];
    this.legName = parsedJson['leg_name'];
    this.legTotalCost = double.parse(parsedJson['leg_total_cost']);
    this.legTotalCurrency = parsedJson['leg_total_currency'];
    this.loadStat = LoadStat.fromJSON(parsedJson['load_stat']);
    this.otherCharges = parsedJson['other_charges'];
    this.remarks = parsedJson['remarks'];
    this.resultId = parsedJson['result_id'];
//    this.schedule = (parsedJson['schedule'] as List)
//        .map((json) => Schedule.fromJSON(json))
//        .toList();
    this.serviceType = parsedJson['service_type'];
    this.slab = parsedJson['slab'];
    this.slabCurrency = parsedJson['slab_currency'];
    this.slabRate = parsedJson['slab_rate'];
    this.subVendor = SubVendor.fromJSON(parsedJson['sub_vendor']);
    this.subVendorId = parsedJson['subVendorId'];
    this.transitTime = parsedJson['transitTime'];
    this.vendor = Vendor.fromJSON(parsedJson['vendor']);
    this.vendorId = parsedJson['vendorId'];
    this.viaRoute = parsedJson['viaRoute'];
  }
}
