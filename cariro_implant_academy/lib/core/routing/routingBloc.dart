import 'package:cariro_implant_academy/core/routing/routing_Bloc_Events.dart';
import 'package:cariro_implant_academy/core/routing/routing_Bloc_Status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RoutingBloc extends Bloc<RoutingBlocEvents, RoutingBlocStatus> {
  RoutingBloc() : super(RoutingBlocStatus_Init()) {
    on<RoutingBlocEvent_UnAuthorized>(
      (event, emit) {
        emit(RoutingBlocStatus_UnAuthorized());
      },
    );
  }
}
