import 'package:cariro_implant_academy/features/patientsMedical/treatmentFeature/presentation/bloc/treatmentBloc_Events.dart';
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
import '../../domain/entities/surgicalTreatmentEntity.dart';
import '../bloc/treatmentBloc.dart';
import '../bloc/treatmentBloc_States.dart';

class PostSurgeryWidget extends StatefulWidget {
  PostSurgeryWidget({
    Key? key,
    required this.surgicalTreatmentEntity,
  }) : super(key: key);
  SurgicalTreatmentEntity surgicalTreatmentEntity;

  @override
  State<PostSurgeryWidget> createState() => _PostSurgeryWidgetState();
}

class _PostSurgeryWidgetState extends State<PostSurgeryWidget> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  late TreatmentBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<TreatmentBloc>(context);
    bloc.add(TreatmentBloc_GetTacsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return Container();
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
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30 = isSelected;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                    break;
                                  case "4-0":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40 = isSelected;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                    break;
                                  case "5-0":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50 = isSelected;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                    break;
                                  case "6-0":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60 = isSelected;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                    break;
                                  case "7-0":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70 = isSelected;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = false;
                                    break;
                                  case "Implant Subcrestal":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70 = false;
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal = isSelected;
                                    break;
                                }
                                setState(() {});
                              },
                              singleSelect: true,
                              labels: [
                                CIA_MultiSelectChipWidgeModel(
                                    label: "3-0", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize30!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "4-0", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize40!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "5-0", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize50!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "6-0", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize60!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "7-0", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSize70!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Implant Subcrestal",
                                    isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRaySutureSizeImplantSubcrestal!),
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
                                      widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialVicryl = p0.contains("Vicryl");
                                      widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialProline = p0.contains("Proline");
                                      widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialXRay = p0.contains("X-ray");
                                      setState(() {});
                                    },
                                    singleSelect: true,
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Vicryl", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialVicryl!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Proline", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialProline!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "X-ray", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialXRay!),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Suture Technique",
                                    onChange: (value) {
                                      widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialSutureTechnique = value;
                                    },
                                    controller: TextEditingController(
                                      text: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayMaterialSutureTechnique ?? "",
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
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryHealingCollar = isSelected;
                                    break;
                                  case "Customized Healling Collar":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar = isSelected;
                                    break;
                                  case "Crown":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryCrown = isSelected;
                                    break;
                                  case "Maryland Bridge":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryMarylandBridge = isSelected;
                                    break;
                                  case "Bridge on teeth":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth = isSelected;
                                    break;
                                  case "Denture with glass fiber":
                                    widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber = isSelected;
                                    break;
                                }
                                setState(() {});
                              },
                              labels: [
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Healing Collar", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryHealingCollar!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Customized Healling Collar",
                                    isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryCustomizedHeallingCollar!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Crown", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryCrown!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Maryland Bridge", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryMarylandBridge!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Bridge on teeth", isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryBridgeOnTeeth!),
                                CIA_MultiSelectChipWidgeModel(
                                    label: "Denture with glass fiber",
                                    isSelected: widget.surgicalTreatmentEntity.sutureAndTemporizationAndXRayTemporaryDentureWithGlassFiber!),
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
                                          widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftChin = isSelected;
                                          break;
                                        case "Ramus":
                                          widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftRamus = isSelected;
                                          break;
                                        case "Tuberosity":
                                          widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftTuberosity = isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Chin", isSelected: widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftChin!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Ramus", isSelected: widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftRamus!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Tuberosity", isSelected: widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftTuberosity!),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Other Specify",
                                    onChange: (value) {
                                      widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftOther = value;
                                    },
                                    controller: TextEditingController(text: widget.surgicalTreatmentEntity.guidedBoneRegenerationBlockGraftOther ?? ""),
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
                                    widget.surgicalTreatmentEntity.guidedBoneRegenerationCutByDisc = isSelected;
                                    break;
                                  case "Piezo":
                                    widget.surgicalTreatmentEntity.guidedBoneRegenerationCutByPiezo = isSelected;
                                    break;
                                }
                                setState(() {});
                              },
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Disc", isSelected: widget.surgicalTreatmentEntity.guidedBoneRegenerationCutByDisc!),
                                CIA_MultiSelectChipWidgeModel(label: "Piezo", isSelected: widget.surgicalTreatmentEntity.guidedBoneRegenerationCutByPiezo!),
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
                                widget.surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber = int.parse(value);
                              },
                              isNumber: true,
                              controller: TextEditingController(
                                text: (widget.surgicalTreatmentEntity.guidedBoneRegenerationCutByScrewsNumber ?? 0).toString(),
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
                                        widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous = int.parse(value);
                                        if (widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous! > 100)
                                          widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous = 100;
                                        widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Xenograft =
                                            100 - (widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous ?? 0);

                                        _setSatate(() {});
                                      },
                                      validator: (value) {
                                        if (int.parse(value) > 100) {
                                          widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous = 100;
                                          widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Xenograft =
                                              100 - (widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous ?? 0);

                                          return "100";
                                        }
                                        return value;
                                      },
                                      controller: TextEditingController(
                                        text: (widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Autogenous ?? 0).toString(),
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
                                        text: (widget.surgicalTreatmentEntity.guidedBoneRegenerationBoneParticle100Xenograft ?? 0).toString(),
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
                                      widget.surgicalTreatmentEntity.guidedBoneRegenerationACMBurArea = value;
                                    },
                                    controller: TextEditingController(
                                      text: widget.surgicalTreatmentEntity.guidedBoneRegenerationACMBurArea ?? "",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Notes",
                                    onChange: (value) {
                                      widget.surgicalTreatmentEntity.guidedBoneRegenerationACMBurNotes = value;
                                    },
                                    controller: TextEditingController(
                                      text: widget.surgicalTreatmentEntity.guidedBoneRegenerationACMBurNotes ?? "",
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
                      Row(
                        children: [
                          Expanded(child: FormTextValueWidget(text: "Approach")),
                          Expanded(
                            flex: 4,
                            child: CIA_TextFormField(
                              label: "",
                              onChange: (value) {
                                widget.surgicalTreatmentEntity.openSinusLiftApproachString = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.openSinusLiftApproachString ?? "",
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
                                widget.surgicalTreatmentEntity.openSinusLiftFillMaterialString = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.openSinusLiftFillMaterialString ?? "",
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
                                          asyncUseCase: companies.isNotEmpty ? null : sl<GetMembraneCompaniesUseCase>(),
                                          label: "Membrane Company",
                                          selectedItem: widget.surgicalTreatmentEntity.openSinusLift_Membrane_Company != null
                                              ? widget.surgicalTreatmentEntity.openSinusLift_Membrane_Company
                                              : companies
                                                  .firstWhereOrNull((element) => element.id == widget.surgicalTreatmentEntity.openSinusLift_Membrane_CompanyID),
                                          onSelect: (value) {
                                            widget.surgicalTreatmentEntity.openSinusLift_Membrane_CompanyID = value.id;
                                            widget.surgicalTreatmentEntity.openSinusLift_Membrane_Company = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CIA_DropDownSearchBasicIdName<int>(
                                          asyncUseCase:
                                              widget.surgicalTreatmentEntity.openSinusLift_Membrane_CompanyID == null ? null : sl<GetMembranesUseCase>(),
                                          searchParams: widget.surgicalTreatmentEntity.openSinusLift_Membrane_CompanyID,
                                          label: "Membrane Size",
                                          selectedItem: () {
                                            if (widget.surgicalTreatmentEntity.openSinusLift_Membrane != null)
                                              return BasicNameIdObjectEntity(
                                                  name: widget.surgicalTreatmentEntity.openSinusLift_Membrane!.name != "" &&
                                                          widget.surgicalTreatmentEntity.openSinusLift_Membrane!.name != null
                                                      ? widget.surgicalTreatmentEntity.openSinusLift_Membrane?.name
                                                      : widget.surgicalTreatmentEntity.openSinusLift_Membrane?.size??"",
                                                  id: widget.surgicalTreatmentEntity.openSinusLift_Membrane!.id);
                                            return null;
                                          }(),
                                          onSelect: (value) {
                                            widget.surgicalTreatmentEntity.openSinusLift_MembraneID = value.id;
                                            widget.surgicalTreatmentEntity.openSinusLift_Membrane = MembraneEntity(id: value.id, size: value.name);
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
                                          asyncUseCase: sl<GetTacsUseCase>(),
                                          label: "Tacs Company",
                                          selectedItem: widget.surgicalTreatmentEntity.openSinusLift_TacsCompany != null
                                              ? BasicNameIdObjectEntity(
                                                  id: widget.surgicalTreatmentEntity.openSinusLift_TacsCompany!.id,
                                                  name: widget.surgicalTreatmentEntity.openSinusLift_TacsCompany!.name)
                                              : null,
                                          onSelect: (value) {
                                            widget.surgicalTreatmentEntity.openSinusLiftTacsNumber = 0;
                                            widget.surgicalTreatmentEntity.openSinusLift_TacsCompanyID = value.id;
                                            widget.surgicalTreatmentEntity.openSinusLift_TacsCompany = TacCompanyEntity(
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
                                      widget.surgicalTreatmentEntity.openSinusLiftTacsNumber = int.parse(value);
                                    },
                                    controller: TextEditingController(
                                      text: (widget.surgicalTreatmentEntity.openSinusLiftTacsNumber ?? 0).toString(),
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
                      SizedBox(width: 5),
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
                                          widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeSoftTissueGraft = isSelected;
                                          widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeAdvanced = !isSelected;
                                          break;
                                        case "advanced":
                                          widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeAdvanced = isSelected;
                                          widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeSoftTissueGraft = !isSelected;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                    singleSelect: true,
                                    labels: [
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Soft Tissue Graft",
                                          value: "stg",
                                          isSelected: widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeSoftTissueGraft!),
                                      CIA_MultiSelectChipWidgeModel(
                                          label: "Advanced", value: "advanced", isSelected: widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeAdvanced!),
                                    ],
                                  ),
                                ),
                                widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeSoftTissueGraft!
                                    ? Expanded(
                                        child: CIA_MultiSelectChipWidget(
                                            onChange: (item, isSelected) {
                                              switch (item) {
                                                case "Free Gingival Graft":
                                                  widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeFreeGinivalGraft = isSelected;
                                                  break;
                                                case "Connective Tissue Graft":
                                                  widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeConnectiveTissueGraft = isSelected;
                                                  break;
                                              }
                                              setState(() {});
                                            },
                                            labels: [
                                              CIA_MultiSelectChipWidgeModel(
                                                  label: "Free Gingival Graft",
                                                  isSelected: widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeFreeGinivalGraft!),
                                              CIA_MultiSelectChipWidgeModel(
                                                  label: "Connective Tissue Graft",
                                                  isSelected: widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeConnectiveTissueGraft!),
                                            ]),
                                      )
                                    : (widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeAdvanced!
                                        ? Expanded(
                                            child: CIA_TextFormField(
                                              label: "Surgery Technique",
                                              onChange: (value) {
                                                widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeSurgeryTechnique = value;
                                              },
                                              controller: TextEditingController(
                                                text: widget.surgicalTreatmentEntity.softTissueGraftSurgeryTypeSurgeryTechnique ?? "",
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
                                widget.surgicalTreatmentEntity.softTissueGraftExposureCustomizedHealingCollarTeethNumber = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.softTissueGraftExposureCustomizedHealingCollarTeethNumber ?? "",
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
                                widget.surgicalTreatmentEntity.softTissueGraftDonorSiteNotes = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.softTissueGraftDonorSiteNotes ?? "",
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
                                      widget.surgicalTreatmentEntity.softTissueGraftSutureMaterial = value;
                                    },
                                    controller: TextEditingController(
                                      text: widget.surgicalTreatmentEntity.softTissueGraftSutureMaterial ?? "",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Technique",
                                    onChange: (value) {
                                      widget.surgicalTreatmentEntity.softTissueGraftSutureTechnique = value;
                                    },
                                    controller: TextEditingController(
                                      text: widget.surgicalTreatmentEntity.softTissueGraftSutureTechnique ?? "",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CIA_TextFormField(
                                    label: "Pack Type",
                                    onChange: (value) {
                                      widget.surgicalTreatmentEntity.softTissueGraftSuturePackType = value;
                                    },
                                    controller: TextEditingController(
                                      text: widget.surgicalTreatmentEntity.softTissueGraftSuturePackType ?? "",
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
                                widget.surgicalTreatmentEntity.softTissueGraftRecipientSiteArea = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.softTissueGraftRecipientSiteArea ?? "",
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
                                    widget.surgicalTreatmentEntity.softTissueGraftAugmentationBuccal = isSelected;
                                    break;
                                  case "Crestal":
                                    widget.surgicalTreatmentEntity.softTissueGraftAugmentationCrestal = isSelected;
                                    break;
                                  case "Lingual":
                                    widget.surgicalTreatmentEntity.softTissueGraftAugmentationLingual = isSelected;
                                    break;
                                  case "Mesial":
                                    widget.surgicalTreatmentEntity.softTissueGraftAugmentationMesial = isSelected;
                                    break;
                                  case "Distal":
                                    widget.surgicalTreatmentEntity.softTissueGraftAugmentationDistal = isSelected;
                                    break;
                                }
                                setState(() {});
                              },
                              labels: [
                                CIA_MultiSelectChipWidgeModel(label: "Buccal", isSelected: widget.surgicalTreatmentEntity.softTissueGraftAugmentationBuccal!),
                                CIA_MultiSelectChipWidgeModel(label: "Crestal", isSelected: widget.surgicalTreatmentEntity.softTissueGraftAugmentationCrestal!),
                                CIA_MultiSelectChipWidgeModel(label: "Lingual", isSelected: widget.surgicalTreatmentEntity.softTissueGraftAugmentationLingual!),
                                CIA_MultiSelectChipWidgeModel(label: "Mesial", isSelected: widget.surgicalTreatmentEntity.softTissueGraftAugmentationMesial!),
                                CIA_MultiSelectChipWidgeModel(label: "Distal", isSelected: widget.surgicalTreatmentEntity.softTissueGraftAugmentationDistal!),
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
                                widget.surgicalTreatmentEntity.softTissueGraftFrenectomyNotes = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.softTissueGraftFrenectomyNotes ?? "",
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
                                widget.surgicalTreatmentEntity.softTissueGraftBoneGraftNotes = value;
                              },
                              controller: TextEditingController(
                                text: widget.surgicalTreatmentEntity.softTissueGraftBoneGraftNotes ?? "",
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
}
