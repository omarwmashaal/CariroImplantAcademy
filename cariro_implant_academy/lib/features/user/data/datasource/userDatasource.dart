import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/features/patient/data/models/visitModel.dart';
import 'package:cariro_implant_academy/features/user/data/candidateDetailsModel.dart';
import 'package:cariro_implant_academy/features/user/data/models/userModel.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../core/constants/remoteConstants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/useCases/useCases.dart';
import '../../../patient/domain/entities/advancedPatientSearchEntity.dart';
import '../../../patient/domain/entities/visitEntity.dart';
import '../../domain/entities/userEntity.dart';

abstract class UserDatasource {
  Future<UserModel> getUserData({required int id});

  Future<List<UserModel>> searchUsersByRole({required String role, String? search, int? batch, Website? accessWebsites});
  Future<List<UserModel>> searchUsersByWorkPlace(String? search, Website source);

  Future<NoParams> updateUserInfo(int id, UserEntity userData);
  Future<List<CandidateDetailsModel>> getCandidateDetails(int id, DateTime? from, DateTime? to);

  Future<NoParams> changeRole(int id, String role);
  Future<NoParams> removeUser(int id);
  Future<NoParams> refreshCandidatesData(int? batchId);

  Future<NoParams> resetPassword({required String newPassword1, required String newPassword2, required String oldPassword});

  Future<List<VisitModel>> getSessionsDurations(DateTime? from, DateTime? to, int id);
}

class UserDatasourceImpl extends UserDatasource {
  final HttpRepo httpRepo;

  UserDatasourceImpl({required this.httpRepo});

  @override
  Future<UserModel> getUserData({required int id}) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$userController/GetUserData?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return UserModel.fromJson(response.body! as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<UserModel>> searchUsersByRole({required String role, String? search, int? batch, Website? accessWebsites}) async {
    late StandardHttpResponse response;
    try {
      search = search == "" ? null : search;
      String query = "";
      query += "${query == "" ? "" : "${role == null ? "" : "&"}"}${role == null ? "" : "role=$role"}";
      query += "${query == "" ? "" : "${search == null ? "" : "&"}"}${search == null ? "" : "search=$search"}";
      query += "${query == "" ? "" : "${batch == null ? "" : "&"}"}${batch == null ? "" : "batch=$batch"}";
      query +=
          "${query == "" ? "" : "${accessWebsites == null ? "" : "&"}"}${accessWebsites == null ? "" : "accessWebsites=${accessWebsites!.index}"}";
      response = await httpRepo.get(host: "$serverHost/$userController/SearchUsersByRole?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updateUserInfo(int id, UserEntity userData) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(host: "$serverHost/$userController/UpdateUserInfo?id=$id", body: UserModel.fromEntity(userData).toJson());
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> resetPassword({required String newPassword1, required String newPassword2, required String oldPassword}) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$authenticationController/ResetPassword?newPassword1=$newPassword1&newPassword2=$newPassword2&oldPassword=$oldPassword",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<VisitModel>> getSessionsDurations(DateTime? from, DateTime? to, int id) async {
    late StandardHttpResponse response;
    String query = "id=$id";
    if (from != null) query += "${query == "" ? "" : "&"}from=${DateFormat("yyyy-MM-dd").format(from)}";
    if (to != null) query += "${query == "" ? "" : "&"}to=${DateFormat("yyyy-MM-dd").format(to)}";

    try {
      response = await httpRepo.get(
        host: "$serverHost/$userController/GetSessionsDurations?$query",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => VisitModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> changeRole(int id, String role) async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.put(
        host: "$serverHost/$userController/ChangeRole?id=$id&role=$role",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<UserModel>> searchUsersByWorkPlace(String? search, Website source) async {
    late StandardHttpResponse response;
    try {
      search = search == "" ? null : search;
      String query = "source=${source.index}&";
      query += "${query == "" ? "" : "${search == null ? "" : "&"}"}${search == null ? "" : "search=$search"}";
      response = await httpRepo.get(host: "$serverHost/$userController/searchUsersByWorkPlace?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<CandidateDetailsModel>> getCandidateDetails(int id, DateTime? from, DateTime? to) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
          host:
              "$serverHost/$userController/GetCandidateDetails?id=$id${from == null ? "" : "&from=${DateFormat("MM-dd-yyyy").format(from)}"}${to == null ? "" : "&to=${DateFormat("MM-dd-yyyy").format(to)}"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return response.body == null ? [] : (response.body as List<dynamic>).map((e) => CandidateDetailsModel.fromMap(e)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> removeUser(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.delete(host: "$serverHost/$userController/RemoveUser?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> refreshCandidatesData(int? batchId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$userController/RefreshAllCandidatesData?${batchId == null ? "" : "batchId=$batchId"}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
