import 'dart:io';
import 'dart:async';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:clipboard/clipboard.dart';
class FaceScanner extends StatefulWidget {
  @override
  _FaceScannerState createState() => _FaceScannerState();
}

class _FaceScannerState extends State<FaceScanner> {
  File image;
  var imgfile;
  Future<File> imageFile;
  ImagePicker imagePicker;
  bool isFaceDetected = false;

  //----------------------------------
  String result = "";
  List<Rect> rect = new List<Rect>();

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
    var tempStore = await ImagePicker().getImage(source: ImageSource.camera);

    if (tempStore != null) {
      imgfile = await tempStore.readAsBytes();
      imgfile = await decodeImageFromList(imgfile);
      // showInSnackBar("Image Loaded!");

      setState(() {
        image = File(tempStore.path);
        image = File(tempStore.path);
        imgfile = imgfile;
        isFaceDetected = false;
        //Extracting text
        detectFace();
      });
    } else {
      result = "NO image selected";
      // showInSnackBar('PickedFile is null');
    }
  }

  pickImageFromMyGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    if (tempStore != null) {
      imgfile = await tempStore.readAsBytes();
      // showInSnackBar("Image Loaded!");

      setState(() {
        image = File(tempStore.path);
        image = File(tempStore.path); // Exception occurred here
        //Extracting text
        detectFace();
      });
    } else {
      result = "NO image selected";
      // showInSnackBar('PickedFile is null');
    }
  }

  // performTextExtraction() async {
  //   final FirebaseVisionImage firebaseVisionImage =
  //       FirebaseVisionImage.fromFile(image);

  //   final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();

  //   VisionText visionText = await recognizer.processImage(firebaseVisionImage);

  //   result = "";
  //   setState(() {
  //     for (TextBlock block in visionText.blocks) {
  //       // ignore: unused_local_variable
  //       final String textss = block.text;

  //       for (TextLine line in block.lines) {
  //         for (TextElement element in line.elements) {
  //           result += element.text + " ";
  //         }
  //       }
  //       result += "\n\n";
  //     }
  //   });
  //   if (result == "") result = "Sorry!!\n\n No text detected!";
  // }

  Future detectFace() async {
    final FirebaseVisionImage myimg = FirebaseVisionImage.fromFile(image);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(myimg);

    if (rect.length > 0) {
      rect = new List<Rect>();
    }

    for (Face face in faces) {
      rect.add(face.boundingBox);
    }
  }

  //--------------------------------------------------------------------------

  // @override
  @override
  void initState() {
    super.initState();
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
                padding:
                    EdgeInsets.only(left: 80, bottom: 90, right: 40, top: 50),
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
                  fit: BoxFit.fitWidth,
                )),
              ),






              Row( 
                // direction = Axis.horizontal,
                children: [



                  Expanded(
                    child: Column(
                    children: [
                      
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
                      FlatButton(
                        child: Icon(
                          Icons.info,
                          size: 50,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => new AlertDialog(
                                    title: new Text('Some Tips'),
                                    content: Text(
                                        '*Long press on the camera icon to select image through camera \n*Or just tap on the camera icon to select image through gallery!\n*Click on the bin to Remove current Image and Text!\n\n'),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.of(context, rootNavigator: true)
                                              .pop(); // dismisses only the dialog and returns nothing
                                        },
                                        child: new Text('OK'),
                                      ),
                                    ],
                                  ));
                        },
                      ),
                    ],
                ),
                  ),



















                  Container(
                    margin: EdgeInsets.only(top: 20, right: 140,left: 70),
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
                              pickImageFromMyGallery();
                              detectFace();
                              // performTextExtraction();
                            },
                            onLongPress: () {
                              captureImageWithMyCamera();
                              detectFace();
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
                  
                  




              // Expanded(
                 
              // ),
            ],
          ),
                ],


                
              ),
              
        ),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imgfile;

  // FacePainter((@required this.rect, @required this.imgfile ));

  @override
  void paint(Canvas canvas, Size size) {
    if (imgfile != null) {
      canvas.drawImage(imgfile, Offset.zero, Paint());
    }
    for (Rect rectangle in rect) {
      canvas.drawRect(
        rectangle,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(FacePainter oldDelegate) => false;
}
