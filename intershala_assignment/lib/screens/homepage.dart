import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intershala_assignment/bloc/vehicle_bloc.dart';
import 'package:intershala_assignment/bloc/vehicle_state.dart';

import '../bloc/vehicle_event.dart';
import '../service/firebase_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late VehiclesBloc fetchBloc;
  String? imageUrl;
  Future<String> getImage(String? vehicleName) async {
    print("++++++++++++++++++++++++++++++++");
    String imageUrl = await FirebaseService.loadImage(
        vehicleName.toString().substring(7), 'vehicle');
    print("IMage Url: $imageUrl");
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    fetchBloc = BlocProvider.of<VehiclesBloc>(context);
    fetchBloc.add(FetchVehicleEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Flutter App "),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<VehiclesBloc, VehiclesState>(
            builder: (context, state) {
              if (state is VehicleLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
              if (state is VehicleFetchingSucess) {
                print("state is un sucess");
                return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: state.vehicle.isEmpty
                          ? const Center(child:  Text("No Vehicles"))
                          : Column(
                              children: state.vehicle
                                  .map((vehicle) => Card(
                                        color: (vehicle.vehicleAge! <= 5 &&
                                                vehicle.vehicleSpead! >= 15)
                                            ? Colors.green
                                            : (vehicle.vehicleAge! > 5 &&
                                                    vehicle.vehicleSpead! > 15)
                                                ? Colors.amber
                                                : Colors.red,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 90.0,
                                          
                                          child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [ 
                                              FutureBuilder(
                                                  future: getImage(
                                                      vehicle.vehicleName),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState.none:
                                                        return Text('none');
                                                      case ConnectionState
                                                          .waiting:
                                                        return Center(
                                                            child: Column(
                                                          children: [
                                                            Text("Loading ..."),
                                                            Expanded(
                                                                child:
                                                                    SpinKitCircle(
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          ],
                                                        ));
                                                      case ConnectionState
                                                          .active:
                                                        return Text('');
                                                      case ConnectionState.done:
                                                        imageUrl =
                                                            snapshot.data;
                                                            
                                                        return CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height: 50.0,
                                                          width: 50.0,
                                                          imageUrl:
                                                              snapshot.data,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                              4,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                4,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              const Center(
                                                                  child:
                                                                      SpinKitCircle(
                                                            color: Colors.white,
                                                          )),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        );
                                                    }
                                                  }),
                                                const  SizedBox(width: 50,),
                                                  
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      
                                                      Text('${vehicle.vehicleSpead}  km/l', style: const TextStyle(color: Colors.white),),
                                                      Text("${vehicle.vehicleAge} old", style: const TextStyle(color: Colors.white),)
                                                    ],
                                                  )
                                            ],
                                          )),
                                        ),
                                      ))
                                  .toList())),
                );
                //       return  ListView.builder(
                //   itemBuilder: (context, index) {
                //     print(state);
                //     return Text("state data");
                //   },
                // );
              }
              if (state is VehicleFetchingError) {
                return const Center(
                  child: Text("Unable to Load Vehicle"),
                );
              }
              return const CircularProgressIndicator(
                color: Colors.black,
              );
            },
          )),
    );
  }
}
