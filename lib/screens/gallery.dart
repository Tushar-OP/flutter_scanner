import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_genius_scan/flutter_genius_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final picker = ImagePicker();

  getImageAndProcess() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    FlutterGeniusScan.scanWithConfiguration({
      'source': 'image',
      'sourceImageUrl': pickedFile.path,
      'multiPage': true,
    }).then((result) {
      String pdfUrl = result['pdfUrl'];

      OpenFile.open(pdfUrl.replaceAll("file://", '')).then(
        (result) => debugPrint(result.toString()),
        onError: (error) => displayError(context, error),
      );
    }, onError: (error) => displayError(context, error));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getImageAndProcess(),
      child: Card(
        child: Center(
          child: Text(
            'Pick from Gallery',
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
