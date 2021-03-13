import 'dart:async';
import 'dart:io';

// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:mlkit/mlkit.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:clipboard/clipboard.dart';

class BarcodeScanner extends StatefulWidget {
  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  File image;
  Future<File> imageFile;
  ImagePicker imagePicker;
  FirebaseVisionBarcodeDetector barcodeDetector =
      FirebaseVisionBarcodeDetector.instance;
  // List<VisionBarcode> _curBarcodeLabels = <VisionBarcode>[];

  FirebaseVisionTextDetector textDetector = FirebaseVisionTextDetector.instance;
  // List<VisionText> _curTextLabels = <VisionText>[];

  FirebaseVisionLabelDetector labelDetector =
      FirebaseVisionLabelDetector.instance;
  // List<VisionLabel> _curLabelLabels = <VisionLabel>[];

  FirebaseVisionFaceDetector faceDetector = FirebaseVisionFaceDetector.instance;
  // List<VisionFace> _curFaceLabels = <VisionFace>[];

  Stream sub;
  // StreamSubscription<dynamic> subscription;

  //----------------------------------
  String result = "";

  //------------------------------------------------------------

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   super.initState();
  //   imagePicker = ImagePicker();
  // }

  // void showInSnackBar(String value) {
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   _scaffoldKey.currentState?.removeCurrentSnackBar();
  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text(
  //       value,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16.0,
  //           fontFamily: "WorkSansSemiBold"),
  //     ),
  //     backgroundColor: Colors.blue,
  //     duration: Duration(seconds: 3),
  //   ));
  // }

  //-------------------------------------------------------------------

  deleteCurrentImage() {
    setState(() {
      image = null;
      result = "No image found yet!";
    });
  }

  captureImageWithMyCamera() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // showInSnackBar("Image Loaded!");

      setState(() {
        image = File(pickedFile.path); // Exception occurred here
        //Extracting text
        decodeBarCode();

        // performTextExtraction();
      });
    } else {
      result = "NO image selected";
      // showInSnackBar('PickedFile is null');
    }
  }

  pickImageFromMyGallery() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // showInSnackBar("Image Loaded!");

      setState(() {
        image = File(pickedFile.path); // Exception occurred here
        //Extracting text
        decodeBarCode();

        // performTextExtraction();
      });
    } else {
      // result = "NO image selected";
      // showInSnackBar('PickedFile is null');
    }
  }

  //------------------------------

  decodeBarCode() async {
    final FirebaseVisionImage myimg = FirebaseVisionImage.fromFile(image);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(myimg);
    result = "";
    setState(() {
      for (Barcode readableCode in barCodes) {
        result += (readableCode.displayValue) + "\n";
      }
    });
    if (result == "") result = "Sorry!!\n\n No Bar Codes detected!";
  }

  // performTextExtraction() async {
  // final FirebaseVisionImage firebaseVisionImage =
  //     FirebaseVisionImage.fromFile(image);

  // final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

  // VisionText visionText = await recognizer.processImage(firebaseVisionImage);

  // result = "";
  // setState(() {
  //   for (TextBlock block in visionText.blocks) {
  //     // ignore: unused_local_variable
  //     final String textss = block.text;

  //     for (TextLine line in block.lines) {
  //       for (TextElement element in line.elements) {
  //         result += element.text + " ";
  //       }
  //     }
  //     result += "\n\n";
  //   }
  // });
  // if (result == "") result = "Sorry!!\n\n No text detected!";
  // }

  //--------------------------------------------------------------------------

  // @override
  @override
  void initState() {
    super.initState();
    // sub = new Stream.empty();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode Reader"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              // backgroundBlendMode:
              image: DecorationImage(
            image: AssetImage("assets/back.jpg"),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              SizedBox(
                width: 300,
              ),

              //Output
              //--------------------------------------
              Container(
                height: 450,
                width: 350,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 80, bottom: 90, right: 40,top: 40),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SelectableText(
                      (result == "") ? "No image found yet!" : result,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    // backgroundBlendMode:
                    image: DecorationImage(
                  image: AssetImage("assets/note.jpg"),
                  fit: BoxFit.fill,
                )),
              ),

              Container(
                margin: EdgeInsets.only(top: 20, right: 140),
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/pin.png",
                            height: 240,
                            width: 240,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: () {
                          // deleteCurrentImage();
                          pickImageFromMyGallery();
                          decodeBarCode();
                          // performTextExtraction();
                        },
                        onLongPress: () {
                          // deleteCurrentImage();
                          captureImageWithMyCamera();
                          decodeBarCode();
                          // performTextExtraction();
                        },

                        //to check if image is picked
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          child: image != null
                              ? Image.file(
                                  image,
                                  width: 140,
                                  height: 192,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  width: 240,
                                  height: 200,
                                  child: Icon(
                                    Icons.camera,
                                    size: 100,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.delete,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {
                      deleteCurrentImage();
                    },
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.content_copy,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {
                      // deleteCurrentImage();
                      // newMethod
                      //     .setData(ClipboardData(text: result))
                      //     .then((result) {
                      //   // show toast or snackbar after successfully save
                      //   // Fluttertoast.showToast(msg: "copied");
                      // });
                    },
                  ),
                ],
              ),

              FlatButton(
                child: Text(
                  "*Long press on the camera icon to select image through camera \n*Or just tap on the camera icon to select image through gallery!\n*Click on the bin to Remove current Image and Text!\n\n",
                  // textScaleFactor: 2,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    // backgroundColor: Colors.black
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
