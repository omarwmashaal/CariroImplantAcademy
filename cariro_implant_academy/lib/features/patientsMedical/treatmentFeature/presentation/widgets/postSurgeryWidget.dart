import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/presentation/widgets/LoadingWidget.dart';
import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
import 'package:cariro_implant_academy/presentation/widgets/bigErrorPageWidget.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';

import '../../../../../Widgets/CIA_DropDown.dart';
import '../../../../../Widgets/CIA_TextFormField.dart';
import '../../../../../Widgets/FormTextWidget.dart';
import '../../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../../core/features/settings/domain/entities/membraneEnity.dart';
import '../../../../../core/features/settings/domain/entities/tacEntity.dart';
import '../../../../../core/features/settings/domain/useCases/getMembraneCompaniesUseCase.dart';
import '../../../../../core/features/settings/domain/useCases/getMembranesUseCase.dart';
import '../../../../../core/features/settings/domain/useCases/getTacsUseCase.dart';
import '../../../../../core/injection_contianer.dart';
import '../../domain/entities/postSurgicalTreatmentEntity.dart';
import '../bloc/treatmentBloc.dart';
import '../bloc/treatmentBloc_States.dart';

class PostSurgeryWidget extends StatefulWidget {
  PostSurgeryWidget({
    Key? key,
    required this.postSurgeryId,
    required this.onLoaded,
    required this.onChange,
  }) : super(key: key);
  int postSurgeryId;
  Function(PostSurgicalTreatmentEntity postSurgeryData) onLoaded;
  Function(int screws, int? membraneId, int tacsNumber, int? tacCompanyId) onChange;

  @override
  State<PostSurgeryWidget> createState() => _PostSurgeryWidgetState();
}

