import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/invoice_controller.dart';
import '../res/colors.dart';
import '../res/fonts.dart';

class InvoiceProduct extends StatefulWidget {
  const InvoiceProduct({Key? key}) : super(key: key);

  @override
  State<InvoiceProduct> createState() => _InvoiceProductState();
}

class _InvoiceProductState extends State<InvoiceProduct> {
  double width = 0.0;
  bool search = false;
  InvoiceController _invoiceController = Get.put(InvoiceController());
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Obx(
      () => Container(
        child: Column(
          children: [
            header("Products"),
            (search)
                ? searchContainer()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _invoiceController.invoiceProductList.length,
                    itemBuilder: (context, index) {
                      var data = _invoiceController.invoiceProductList[index];
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            topRow(data['name'].toString(),
                                "\$ ${data['amount']}"),
                            secondRow(data['description'].toString()),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  searchBox() {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: TextField(
        decoration: InputDecoration(
            labelText: 'Search Product',
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
            _invoiceController.searchInvoiceProductFunction(value);
          });
        },
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
                itemCount: _invoiceController.searchInvoiceProduct.length,
                itemBuilder: (context, index) {
                  var data = _invoiceController.searchInvoiceProduct[index];
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
                        topRow(data['name'].toString(), "\$ ${data['amount']}"),
                        secondRow(data['description'].toString()),
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
                        onTap: () {},
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

  secondRow(String value) {
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
                  value,
                  style: Fonts().regular(13, Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
          )
        ],
      ),
    );
  }
}
