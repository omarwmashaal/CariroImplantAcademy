import 'package:cariro_implant_academy/core/Http/httpRepo.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/clinicPricesModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/labPricesForDoctorModel.dart';
import 'package:cariro_implant_academy/core/features/settings/data/models/labSizesThresholdModel.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labPricesForDoctorEntity.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/entities/labSizesThresholdEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemCompanyModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labItemShadeModel.dart';
import 'package:cariro_implant_academy/features/labRequest/data/models/labOptionModel.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemCompanyEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemShadeEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labOptionEntity.dart';
import 'package:cariro_implant_academy/features/patient/data/models/roomModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/prosthetic/domain/enums/enum.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/data/models/treatmentItemModel.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/domain/entities/treatmentItemEntity.dart';

import '../../../../../features/labRequest/data/models/labItemParentModel.dart';
import '../../../../../features/labRequest/data/models/labItemModel.dart';
import '../../../../../features/labRequest/domain/entities/labItemParentEntity.dart';
import '../../../../../features/labRequest/domain/entities/labItemEntity.dart';
import '../../../../../features/patient/domain/entities/roomEntity.dart';
import '../../../../constants/enums/enums.dart';
import '../../../../constants/remoteConstants.dart';
import '../../../../data/models/BasicNameIdObjectModel.dart';
import '../../../../domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../error/exception.dart';
import '../../../../useCases/useCases.dart';
import '../../domain/entities/clinicPriceEntity.dart';
import '../../domain/entities/tacEntity.dart';
import '../../domain/useCases/addImplantsUseCase.dart';
import '../../domain/useCases/addMembranesUseCase.dart';
import '../models/ImplantModel.dart';
import '../models/membraneCompanyModel.dart';
import '../models/membraneModel.dart';
import '../models/tacCompanyModel.dart';

abstract class SettingsDatasource {
  Future<List<TacCompanyModel>> getTacs();

  Future<List<MembraneCompanyModel>> getMembraneCompanies();

  Future<List<MembraneModel>> getMembranes(int id);

  Future<List<BasicNameIdObjectModel>> getImplantCompanies();
  Future<List<BasicNameIdObjectModel>> getDefaultSurgicalComplications();
  Future<List<BasicNameIdObjectModel>> getDefaultProstheticComplications();

  Future<List<BasicNameIdObjectModel>> getImplantLines(int id);

  Future<List<ImplantModel>> getImplants(int id);

  Future<List<BasicNameIdObjectModel>> getIncomeCategories();

  Future<List<BasicNameIdObjectModel>> getExpensesCategories(Website website);

  Future<List<BasicNameIdObjectModel>> getPaymentMethods();

  Future<List<BasicNameIdObjectModel>> getMedicalExpensesCategories(Website website);

  Future<List<BasicNameIdObjectModel>> getNonMedicalNonStockExpensesCategories(Website website);

  Future<List<BasicNameIdObjectModel>> getNonMedicalStockCategories(Website website);

  Future<List<BasicNameIdObjectModel>> getStockCategories(Website website);

  Future<List<BasicNameIdObjectModel>> getSuppliers(Website website, bool medical);
  Future<List<LabSizesThresholdModel>> getLabThresholds(int parentId);

  Future<NoParams> changeImplantCompanyName(BasicNameIdObjectEntity value);
  Future<NoParams> updateDefaultSurgicalComplications(List<BasicNameIdObjectEntity> value);
  Future<NoParams> updateDefaultProstheticComplications(List<BasicNameIdObjectEntity> value);
  Future<NoParams> updateLabOptionsDoctorPriceList(List<LabPriceForDoctorEntity> data);

  Future<NoParams> changeImplantLineName(BasicNameIdObjectEntity value);

  Future<NoParams> addImplants(UpdateImplantsParams value);

  Future<NoParams> addImplantLines(BasicNameIdObjectEntity value);

  Future<NoParams> addImplantCompanies(String name);

  Future<NoParams> addMembranes(AddMembraneParams value);

  Future<NoParams> addTacsCompanies(List<TacCompanyEntity> model);

