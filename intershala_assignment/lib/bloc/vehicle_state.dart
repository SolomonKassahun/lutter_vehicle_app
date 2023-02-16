import 'package:intershala_assignment/model/vehicle_info.dart';

abstract class VehiclesState  {}

class VehicleLoading extends VehiclesState {}
class VehicleFetchingSucess extends VehiclesState {
  final List<Vehicle> vehicle;
  VehicleFetchingSucess({required this.vehicle});
}
class VehicleFetchingError extends VehiclesState { 
  final String message;
  VehicleFetchingError({required this.message});
}