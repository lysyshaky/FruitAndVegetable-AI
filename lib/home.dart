import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  // ignore: unused_field
  late File _image;
  bool _loading = false;
  List outputs = [];
  pickImage() async {
    // ignore: deprecated_member_use
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    // ignore: deprecated_member_use
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  loaModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loaModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _loading = false;
      outputs = output!;
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Teachiablemachine CNN',
              style: TextStyle(color: Color(0xFFEEDA28), fontSize: 15),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Decect Dogs and Cats",
              style: TextStyle(
                  color: Color(0xFFE99600),
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
                // ignore: sized_box_for_whitespace
                child: _loading
                    ? Container(
                        width: 300,
                        child: Column(
                          children: [
                            Image.asset('assets/cat.png'),
                            const SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      )
                    // ignore: avoid_unnecessary_containers
                    : Container(
                        child: Column(children: [
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: 250,
                            child: Image.file(_image),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          outputs != null
                              ? Text(
                                  "${outputs[0]['label']}",
                                  style: const TextStyle(
                                      color: Color(0xFFEEDA28), fontSize: 20),
                                )
                              : Container(),
                        ]),
                      )),
            const SizedBox(
              height: 20,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE99600),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Take a photo",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: pickGalleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 260,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE99600),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Camera Roll",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
