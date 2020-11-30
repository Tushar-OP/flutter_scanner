import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:open_file/open_file.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FlutterGeniusScan.scanWithConfiguration({
          'source': 'camera',
          'multiPage': true,
        }).then((result) {
          String pdfUrl = result['pdfUrl'];
          OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
            (result) => debugPrint(result.message),
            onError: (error) => displayError(context, error),
          );
        }, onError: (error) => displayError(context, error));
      },
      child: Card(
        child: Center(
          child: Text(
            'Pick from Camera',
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }

  void displayError(BuildContext context, PlatformException error) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.message)));
  }
}
