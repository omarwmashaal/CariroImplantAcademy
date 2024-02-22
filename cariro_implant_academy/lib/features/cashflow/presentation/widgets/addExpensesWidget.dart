import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/Widgets/SnackBar.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemParentsUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsCompaniesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/domain/useCases/getLabItemsLinesUseCase.dart';
import 'package:cariro_implant_academy/core/features/settings/presentation/pages/LabItemsSettingsPage.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getExpensesCategoryByNameUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc_States.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemEntity.dart';
import 'package:cariro_implant_academy/features/labRequest/domain/entities/labItemParentEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/entities/stockEntity.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getStockByNameUseCase.dart';
import 'package:cariro_implant_academy/presentation/widgets/customeLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/simple_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/enums/enums.dart';
import '../../../../Widgets/CIA_DropDown.dart';
import '../../../../Widgets/CIA_TextFormField.dart';
import '../../../../Widgets/MultiSelectChipWidget.dart';
import '../../../../core/domain/entities/BasicNameIdObjectEntity.dart';
import '../../../../core/features/settings/domain/useCases/getImplantCompaniesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getImplantLinesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getImplantSizesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getMedicalExpensesCategoriesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getMembraneCompaniesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getMembranesUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getNonMedicalNonStockExpensesCategories.dart';
import '../../../../core/features/settings/domain/useCases/getNonMedicalStockCategories.dart';
import '../../../../core/features/settings/domain/useCases/getPaymentMethodsUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getSuppliersUseCase.dart';
import '../../../../core/features/settings/domain/useCases/getTacsUseCase.dart';
import '../../../../core/injection_contianer.dart';
import '../../../../core/useCases/useCases.dart';
import '../../domain/entities/cashFlowEntity.dart';
import '../bloc/cashFlowBloc_Events.dart';

void ShowAddExpenesesPopUpWidget({
  required BuildContext context,
  required CashFlowBloc cashFlowBloc,
}) {
  List<CashFlowEntity> models = <CashFlowEntity>[
    CashFlowEntity(
      category: BasicNameIdObjectEntity(),
      paymentMethod: BasicNameIdObjectEntity(),
      supplier: BasicNameIdObjectEntity(),
    )
  ];
  bool newCategory = false;
  bool newPaymentMethod = false;
  bool newSupplier = false;
  bool isStockItem = false;
  int total = 0;

  EnumExpenseseCategoriesType expCategory = EnumExpenseseCategoriesType.Service;
  Website inventoryWebsite = siteController.getSite();
  LabItemParentEntity? selectedParentLab;
  BasicNameIdObjectEntity? category;
  int? categoryId;
  BasicNameIdObjectEntity? supplier;
  int? supplierId;
  BasicNameIdObjectEntity? paymentMethod;
  int? paymentMethodId;
  CIA_ShowPopUp(
      context: context,
      width: double.maxFinite,
      height: 600,
      title: "Add new Expenses",
      onSave: () async {
        models.forEach((element) {
          element.supplierId = supplierId;
          element.supplier = supplier;
          element.paymentMethodId = paymentMethodId;
          element.paymentMethod = paymentMethod;
          element.categoryId = categoryId;
          element.category = category;
        });
        cashFlowBloc.add(CashFlowBloc_AddExpenseEvent(
          type: expCategory,
          isStockItem: isStockItem,
          models: models,
          inventory: inventoryWebsite,
        ));
        return false;
      },
      child: StatefulBuilder(builder: (context, _setState) {
        return BlocListener(
          bloc: cashFlowBloc,
          listener: (context, state) {
            if (state is CashFlowBloC_ProcessingCashFlowState)
              CustomLoader.show(context);
            else {
              CustomLoader.hide();
              if (state is CashFlowBloC_ProcessingCashFlowErrorState)
                ShowSnackBar(context, isSuccess: false, message: state.message);
              else if (state is CashFlowBloC_ProcessingCashFlowSuccessfullyState) {
                ShowSnackBar(context, isSuccess: true);
                dialogHelper.dismissAll(context);
              }
            }
          },
          child: Column(
            children: [
              _CategorySelection(
                  expCategory: expCategory,
                  onChange: (
                    expensesCat,
                    website,
                    _category,
                    _categoryId,
                    _supplier,
                    _supplierId,
                    _paymentMethod,
                    _paymentMethodId,
                  ) {
                    expCategory = expensesCat;
                    inventoryWebsite = website;
                    category = _category;
                    categoryId = _categoryId;
                    supplier = _supplier;
                    supplierId = _supplierId;
                    paymentMethod = _paymentMethod;
                    paymentMethodId = _paymentMethodId;

                    _setState(() => null);
                  }),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                    child: expCategory == EnumExpenseseCategoriesType.BoughtMedical
                        ? !(siteController.getSite() == Website.Lab || inventoryWebsite == Website.Lab)
                            ? _MedicalExpenesesWidget(
                                onChanged: (data) {
                                  total = 0;
                                  data.forEach((element) {
                                    total += element.price ?? 0;
                                  });
                                  models = data;
                                  cashFlowBloc.emit(CashFlowBloC_CashFlowTotalState(total: total));
                                },
                              )
                            : _LabItemsExpensesWidget(onChange: (data) {
                                total = 0;
                                data.forEach((element) {
                                  total += element.price ?? 0;
                                });
                                models = data;
                                cashFlowBloc.emit(CashFlowBloC_CashFlowTotalState(total: total));
                              })
                        : _NormalItemsExpensesWidget(onChange: (data) {
                            total = 0;
                            data.forEach((element) {
                              total += element.price ?? 0;
                            });
                            models = data;
                            cashFlowBloc.emit(CashFlowBloC_CashFlowTotalState(total: total));
                          })),
              ),
              BlocBuilder<CashFlowBloc, CashFlowBloc_States>(
                buildWhen: (previous, current) => current is CashFlowBloC_CashFlowTotalState,
                builder: (context, state) {
                  if (state is CashFlowBloC_CashFlowTotalState) total = state.total;
                  return Text("Total: EGP ${total}");
                },
              )
            ],
          ),
        );
      }));
}

