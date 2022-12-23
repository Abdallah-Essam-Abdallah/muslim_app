import 'package:flutter/material.dart';
import 'package:muslim_app/configs/size_config.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;

  const CustomDialog(this.content, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.right,
      ),
      content: Text(
        content,
        textAlign: TextAlign.right,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text(
              'الغاء',
              textAlign: TextAlign.right,
            ))
      ],
    );
  }
}

class DisconectedInternetWidget extends StatelessWidget {
  const DisconectedInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_statusbar_connected_no_internet_4,
              size: SizeConfig.screenHeight! * .35,
              color: Colors.red[900],
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * .01,
            ),
            Text(
              'تعذر الاتصال بالانترنت ',
              style: TextStyle(fontSize: SizeConfig.screenWidth! * .10),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * .15,
            ),
          ],
        ),
      ),
    );
  }
}
