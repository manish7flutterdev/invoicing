import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/invoice_controller.dart';
import '../res/colors.dart';
import '../res/fonts.dart';
import 'invoice_create.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  double width = 0.0;
  int tabIndex = 0;
  InvoiceController _invoiceController = Get.put(InvoiceController());
  TextEditingController _search = TextEditingController();
  bool search = false;

  List data = [
    {
      "name": "Surjit Singh",
      "amount": 30,
      "invoiceNumber": "STA-0001",
      "due": "due 7 days ago",
      "status": "unpaid",
    },
    {
      "name": "Surjit Singh",
      "amount": 40,
      "invoiceNumber": "STA-0002",
      "due": "due 7 days ago",
      "status": "unpaid",
    },
    {
      "name": "Surjit Singh",
      "amount": 50,
      "invoiceNumber": "STA-0003",
      "due": "due 7 days ago",
      "status": "unpaid",
    },
    {
      "name": "Surjit Singh",
      "amount": 100,
      "invoiceNumber": "STA-0004",
      "due": "due 7 days ago",
      "status": "draft",
    },
    {
      "name": "Surjit Singh",
      "amount": 80,
      "invoiceNumber": "STA-0005",
      "due": "due 7 days ago",
      "status": "draft",
    },
  ];

  @override
  Widget build(BuildContext context) {
    print(tabIndex);
    width = MediaQuery.of(context).size.width;
    return Obx(
      () => Container(
        child: Column(
          children: [
            header("invoices"),
            (search)
                ? searchContainer()
                : DefaultTabController(
                    length: 4,
                    initialIndex: tabIndex,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(tabs: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'ALL',
                                  style: Fonts().medium(13, Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'DRAFT',
                                  style: Fonts().medium(13, Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'PAID',
                                  style: Fonts().medium(13, Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  'UNPAID',
                                  style: Fonts().medium(13, Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                          ]),
                          Expanded(
                              child: Container(
                            child: TabBarView(children: [
                              list(_invoiceController.invoiceList, 'all'),
                              list(_invoiceController.invoiceList, 'draft'),
                              list(_invoiceController.invoiceList, 'paid'),
                              list(_invoiceController.invoiceList, 'unpaid'),
                            ]),
                          ))
                        ],
                      ),
                    ))
          ],
        ),
      ),
    );
  }

  searchContainer() {
    return Expanded(
        child: Container(
      child: Column(
        children: [
          searchBox(),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _invoiceController.searchInvoice.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        topRow(
                            _invoiceController.searchInvoice[index]['name']
                                .toString(),
                            "\$ ${_invoiceController.searchInvoice[index]['amount']}"),
                        secondRow(
                            _invoiceController.searchInvoice[index]
                                    ['invoiceNumber']
                                .toString(),
                            _invoiceController.searchInvoice[index]['due']
                                .toString()),
                        thirdRow(_invoiceController.searchInvoice[index]
                                ['status']
                            .toString()),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }

  list(var data, String tab) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        shrinkWrap: true,
        itemCount: _invoiceController.invoiceList.length,
        itemBuilder: (context, index) {
          return (tab == "all")
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        topRow(
                            _invoiceController.invoiceList[index]['name']
                                .toString(),
                            "\$ ${_invoiceController.invoiceList[index]['amount']}"),
                        secondRow(
                            _invoiceController.invoiceList[index]
                                    ['invoiceNumber']
                                .toString(),
                            _invoiceController.invoiceList[index]['due']
                                .toString()),
                        thirdRow(_invoiceController.invoiceList[index]['status']
                            .toString()),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                )
              : (_invoiceController.invoiceList[index]['status'] == tab)
                  ? InkWell(
                      onTap: () {
                        if (_invoiceController.invoiceList[index]['status'] ==
                            'draft') {
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                height: 250,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "Draft",
                                            style:
                                                Fonts().bold(25, Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.visibility,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    topRow(
                                        _invoiceController.invoiceList[index]
                                                ['name']
                                            .toString(),
                                        "\$ ${_invoiceController.invoiceList[index]['amount']}"),
                                    topRow(
                                        _invoiceController.invoiceList[index]
                                                ['invoiceNumber']
                                            .toString(),
                                        "${_invoiceController.invoiceList[index]['due']}"),
                                    Expanded(child: SizedBox()),
                                    bottomButton()
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            topRow(
                                _invoiceController.invoiceList[index]['name']
                                    .toString(),
                                "\$ ${_invoiceController.invoiceList[index]['amount']}"),
                            secondRow(
                                _invoiceController.invoiceList[index]
                                        ['invoiceNumber']
                                    .toString(),
                                _invoiceController.invoiceList[index]['due']
                                    .toString()),
                            thirdRow(_invoiceController.invoiceList[index]
                                    ['status']
                                .toString()),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ),
                    )
                  : Container();
        });
  }

  bottomButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: CustomColours.greyColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Cancel",
                style: Fonts().bold(15, CustomColours.greyColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 40,
              decoration: BoxDecoration(
                color: CustomColours.bluePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: Fonts().bold(15, Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  header(String text) {
    return Container(
        width: width,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: Row(
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
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  text,
                  style: Fonts().bold(20, CustomColours.greyColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            search = !search;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 50,
                          child: Icon(
                            Icons.search,
                            color: (search) ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => InvoiceCreate());
                        },
                        child: Container(
                          width: 40,
                          height: 50,
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  searchBox() {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: TextField(
        decoration: InputDecoration(
            labelText: 'Search Invoice',
            labelStyle: Fonts().semiBold(14, CustomColours.greyColor[400]!),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: CustomColours.greyColor[400]!),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: CustomColours.bluePrimary[900]!),
              borderRadius: BorderRadius.circular(8),
            )),
        controller: _search,
        onChanged: (value) {
          setState(() {
            _invoiceController.searchInvoiceFunction(value);
          });
        },
      ),
    );
  }
}

topRow(String first, second) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first,
                style: Fonts().bold(15, Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                second,
                style: Fonts().bold(15, Colors.black),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

secondRow(String first, second) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first,
                style: Fonts().regular(13, Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                second,
                style: Fonts().regular(13, CustomColours.redColor),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

thirdRow(String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          width: 70,
          decoration: BoxDecoration(
              color: (value == 'unpaid')
                  ? CustomColours.orangePrimary
                  : CustomColours.bluePrimary,
              borderRadius: BorderRadius.circular(4)),
          child: Center(
            child: Text(
              value == 'unpaid'
                  ? "Overdue"
                  : (value == 'paid')
                      ? "Paid"
                      : "Draft",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
        ),
        Icon(Icons.edit)
      ],
    ),
  );
}
