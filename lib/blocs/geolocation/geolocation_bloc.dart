import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:currentlocation_with_bloc/repositories/geolocation/geolocation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository = GeolocationRepository();
  StreamSubscription? _getStreamSubscription;

  GeolocationBloc({required GeolocationRepository geolocationRepository})
      : super(GeolocationLoading()) {
    on<LoadGeolocation>((event, emit) async {
      _getStreamSubscription?.cancel();

      final Position position =
          await _geolocationRepository.getCurrentLocation();
      add(UpdateGeolocation(position: position));
    });

    on<UpdateGeolocation>((event, emit) async {
      emit(GeolocationLoaded(position: event.position));
    });

    on<updateText>((event, emit) async {
      emit(GeolocationLoading());
      final Position position2 =
          await _geolocationRepository.getCurrentLocation();
      add(UpdateGeolocation(position: position2));
    });
  }

  Future<void> close() {
    _getStreamSubscription?.cancel();
    return super.close();
  }
}
