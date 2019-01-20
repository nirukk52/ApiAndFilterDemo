import 'package:movies_streams/models/ScheduleTrack.dart';

class Schedule {
  String arrivalTime;
  String carrierCode;
  String departureTime;
  String destinationPort;
  String destinationPortName;
  String destinationTerminal;
  int id;
  String originPort;
  String originPortName;
  String originTerminal;
  String portCutoff;
  List<ScheduleTrack> scheduleTrack;
  String serviceName;
  String transitTime;
  String vessel;
  String vgmCutoff;
  String viaPort;
  String voyage;
  String voyageLocal;

  Schedule.fromJSON(Map<String, dynamic> parsedJson) {
    this.arrivalTime = parsedJson['arrival_time'];
    this.carrierCode = parsedJson['carrier_code'];
    this.departureTime = parsedJson['departure_time'];
    this.destinationPort = parsedJson['destination_port'];
    this.destinationPortName = parsedJson['destination_port_name'];
    this.destinationTerminal = parsedJson['destination_terminal'];
    this.id = parsedJson['id'];
    this.originPort = parsedJson['origin_port'];
    this.originPortName = parsedJson['origin_port_name'];
    this.originTerminal = parsedJson['origin_terminal'];
    this.portCutoff = parsedJson['port_cutoff'];
    this.scheduleTrack = (parsedJson['schedule_track'] as List)
        .map((json) => ScheduleTrack.fromJSON(json))
        .toList();
    this.serviceName = parsedJson['service_name'];
    this.transitTime = parsedJson['transit_time'];
    this.vessel = parsedJson['vessel'];
    this.vgmCutoff = parsedJson['vgm_cutoff'];
    this.viaPort = parsedJson['via_port'];
    this.voyage = parsedJson['voyage'];
    this.voyageLocal = parsedJson['voyage_local'];
  }
}
