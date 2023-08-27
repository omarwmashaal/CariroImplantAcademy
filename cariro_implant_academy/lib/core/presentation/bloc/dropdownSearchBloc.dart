import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCases/loadUsersUseCase.dart';

class DropDownBlocStates {}

class DropDownSearchBloc extends Cubit<DropDownBlocStates> {
  DropDownSearchBloc(super.initialState);

  Future<List<BasicNameIdObjectEntity>> searchString(LoadParams params, UseCases<List<BasicNameIdObjectEntity>, LoadParams> useCase) async {
    final result = await useCase(params);
    return result.fold((l) => [], (r) => r);
  }
}
