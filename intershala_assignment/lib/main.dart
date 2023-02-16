import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intershala_assignment/bloc/vehicle_bloc.dart';
import 'package:intershala_assignment/bloc/vehicle_event.dart';
import 'package:intershala_assignment/data_provider/vehicle_data_provider.dart';
import 'package:intershala_assignment/data_repository/vehicle_data_repository.dart';
import 'package:intershala_assignment/screens/homepage.dart';

import 'bloc_observer.dart';
import 'firebase_options.dart';

void main() async{
  Bloc.observer = SampleObsever();
  //  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized(
    
  );
  await Firebase.initializeApp(
    //  options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  
VehicleDataRepository vehicleDataRepository =  VehicleDataRepository(vehicleDataProvider: VehicleDataProvider());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> VehiclesBloc(vehicleDataRepository: vehicleDataRepository)..add(FetchVehicleEvent()))
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Homepage(),
      ),
    );
  }
}