  Future<NoParams> addMembraneCompanies(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addExpensesCategories(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addIncomeCategories(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addSuppliers(List<BasicNameIdObjectEntity> model, bool medical);

  Future<NoParams> addStockCategories(List<BasicNameIdObjectEntity> model);

  Future<NoParams> addPaymentMethods(List<BasicNameIdObjectEntity> model);

  Future<NoParams> editRooms(List<RoomEntity> model);

  Future<NoParams> editTreatmentPrices(List<TreatmentItemEntity> prices);

  Future<List<ClinicPricesModel>> getTeethTreatmentPrices(List<int>? teeth, List<EnumClinicPrices>? category);

  Future<NoParams> updateTeethTreatmentPrices(List<ClinicPriceEntity> params);

  Future<List<LabItemParentModel>> getLabItemParents();
  Future<List<LabItemCompanyModel>> getLabItemCompanies(int id);
  Future<List<LabItemShadeModel>> getLabItemLines(int? parentId, int? companyId);
  Future<List<LabItemModel>> getLabItems(int? parentId, int? companyId, int? shadeId);
  Future<List<LabOptionModel>> getLabOptions(int? parentId, int? doctorId);
  Future<NoParams> updateLabItems(List<LabItemEntity> data);
  Future<NoParams> updateLabItemsShades(List<LabItemShadeEntity> data);
  Future<NoParams> updateLabItemsCompanies(List<LabItemCompanyEntity> data);
  Future<NoParams> updateLabItemsParents(List<LabItemParentEntity> data);
  Future<NoParams> updateLabOptions(List<LabOptionEntity> data);

  Future<List<BasicNameIdObjectEntity>> getProsthticItems(EnumProstheticType type);
  Future<List<BasicNameIdObjectEntity>> getProsthticNextVisit(EnumProstheticType type, int itemId);
  Future<List<BasicNameIdObjectEntity>> getProsthticTechnique(EnumProstheticType type, int itemId);
  Future<List<BasicNameIdObjectEntity>> getProsthticMaterial(EnumProstheticType type, int itemId);
  Future<List<BasicNameIdObjectEntity>> getProsthticStatus(EnumProstheticType type, int itemId);
  Future<NoParams> updateProstheticItems(EnumProstheticType type, List<BasicNameIdObjectEntity> data);
  Future<NoParams> updateProstheticNextVisit(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data);
  Future<NoParams> updateProstheticTechnique(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data);
  Future<NoParams> updateProstheticMaterial(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data);
  Future<NoParams> updateProstheticStatus(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data);
  Future<NoParams> updateLabThresholds(int parentId, List<LabSizesThresholdEntity> data);
}

class SettingsDatasourceImpl implements SettingsDatasource {
  final HttpRepo httpRepo;

  SettingsDatasourceImpl({required this.httpRepo});

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
  Future<List<BasicNameIdObjectModel>> getExpensesCategories(Website website) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getExpensesCategories?website=${website.index}");
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
  Future<List<BasicNameIdObjectModel>> getMedicalExpensesCategories(Website website) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getMedicalExpensesCategories?website=${website.index}");
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
  Future<List<BasicNameIdObjectModel>> getNonMedicalNonStockExpensesCategories(Website website) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getNonMedicalNonStockExpensesCategories?website=${website.index}");
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
  Future<List<BasicNameIdObjectModel>> getNonMedicalStockCategories(Website website) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getNonMedicalStockCategories?website=${website.index}");
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
  Future<List<BasicNameIdObjectModel>> getSuppliers(Website website, bool medical) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getSuppliers?website=${website.index}&medical=$medical");
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
  Future<NoParams> addSuppliers(List<BasicNameIdObjectEntity> model, bool medical) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/addSuppliers?medical=$medical",
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
  Future<NoParams> editTreatmentPrices(List<TreatmentItemEntity> prices) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/editTreatmentPrices",
        body: prices.map((e) => TreatmentItemModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<BasicNameIdObjectModel>> getStockCategories(Website website) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetStockCategories?website=${website.index}");
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
  Future<List<LabItemParentModel>> getLabItemParents() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetLabItemsParents");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => LabItemParentModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<BasicNameIdObjectEntity>> getProsthticItems(EnumProstheticType type) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetProstheticItems?type=${type.index}",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BasicNameIdObjectEntity>> getProsthticNextVisit(EnumProstheticType type, int itemId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetProstheticNextVist?type=${type.index}&itemId=$itemId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BasicNameIdObjectEntity>> getProsthticMaterial(EnumProstheticType type, int itemId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetProstheticMaterial?type=${type.index}&itemId=$itemId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BasicNameIdObjectEntity>> getProsthticTechnique(EnumProstheticType type, int itemId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetProstheticTechnique?type=${type.index}&itemId=$itemId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BasicNameIdObjectEntity>> getProsthticStatus(EnumProstheticType type, int itemId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetProstheticStatus?type=${type.index}&itemId=$itemId",
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return ((response.body ?? []) as List<dynamic>).map((e) => BasicNameIdObjectModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<NoParams> updateProstheticItems(EnumProstheticType type, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$settingsController/UpdateProstheticItems?type=${type.index}",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateProstheticNextVisit(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$settingsController/UpdateProstheticNextVisit?itemId=$itemId&type=${type.index}",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateProstheticTechnique(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$settingsController/UpdateProstheticTechnique?itemId=$itemId&type=${type.index}",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateProstheticMaterial(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$settingsController/UpdateProstheticMaterial?itemId=$itemId&type=${type.index}",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateProstheticStatus(EnumProstheticType type, int itemId, List<BasicNameIdObjectEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(
        host: "$serverHost/$settingsController/UpdateProstheticStatus?itemId=$itemId&type=${type.index}",
        body: data.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<LabItemCompanyModel>> getLabItemCompanies(int id) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getLabItemCompanies?id=$id");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => LabItemCompanyModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<LabItemShadeModel>> getLabItemLines(int? parentId, int? companyId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
          host:
              "$serverHost/$settingsController/GetLabItemShades?${parentId != null ? "parentId=$parentId" : ""}&${companyId != null ? "companyId=$companyId" : ""}");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => LabItemShadeModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<List<LabItemModel>> getLabItems(int? parentId, int? companyId, int? shadeId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
          host:
              "$serverHost/$settingsController/getLabItems?${parentId != null ? "parentId=$parentId" : ""}&${companyId != null ? "companyId=$companyId" : ""}&${shadeId != null ? "shadeId=$shadeId" : ""}");
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
  Future<NoParams> updateLabItems(List<LabItemEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItems?",
        body: data.map((e) => LabItemModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabItemsCompanies(List<LabItemCompanyEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItemCompanies",
        body: data.map((e) => LabItemCompanyModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabItemsShades(List<LabItemShadeEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItemShades",
        body: data.map((e) => LabItemShadeModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabItemsParents(List<LabItemParentEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabItemParents",
        body: data.map((e) => LabItemParentModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<LabOptionModel>> getLabOptions(int? parentId, int? doctorId) async {
    late StandardHttpResponse response;
    String query = "";
    query += parentId == null ? "" : (query == "" ? "" : "&") + "parentId=$parentId";
    query += doctorId == null ? "" : (query == "" ? "" : "&") + "userId=$doctorId";
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/GetLabOptions?$query");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => LabOptionModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updateLabOptions(List<LabOptionEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabOptions",
        body: data.map((e) => LabOptionModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<BasicNameIdObjectModel>> getDefaultSurgicalComplications() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetSurgicalComplications",
      );
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
  Future<NoParams> updateDefaultSurgicalComplications(List<BasicNameIdObjectEntity> value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateSurgicalComplications",
        body: value.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<BasicNameIdObjectModel>> getDefaultProstheticComplications() async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(
        host: "$serverHost/$settingsController/GetProstheticComplications",
      );
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
  Future<NoParams> updateDefaultProstheticComplications(List<BasicNameIdObjectEntity> value) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateProstheticComplications",
        body: value.map((e) => BasicNameIdObjectModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<NoParams> updateLabOptionsDoctorPriceList(List<LabPriceForDoctorEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/UpdateLabOptionsDoctorPriceList",
        body: data.map((e) => LabPriceForDoctorModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }

  @override
  Future<List<LabSizesThresholdModel>> getLabThresholds(int parentId) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.get(host: "$serverHost/$settingsController/getLabThresholds?parentId=$parentId");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    try {
      return ((response.body ?? []) as List<dynamic>).map((e) => LabSizesThresholdModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw DataConversionException(message: "Couldn't convert data");
    }
  }

  @override
  Future<NoParams> updateLabThresholds(int parentId, List<LabSizesThresholdEntity> data) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.put(
        host: "$serverHost/$settingsController/updateLabThresholds?parentId=$parentId",
        body: data.map((e) => LabSizesThresholdModel.fromEntity(e).toJson()).toList(),
      );
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode, message: response.errorMessage);
    return NoParams();
  }
}
