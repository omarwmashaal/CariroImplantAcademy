import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/clinicPricesModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/treatmentPricesModel.dart';
import 'package:cariro_implant_academy/features/patient/data/models/roomModel.dart';

import '../../../../../features/labRequest/data/models/labItemModel.dart';
import '../../../../../features/labRequest/domain/entities/labItemEntity.dart';
import '../../../../../features/patient/domain/entities/roomEntity.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../constants/remoteConstants.dart';
import '../../../../data/models/BasicNameIdObjectModel.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../error/exception.dart';
import '../../../../useCases/useCases.dart';
import '../../domain/entities/clinicPriceEntity.dart';
import '../../domain/entities/implantEntity.dart';
import '../../domain/entities/membraneCompanyEnity.dart';
import '../../domain/entities/tacEntity.dart';
import '../../domain/entities/treatmentPricesEntity.dart';
import '../../domain/useCases/addImplantsUseCase.dart';
import '../../domain/useCases/addMembranesUseCase.dart';
import '../models/ImplantModel.dart';
import '../models/membraneCompanyModel.dart';
import '../models/membraneModel.dart';
import '../models/tacCompanyModel.dart';

abstract class SettingsDatasource {
  Future<TreatmentPricesModel> getTreatmentPrices();

  Future<List<TacCompanyModel>> getTacs();

  Future<List<MembraneCompanyModel>> getMembraneCompanies();

  Future<List<MembraneModel>> getMembranes(int id);

  Future<List<BasicNameIdObjectModel>> getImplantCompanies();

  Future<List<BasicNameIdObjectModel>> getImplantLines(int id);

  Future<List<ImplantModel>> getImplants(int id);

  Future<List<BasicNameIdObjectModel>> getIncomeCategories();

  Future<List<BasicNameIdObjectModel>> getExpensesCategories();

  Future<List<BasicNameIdObjectModel>> getPaymentMethods();

  Future<List<BasicNameIdObjectModel>> getMedicalExpensesCategories();

  Future<List<BasicNameIdObjectModel>> getNonMedicalNonStockExpensesCategories();

  Future<List<BasicNameIdObjectModel>> getNonMedicalStockCategories();

  Future<List<BasicNameIdObjectModel>> getStockCategories();

  Future<List<BasicNameIdObjectModel>> getSuppliers();

  Future<NoParams> changeImplantCompanyName(BasicNameIdObjectEntity value);

  Future<NoParams> changeImplantLineName(BasicNameIdObjectEntity value);

  Future<NoParams> addImplants(UpdateImplantsParams value);

  Future<NoParams> addImplantLines(BasicNameIdObjectEntity value);

  Future<NoParams> addImplantCompanies(String name);

  Future<NoParams> addMembranes(AddMembraneParams value);

  Future<NoParams> addTacsCompanies(List<TacCompanyEntity> model);

