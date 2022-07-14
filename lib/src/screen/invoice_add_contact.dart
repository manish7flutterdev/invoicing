import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/invoice_controller.dart';
import '../res/colors.dart';
import '../res/fonts.dart';

class InvoiceAddContact extends StatefulWidget {
  const InvoiceAddContact({Key? key}) : super(key: key);

  @override
  State<InvoiceAddContact> createState() => _InvoiceAddContactState();
}

class _InvoiceAddContactState extends State<InvoiceAddContact> {
  double width = 0.0;
  int tabIndex = 0;
  InvoiceController _invoiceController = Get.put(InvoiceController());
  TextEditingController _contactName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zipcode = TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController __website = TextEditingController();
  TextEditingController _fax = TextEditingController();
  TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            header("Add a Contact"),
            DefaultTabController(
                length: 3,
                initialIndex: tabIndex,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(tabs: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'CONTACT',
                              style: Fonts().medium(13, Colors.black),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'BILLING',
                              style: Fonts().medium(13, Colors.black),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              'MORE',
                              style: Fonts().medium(13, Colors.black),
                              textAlign: TextAlign.center,
                            )),
                      ]),
                      Expanded(
                          child: Container(
                        child: TabBarView(
                            children: [contact(), billing(), more()]),
                      )),
                      (MediaQuery.of(context).viewInsets.bottom == 0)
                          ? bottomButton()
                          : Container()
                    ],
                  ),
                )),
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

  contact() {
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            textField("Contact Name", _contactName, red: true),
            SizedBox(
              height: 12,
            ),
            textField("Email", _email, red: true),
            SizedBox(
              height: 12,
            ),
            textField("Phone", _phone)
          ],
        ),
      ),
    );
  }

  billing() {
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            textField("Address", _address),
            SizedBox(
              height: 10,
            ),
            textField("City", _city),
            SizedBox(
              height: 10,
            ),
            textField("State", _state),
            SizedBox(
              height: 10,
            ),
            textField("Zip Code", _zipcode),
            SizedBox(
              height: 10,
            ),
            textField("Country", _country),
          ],
        ),
      ),
    );
  }

  more() {
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            textField("Website", __website),
            SizedBox(
              height: 10,
            ),
            textField("Fax", _fax),
            SizedBox(
              height: 10,
            ),
            textField("Notes", _notes),
          ],
        ),
      ),
    );
  }

  textField(String heading, TextEditingController controller,
      {bool red = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                heading,
                style: Fonts().bold(12, Colors.black),
              ),
              (red)
                  ? Text(
                      "*",
                      style: Fonts().bold(15, CustomColours.redColor),
                    )
                  : Container()
            ],
          ),
          SizedBox(
            height: 15,
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
                controller: controller,
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
            onTap: () {
              if (validation()) {
                submit();
              }
            },
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

  validation() {
    if (_contactName.text == '') {
      errorBox(context, "Please enter contact Name");
      return false;
    } else if (_email.text == '') {
      errorBox(context, "Please enter email");
      return false;
    } else {
      return true;
    }
  }

  submit() {
    var data = {
      "name": _contactName.text,
      "email": _email.text,
      "phone": _phone.text,
      "address": _address.text,
      "city": _city.text,
      "state": _state.text,
      "zip": _zipcode.text,
      "country": _country.text,
      "website": __website.text,
      "fax": _fax.text,
      "notes": _notes.text
    };
    _invoiceController.contactList.add(data);
    Navigator.pop(context);
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
}
