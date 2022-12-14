import 'package:currentlocation_with_bloc/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Location With Bloc"))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<GeolocationBloc>().add(updateText());
        },
        child: const Icon(Icons.location_on),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GeolocationBloc, GeolocationState>(
          builder: (context, state) {
            if (state is GeolocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GeolocationLoaded) {
              try {
                return Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Latitude : ${state.position.latitude}"),
                    Text("Longitude : ${state.position.longitude}")
                  ],
                ));
              } catch (e) {
                return Text(e.toString());
              }
            } else {
              return const Text("Something wrong");
            }
          },
        ),
      ),
    );
  }
}
