import 'package:flutter/material.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesseract_ocr_example/result.dart';

void main() => runApp(MaterialApp(home: MyApp(),));
var text;
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _scanning = false;
  String _extractText = '';
  int _scanTime = 0;
  File _selectedFile;
  bool _inProcess = false;

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/placeholder.jpg",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

    getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.blueGrey[900],
            toolbarTitle: "Crop",
            statusBarColor: Colors.blueGrey[900],
            backgroundColor: Colors.black54,

          )
      );
      text = (await TesseractOcr.extractText(cropped.path, language: 'eng')).toString();
      Navigator.push(context,MaterialPageRoute(builder: (context)=>FfirstRoute(text: text,)));


      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("OCRmaKe",style: TextStyle(letterSpacing: 3),),
          titleSpacing: 15.0,
        ),
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img2.jpg'),
                  fit: BoxFit.cover,
                )
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[

                SafeArea(
                  child: Container(
                    height: 10,
                    width: 10,
                    alignment: Alignment.topCenter,
                    color: Colors.white10,
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: SizedBox(
                      height: 70 ,
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Text("Designed by Shivansh Amattya",style: TextStyle(color: Colors.brown[400],letterSpacing: 8,fontWeight: FontWeight.bold,fontSize: 13.5,fontFamily: "Pacifico"),),
                    ),
                  ),
                ),
              ],
            ) ,
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        backgroundColor: Colors.blueGrey[900],
        onPressed: ()
        {
          getImage(ImageSource.camera);
        },
      ),
      );

  }
}


