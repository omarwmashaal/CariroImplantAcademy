import 'package:cariro_implant_academy/Widgets/AppBarBloc_Events.dart';
import 'package:cariro_implant_academy/Widgets/AppBarBloc_States.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/usecases/deleteNotificationsUseCase.dart';
import 'package:cariro_implant_academy/core/features/notification/domain/usecases/markAllNotificationsAsReadUseCase.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../core/features/notification/domain/entities/notificationEntity.dart';
import '../core/features/notification/domain/usecases/getNotificationsUseCase.dart';

class AppBarBloc extends Bloc<AppBarBlocEvents, AppBarBlocState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAllNotificationsAsReadUseCase markAllNotificationsAsReadUseCase;
  final DeleteNotificationsUseCase deleteNotificationsUseCase;
  List<NotificationEntity> notifications = [];

  AppBarBloc({
    required this.getNotificationsUseCase,
    required this.markAllNotificationsAsReadUseCase,
    required this.deleteNotificationsUseCase,
  }) : super(AppBarInitialState()) {
    on<AppBarGetNotificationsEvent>(
      (event, emit) async {
        emit(AppBarLoadingNotificationsState());
        final result = await getNotificationsUseCase(NoParams());
        result.fold(
          (l) {
            emit(AppBarLoadingNotificationsErrorState(message: l.message ?? ""));
          },
          (r) {
            notifications = r;
            if (notifications.firstWhereOrNull((element) => element.read == false) != null) {
              emit(AppBarNewNotificationState(notifications: r));
            } else
              emit(AppBarNotificationsLoadedState(notifications: r));
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
    on<AppBarMarkAllNotificationsAsReadEvent>(
      (event, emit) async {
        final result = await markAllNotificationsAsReadUseCase(NoParams());
        result.fold((l) => emit(AppBarMarkedNotificationsAsReadErrorState(message: l.message ?? "")), (r) => emit(AppBarMarkedNotificationsAsReadState()));
      },
    );
    on<AppBarDeleteNotificationEvent>(
      (event, emit) async {
        emit(AppBarDeletingNotificationsState());
        final result = await deleteNotificationsUseCase(event.id);
        result.fold(
          (l) => emit(AppBarDeletingNotificationsErrorState(message: l.message ?? "")),
          (r) => emit(AppBarDeletedNotificationsSuccessfullyState()),
        );
      },
    );
  }
}
