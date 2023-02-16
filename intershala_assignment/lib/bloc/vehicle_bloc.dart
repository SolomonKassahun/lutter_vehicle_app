import 'package:bloc/bloc.dart';
import 'package:intershala_assignment/bloc/vehicle_event.dart';
import 'package:intershala_assignment/bloc/vehicle_state.dart';
import 'package:intershala_assignment/data_repository/vehicle_data_repository.dart';

import '../model/vehicle_info.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState>{
  final VehicleDataRepository vehicleDataRepository;
  List<Vehicle> vehicleList = [];
  VehiclesBloc( {required this.vehicleDataRepository}):super(VehicleLoading()){
    on<FetchVehicleEvent>(((event, emit) => fetchVehicleInformation()));
  }
  
  void fetchVehicleInformation() async{
    try {
      List<Vehicle> vehicle = await vehicleDataRepository.getVehicle();
     print("Data arrived at the data provider: $vehicle  ");
      if(vehicle != []){
        // ignore: invalid_use_of_visible_for_testing_member
        emit(VehicleFetchingSucess(vehicle: vehicle));
      } else{
           // ignore: invalid_use_of_visible_for_testing_member
           emit(VehicleFetchingError(message: "Unable to Load Vehicles"));
      }
    } catch (e) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(VehicleFetchingError(message: "Unable to Load Vehicles"));
    }

  }


}