class _PostSurgeryWidgetState extends State<PostSurgeryWidget> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  late TreatmentBloc bloc;
  int screws = 0;
  int? membraneId;
  int tacsNumber = 0;
  int? tacCompanyId;
  @override
  void initState() {
    bloc = BlocProvider.of<TreatmentBloc>(context);
    bloc.add(TreatmentBloc_GetTacsEvent());
    bloc.add(TreatmentBloc_GetPostSurgicalTreatmentDataEvent(id: widget.postSurgeryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
    return BlocConsumer<TreatmentBloc, TreatmentBloc_States>(
      listener: (context, state) {
        if (state is TreatmentBloc_SavingPostSurgicalTreatmentDataState)
          CustomLoader.show(context);
        else {
          CustomLoader.hide();
          if (state is TreatmentBloc_SavingPostSurgicalTreatmentDataErrorState)
            ShowSnackBar(context, isSuccess: false, message: state.message);
          else if (state is TreatmentBloc_SavedPostSurgicalTreatmentDataSuccessfullyState) dialogHelper.dismissAll(context);
        }
      },
      buildWhen: (previous, current) =>
          current is TreatmentBloc_LoadingPostSurgicalTreatmentDataState ||
          current is TreatmentBloc_LoadingPostSurgicalTreatmentDataErrorState ||
          current is TreatmentBloc_LoadedPostSurgicalTreatmentDataSuccessfullyState,
      builder: (context, state) {
        if (state is TreatmentBloc_LoadingPostSurgicalTreatmentDataState)
          return LoadingWidget();
        else if (state is TreatmentBloc_LoadingPostSurgicalTreatmentDataErrorState)
          return BigErrorPageWidget(message: state.message);
        else if (state is TreatmentBloc_LoadedPostSurgicalTreatmentDataSuccessfullyState) {
          var postSurgeryData = state.data;
          screws = postSurgeryData.guidedBoneRegenerationCutByScrewsNumber ?? 0;
          tacCompanyId = postSurgeryData.openSinusLift_TacsCompanyID;
          tacsNumber = postSurgeryData.openSinusLiftTacsNumber ?? 0;
          membraneId = postSurgeryData.openSinusLift_MembraneID;
          widget.onLoaded(postSurgeryData);
          widget.onChange(screws, membraneId, tacsNumber, tacCompanyId);
          return DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    child: TabBar(
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          text: "Suture & Temporization & X-ray",
                        ),
                        Tab(
                          text: "Guided Bone Regeneration",
                        ),
                        Tab(
                          text: "Open Sinus Lift",
                        ),
                        Tab(
                          text: "Soft Tissue Graft",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          key: GlobalKey(),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            CIA_TextFormField(
                              label: "Notes",
                              controller: TextEditingController(text: postSurgeryData.notesSuture),
                              onChange: (v) => postSurgeryData.notesSuture = v,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Suture Size")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_MultiSelectChipWidget(
                                    key: GlobalKey(),
                                    onChange: (item, isSelected) {
                                      switch (item) {
                                        case "3-0":
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize30 = isSelected;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize40 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize50 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize60 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize70 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                          break;
                                        case "4-0":
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize30 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize40 = isSelected;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize50 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize60 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize70 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                          break;
                                        case "5-0":
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize30 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize40 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize50 = isSelected;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize60 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize70 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                          break;
                                        case "6-0":
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize30 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize40 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize50 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize60 = isSelected;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize70 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                          break;
                                        case "7-0":
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize30 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize40 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize50 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize60 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize70 = isSelected;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                          break;
                                        case "Implant Subcrestal":
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize30 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize40 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize50 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize60 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSize70 = false;
                                          postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    singleSelect: true,
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "3-0", isSelected: postSurgeryData.sutureAndTemporizationAndXRaySutureSize30!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "4-0", isSelected: postSurgeryData.sutureAndTemporizationAndXRaySutureSize40!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "5-0", isSelected: postSurgeryData.sutureAndTemporizationAndXRaySutureSize50!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "6-0", isSelected: postSurgeryData.sutureAndTemporizationAndXRaySutureSize60!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "7-0", isSelected: postSurgeryData.sutureAndTemporizationAndXRaySutureSize70!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Implant Subcrestal",
                                          isSelected: postSurgeryData.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Suture Material")),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          onChangeList: (p0) {
                                            postSurgeryData.sutureAndTemporizationAndXRayMaterialVicryl = p0.contains("Vicryl");
                                            postSurgeryData.sutureAndTemporizationAndXRayMaterialProline = p0.contains("Proline");
                                            postSurgeryData.sutureAndTemporizationAndXRayMaterialXRay = p0.contains("X-ray");
                                            setState(() {});
                                          },
                                          singleSelect: true,
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Vicryl", isSelected: postSurgeryData.sutureAndTemporizationAndXRayMaterialVicryl!),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Proline", isSelected: postSurgeryData.sutureAndTemporizationAndXRayMaterialProline!),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "X-ray", isSelected: postSurgeryData.sutureAndTemporizationAndXRayMaterialXRay!),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Suture Technique",
                                          onChange: (value) {
                                            postSurgeryData.sutureAndTemporizationAndXRayMaterialSutureTechnique = value;
                                          },
                                          controller: TextEditingController(
                                            text: postSurgeryData.sutureAndTemporizationAndXRayMaterialSutureTechnique ?? "",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Temporary")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_MultiSelectChipWidget(
                                    onChange: (item, isSelected) {
                                      switch (item) {
                                        case "Healing Collar":
                                          postSurgeryData.sutureAndTemporizationAndXRayTemporaryHealingCollar = isSelected;
                                          break;
                                        case "Customized Healling Collar":
                                          postSurgeryData.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar = isSelected;
                                          break;
                                        case "Crown":
                                          postSurgeryData.sutureAndTemporizationAndXRayTemporaryCrown = isSelected;
                                          break;
                                        case "Maryland Bridge":
                                          postSurgeryData.sutureAndTemporizationAndXRayTemporaryMarylandBridge = isSelected;
                                          break;
                                        case "Bridge on teeth":
                                          postSurgeryData.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = isSelected;
                                          break;
                                        case "Denture with glass fiber":
                                          postSurgeryData.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Healing Collar", isSelected: postSurgeryData.sutureAndTemporizationAndXRayTemporaryHealingCollar!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Customized Healling Collar",
                                          isSelected: postSurgeryData.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Crown", isSelected: postSurgeryData.sutureAndTemporizationAndXRayTemporaryCrown!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Maryland Bridge",
                                          isSelected: postSurgeryData.sutureAndTemporizationAndXRayTemporaryMarylandBridge!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Bridge on teeth", isSelected: postSurgeryData.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Denture with glass fiber",
                                          isSelected: postSurgeryData.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            CIA_TextFormField(
                              label: "Notes",
                              controller: TextEditingController(text: postSurgeryData.notesGBR),
                              onChange: (v) => postSurgeryData.notesGBR = v,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Block Graft")),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          onChange: (item, isSelected) {
                                            switch (item) {
                                              case "Chin":
                                                postSurgeryData.guidedBoneRegenerationBlockGraftChin = isSelected;
                                                break;
                                              case "Ramus":
                                                postSurgeryData.guidedBoneRegenerationBlockGraftRamus = isSelected;
                                                break;
                                              case "Tuberosity":
                                                postSurgeryData.guidedBoneRegenerationBlockGraftTuberosity = isSelected;
                                                break;
                                            }
                                            setState(() {});
                                          },
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Chin", isSelected: postSurgeryData.guidedBoneRegenerationBlockGraftChin!),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Ramus", isSelected: postSurgeryData.guidedBoneRegenerationBlockGraftRamus!),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Tuberosity", isSelected: postSurgeryData.guidedBoneRegenerationBlockGraftTuberosity!),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Other Specify",
                                          onChange: (value) {
                                            postSurgeryData.guidedBoneRegenerationBlockGraftOther = value;
                                          },
                                          controller: TextEditingController(text: postSurgeryData.guidedBoneRegenerationBlockGraftOther ?? ""),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Cut By")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_MultiSelectChipWidget(
                                    onChange: (item, isSelected) {
                                      switch (item) {
                                        case "Disc":
                                          postSurgeryData.guidedBoneRegenerationCutByDisc = isSelected;
                                          break;
                                        case "Piezo":
                                          postSurgeryData.guidedBoneRegenerationCutByPiezo = isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "Disc", isSelected: postSurgeryData.guidedBoneRegenerationCutByDisc!),
                                      CIA_MultiSelectChipWidgeModel(label: "Piezo", isSelected: postSurgeryData.guidedBoneRegenerationCutByPiezo!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Screws")),
                                Expanded(
                                  flex: 2,
                                  child: CIA_TextFormField(
                                    label: "No of screws",
                                    onChange: (value) {
                                      postSurgeryData.guidedBoneRegenerationCutByScrewsNumber = int.parse(value);
                                      screws = postSurgeryData.guidedBoneRegenerationCutByScrewsNumber ?? 0;
                                    },
                                    isNumber: true,
                                    controller: TextEditingController(
                                      text: (postSurgeryData.guidedBoneRegenerationCutByScrewsNumber ?? 0).toString(),
                                    ),
                                  ),
                                ),
                                Expanded(flex: 2, child: SizedBox())
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Bone Particle")),
                                Expanded(
                                  flex: 4,
                                  child: StatefulBuilder(builder: (context, _setSatate) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: CIA_TextFormField(
                                            label: "Autogenous %",
                                            suffix: "%",
                                            isNumber: true,
                                            onChange: (value) {
                                              postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous = int.parse(value);
                                              if (postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous! > 100)
                                                postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous = 100;
                                              postSurgeryData.guidedBoneRegenerationBoneParticle100Xenograft =
                                                  100 - (postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous ?? 0);

                                              _setSatate(() {});
                                            },
                                            validator: (value) {
                                              if (int.parse(value) > 100) {
                                                postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous = 100;
                                                postSurgeryData.guidedBoneRegenerationBoneParticle100Xenograft =
                                                    100 - (postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous ?? 0);

                                                return "100";
                                              }
                                              return value;
                                            },
                                            controller: TextEditingController(
                                              text: (postSurgeryData.guidedBoneRegenerationBoneParticle100Autogenous ?? 0).toString(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: CIA_TextFormField(
                                            enabled: false,
                                            label: "Xenograft %",
                                            suffix: "%",
                                            isNumber: true,
                                            controller: TextEditingController(
                                              text: (postSurgeryData.guidedBoneRegenerationBoneParticle100Xenograft ?? 0).toString(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(child: SizedBox()),
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "ACM Bur")),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Area",
                                          onChange: (value) {
                                            postSurgeryData.guidedBoneRegenerationACMBurArea = value;
                                          },
                                          controller: TextEditingController(
                                            text: postSurgeryData.guidedBoneRegenerationACMBurArea ?? "",
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Notes",
                                          onChange: (value) {
                                            postSurgeryData.guidedBoneRegenerationACMBurNotes = value;
                                          },
                                          controller: TextEditingController(
                                            text: postSurgeryData.guidedBoneRegenerationACMBurNotes ?? "",
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            CIA_TextFormField(
                              label: "Notes",
                              controller: TextEditingController(text: postSurgeryData.notesOSL),
                              onChange: (v) => postSurgeryData.notesOSL = v,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Approach")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "",
                                    onChange: (value) {
                                      postSurgeryData.openSinusLiftApproachString = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.openSinusLiftApproachString ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Fill Material")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "",
                                    onChange: (value) {
                                      postSurgeryData.openSinusLiftFillMaterialString = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.openSinusLiftFillMaterialString ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Membrane")),
                                Expanded(
                                  flex: 4,
                                  child: SimpleBuilder(builder: (context) {
                                    List<BasicNameIdObjectEntity> companies = [];
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                onClear: () {
                                                  postSurgeryData.openSinusLift_Membrane_CompanyID = null;
                                                  postSurgeryData.openSinusLift_Membrane_Company = null;
                                                  setState(() {});
                                                },
                                                asyncUseCase: companies.isNotEmpty ? null : sl<GetMembraneCompaniesUseCase>(),
                                                label: "Membrane Company",
                                                selectedItem: postSurgeryData.openSinusLift_Membrane_Company != null
                                                    ? postSurgeryData.openSinusLift_Membrane_Company
                                                    : companies.firstWhereOrNull(
                                                        (element) => element.id == postSurgeryData.openSinusLift_Membrane_CompanyID),
                                                onSelect: (value) {
                                                  postSurgeryData.openSinusLift_Membrane_CompanyID = value.id;
                                                  postSurgeryData.openSinusLift_Membrane_Company = value;
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName<int>(
                                                onClear: () {
                                                  postSurgeryData.openSinusLift_MembraneID = null;
                                                  membraneId = null;
                                                  postSurgeryData.openSinusLift_Membrane = null; // MembraneEntity(id: value.id, size: value.name);
                                                  setState(() {});
                                                },
                                                asyncUseCase:
                                                    postSurgeryData.openSinusLift_Membrane_CompanyID == null ? null : sl<GetMembranesUseCase>(),
                                                searchParams: postSurgeryData.openSinusLift_Membrane_CompanyID,
                                                label: "Membrane Size",
                                                selectedItem: () {
                                                  if (postSurgeryData.openSinusLift_Membrane != null)
                                                    return BasicNameIdObjectEntity(
                                                        name: postSurgeryData.openSinusLift_Membrane!.name != "" &&
                                                                postSurgeryData.openSinusLift_Membrane!.name != null
                                                            ? postSurgeryData.openSinusLift_Membrane?.name
                                                            : postSurgeryData.openSinusLift_Membrane?.size ?? "",
                                                        id: postSurgeryData.openSinusLift_Membrane!.id);
                                                  return null;
                                                }(),
                                                onSelect: (value) {
                                                  postSurgeryData.openSinusLift_MembraneID = value.id;
                                                  membraneId = value.id;
                                                  postSurgeryData.openSinusLift_Membrane = MembraneEntity(id: value.id, size: value.name);
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Tacs")),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                                            buildWhen: (previous, current) => current is TreatmentBloc_LoadedTacsState,
                                            builder: (context, state) {
                                              List<TacCompanyEntity> tacs = [];
                                              if (state is TreatmentBloc_LoadedTacsState) tacs = state.tacs;
                                              return CIA_DropDownSearchBasicIdName(
                                                onClear: () {
                                                  postSurgeryData.openSinusLiftTacsNumber = 0;
                                                  postSurgeryData.openSinusLift_TacsCompanyID = null;
                                                  tacCompanyId = postSurgeryData.openSinusLift_TacsCompanyID;
                                                  postSurgeryData.openSinusLift_TacsCompany = null;
                                                  bloc.emit(TreatmentBloc_UpdateAvailableTacsState(count: 0));
                                                },
                                                asyncUseCase: sl<GetTacsUseCase>(),
                                                label: "Tacs Company",
                                                selectedItem: postSurgeryData.openSinusLift_TacsCompany != null
                                                    ? BasicNameIdObjectEntity(
                                                        id: postSurgeryData.openSinusLift_TacsCompany!.id,
                                                        name: postSurgeryData.openSinusLift_TacsCompany!.name)
                                                    : null,
                                                onSelect: (value) {
                                                  postSurgeryData.openSinusLiftTacsNumber = 0;
                                                  postSurgeryData.openSinusLift_TacsCompanyID = value.id;
                                                  tacCompanyId = postSurgeryData.openSinusLift_TacsCompanyID;
                                                  postSurgeryData.openSinusLift_TacsCompany = TacCompanyEntity(
                                                    name: value.name,
                                                    id: value.id,
                                                  ); //tacs.firstWhere((element) => element.id == value.id);
                                                  bloc.emit(TreatmentBloc_UpdateAvailableTacsState(
                                                      count: tacs.firstWhereOrNull((element) => element.id == value.id)?.count ?? 0));
                                                },
                                              );
                                            }),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Number",
                                          isNumber: true,
                                          onChange: (value) {
                                            postSurgeryData.openSinusLiftTacsNumber = int.parse(value);
                                            tacsNumber = postSurgeryData.openSinusLiftTacsNumber ?? 0;
                                          },
                                          controller: TextEditingController(
                                            text: (postSurgeryData.openSinusLiftTacsNumber ?? 0).toString(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                          child: BlocBuilder<TreatmentBloc, TreatmentBloc_States>(
                                        buildWhen: (previous, current) => current is TreatmentBloc_UpdateAvailableTacsState,
                                        builder: (context, state) {
                                          int count = 0;
                                          if (state is TreatmentBloc_UpdateAvailableTacsState) count = state.count;
                                          return FormTextValueWidget(
                                            text: "Available number: $count",
                                          );
                                        },
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            CIA_TextFormField(
                              label: "Notes",
                              controller: TextEditingController(text: postSurgeryData.notesSTG),
                              onChange: (v) => postSurgeryData.notesSTG = v,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Surgery Type")),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                          key: GlobalKey(),
                                          onChange: (item, isSelected) {
                                            switch (item) {
                                              case "stg":
                                                postSurgeryData.softTissueGraftSurgeryTypeSoftTissueGraft = isSelected;
                                                postSurgeryData.softTissueGraftSurgeryTypeAdvanced = !isSelected;
                                                break;
                                              case "advanced":
                                                postSurgeryData.softTissueGraftSurgeryTypeAdvanced = isSelected;
                                                postSurgeryData.softTissueGraftSurgeryTypeSoftTissueGraft = !isSelected;
                                                break;
                                            }
                                            setState(() {});
                                          },
                                          singleSelect: true,
                                          labels: [
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Soft Tissue Graft",
                                                value: "stg",
                                                isSelected: postSurgeryData.softTissueGraftSurgeryTypeSoftTissueGraft!),
                                            CIA_MultiSelectChipWidgeModel(
                                                label: "Advanced",
                                                value: "advanced",
                                                isSelected: postSurgeryData.softTissueGraftSurgeryTypeAdvanced!),
                                          ],
                                        ),
                                      ),
                                      postSurgeryData.softTissueGraftSurgeryTypeSoftTissueGraft!
                                          ? Expanded(
                                              child: CIA_MultiSelectChipWidget(
                                                  onChange: (item, isSelected) {
                                                    switch (item) {
                                                      case "Free Gingival Graft":
                                                        postSurgeryData.softTissueGraftSurgeryTypeFreeGinivalGraft = isSelected;
                                                        break;
                                                      case "Connective Tissue Graft":
                                                        postSurgeryData.softTissueGraftSurgeryTypeConnectiveTissueGraft = isSelected;
                                                        break;
                                                    }
                                                    setState(() {});
                                                  },
                                                  labels: [
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Free Gingival Graft",
                                                        isSelected: postSurgeryData.softTissueGraftSurgeryTypeFreeGinivalGraft!),
                                                    CIA_MultiSelectChipWidgeModel(
                                                        label: "Connective Tissue Graft",
                                                        isSelected: postSurgeryData.softTissueGraftSurgeryTypeConnectiveTissueGraft!),
                                                  ]),
                                            )
                                          : (postSurgeryData.softTissueGraftSurgeryTypeAdvanced!
                                              ? Expanded(
                                                  child: CIA_TextFormField(
                                                    label: "Surgery Technique",
                                                    onChange: (value) {
                                                      postSurgeryData.softTissueGraftSurgeryTypeSurgeryTechnique = value;
                                                    },
                                                    controller: TextEditingController(
                                                      text: postSurgeryData.softTissueGraftSurgeryTypeSurgeryTechnique ?? "",
                                                    ),
                                                  ),
                                                )
                                              : SizedBox()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Exposure")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "Customized Healing Collar teeth numher",
                                    onChange: (value) {
                                      postSurgeryData.softTissueGraftExposureCustomizedHealingCollarTeethNumber = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.softTissueGraftExposureCustomizedHealingCollarTeethNumber ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Donor Site")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "Notes",
                                    onChange: (value) {
                                      postSurgeryData.softTissueGraftDonorSiteNotes = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.softTissueGraftDonorSiteNotes ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Stuture")),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Material",
                                          onChange: (value) {
                                            postSurgeryData.softTissueGraftSutureMaterial = value;
                                          },
                                          controller: TextEditingController(
                                            text: postSurgeryData.softTissueGraftSutureMaterial ?? "",
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Technique",
                                          onChange: (value) {
                                            postSurgeryData.softTissueGraftSutureTechnique = value;
                                          },
                                          controller: TextEditingController(
                                            text: postSurgeryData.softTissueGraftSutureTechnique ?? "",
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_TextFormField(
                                          label: "Pack Type",
                                          onChange: (value) {
                                            postSurgeryData.softTissueGraftSuturePackType = value;
                                          },
                                          controller: TextEditingController(
                                            text: postSurgeryData.softTissueGraftSuturePackType ?? "",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Recipient Site")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "Area",
                                    onChange: (value) {
                                      postSurgeryData.softTissueGraftRecipientSiteArea = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.softTissueGraftRecipientSiteArea ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Augmentation Site")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_MultiSelectChipWidget(
                                    onChange: (item, isSelected) {
                                      switch (item) {
                                        case "Buccal":
                                          postSurgeryData.softTissueGraftAugmentationBuccal = isSelected;
                                          break;
                                        case "Crestal":
                                          postSurgeryData.softTissueGraftAugmentationCrestal = isSelected;
                                          break;
                                        case "Lingual":
                                          postSurgeryData.softTissueGraftAugmentationLingual = isSelected;
                                          break;
                                        case "Mesial":
                                          postSurgeryData.softTissueGraftAugmentationMesial = isSelected;
                                          break;
                                        case "Distal":
                                          postSurgeryData.softTissueGraftAugmentationDistal = isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(label: "Buccal", isSelected: postSurgeryData.softTissueGraftAugmentationBuccal!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Crestal", isSelected: postSurgeryData.softTissueGraftAugmentationCrestal!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Lingual", isSelected: postSurgeryData.softTissueGraftAugmentationLingual!),
                                      CIA_MultiSelectChipWidgeModel(label: "Mesial", isSelected: postSurgeryData.softTissueGraftAugmentationMesial!),
                                      CIA_MultiSelectChipWidgeModel(label: "Distal", isSelected: postSurgeryData.softTissueGraftAugmentationDistal!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Frenectomy")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "",
                                    onChange: (value) {
                                      postSurgeryData.softTissueGraftFrenectomyNotes = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.softTissueGraftFrenectomyNotes ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(child: FormTextValueWidget(text: "Bone Graft")),
                                Expanded(
                                  flex: 4,
                                  child: CIA_TextFormField(
                                    label: "Type & Site",
                                    onChange: (value) {
                                      postSurgeryData.softTissueGraftBoneGraftNotes = value;
                                    },
                                    controller: TextEditingController(
                                      text: postSurgeryData.softTissueGraftBoneGraftNotes ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        }
        return Container();
      },
    );
  }
}
