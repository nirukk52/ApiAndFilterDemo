//
//  ScheduleTrack.dart
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 13, 2019

class ScheduleTrack {  
  String arrivalTime;    
  String departureTime;    
  int id;    
  String portCode;    
  String portCutoff;    
  String portName;    
  int routeId;    
  String serviceName;    
  String terminal;    
  String transitTime;    
  String vessel;    
  String vgmCutoff;    
  String voyage;    
  String voyageLocal;    

  ScheduleTrack.fromJSON(Map<String, dynamic> parsedJson) {    
    this.arrivalTime = parsedJson['arrival_time'];
    this.departureTime = parsedJson['departure_time'];
    this.id = parsedJson['id'];    
    this.portCode = parsedJson['port_code'];
    this.portCutoff = parsedJson['port_cutoff'];
    this.portName = parsedJson['port_name'];
    this.routeId = parsedJson['route_id'];
    this.serviceName = parsedJson['service_name'];
    this.terminal = parsedJson['terminal'];    
    this.transitTime = parsedJson['transit_time'];
    this.vessel = parsedJson['vessel'];    
    this.vgmCutoff = parsedJson['vgm_cutoff'];
    this.voyage = parsedJson['voyage'];    
    this.voyageLocal = parsedJson['voyage_local'];
  }
}