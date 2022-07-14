import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/fonts.dart';

class InvoiceSetting extends StatefulWidget {
  const InvoiceSetting({Key? key}) : super(key: key);

  @override
  State<InvoiceSetting> createState() => _InvoiceSettingState();
}

class _InvoiceSettingState extends State<InvoiceSetting> {
  double width = 0.0;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [header("Settings")],
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
