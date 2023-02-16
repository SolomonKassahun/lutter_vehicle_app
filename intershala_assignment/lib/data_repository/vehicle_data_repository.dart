import 'package:intershala_assignment/data_provider/vehicle_data_provider.dart';
import 'package:intershala_assignment/model/vehicle_info.dart';

class VehicleDataRepository{
  late final VehicleDataProvider vehicleDataProvider;
  VehicleDataRepository({required this.vehicleDataProvider});

  Future<List<Vehicle>> getVehicle() async{
    return await vehicleDataProvider.getVehicleInformation();

  }

}