import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/invoice_controller.dart';
import '../res/colors.dart';
import '../res/fonts.dart';
import 'invoice_list.dart';
import 'invoice_product.dart';
import 'invoice_setting.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  double width = 0.0;
  double height = 0.0;
  double statusBar = 0.0;
  int _selectedIndex = 0;
  InvoiceController _invoiceController = Get.put(InvoiceController());

  List<Widget> pages = [
    // Invoices(), Products(), InvoiceSetting()
    InvoiceList(), InvoiceProduct(), InvoiceSetting()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    statusBar = MediaQuery.of(context).padding.top;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height - statusBar;
    _invoiceController.searchInvoice.value = _invoiceController.invoiceList;
    _invoiceController.searchInvoiceProduct.value =
        _invoiceController.invoiceProductList;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Invoices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: statusBar),
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // header((_selectedIndex == 0)
            //     ? "Invoices"
            //     : (_selectedIndex == 1)
            //         ? "Products"
            //         : "Setting"),
            Expanded(child: pages[_selectedIndex])
          ],
        ),
      ),
    );
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
}
