import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_image_to_text/utils/utils.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ImageToText(),
    );
  }
}

class ImageToText extends StatefulWidget {
  const ImageToText({Key? key}) : super(key: key);

  @override
  State<ImageToText> createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  File? _pickedImage;
  String outputText = "";

  pickedImage(File file) {
    setState(() {
      _pickedImage = file;
    });

    InputImage inputImage = InputImage.fromFile(file);
    processImageForConversion(inputImage);
  }

  processImageForConversion(inputImage) async {
    setState(() {
      outputText = "";
    });

    final textRecognizer =
        TextRecognizer(script: TextRecognitionScript.japanese);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      List<Point<int>> blockCornerPoints = block.cornerPoints;
      print(block.text);
      // List of corner points of the text block in clockwise order starting with the top left point relative to the image in the default coordinate space.
      print(blockCornerPoints);
      setState(() {
        outputText += block.text + "\n";
      });
    }
  }

  // Function to extract numbers and units from text
  List<String> extractNumbersAndUnits(String input) {
    List<String> results = [];
    RegExp regExp = RegExp(r"(\d+(\.\d+)?)\s*([^0-9\s]+)");

    // Explanation of the regular expression:
    // (\d+(\.\d+)?) - Matches a number, which can be an integer or float.
    // \d+          - Matches one or more digits.
    // (\.\d+)?     - Matches an optional decimal point and one or more digits.
    // \s*          - Matches zero or more whitespace characters.
    // ([^0-9\s]+)  - Matches one or more characters (units).

    Iterable<Match> matches = regExp.allMatches(input);

    for (Match match in matches) {
      results.add(match.group(1)!); // Add matched number
      results.add(match.group(3)!); // Add matched unit
    }

    return results;
  }

  /* // Japanese
  List<String> extractNumbersAndUnits(String input) {
    List<String> results = [];
    RegExp regExp = RegExp(
        r"(\d+(\.\d+)?)\s*([\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}]+)");

    // Explanation of the regular expression:
    // (\d+(\.\d+)?) - Matches a number, which can be an integer or float.
    // \d+          - Matches one or more digits.
    // (\.\d+)?     - Matches an optional decimal point and one or more digits.
    // \s*          - Matches zero or more whitespace characters.
    // ([\p{Script=Hiragana}\p{Script=Katakana}\p{Script=Han}]+) - Matches one or more characters from Japanese scripts.

    Iterable<Match> matches = regExp.allMatches(input);

    for (Match match in matches) {
      results.add(match.group(1)!); // Add matched number
      results.add(match.group(3)!); // Add matched unit
    }

    return results;
  } */

  @override
  Widget build(BuildContext context) {
    // debug
    // print(outputText);
    List<String> numbersAndUnits = extractNumbersAndUnits(outputText);
    // debug
    // print(numbersAndUnits);
    // String exampleText = "Weight: 10.5 kg\nHeight: 180 cm\nLength: 5.2 ft";
    // List<String> numbersAndUnits = extractNumbersAndUnits(exampleText);
    // After running the function with exampleText, numbersAndUnits will contain:
    // ["10.5", "kg", "180", "cm", "5.2", "ft"]

    return Scaffold(
      appBar: AppBar(title: Text("Image to Text")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage(ImageSource.gallery, pickedImage);
        },
        child: Icon(Icons.image),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(children: [
          // Display image if picked
          if (_pickedImage == null)
            Container(
              height: 300,
              color: Colors.black,
              width: double.infinity,
            )
          else
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.file(
                _pickedImage!,
                fit: BoxFit.fill,
              ),
            ),
          Expanded(child: Container()),

          // Display extracted numbers and units
          Column(
            children: numbersAndUnits.map((item) {
              return Text(
                item,
                style: TextStyle(fontSize: 18),
              );
            }).toList(),
          ),
          Expanded(child: Container()),
        ]),
      ),
    );
  }
}
