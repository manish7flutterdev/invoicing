import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoicing/src/screen/invoice_add_contact.dart';

import '../controller/invoice_controller.dart';
import '../res/colors.dart';
import '../res/fonts.dart';

class InvoiceCreate extends StatefulWidget {
  const InvoiceCreate({Key? key}) : super(key: key);

  @override
  State<InvoiceCreate> createState() => _InvoiceCreateState();
}

class _InvoiceCreateState extends State<InvoiceCreate> {
  double width = 0.0;

  TextEditingController _posoController = TextEditingController();
  TextEditingController _due = TextEditingController();
  TextEditingController _issue = TextEditingController();
  TextEditingController _discountAmount = TextEditingController();
  TextEditingController _quantity = TextEditingController(text: 1.toString());
  InvoiceController _invoiceController = Get.put(InvoiceController());

  @override
  void initState() {
    _invoiceController.newInvoice['invoiceNumber'] = "STA-0001";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _invoiceController.contactSelected.value = false;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Obx(
      () => Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            header("Create Invoice"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    addPerson(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        invoiceNumber("Invoice Number",
                            _invoiceController.newInvoice['invoiceNumber']),
                        posoNumber("P.O/S.O Number")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        issueDateWidget("Issue Date"),
                        dueDateWidget("Due Date")
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    productHeading(),
                    SizedBox(
                      height: 20,
                    ),
                    productListView(),
                    SizedBox(
                      height: 20,
                    ),
                    subtotal(),
                    SizedBox(
                      height: 30,
                    ),
                    discount(),
                    SizedBox(
                      height: 30,
                    ),
                    total(),
                    SizedBox(
                      height: 20,
                    ),
                    buttons(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  header(String text) {
    return Container(
        width: width,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 50,
                  child: Icon(
                    Icons.navigate_before,
                    color: CustomColours.greyColor[800]!,
                    size: 35,
                  ),
                ),
              ),
            ),
            Text(
              text,
              style: Fonts().bold(20, CustomColours.greyColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 40,
                height: 50,
              ),
            ),
          ],
        ));
  }