  Future<NoParams> addMembraneCompanies(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addExpensesCategories(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addIncomeCategories(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addSuppliers(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addStockCategories(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addPaymentMethods(List<BasicNameIdObjectEntity> model);

  Future<NoParams> editRooms(List<RoomEntity> model);

  Future<NoParams> editTreatmentPrices(TreatmentPricesEntity prices);

  Future<List<ClinicPricesModel>> getTeethTreatmentPrices(List<int>? teeth, List<EnumClinicPrices>? category);

  Future<NoParams> updateTeethTreatmentPrices(List<ClinicPriceEntity> params);

  Future<List<BasicNameIdObjectModel>> getLabItemParents();

  Future<List<BasicNameIdObjectModel>> getLabItemCompanies(int id);

  Future<List<BasicNameIdObjectModel>> getLabItemLines(int id);

  Future<List<LabItemModel>> getLabItems(int id);

  Future<NoParams> updateLabItems(int shadeId, List<LabItemEntity> data);

  Future<NoParams> updateLabItemsShades(int companyId, List<BasicNameIdObjectEntity> data);

  Future<NoParams> updateLabItemsCompanies(int parentItemId, List<BasicNameIdObjectEntity> data);
}

class SettingsDatasourceImpl implements SettingsDatasource {
  final HttpRepo httpRepo;

  SettingsDatasourceImpl({required this.httpRepo});

  @override
  Future<TreatmentPricesModel> getTreatmentPrices() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetTreatmentPrices");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return TreatmentPricesModel.fromJson(response.body as Map<String, dynamic>);
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getImplantCompanies() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetImplantCompanies");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getImplantLines(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetImplantLines?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<ImplantModel>> getImplants(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetImplants?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => ImplantModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<MembraneCompanyModel>> getMembraneCompanies() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetMembraneCompanies");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => MembraneCompanyModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<TacCompanyModel>> getTacs() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetTacsCompanies");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => TacCompanyModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<MembraneModel>> getMembranes(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetMembranes?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => MembraneModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getExpensesCategories() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getExpensesCategories");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getIncomeCategories() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getIncomeCategories");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getPaymentMethods() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getPaymentMethods");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getMedicalExpensesCategories() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getMedicalExpensesCategories");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getNonMedicalNonStockExpensesCategories() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getNonMedicalNonStockExpensesCategories");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getNonMedicalStockCategories() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getNonMedicalStockCategories");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getSuppliers() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getSuppliers");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> addExpensesCategories(List<BasicNameIdObjectEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/addExpensesCategories",
        body: model.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addImplantCompanies(String name) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/ImplantCompanies?name=$name",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addImplantLines(BasicNameIdObjectEntity value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(host: "$serverHost/$settingsController/implantLines?id=${value.id}&name=${value.name}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addImplants(UpdateImplantsParams value) async {
    late StandardHttpResponse response;

    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/implants?id=${value.lineId}",
        body: value.data.map((e) => ImplantModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addIncomeCategories(List<BasicNameIdObjectEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/addIncomeCategories",
        body: model.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addMembraneCompanies(List<BasicNameIdObjectEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/AddMembraneCompanies",
        body: model.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addMembranes(AddMembraneParams value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/AddMembranes?id=${value.companyId}",
        body: value.data.map((e) => MembraneModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addPaymentMethods(List<BasicNameIdObjectEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/AddPaymentMethods",
        body: model.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addStockCategories(List<BasicNameIdObjectEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/addStockCategories",
        body: model.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addSuppliers(List<BasicNameIdObjectEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/addSuppliers",
        body: model.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> addTacsCompanies(List<TacCompanyEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/addTacsCompanies",
        body: model.map((e) => TacCompanyModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> changeImplantCompanyName(BasicNameIdObjectEntity value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(host: "$serverHost/$settingsController/changeImplantCompanyName?id=${value.id}&name=${value.name}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> changeImplantLineName(BasicNameIdObjectEntity value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(host: "$serverHost/$settingsController/changeImplantLineName?id=${value.id}&name=${value.name}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> editRooms(List<RoomEntity> model) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/editRooms",
        body: model.map((e) => RoomModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> editTreatmentPrices(TreatmentPricesEntity prices) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/editTreatmentPrices",
        body: TreatmentPricesModel.fromEntity(prices).toJson(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<BasicNameIdObjectModel>> getStockCategories() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetStockCategories");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<ClinicPricesModel>> getTeethTreatmentPrices(List<int>? teeth, List<EnumClinicPrices>? category) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$settingsController/getTeethTreatmentPrices?",
        body: {
          "teeth": teeth,
          "category": category?.map((e) => e.index).toList(),
        },
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => ClinicPricesModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updateTeethTreatmentPrices(List<ClinicPriceEntity> params) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/updateTeethTreatmentPrices",
        body: params.map((e) => ClinicPricesModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<BasicNameIdObjectModel>> getLabItemParents() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetLabItemsParents");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getLabItemCompanies(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getLabItemCompanies?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectModel>> getLabItemLines(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getLabItemLines?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<LabItemModel>> getLabItems(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getLabItems?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => LabItemModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updateLabItems(int shadeId, List<LabItemEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItems?id=$shadeId",
        body: data.map((e) => LabItemModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabItemsCompanies(int parentItemId, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItemCompanies?id=$parentItemId",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabItemsShades(int companyId, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItemShades?id=$companyId",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