class _CategorySelection extends StatefulWidget {
  _CategorySelection({
    Key? key,
    required this.onChange,
    required this.expCategory,
  }) : super(key: key);
  EnumExpenseseCategoriesType expCategory;
  Function(
    EnumExpenseseCategoriesType expCategory,
    Website inventoryWebsite,
    BasicNameIdObjectEntity? category,
    int? categoryId,
    BasicNameIdObjectEntity? supplier,
    int? supplierId,
    BasicNameIdObjectEntity? paymentMethod,
    int? paymentMethodId,
  ) onChange;

  @override
  State<_CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<_CategorySelection> {
  Website inventoryWebsite = siteController.getSite();
  bool newCategory = false;
  bool newPaymentMethod = false;
  bool newSupplier = false;
  bool isStockItem = false;
  LabItemParentEntity? selectedParentLab;
  BasicNameIdObjectEntity? category;
  int? categoryId;
  BasicNameIdObjectEntity? supplier;
  int? supplierId;
  BasicNameIdObjectEntity? paymentMethod;
  int? paymentMethodId;

  @override
  void initState() {
    widget.expCategory = EnumExpenseseCategoriesType.Service;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CIA_MultiSelectChipWidget(
                  key: GlobalKey(),
                  singleSelect: true,
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "Paid for service?", isSelected: widget.expCategory == EnumExpenseseCategoriesType.Service),
                    CIA_MultiSelectChipWidgeModel(
                        label: "Paid for buying items?",
                        isSelected:
                            widget.expCategory == EnumExpenseseCategoriesType.BoughtItem || widget.expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                  ],
                  onChange: (item, isSelected) {
                    if (item == "Paid for service?")
                      widget.expCategory = EnumExpenseseCategoriesType.Service;
                    else {
                      widget.expCategory = EnumExpenseseCategoriesType.BoughtItem;
                    }
                    widget.onChange(
                      widget.expCategory,
                      inventoryWebsite,
                      category,
                      categoryId,
                      supplier,
                      supplierId,
                      paymentMethod,
                      paymentMethodId,
                    );

                    setState(() {});
                  },
                ),
              ),
              VerticalDivider(thickness: 2),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: widget.expCategory != EnumExpenseseCategoriesType.Service,
                  child: Row(
                    children: [
                      FormTextKeyWidget(text: "Inventory Website"),
                      SizedBox(width: 10),
                      Expanded(
                        child: CIA_MultiSelectChipWidget(
                          singleSelect: true,
                          labels: [
                            CIA_MultiSelectChipWidgeModel(label: "CIA", isSelected: inventoryWebsite == Website.CIA),
                            CIA_MultiSelectChipWidgeModel(label: "Lab", isSelected: inventoryWebsite == Website.Lab),
                            CIA_MultiSelectChipWidgeModel(label: "Clinic", isSelected: inventoryWebsite == Website.Clinic),
                          ],
                          onChange: (item, isSelected) {
                            inventoryWebsite = Website.values.firstWhere((element) => element.name == item);
                            supplierId = null;
                            supplier = null;
                            categoryId = null;
                            category = null;
                            widget.onChange(
                              widget.expCategory,
                              inventoryWebsite,
                              category,
                              categoryId,
                              supplier,
                              supplierId,
                              paymentMethod,
                              paymentMethodId,
                            );
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 2,
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: (widget.expCategory == EnumExpenseseCategoriesType.BoughtItem || widget.expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                  child: CIA_MultiSelectChipWidget(
                    key: GlobalKey(),
                    singleSelect: true,
                    labels: [
                      CIA_MultiSelectChipWidgeModel(label: "Bought nonMedical Item?", isSelected: widget.expCategory == EnumExpenseseCategoriesType.BoughtItem),
                      CIA_MultiSelectChipWidgeModel(
                          label: "Bought ${siteController.getSite() == Website.Lab ? "Lab" : "Medical"} Item?",
                          isSelected: widget.expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                    ],
                    onChange: (item, isSelected) {
                      if (item == "Bought nonMedical Item?")
                        widget.expCategory = EnumExpenseseCategoriesType.BoughtItem;
                      else
                        widget.expCategory = EnumExpenseseCategoriesType.BoughtMedical;

                      widget.onChange(
                        widget.expCategory,
                        inventoryWebsite,
                        category,
                        categoryId,
                        supplier,
                        supplierId,
                        paymentMethod,
                        paymentMethodId,
                      );
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CIA_MultiSelectChipWidget(
                      onChange: (item, isSelected) {
                        if (isSelected) {
                          paymentMethodId = null;
                        } else {
                          paymentMethod = null;
                        }
                        widget.onChange(
                          widget.expCategory,
                          inventoryWebsite,
                          category,
                          categoryId,
                          supplier,
                          supplierId,
                          paymentMethod,
                          paymentMethodId,
                        );
                        setState(() => newPaymentMethod = isSelected);
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(label: "New", isSelected: newPaymentMethod),
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: newPaymentMethod
                          ? CIA_TextFormField(
                              label: "Payment Method",
                              onChange: (value) {
                                paymentMethodId = null;
                                paymentMethod = BasicNameIdObjectEntity(name: value);
                                widget.onChange(
                                  widget.expCategory,
                                  inventoryWebsite,
                                  category,
                                  categoryId,
                                  supplier,
                                  supplierId,
                                  paymentMethod,
                                  paymentMethodId,
                                );
                              },
                              controller: TextEditingController(text: paymentMethod?.name ?? ""),
                            )
                          : CIA_DropDownSearchBasicIdName(
                              label: "Payment Method",
                              asyncUseCase: sl<GetPaymentMethodsUseCase>(),
                              onSelect: (value) {
                                paymentMethod = value;
                                paymentMethodId = value.id;
                                widget.onChange(
                                  widget.expCategory,
                                  inventoryWebsite,
                                  category,
                                  categoryId,
                                  supplier,
                                  supplierId,
                                  paymentMethod,
                                  paymentMethodId,
                                );
                              },
                              selectedItem: paymentMethod,
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              VerticalDivider(),
              SizedBox(height: 5),
              Expanded(
                child: Row(
                  children: [
                    CIA_MultiSelectChipWidget(
                      onChange: (item, isSelected) {
                        if (isSelected) {
                          supplierId = null;
                        } else
                          supplier = null;
                        widget.onChange(
                          widget.expCategory,
                          inventoryWebsite,
                          category,
                          categoryId,
                          supplier,
                          supplierId,
                          paymentMethod,
                          paymentMethodId,
                        );
                        setState(() => newSupplier = isSelected);
                      },
                      labels: [
                        CIA_MultiSelectChipWidgeModel(label: "New", isSelected: newSupplier),
                      ],
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: newSupplier
                          ? CIA_TextFormField(
                              label: "Supplier",
                              onChange: (value) {
                                supplierId = null;
                                supplier = BasicNameIdObjectEntity(name: value);
                                widget.onChange(
                                  widget.expCategory,
                                  inventoryWebsite,
                                  category,
                                  categoryId,
                                  supplier,
                                  supplierId,
                                  paymentMethod,
                                  paymentMethodId,
                                );
                              },
                              controller: TextEditingController(text: supplier?.name ?? ""),
                            )
                          : CIA_DropDownSearchBasicIdName<GetSuppliersParams>(
                              label: "Supplier",
                              asyncUseCase: sl<GetSuppliersUseCase>(),
                              searchParams: GetSuppliersParams(
                                website: inventoryWebsite,
                                medical: widget.expCategory == EnumExpenseseCategoriesType.BoughtMedical,
                              ),
                              onSelect: (value) {
                                supplier = value;
                                supplierId = value.id;
                                widget.onChange(
                                  widget.expCategory,
                                  inventoryWebsite,
                                  category,
                                  categoryId,
                                  supplier,
                                  supplierId,
                                  paymentMethod,
                                  paymentMethodId,
                                );
                              },
                              selectedItem: supplier,
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              VerticalDivider(),
              SizedBox(height: 5),
              Expanded(
                child: Row(
                  children: [
                    widget.expCategory == EnumExpenseseCategoriesType.BoughtMedical
                        ? Container()
                        : CIA_MultiSelectChipWidget(
                            onChange: (item, isSelected) {
                              if (isSelected)
                                categoryId = null;
                              else
                                category = null;
                              widget.onChange(
                                widget.expCategory,
                                inventoryWebsite,
                                category,
                                categoryId,
                                supplier,
                                supplierId,
                                paymentMethod,
                                paymentMethodId,
                              );
                              setState(() => newCategory = isSelected);
                            },
                            labels: [
                              CIA_MultiSelectChipWidgeModel(label: "New", isSelected: newCategory),
                            ],
                          ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: widget.expCategory == EnumExpenseseCategoriesType.BoughtMedical
                          ? Container()
                          : newCategory
                              ? CIA_TextFormField(
                                  label: "Category",
                                  onChange: (value) {
                                    categoryId = null;
                                    category = BasicNameIdObjectEntity(name: value);
                                    widget.onChange(
                                      widget.expCategory,
                                      inventoryWebsite,
                                      category,
                                      categoryId,
                                      supplier,
                                      supplierId,
                                      paymentMethod,
                                      paymentMethodId,
                                    );
                                  },
                                  controller: TextEditingController(text: category?.name ?? ""),
                                )
                              : CIA_DropDownSearchBasicIdName<Website>(
                                  label: "Category",
                                  asyncUseCase: widget.expCategory == EnumExpenseseCategoriesType.Service
                                      ? sl<GetNonMedicalNonStockExpensesCategoriesUseCase>()
                                      : widget.expCategory == EnumExpenseseCategoriesType.BoughtItem
                                          ? sl<GetNonMedicalStockCategoriesUseCase>()
                                          : sl<GetMedicalExpensesCategoriesUseCase>(),
                                  searchParams: inventoryWebsite,
                                  onSelect: (value) {
                                    category = value;
                                    categoryId = value.id;
                                    widget.onChange(
                                      widget.expCategory,
                                      inventoryWebsite,
                                      category,
                                      categoryId,
                                      supplier,
                                      supplierId,
                                      paymentMethod,
                                      paymentMethodId,
                                    );
                                  },
                                  selectedItem: category,
                                ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabItemsExpensesWidget extends StatefulWidget {
  _LabItemsExpensesWidget({Key? key, required this.onChange}) : super(key: key);
  Function(List<CashFlowEntity> data) onChange;

  @override
  State<_LabItemsExpensesWidget> createState() => _LabItemsExpensesWidgetState();
}

class _LabItemsExpensesWidgetState extends State<_LabItemsExpensesWidget> {
  List<CashFlowEntity> data = [
    CashFlowEntity(count: 1),
  ];

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Column(
      children: data.map<Widget>((e) {
        index++;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FormTextValueWidget(text: "${index.toString()}. "),
              Expanded(
                child: CIA_DropDownSearchBasicIdName(
                  label: "Item Type",
                  asyncUseCaseDynamic: sl<GetLabItemParentsUseCase>(),
                  onSelect: (value) {
                    e.labItemShade = null;
                    e.labItemShadeId = null;
                    e.labItemCompany = null;
                    setState(() => e.labItemParent = value);
                  },
                  selectedItem: e.labItemParent,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CIA_DropDownSearchBasicIdName<int>(
                  label: "Company",
                  asyncUseCaseDynamic: e.labItemParent == null ? null : sl<GetLabItemsCompaniesUseCase>(),
                  searchParams: e.labItemParent?.id,
                  onSelect: (value) {
                    e.labItemShade = null;
                    e.labItemShadeId = null;
                    setState(() => e.labItemCompany = value);
                  },
                  selectedItem: e.labItemCompany,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CIA_DropDownSearchBasicIdName<int>(
                  label: "Shade",
                  asyncUseCaseDynamic: e.labItemCompany == null ? null : sl<GetLabItemsLinesUseCase>(),
                  searchParams: e.labItemCompany?.id,
                  onSelect: (value) => setState(() {
                    e.labItemShadeId = value.id;
                    e.labItemShade = value;
                    widget.onChange(data
                        .where((element) =>
                            element.price != null && element.labItemShadeId != null && !(element.size?.isEmpty ?? true) && !(element.code?.isEmpty ?? true))
                        .toList());
                  }),
                  selectedItem: e.labItemShade,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Visibility(
                  visible: e.labItemShadeId != null,
                  child: CIA_TextFormField(
                    errorFunction: (value) => e.code?.isEmpty ?? true,
                    label: "Code",
                    controller: TextEditingController(text: e.code),
                    onChange: (v) {
                      e.code = v;
                      widget.onChange(data
                          .where((element) =>
                              element.price != null && element.labItemShadeId != null && !(element.size?.isEmpty ?? true) && !(element.code?.isEmpty ?? true))
                          .toList());
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Visibility(
                  visible: e.labItemShadeId != null,
                  child: CIA_TextFormField(
                    label: "Size",
                    errorFunction: (value) => e.size?.isEmpty ?? true,
                    controller: TextEditingController(text: e.size),
                    onChange: (v) {
                      e.size = v;
                      widget.onChange(data
                          .where((element) =>
                              element.price != null && element.labItemShadeId != null && !(element.size?.isEmpty ?? true) && !(element.code?.isEmpty ?? true))
                          .toList());
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Visibility(
                  visible: e.labItemShadeId != null,
                  child: CIA_TextFormField(
                    label: "Price",
                    isNumber: true,
                    errorFunction: (value) => e.price == null,
                    suffix: "EGP",
                    controller: TextEditingController(text: e.price?.toString() ?? "0"),
                    onChange: (v) {
                      e.price = int.tryParse(v) ?? 0;
                      widget.onChange(data
                          .where((element) =>
                              element.price != null && element.labItemShadeId != null && !(element.size?.isEmpty ?? true) && !(element.code?.isEmpty ?? true))
                          .toList());
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    data.add(CashFlowEntity(
                      labItemShadeId: data.last.labItemShadeId,
                      labItemCompany: data.last.labItemCompany,
                      labItemParent: data.last.labItemParent,
                      labItemShade: data.last.labItemShade,
                      count: 1,
                    ));

                    widget.onChange(data
                        .where((element) =>
                            element.price != null && element.labItemShadeId != null && !(element.size?.isEmpty ?? true) && !(element.code?.isEmpty ?? true))
                        .toList());
                    setState(() {});
                  }),
              SizedBox(width: 10),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    data.remove(e);
                    widget.onChange(data
                        .where((element) =>
                            element.price != null && element.labItemShadeId != null && !(element.size?.isEmpty ?? true) && !(element.code?.isEmpty ?? true))
                        .toList());
                    setState(() {});
                  }),
            ],
          ),
        );
      }).toList()
        ..insert(
            0,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormTextKeyWidget(
                text: "Warning: item with no price, size or shade will be removed!",
                color: Colors.red,
              ),
            )),
    );
  }
}

class _NormalItemsExpensesWidget extends StatefulWidget {
  _NormalItemsExpensesWidget({Key? key, required this.onChange}) : super(key: key);
  Function(List<CashFlowEntity> data) onChange;

  @override
  State<_NormalItemsExpensesWidget> createState() => _NormalItemsExpensesWidgetState();
}

class _NormalItemsExpensesWidgetState extends State<_NormalItemsExpensesWidget> {
  List<CashFlowEntity> data = [CashFlowEntity()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .map((model) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CIA_TextFormField(
                          onChange: (value) {
                            model.name = value;
                            widget
                                .onChange(data.where((element) => element.price != null && element.count != null && !(element.name?.isEmpty ?? true)).toList());
                          },
                          label: "Name",
                          controller: TextEditingController(text: model.name ?? "")),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CIA_TextFormField(
                        isNumber: true,
                        onChange: (value) {
                          if (value == null || value == "") value = "0";
                          model.price = int.parse(value);
                          widget.onChange(data);
                          int total = 0;
                          data.forEach((element) {
                            total += element.price ?? 0;
                          });
                          BlocProvider.of<CashFlowBloc>(context).emit(CashFlowBloC_CashFlowTotalState(total: total));
                        },
                        label: "Price",
                        controller: TextEditingController(text: (model.price ?? 0).toString()),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CIA_TextFormField(
                        isNumber: true,
                        onChange: (value) {
                          if (value == null || value == "") value = "0";
                          model.count = int.parse(value);
                          widget.onChange(data);
                        },
                        label: "Count",
                        controller: TextEditingController(text: (model.count ?? 0).toString()),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CIA_TextFormField(
                        onChange: (value) {
                          model.notes = value;
                          widget.onChange(data);
                        },
                        label: "Notes",
                        controller: TextEditingController(text: model.notes ?? ""),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: () {
                          int index = 0;
                          index = data.indexWhere((element) => element == model);
                          data.add(CashFlowEntity());
                          widget.onChange(data);
                          setState(() {});
                        },
                        icon: Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          data.remove(model);
                          widget.onChange(data);
                          setState(() {});
                        },
                        icon: Icon(Icons.remove))
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _MedicalExpenesesWidget extends StatefulWidget {
  _MedicalExpenesesWidget({Key? key, required this.onChanged}) : super(key: key);
  Function(List<CashFlowEntity> data) onChanged;

  @override
  State<_MedicalExpenesesWidget> createState() => _MedicalExpenesesWidgetState();
}

class _MedicalExpenesesWidgetState extends State<_MedicalExpenesesWidget> {
  String medicalType = "Tacs";
  List<CashFlowEntity> data = [CashFlowEntity()];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CIA_MultiSelectChipWidget(
          key: GlobalKey(),
          singleSelect: true,
          labels: [
            CIA_MultiSelectChipWidgeModel(label: "Tacs", isSelected: medicalType == "Tacs"),
            CIA_MultiSelectChipWidgeModel(label: "Membranes", isSelected: medicalType == "Membranes"),
            CIA_MultiSelectChipWidgeModel(label: "Screws", isSelected: medicalType == "Screws"),
            CIA_MultiSelectChipWidgeModel(label: "Implants", isSelected: medicalType == "Implants"),
            // CIA_MultiSelectChipWidgeModel(label: "Other", isSelected: medicalType == "Other"),
          ],
          onChange: (item, isSelected) {
            data = [CashFlowEntity()];
            if (isSelected)
              setState(() {
                medicalType = item;
              });
          },
        ),
        Column(
          children: data
              .map((model) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: () {
                        List<Widget> r = [];
                        if (medicalType == "Tacs") {
                          return [
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName(
                                label: "Tacs Company",
                                asyncUseCase: sl<GetTacsUseCase>(),
                                onSelect: (value) {
                                  model.tac = value;
                                  model.id = model.tac?.id;
                                },
                                selectedItem: model.tac,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                onChange: (value) {
                                  if (value == null || value == "") value = "0";
                                  model.count = int.parse(value);
                                  widget.onChanged(data);
                                },
                                label: "Count",
                                controller: TextEditingController(text: (model.count ?? 0).toString()),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                onChange: (value) {
                                  if (value == null || value == "") value = "0";
                                  model.price = int.parse(value);
                                  widget.onChanged(data);
                                },
                                label: "Price",
                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                              ),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  data.add(CashFlowEntity());
                                  setState(() {});
                                },
                                icon: Icon(Icons.add)),
                            IconButton(
                                onPressed: () {
                                  data.remove(model);
                                  setState(() {});
                                },
                                icon: Icon(Icons.remove))
                          ];
                        } else if (medicalType == "Membranes") {
                          return [
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName(
                                label: "Membrane Company",
                                asyncUseCase: sl<GetMembraneCompaniesUseCase>(),
                                onSelect: (value) {
                                  model.membraneCompany = value;
                                  setState(() {});
                                },
                                selectedItem: model.membraneCompany,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName(
                                label: "Membrane",
                                asyncUseCase: model.membraneCompany == null ? null : sl<GetMembranesUseCase>(),
                                searchParams: model.membraneCompany == null ? null : model.membraneCompany?.id,
                                onSelect: (value) {
                                  model.membrane = value;
                                  model.id = model.membrane?.id;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                onChange: (value) {
                                  if (value == null || value == "") value = "0";
                                  model.count = int.parse(value);
                                },
                                label: "Count",
                                controller: TextEditingController(text: (model.count ?? 0).toString()),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                onChange: (value) {
                                  if (value == null || value == "") value = "0";
                                  model.price = int.parse(value);
                                  widget.onChanged(data);
                                },
                                label: "Price",
                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                              ),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  data.add(CashFlowEntity());

                                  setState(() {});
                                },
                                icon: Icon(Icons.add)),
                            IconButton(
                                onPressed: () {
                                  data.remove(model);
                                  setState(() {});
                                },
                                icon: Icon(Icons.remove))
                          ];
                        } else if (medicalType == "Implants") {
                          return [
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName(
                                label: "Implant Company",
                                asyncUseCase: sl<GetImplantCompaniesUseCase>(),
                                onSelect: (value) {
                                  model.implantCompany = value;
                                  setState(() {});
                                },
                                selectedItem: model.implantCompany,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName(
                                label: "Implant Line",
                                asyncUseCase: model.implantCompany == null ? null : sl<GetImplantLinesUseCase>(),
                                searchParams: model.implantCompany == null ? null : model.implantCompany?.id,
                                onSelect: (value) {
                                  model.implantLine = value;
                                  setState(() {});
                                },
                                selectedItem: model.implantLine,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_DropDownSearchBasicIdName(
                                label: "Implant",
                                asyncUseCase: model.implantLine == null ? null : sl<GetImplantSizesUseCase>(),
                                searchParams: model.implantLine == null ? null : model.implantLine?.id,
                                onSelect: (value) {
                                  model.id = value.id;
                                  model.implant = value;
                                },
                                selectedItem: model.name == null
                                    ? null
                                    : BasicNameIdObjectEntity(
                                        name: model.name,
                                      ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                onChange: (value) {
                                  if (value == null || value == "") value = "0";
                                  model.count = int.parse(value);
                                },
                                label: "Count",
                                controller: TextEditingController(text: (model.count ?? 0).toString()),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                onChange: (value) {
                                  if (value == null || value == "") value = "0";
                                  model.price = int.parse(value);
                                  widget.onChanged(data);
                                },
                                label: "Price",
                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                              ),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  data.add(CashFlowEntity());
                                  widget.onChanged(data);
                                  setState(() {});
                                },
                                icon: Icon(Icons.add)),
                            IconButton(
                                onPressed: () {
                                  data.remove(model);
                                  widget.onChanged(data);
                                  setState(() {});
                                },
                                icon: Icon(Icons.remove))
                          ];
                        } else if (medicalType == "Screws") {
                          model.name = "Screws";
                          return [
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                label: "Screws Count",
                                controller: TextEditingController(),
                                onChange: (value) {

                                  model.count = int.tryParse(value) ?? 0;
                                  widget.onChanged(data);
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CIA_TextFormField(
                                isNumber: true,
                                label: "Price",
                                controller: TextEditingController(),
                                onChange: (value) {
                                  model.price = int.tryParse(value) ?? 0;
                                  widget.onChanged(data);
                                },
                              ),
                            )
                          ];
                        }

                        return r;
                      }(),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