  buttons() {
    return Container(
      margin: EdgeInsets.all(20),
      width: width,
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              if (validation()) {
                preview();
              }
            },
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: CustomColours.bluePrimary),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Preview",
                    style: Fonts().bold(14, CustomColours.bluePrimary),
                  ),
                )),
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: CustomColours.bluePrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Save and Send",
                      style: Fonts().bold(14, Colors.white),
                    ),
                  )))
        ],
      ),
    );
  }

  addPerson() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: CustomColours.greyColor.withOpacity(0.5))),
      child: (_invoiceController.contactSelected.value)
          ? addPersonWidget(_invoiceController.contactIndex.value)
          : Center(
              child: InkWell(
              onTap: () {
                contactPopup();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add,
                      size: 28,
                      color: CustomColours.bluePrimary,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Add a contact",
                      style: Fonts().bold(18, CustomColours.bluePrimary),
                    )
                  ],
                ),
              ),
            )),
    );
  }

  addPersonWidget(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "To",
                style: Fonts().regular(15, Colors.black),
              ),
              InkWell(
                onTap: () {
                  contactPopup();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: Center(
                      child: Icon(
                    Icons.change_circle,
                    size: 30,
                  )),
                ),
              )
            ],
          ),
          Text(_invoiceController.contactList[index]['name'].toString(),
              style: Fonts().bold(17, Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text(_invoiceController.contactList[index]['email'].toString(),
              style: Fonts().semiBold(15, Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text(_invoiceController.contactList[index]['phone'].toString(),
              style: Fonts().semiBold(15, Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text(_invoiceController.contactList[index]['address'].toString(),
              style: Fonts().semiBold(15, Colors.black))
        ],
      ),
    );
  }

  invoiceNumber(String heading, value) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 2),
                width: width / 2.5,
                height: 45,
                decoration: BoxDecoration(
                  color: CustomColours.greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      value,
                      style: Fonts().bold(14, Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  posoNumber(String heading) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              width: width / 2.5,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: CustomColours.greyColor.withOpacity(0.5))),
              child: TextField(
                onChanged: (value) {
                  _invoiceController.newInvoice['posoNumber'] = value;
                  print(_invoiceController.newInvoice);
                },
                controller: _posoController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 8, right: 8, bottom: 6),
                    border: InputBorder.none),
                minLines: 1,
                style: Fonts().regular(14, CustomColours.greyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  issueDateWidget(String heading) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
                width: width / 2.5,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: CustomColours.greyColor.withOpacity(0.5))),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Center(
                        child: Text(
                          _invoiceController.issueDate.toString(),
                          style: Fonts().bold(15, Colors.black),
                        ),
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        _selectIssueDate(context);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Center(
                          child: Icon(
                            Icons.calendar_month,
                            color: CustomColours.bluePrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  _selectIssueDate(BuildContext context) async {
    var selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));

    if (selected != null)
      setState(() {
        _invoiceController.issueDate.value =
            "${selected.day}-${selected.month}-${selected.year}";
      });
  }

  dueDateWidget(String heading) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
                width: width / 2.5,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: CustomColours.greyColor.withOpacity(0.5))),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Center(
                        child: Text(
                          _invoiceController.dueDate.toString(),
                          style: Fonts().bold(15, Colors.black),
                        ),
                      ),
                    )),
                    InkWell(
                      onTap: () {
                        _selectDueDate(context);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        child: Center(
                          child: Icon(
                            Icons.calendar_month,
                            color: CustomColours.bluePrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  _selectDueDate(BuildContext context) async {
    var selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (selected != null)
      setState(() {
        _invoiceController.dueDate.value =
            "${selected.day}-${selected.month}-${selected.year}";
      });
  }

  quantity(String heading) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
                width: width / 3,
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        _invoiceController.reduceQuantity();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey[500]!),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                        child: Center(
                          child: Icon(Icons.remove),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[500]!),
                      ),
                      child: Center(
                        child: Text(
                          _invoiceController.newProductQuantity.toString(),
                          style: Fonts().bold(16, Colors.black),
                        ),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        _invoiceController.addQuantity();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.grey[500]!),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    )),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  amount(String heading, String amount) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
                width: width / 3.5,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: CustomColours.greyColor.withOpacity(0.5))),
                child: Center(child: Text(amount.toString()))),
          ),
        ],
      ),
    );
  }

  productHeading() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Products",
            style: Fonts().bold(25, Colors.black),
          ),
          InkWell(
            onTap: () {
              popup();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: CustomColours.bluePrimary),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  subtotal() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Subtotal",
            style: Fonts().bold(18, Colors.black),
          ),
          Text(
            "\$ " + _invoiceController.subTotal.toString(),
            style: Fonts().bold(18, Colors.black),
          ),
        ],
      ),
    );
  }

  discount() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.discount,
                color: CustomColours.bluePrimary,
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (_invoiceController.newInvoice['products'].length == 0) {
                  } else {
                    discountPopup();
                  }
                },
                child: Text(
                  (_invoiceController.discount.value == 0.0)
                      ? "Add Discount"
                      : "Total Discount",
                  style: Fonts().bold(18, CustomColours.bluePrimary),
                ),
              ),
            ],
          ),
          (_invoiceController.discount.value == 0.0)
              ? Container()
              : Text(
                  "\$ " + _invoiceController.discount.toString(),
                  style: Fonts().bold(18, Colors.black),
                ),
        ],
      ),
    );
  }

  total() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total",
            style: Fonts().bold(20, Colors.black),
          ),
          Text(
            "\$ " +
                (_invoiceController.subTotal.value -
                        _invoiceController.discount.value)
                    .toString(),
            style: Fonts().bold(20, Colors.black),
          ),
        ],
      ),
    );
  }

  productListView() {
    return Obx(() => ListView.builder(
        padding: EdgeInsets.zero,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: _invoiceController.newInvoice['products'].length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[500]!,
                    offset: const Offset(
                      0.0,
                      2.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _invoiceController.newInvoice['products'][index]
                                    ['productName']
                                .toString(),
                            style: Fonts().bold(15, Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: 90,
                          child: Text(
                            "\$ ${_invoiceController.newInvoice['products'][index]['total'].toString()}",
                            style: Fonts().bold(15, Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              _invoiceController.newInvoice['products'][index]
                                      ['quantity']
                                  .toString(),
                              style: Fonts().regular(15, Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "X",
                              style: Fonts().regular(15, Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _invoiceController.newInvoice['products'][index]
                                      ['unitPrice']
                                  .toString(),
                              style: Fonts().regular(15, Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            _invoiceController.removeProduct(index);
                            _invoiceController.calculateSubtotal();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: Icon(Icons.delete),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ));
        }));
  }

  discountAmountBox(String heading) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: Fonts().bold(12, Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: width,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: CustomColours.greyColor.withOpacity(0.5))),
              child: TextField(
                onChanged: (value) {},
                controller: _discountAmount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 8, right: 8, bottom: 6),
                    border: InputBorder.none),
                minLines: 1,
                style: Fonts().regular(14, CustomColours.greyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  discountPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: Colors.black.withOpacity(0),
                child: Obx(() => Container(
                      margin: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          // color: Colors.white, //
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(12),
                                      child: Image.asset(
                                          'assets/images/cancel.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Discount",
                                      style: Fonts().bold(20, Colors.black),
                                    ),
                                    Container()
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Type",
                                      style: Fonts().bold(18, Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _invoiceController
                                                .percentDollar.value = true;
                                          },
                                          child: Container(
                                            width: 70,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                ),
                                                color: (_invoiceController
                                                            .percentDollar
                                                            .value ==
                                                        true)
                                                    ? CustomColours.bluePrimary
                                                    : Colors.white,
                                                border: Border.all(
                                                    color: CustomColours
                                                        .bluePrimary)),
                                            child: Center(
                                              child: Text(
                                                "%",
                                                style: Fonts().bold(
                                                  18,
                                                  (_invoiceController
                                                              .percentDollar
                                                              .value ==
                                                          true)
                                                      ? Colors.white
                                                      : CustomColours
                                                          .bluePrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _invoiceController
                                                .percentDollar.value = false;
                                          },
                                          child: Container(
                                            width: 70,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                color: (_invoiceController
                                                            .percentDollar
                                                            .value ==
                                                        true)
                                                    ? Colors.white
                                                    : CustomColours.bluePrimary,
                                                border: Border.all(
                                                    color: CustomColours
                                                        .bluePrimary)),
                                            child: Center(
                                              child: Text(
                                                "\$",
                                                style: Fonts().bold(
                                                  18,
                                                  (_invoiceController
                                                              .percentDollar
                                                              .value ==
                                                          false)
                                                      ? Colors.white
                                                      : CustomColours
                                                          .bluePrimary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              discountAmountBox(
                                  (_invoiceController.percentDollar.value ==
                                          true)
                                      ? "Percentage"
                                      : "Amount"),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_invoiceController.percentDollar.value ==
                                      false) {
                                    _invoiceController.discount.value =
                                        double.parse(_discountAmount.text);
                                  } else {
                                    _invoiceController
                                        .discount.value = _invoiceController
                                            .subTotal.value *
                                        (double.parse(_discountAmount.text) /
                                            100);
                                  }
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: CustomColours.bluePrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Add Discount",
                                      style: Fonts().bold(15, Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]),
                          )
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  popup() {
    _invoiceController.newProductQuantity.value = 1;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: Colors.black.withOpacity(0),
                child: Obx(() => Container(
                      margin: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          // color: Colors.white, //
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _invoiceController
                                          .newProductQuantity.value = 1;
                                      _invoiceController.updateNewProduct();
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(12),
                                      child: Image.asset(
                                          'assets/images/cancel.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add Item",
                                      style: Fonts().bold(18, Colors.black),
                                    ),
                                    Text(
                                      "\$ ${_invoiceController.newProductMap['total']}",
                                      style: Fonts().bold(18, Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              productDropdown(),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    quantity("Quantity"),
                                    amount(
                                        "Amount (\$)",
                                        _invoiceController
                                            .newProductMap['unitPrice']
                                            .toString())
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  _invoiceController.addProductToInvoice();
                                  _invoiceController.calculateSubtotal();

                                  _invoiceController.updateNewProduct();
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: CustomColours.bluePrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Add Product",
                                      style: Fonts().bold(15, Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]),
                          )
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  productDropdown() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: CustomColours.greyColor[50],
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 12),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(10),
            value: _invoiceController.productsDropDownValue.value,
            onChanged: (newValue) {
              setState(() {
                _invoiceController.productsDropDownValue.value =
                    newValue.toString();
                _invoiceController.updateNewProduct();
              });
            },
            hint: Text(
              "Select a Product",
              style: Fonts().semiBold(13, Colors.black),
            ),
            style: Fonts().semiBold(13, Colors.black),
            //     icon: Icon(Icons.arrow_drop_down),
            icon: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 15,
            isExpanded: true,
            underline: SizedBox(),
            items: _invoiceController.invoiceProductList.map((var valueItem) {
              return DropdownMenuItem(
                value: valueItem['name'],
                child: Text(valueItem['name'].toString()),
              );
            }).toList(),
          ),
        ));
  }

  contactPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: Colors.black.withOpacity(0),
                child: Obx(() => Container(
                      margin: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          // color: Colors.white, //
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      padding: EdgeInsets.all(12),
                                      child: Image.asset(
                                          'assets/images/cancel.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Select Contact",
                                style: Fonts().bold(18, Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              contactDropDown(),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  _invoiceController.contactSelected.value =
                                      true;
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: CustomColours.bluePrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Select",
                                      style: Fonts().bold(15, Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "or",
                                style: Fonts().bold(14, Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Get.to(() => InvoiceAddContact());
                                },
                                child: Container(
                                  height: 50,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: CustomColours.bluePrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Add a Contact",
                                      style: Fonts().bold(15, Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ]),
                          )
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  contactDropDown() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: CustomColours.greyColor[50],
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(right: 4.0, left: 12),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(10),
            value: _invoiceController.contactDropdown.value,
            onChanged: (newValue) {
              setState(() {
                _invoiceController.contactDropdown.value = newValue.toString();
                _invoiceController.updateContactIndex();
              });
            },
            hint: Text(
              "Select a Contact",
              style: Fonts().semiBold(13, Colors.black),
            ),
            style: Fonts().semiBold(13, Colors.black),
            //     icon: Icon(Icons.arrow_drop_down),
            icon: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 15,
            isExpanded: true,
            underline: SizedBox(),
            items: _invoiceController.contactList.map((var valueItem) {
              return DropdownMenuItem(
                value: valueItem['name'],
                child: Text(valueItem['name'].toString()),
              );
            }).toList(),
          ),
        ));
  }

  validation() {
    if (_invoiceController.contactSelected.value == false) {
      errorBox(context, "Please select a Contact");
      return false;
    } else if (_invoiceController.newInvoice['posoNumber'] == '') {
      errorBox(context, "Please Enter PO/SO Number");
      return false;
    } else if (_invoiceController.issueDate == '') {
      errorBox(context, "Please select issue date");
      return false;
    } else if (_invoiceController.dueDate == '') {
      errorBox(context, "Please select due date");
      return false;
    } else if (_invoiceController.newInvoice['products'].length == 0) {
      errorBox(context, "Please add products");
      return false;
    } else {
      return true;
    }
  }

  void errorBox(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            text,
            style: Fonts().semiBold(17, Colors.black),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  preview() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: Colors.black.withOpacity(0),
                child: Obx(() => Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 50,
                                  width: 50,
                                  padding: EdgeInsets.all(12),
                                  child: Icon(
                                    Icons.cancel,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      child: Text(
                                        "Invoice #${_invoiceController.newInvoice['invoiceNumber']}",
                                        style: Fonts().bold(15, Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Status",
                                                      style: Fonts().bold(
                                                          12, Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        'Draft',
                                                        style: Fonts().bold(
                                                            11, Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Contact",
                                                      style: Fonts().bold(
                                                          12, Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    width: width / 2,
                                                    child: Text(
                                                      _invoiceController
                                                          .contactList[
                                                              _invoiceController
                                                                  .contactIndex
                                                                  .value]
                                                              ['name']
                                                          .toString(),
                                                      style: Fonts().bold(
                                                          14,
                                                          CustomColours
                                                              .bluePrimary),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Amount",
                                                      style: Fonts().semiBold(
                                                          12, Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "\$ " +
                                                          (_invoiceController
                                                                      .subTotal
                                                                      .value -
                                                                  _invoiceController
                                                                      .discount
                                                                      .value)
                                                              .toString(),
                                                      style: Fonts().semiBold(
                                                          14, Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "Due",
                                                      style: Fonts().semiBold(
                                                          12, Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      _invoiceController
                                                          .dueDate.value,
                                                      style: Fonts().semiBold(
                                                          14, Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: width,
                                          height: 1,
                                          color: CustomColours.greyColor
                                              .withOpacity(0.3),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                              child: Text(
                                                "Invoice",
                                                style: Fonts()
                                                    .semiBold(17, Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        userDetailRow(),
                                        SizedBox(height: 10),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: width,
                                          height: 1,
                                          color: CustomColours.greyColor
                                              .withOpacity(0.3),
                                        ),
                                        billRow(),
                                        invoiceBillDetails(),
                                        SizedBox(height: 15),
                                        invoiceProductListPreview(),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        amounts(),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  userDetailRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _invoiceController.userInfo['companyName'].toString(),
                style: Fonts().bold(12, Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _invoiceController.userInfo['email'].toString(),
                style: Fonts().regular(11, Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _invoiceController.userInfo['phone'].toString(),
                style: Fonts().regular(11, Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _invoiceController.userInfo['address'].toString(),
                style: Fonts().regular(11, Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _invoiceController.userInfo['country'].toString(),
                style: Fonts().regular(11, Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  billRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Bill to:",
                style: Fonts().bold(12, Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _invoiceController
                    .contactList[_invoiceController.contactIndex.toInt()]
                        ['name']
                    .toString(),
                style: Fonts().bold(12, Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                _invoiceController
                    .contactList[_invoiceController.contactIndex.toInt()]
                        ['email']
                    .toString(),
                style: Fonts().regular(12, Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  invoiceBillDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Invoice number: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    _invoiceController.newInvoice['invoiceNumber'].toString(),
                    style: Fonts().regular(11, Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "P.O/S.O. number: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    _invoiceController.newInvoice['posoNumber'].toString(),
                    style: Fonts().regular(11, Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Invoice Date: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    _invoiceController.issueDate.toString(),
                    style: Fonts().regular(11, Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Payment due: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    _invoiceController.dueDate.toString(),
                    style: Fonts().regular(11, Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Amount due: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    "\$ " +
                        (_invoiceController.subTotal.value -
                                _invoiceController.discount.value)
                            .toString(),
                    style: Fonts().regular(11, Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  invoiceProductListPreview() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: _invoiceController.newInvoice['products'].length,
        itemBuilder: (context, index) {
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!)),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _invoiceController.newInvoice['products'][index]
                                    ['productName']
                                .toString(),
                            style: Fonts().bold(10, Colors.black),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: 90,
                          child: Text(
                            "\$ ${_invoiceController.newInvoice['products'][index]['total'].toString()}",
                            style: Fonts().bold(10, Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              _invoiceController.newInvoice['products'][index]
                                      ['quantity']
                                  .toString(),
                              style: Fonts().regular(10, Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "X",
                              style: Fonts().regular(12, Colors.black),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              _invoiceController.newInvoice['products'][index]
                                      ['unitPrice']
                                  .toString(),
                              style: Fonts().regular(10, Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 1,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ));
        });
  }

  amounts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Subtotal: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    "\$ " + _invoiceController.subTotal.toString(),
                    style: Fonts().regular(10, Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Total: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    "\$ " +
                        (_invoiceController.subTotal.value -
                                _invoiceController.discount.value)
                            .toString(),
                    style: Fonts().regular(10, Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Amount due: ",
                    style: Fonts().bold(11, Colors.black),
                  ),
                  Text(
                    "\$ " +
                        (_invoiceController.subTotal.value -
                                _invoiceController.discount.value)
                            .toString(),
                    style: Fonts().regular(10, Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ],
    );
  }
}
