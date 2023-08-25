import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_States.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../core/domain/entities/notificationEntity.dart';
import '../core/domain/useCases/getNotificationsUseCase.dart';

class AppBarBloc extends Bloc<AppBarBlocEvents, AppBarBlocState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  List<NotificationEntity> notifications = [];

  AppBarBloc({required this.getNotificationsUseCase}) : super(AppBarInitialState()) {
    on<AppBarGetNotificationsEvent>(
      (event, emit) async {
        final result = await getNotificationsUseCase(NoParams());
        result.fold(
          (l) {
            print("Notifications error $l");
          },
          (r) {
            notifications = r;
            if (notifications.firstWhereOrNull((element) => element.read == false) != null) {
              emit(AppBarNewNotificationState(notifications: r));
            }
            else emit(AppBarNotificationsLoadedState(notifications: r));
          },
        );
      },
    );
    on<AppBarChangeAppBarEvent>(
      (event, emit) {
        emit(AppBarChangedState(newAppBar: event.newAppBar));
      },
    );

    on<AppBarRemoveAppBarEvent>(
      (event, emit) {
        emit(AppBarChangedState());
      },
    );
  }
}
