# Biometric Authentication Service for Flutter
# biometric_authentication
Flutter package that integrates biometric authentication (face, fingerprint, pattern or password) into your app.

## Features

- We get a popup for biometric authentication when we click the elevated button, and then using a callback function, we can navigate from there after a successful authentication.
- After successfully authenticating by face, finger or password/pattern, depending on the mobile setting, you can navigate

## Getting started
Import

```dart
import 'package:biometric_authentication/biometric_authentication.dart';
```
# Android Integration
* The plugin will build and run on SDK 16+, but isDeviceSupported() will always return false before SDK 23 (Android 6.0).

## Activity Changes
Note that `biometric_authentication` requires the use of a FragmentActivity instead of an Activity. To update your application:

- If you are using FlutterActivity directly, change it to `FlutterFragmentActivity` in your AndroidManifest.xml.

- If you are using a custom activity, update your `MainActivity.java`:

```dart
import io.flutter.embedding.android.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {
// ...
}
```
or `MainActivity.kt`:
```dart
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
// ...
}
```
to inherit from FlutterFragmentActivity.

## Permissions
Update your project's `AndroidManifest.xml` file to include the `USE_BIOMETRIC` permissions:
```dart

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.example.app">
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<manifest>

```

## Usage

To use this package, add `biometric_authentication` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  biometric_authentication: ^1.0.5
```

## Additional information
- Example
```dart
import 'package:flutter/material.dart';
import 'package:biometric_authentication/biometric_authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Auth Example'),
      ),
      body: Center(
        child: BiometricAuthService(
          title: 'Biometric Authentication',
          onAuthentication: (bool isAuthenticated) {
            // Handle authentication status here
            if (isAuthenticated) {
              //authentication completed than move that to the next screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
              // Authentication successful
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Authentication successful'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else {
              // Authentication failed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Authentication failed'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


//screen showed if the authentication completed successfully
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      //text after successful authentication of any biometric
      body: const Center(
        child: Text('Welcome to the second screen!'),
      ),
    );
  }
}

```
