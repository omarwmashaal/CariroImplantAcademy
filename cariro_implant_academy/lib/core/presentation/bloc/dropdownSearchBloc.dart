import 'package:cariro_implant_academy/core/domain/entities/BasicNameIdObjectEntity.dart';
import 'package:cariro_implant_academy/core/useCases/useCases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DropDownBlocStates {}

class DropDownSearchBloc extends Cubit<DropDownBlocStates> {
  DropDownSearchBloc(super.initialState);

  Future<List<BasicNameIdObjectEntity>> searchString<T>(T params, UseCases useCase) async {
    final result = await useCase(params);
    return result.fold((l) => [], (r) => r);
  }

}
