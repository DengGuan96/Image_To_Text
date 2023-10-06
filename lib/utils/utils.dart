import 'dart:io';
import 'dart:ui';

import 'package:image_picker/image_picker.dart';

void pickImage(source, Function(File) imgFile) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file == null) return;
  imgFile(File(file.path));
}
