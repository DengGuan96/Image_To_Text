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

- make sure to select the appropriate SDK in Android Studio by navigating to `File > Project Structure > Project SDK`.
- This module focuses on recognizing text in Latin and japanese.
- Remember to also modify the `minSdkVersion` in your `app/build.gradle` file to `21` to ensure compatibility with the image recognition features.
- Add the dependencies for the ML Kit Android libraries to your module's app-level gradle file, which is usually app/build.gradle
```java
dependencies {
  // To recognize Latin script
  implementation 'com.google.mlkit:text-recognition:16.0.0'

  // To recognize Chinese script
  implementation 'com.google.mlkit:text-recognition-chinese:16.0.0'

  // To recognize Devanagari script
  implementation 'com.google.mlkit:text-recognition-devanagari:16.0.0'

  // To recognize Japanese script
  implementation 'com.google.mlkit:text-recognition-japanese:16.0.0'

  // To recognize Korean script
  implementation 'com.google.mlkit:text-recognition-korean:16.0.0'
}