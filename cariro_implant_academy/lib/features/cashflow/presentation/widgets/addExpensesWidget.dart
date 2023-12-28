import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/FormTextWidget.dart';
import 'package:cariro_implant_academy/features/cashflow/domain/useCases/getExpensesCategoryByNameUseCase.dart';
import 'package:cariro_implant_academy/features/cashflow/presentation/bloc/cashFlowBloc.dart';
import 'package:cariro_implant_academy/features/stock/domain/usecases/getStockByNameUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  CashFlowEntity dummyModel = CashFlowEntity(
    category: BasicNameIdObjectEntity(),
    paymentMethod: BasicNameIdObjectEntity(),
    supplier: BasicNameIdObjectEntity(),
  );
  EnumExpenseseCategoriesType expCategory = EnumExpenseseCategoriesType.Service;
  Website inventoryWebsite = siteController.getSite();
  CIA_ShowPopUp(
      context: context,
      width: 1000,
      height: 500,
      title: "Add new Expenses",
      onSave: () async {
        models.forEach((element) {
          element.supplierId = dummyModel.supplierId;
          element.supplier = dummyModel.supplier;
          element.paymentMethodId = dummyModel.paymentMethodId;
          element.paymentMethod = dummyModel.paymentMethod;
          element.categoryId = dummyModel.categoryId;
          element.category = dummyModel.category;
        });
        cashFlowBloc.add(CashFlowBloc_AddExpenseEvent(
          type: expCategory,
          isStockItem: isStockItem,
          models: models,
          inventory: inventoryWebsite,
        ));
        return false;
      },
      child: SimpleBuilder(builder: (context) {
        String medicalType = "Tacs";
        Website selectedWebsite = siteController.getSite();
        return StatefulBuilder(
          builder: (context, _setState) {
            return Column(
              children: [
                FormTextKeyWidget(text: "Inventroy Website"),
                SizedBox(height: 10,),
                CIA_MultiSelectChipWidget(
                  singleSelect: true,
                  labels: [
                    CIA_MultiSelectChipWidgeModel(label: "CIA", isSelected: inventoryWebsite == Website.CIA),
                    CIA_MultiSelectChipWidgeModel(label: "Lab", isSelected: inventoryWebsite == Website.Lab),
                    CIA_MultiSelectChipWidgeModel(label: "Clinic", isSelected: inventoryWebsite == Website.Clinic),
                  ],
                  onChange: (item, isSelected) {
                    inventoryWebsite = Website.values.firstWhere((element) => element.name==item);
                    _setState((){});
                    },
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: () {
                        List<Widget> r = [];
                        r.add(
                          CIA_MultiSelectChipWidget(
                            key: GlobalKey(),
                            singleSelect: true,
                            labels: [
                              CIA_MultiSelectChipWidgeModel(label: "Paid for service?", isSelected: expCategory == EnumExpenseseCategoriesType.Service),
                              CIA_MultiSelectChipWidgeModel(
                                  label: "Paid for buying items?",
                                  isSelected:
                                      expCategory == EnumExpenseseCategoriesType.BoughtItem || expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                            ],
                            onChange: (item, isSelected) {
                              if (item == "Paid for service?")
                                expCategory = EnumExpenseseCategoriesType.Service;
                              else {
                                expCategory = EnumExpenseseCategoriesType.BoughtItem;
                              }

                              _setState(() {});
                            },
                          ),
                        );

                        r.add(SizedBox(height: 10));
                        r.add(
                          Visibility(
                            visible:
                                (expCategory == EnumExpenseseCategoriesType.BoughtItem || expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CIA_MultiSelectChipWidget(
                                key: GlobalKey(),
                                singleSelect: true,
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Bought nonMedical Item?", isSelected: expCategory == EnumExpenseseCategoriesType.BoughtItem),
                                  CIA_MultiSelectChipWidgeModel(
                                      label: "Bought Medical Item?", isSelected: expCategory == EnumExpenseseCategoriesType.BoughtMedical),
                                ],
                                onChange: (item, isSelected) {
                                  if (item == "Bought nonMedical Item?")
                                    expCategory = EnumExpenseseCategoriesType.BoughtItem;
                                  else
                                    expCategory = EnumExpenseseCategoriesType.BoughtMedical;
                                  _setState(() {});
                                },
                              ),
                            ),
                          ),
                        );

                        r.add(Row(
                          children: [
                            Expanded(
                              child: expCategory == EnumExpenseseCategoriesType.BoughtMedical
                                  ? Container()
                                  : CIA_MultiSelectChipWidget(
                                      onChange: (item, isSelected) {
                                        dummyModel.category = null;
                                        dummyModel.categoryId = null;
                                        _setState(() => newCategory = isSelected);
                                      },
                                      labels: [
                                        CIA_MultiSelectChipWidgeModel(label: "New Category", isSelected: newCategory),
                                      ],
                                    ),
                            ),
                            Expanded(
                              flex: 3,
                              child: expCategory == EnumExpenseseCategoriesType.BoughtMedical
                                  ? CIA_MultiSelectChipWidget(
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
                                        if (isSelected)
                                          _setState(() {
                                            medicalType = item;
                                          });
                                      },
                                    )
                                  : newCategory
                                      ? CIA_TextFormField(
                                          label: "Category",
                                          onChange: (value) {
                                            dummyModel.category = BasicNameIdObjectEntity(name: value);
                                            dummyModel.categoryId = null;
                                            models.forEach((element) {
                                              element.category = BasicNameIdObjectEntity(name: value);
                                              element.categoryId = null;
                                            });
                                          },
                                          controller: TextEditingController(text: dummyModel.category?.name ?? ""),
                                        )
                                      : CIA_DropDownSearchBasicIdName(
                                          label: "Category",
                                          asyncUseCase: expCategory == EnumExpenseseCategoriesType.Service
                                              ? sl<GetNonMedicalNonStockExpensesCategoriesUseCase>()
                                              : expCategory == EnumExpenseseCategoriesType.BoughtItem
                                                  ? sl<GetNonMedicalStockCategoriesUseCase>()
                                                  : sl<GetMedicalExpensesCategoriesUseCase>(),
                                          onSelect: (value) {
                                            dummyModel.category = value;
                                            dummyModel.categoryId = value.id;
                                            models.forEach((model) {});
                                          },
                                          selectedItem: dummyModel.category,
                                        ),
                            )
                          ],
                        ));
                        r.add(SizedBox(height: 10));
                        r.add(Row(
                          children: [
                            Expanded(
                              child: CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) {
                                  dummyModel.paymentMethod = null;
                                  dummyModel.paymentMethodId = null;
                                  _setState(() => newPaymentMethod = isSelected);
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "New Payment Method", isSelected: newPaymentMethod),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: newPaymentMethod
                                  ? CIA_TextFormField(
                                      label: "Payment Method",
                                      onChange: (value) {
                                        dummyModel.paymentMethod = BasicNameIdObjectEntity(name: value);
                                        dummyModel.paymentMethodId = null;
                                        models.forEach((model) {
                                          model.paymentMethod = BasicNameIdObjectEntity(name: value);
                                          model.paymentMethodId = null;
                                        });
                                      },
                                      controller: TextEditingController(text: dummyModel.paymentMethod?.name ?? ""),
                                    )
                                  : CIA_DropDownSearchBasicIdName(
                                      label: "Payment Method",
                                      asyncUseCase: sl<GetPaymentMethodsUseCase>(),
                                      onSelect: (value) {
                                        dummyModel.paymentMethod = value;
                                        dummyModel.paymentMethodId = value.id;
                                        models.forEach((model) {
                                          model.paymentMethod = value;
                                          model.paymentMethodId = value.id;
                                        });
                                      },
                                      selectedItem: dummyModel.paymentMethod,
                                    ),
                            )
                          ],
                        ));
                        r.add(SizedBox(height: 10));
                        r.add(Row(
                          children: [
                            Expanded(
                              child: CIA_MultiSelectChipWidget(
                                onChange: (item, isSelected) {
                                  dummyModel.supplier = null;
                                  dummyModel.supplierId = null;
                                  _setState(() => newSupplier = isSelected);
                                },
                                labels: [
                                  CIA_MultiSelectChipWidgeModel(label: "New Supplier", isSelected: newSupplier),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: newSupplier
                                  ? CIA_TextFormField(
                                      label: "Supplier",
                                      onChange: (value) {
                                        dummyModel.supplier = BasicNameIdObjectEntity(name: value);
                                        dummyModel.supplierId = null;
                                        models.forEach((element) {
                                          element.supplier = BasicNameIdObjectEntity(name: value);
                                          element.supplierId = null;
                                        });
                                      },
                                      controller: TextEditingController(text: dummyModel.supplier?.name ?? ""),
                                    )
                                  : CIA_DropDownSearchBasicIdName(
                                      label: "Supplier",
                                      asyncUseCase: sl<GetSuppliersUseCase>(),
                                      onSelect: (value) {
                                        dummyModel.supplier = value;
                                        dummyModel.supplierId = value.id;
                                        models.forEach((model) {
                                          model.supplier = value;
                                          model.supplierId = value.id;
                                        });
                                      },
                                      selectedItem: dummyModel.supplier,
                                    ),
                            )
                          ],
                        ));

                        if (expCategory == EnumExpenseseCategoriesType.BoughtMedical) {
                          if (medicalType == "Tacs") {
                            r.addAll(models
                                .map((model) => Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Tacs Company",
                                                asyncUseCase: sl<GetTacsUseCase>(),
                                                onSelect: (value) {
                                                  model.tac = value;
                                                  model.id = value.id;
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
                                                  _setState(() {});
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
                                                  total = 0;
                                                  models.forEach((element) {
                                                    total += element.price ?? 0;
                                                  });
                                                  _setState(() {});
                                                },
                                                label: "Price",
                                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            IconButton(
                                                onPressed: () {
                                                  int index = 0;
                                                  index = models.indexWhere((element) => element == model);
                                                  models.insert(
                                                      index + 1,
                                                      CashFlowEntity(
                                                        category: dummyModel.category,
                                                        categoryId: dummyModel.categoryId,
                                                        paymentMethod: dummyModel.paymentMethod,
                                                        paymentMethodId: dummyModel.paymentMethodId,
                                                        supplier: dummyModel.supplier,
                                                        supplierId: dummyModel.supplierId,
                                                      ));
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.add)),
                                            IconButton(
                                                onPressed: () {
                                                  models.remove(model);
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.remove))
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList());
                          } else if (medicalType == "Membranes") {
                            r.addAll(models
                                .map((model) => Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Membrane Company",
                                                asyncUseCase: sl<GetMembraneCompaniesUseCase>(),
                                                onSelect: (value) {
                                                  model.membraneCompany = value;
                                                  _setState(() {});
                                                },
                                                selectedItem: model.membraneCompany,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Membrane",
                                                asyncUseCase: model.membraneCompany == null ? null : sl<GetMembranesUseCase>(),
                                                searchParams: model.membraneCompany == null ? null : model.membraneCompany!.id!,
                                                onSelect: (value) {
                                                  model.id = value.id;
                                                  model.membrane = value;
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
                                                  _setState(() {});
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
                                                  total = 0;
                                                  models.forEach((element) {
                                                    total += element.price ?? 0;
                                                  });
                                                  _setState(() {});
                                                },
                                                label: "Price",
                                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            IconButton(
                                                onPressed: () {
                                                  int index = 0;
                                                  index = models.indexWhere((element) => element == model);
                                                  models.insert(
                                                      index + 1,
                                                      CashFlowEntity(
                                                        category: dummyModel.category,
                                                        categoryId: dummyModel.categoryId,
                                                        paymentMethod: dummyModel.paymentMethod,
                                                        paymentMethodId: dummyModel.paymentMethodId,
                                                        supplier: dummyModel.supplier,
                                                        supplierId: dummyModel.supplierId,
                                                      ));
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.add)),
                                            IconButton(
                                                onPressed: () {
                                                  models.remove(model);
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.remove))
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList());
                          } else if (medicalType == "Implants") {
                            r.addAll(models
                                .map((model) => Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Implant Company",
                                                asyncUseCase: sl<GetImplantCompaniesUseCase>(),
                                                onSelect: (value) {
                                                  model.implantCompany = value;
                                                  _setState(() {});
                                                },
                                                selectedItem: model.implantCompany,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Implant Line",
                                                asyncUseCase: model.implantCompany == null ? null : sl<GetImplantLinesUseCase>(),
                                                searchParams: model.implantCompany == null ? null : model.implantCompany!.id!,
                                                onSelect: (value) {
                                                  model.implantLine = value;
                                                  _setState(() {});
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: CIA_DropDownSearchBasicIdName(
                                                label: "Implant",
                                                asyncUseCase: model.implantLine == null ? null : sl<GetImplantSizesUseCase>(),
                                                searchParams: model.implantLine == null ? null : model.implantLine!.id!,
                                                onSelect: (value) {
                                                  model.id = value.id;
                                                  model.implant = value;
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
                                                  _setState(() {});
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
                                                  total = 0;
                                                  models.forEach((element) {
                                                    total += element.price ?? 0;
                                                  });
                                                  _setState(() {});
                                                },
                                                label: "Price",
                                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            IconButton(
                                                onPressed: () {
                                                  int index = 0;
                                                  index = models.indexWhere((element) => element == model);
                                                  models.insert(
                                                      index + 1,
                                                      CashFlowEntity(
                                                        category: dummyModel.category,
                                                        categoryId: dummyModel.categoryId,
                                                        paymentMethod: dummyModel.paymentMethod,
                                                        paymentMethodId: dummyModel.paymentMethodId,
                                                        supplier: dummyModel.supplier,
                                                        supplierId: dummyModel.supplierId,
                                                      ));
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.add)),
                                            IconButton(
                                                onPressed: () {
                                                  models.remove(model);
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.remove))
                                          ],
                                        ),
                                      ],
                                    ))
                                .toList());
                          } else if (medicalType == "Screws") {
                            models = [models.first];
                            models.first.name = "Screws";

                            sl<GetStockByNameUseCase>()("Screws").then((value) {
                              value.fold((l) => null, (r) => models.first.id = r.id);
                            });

                            r.add(SizedBox(height: 10));
                            r.add(
                              Row(
                                children: [
                                  Expanded(
                                    child: CIA_TextFormField(
                                      isNumber: true,
                                      onChange: (value) {
                                        if (value == null || value == "") value = "0";
                                        models.first.count = int.parse(value);
                                        _setState(() {});
                                      },
                                      label: "Screws Count",
                                      controller: TextEditingController(text: (models.first.count ?? 0).toString()),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: CIA_TextFormField(
                                      isNumber: true,
                                      onChange: (value) {
                                        if (value == null || value == "") value = "0";
                                        models.first.price = int.parse(value);
                                        total = 0;
                                        models.forEach((element) {
                                          total += element.price ?? 0;
                                        });
                                        _setState(() {});
                                      },
                                      label: "Price",
                                      controller: TextEditingController(text: (models.first.price ?? 0).toString()),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            );
                          } else {
                            sl<GetExpensesCategoryByNameUseCase>()("Other Medical").then(
                              (value) => value.fold(
                                (l) => null,
                                (r) {
                                  if (r != null) {
                                    dummyModel.category = r;
                                    dummyModel.categoryId = r.id;
                                  } else {
                                    dummyModel.category = BasicNameIdObjectEntity(name: "Other Medical");
                                  }
                                },
                              ),
                            );

                            r.addAll(models
                                .map((model) => Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CIA_TextFormField(
                                                  onChange: (value) => model.name = value,
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
                                                  total = 0;
                                                  models.forEach((element) {
                                                    total += element.price ?? 0;
                                                  });
                                                  _setState(() {});
                                                },
                                                label: "Price",
                                                controller: TextEditingController(text: (model.price ?? 0).toString()),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Visibility(
                                              visible: expCategory != EnumExpenseseCategoriesType.Service,
                                              child: Expanded(
                                                child: CIA_TextFormField(
                                                  isNumber: true,
                                                  onChange: (value) {
                                                    if (value == null || value == "") value = "0";
                                                    model.count = int.parse(value);
                                                    _setState(() {});
                                                  },
                                                  label: "Count",
                                                  controller: TextEditingController(text: (model.count ?? 0).toString()),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: expCategory != EnumExpenseseCategoriesType.Service ? 10 : 0),
                                            Expanded(
                                              child: CIA_TextFormField(
                                                onChange: (value) => model.notes = value,
                                                label: "Notes",
                                                controller: TextEditingController(text: model.notes ?? ""),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            IconButton(
                                                onPressed: () {
                                                  int index = 0;
                                                  index = models.indexWhere((element) => element == model);
                                                  models.insert(
                                                      index + 1,
                                                      CashFlowEntity(
                                                        category: dummyModel.category,
                                                        categoryId: dummyModel.categoryId,
                                                        paymentMethod: dummyModel.paymentMethod,
                                                        paymentMethodId: dummyModel.paymentMethodId,
                                                        supplier: dummyModel.supplier,
                                                        supplierId: dummyModel.supplierId,
                                                      ));
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.add)),
                                            IconButton(
                                                onPressed: () {
                                                  models.remove(model);
                                                  _setState(() {});
                                                },
                                                icon: Icon(Icons.remove))
                                          ],
                                        )
                                      ],
                                    ))
                                .toList());
                          }
                        } else {
                          r.addAll(models
                              .map((model) => Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CIA_TextFormField(
                                                onChange: (value) => model.name = value,
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
                                                total = 0;
                                                models.forEach((element) {
                                                  total += element.price ?? 0;
                                                });
                                                _setState(() {});
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
                                                _setState(() {});
                                              },
                                              label: "Count",
                                              controller: TextEditingController(text: (model.count ?? 0).toString()),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: CIA_TextFormField(
                                              onChange: (value) => model.notes = value,
                                              label: "Notes",
                                              controller: TextEditingController(text: model.notes ?? ""),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          IconButton(
                                              onPressed: () {
                                                int index = 0;
                                                index = models.indexWhere((element) => element == model);
                                                models.insert(
                                                    index + 1,
                                                    CashFlowEntity(
                                                      category: dummyModel.category,
                                                      categoryId: dummyModel.categoryId,
                                                      paymentMethod: dummyModel.paymentMethod,
                                                      paymentMethodId: dummyModel.paymentMethodId,
                                                      supplier: dummyModel.supplier,
                                                      supplierId: dummyModel.supplierId,
                                                    ));
                                                _setState(() {});
                                              },
                                              icon: Icon(Icons.add)),
                                          IconButton(
                                              onPressed: () {
                                                models.remove(model);
                                                _setState(() {});
                                              },
                                              icon: Icon(Icons.remove))
                                        ],
                                      )
                                    ],
                                  ))
                              .toList());
                        }

                        return r;
                      }(),
                    ),
                  ),
                ),
                Text("Total: ${total.toString()}")
              ],
            );
          },
        );
      }));
}
