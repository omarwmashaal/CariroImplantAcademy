import 'package:cariro_implant_academy/Constants/Controllers.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PopUp.dart';
import 'package:cariro_implant_academy/Widgets/CIA_PrimaryButton.dart';
import 'package:cariro_implant_academy/Widgets/SearchLayout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/LAB_CustomerModel.dart';
import '../../Widgets/Title.dart';
import 'LAB_ViewCustomer.dart';

class LAB_CustomersSearchPage extends StatefulWidget {
  const LAB_CustomersSearchPage({Key? key}) : super(key: key);

  @override
  State<LAB_CustomersSearchPage> createState() =>
      _LAB_CustomersSearchPageState();
}

class _LAB_CustomersSearchPageState extends State<LAB_CustomersSearchPage> {
  CustomerDataSource dataSource = CustomerDataSource();
  late CustomerInfoModel selectedCustomer =
      CustomerInfoModel(1, "Name", "Phone", "ClinicName", "ClinicAddress");

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: internalPagesController,
      children: [
        Column(
          children: [
            Expanded(child: SizedBox()),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TitleWidget(
                      title: "Customers Data",
                    ),
                  ),
                  CIA_PrimaryButton(
                      label: "Add Customer",
                      width: 150,
                      isLong: true,
                      onTab: () {
                        CIA_ShowPopUp(context, "Add new Customer", Text(""));
                      }),
                  SizedBox(width: 30)
                ],
              ),
            )),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SearchLayout(
                  radioButtons: [
                    "Name",
                    "Phone",
                    "ID",
                    "Clinic Name",
                  ],
                  dataSource: dataSource,
                  columnNames: CustomerInfoModel.columns,
                  onCellTab: (value) {
                    print(dataSource.models[value - 1].ID);
                    setState(() {
                      selectedCustomer = dataSource.models[value - 1];
                    });
                    internalPagesController.jumpToPage(1);
                  },
                ),
              ),
            )
          ],
        ),
        LAB_ViewCustomerPage(
          customer: selectedCustomer,
        )
        // ViewCustomerPage()
      ],
    );
  }
}
