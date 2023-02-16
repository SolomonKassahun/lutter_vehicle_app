class Vehicle {
  int? vehicleId;
  int? vehicleAge;
  int? vehicleSpead;
  String? vehicleName;
  String? vehicleModel;
  Vehicle(
      {required this.vehicleId,
      required this.vehicleAge,
      required this.vehicleSpead,
      required this.vehicleName,
      required this.vehicleModel
      });

  Vehicle.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicleId'];
    vehicleAge = json['vehicleAge'];
    vehicleSpead = json['vehicleSpead'];
    vehicleName = json['vehicleName'];
    vehicleModel = json['vehicleModel'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> vehicle = <String, dynamic>{};
    vehicle['vehicleId'] = vehicleId;
    vehicle['vehicleAge'] = vehicleAge;
    vehicle['vehicleSpead'] = vehicleSpead;
    vehicle['vehicleName'] = vehicleName;
    vehicle['vehicleModel'] = vehicleModel;
    return vehicle;
  }
}
