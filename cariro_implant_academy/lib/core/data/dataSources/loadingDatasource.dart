import 'package:cariro_implant_academy/core/data/models/BasicNameIdObjectModel.dart';

import '../../Http/httpRepo.dart';
import '../../constants/remoteConstants.dart';
import '../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../domain/useCases/loadUsersUseCase.dart';
import '../../error/exception.dart';

abstract class LoadingDatasource {
  Future<List<BasicNameIdObjectEntity>> loadUsers({required LoadUsersEnum userType, required String query});
}

class LoadingDataSourceImpl implements LoadingDatasource {
  final HttpRepo httpRepo;

  LoadingDataSourceImpl({required this.httpRepo});

  @override
  Future<List<BasicNameIdObjectEntity>> loadUsers({required LoadUsersEnum userType, required String query}) async {
    late StandardHttpResponse response;
    String searchHost = "";
    switch (userType) {
      case LoadUsersEnum.admins:
        searchHost = "LoadAdmins";
        break;
      case LoadUsersEnum.instructors:
        searchHost = "LoadInstructors";
        break;
      case LoadUsersEnum.assistants:
        searchHost = "LoadAssistants";
        break;
      case LoadUsersEnum.instructorsAndAssistants:
        searchHost = "LoadInstructorsAndAssistants";
        break;
      case LoadUsersEnum.supervisors:
        searchHost = "LoadSupervisors";
        break;
      default:
        searchHost = "";
    }
    try {
      response = await httpRepo.get(host: "$serverHost/$userController/$searchHost");
    } catch (e) {
      throw HttpInternalServerErrorException();
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    try {
      return response.body==null?[]:(response.body as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String,dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }
}
