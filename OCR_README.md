# Image Recognition Module

This module of the Flutter application focuses on image recognition using Google ML Kit, with a specific emphasis on Latin script recognition.

## Dependencies

- `google_mlkit_text_recognition`: Provides text recognition capabilities using Google ML Kit.
- `image_picker`: Allows users to pick images from their device.

## System Requirements

- Android Studio: Latest Version
- Flutter: Latest Version

## Test Environment

- Emulator: Pixel 4 (R Type)

## How to Use

To utilize this image recognition module, follow these steps:

1. Integrate the `google_mlkit_text_recognition` and `image_picker` dependencies into your Flutter project.
2. Implement the `processImageForConversion` function to handle the recognition process.
3. Integrate the `extractNumbersAndUnits` function to extract numbers and units from the recognized text.

## Notes

- This module focuses on recognizing text in Latin script only.
- Remember to also modify the `minSdkVersion` in your `build.gradle` file to `21` to ensure compatibility with the image recognition features.
