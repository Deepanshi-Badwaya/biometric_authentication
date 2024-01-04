library biometric_authentication;


import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

// Define a callback for authentication status
typedef AuthenticationCallback = void Function(bool isAuthenticated);

class BiometricAuthService extends StatefulWidget {
  const BiometricAuthService({Key? key,required this.onAuthentication});

  final AuthenticationCallback onAuthentication;// Callback function to notify the parent widget about authentication status

  @override
  State<BiometricAuthService> createState() => _BiometricAuthService();
}

class _BiometricAuthService extends State<BiometricAuthService> {
  late LocalAuthentication auth; // variable for local authentication

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //btn for the pop up of scanning or biometric authentication of finger , face and by password
        child:ElevatedButton(
          onPressed: () async {
            print('Tapped on Authenticate with Face Recognition button');
            await _authenticate(context);
          },
          child: const Text('Authenticate with Face Recognition'),
        ),

      ),
    );
  }

  // Function to authenticate the user's biometrics
  Future<void> _authenticate(BuildContext context) async {
    try {
      // Check the available biometrics in the device
      bool isEnrolled = await auth.getAvailableBiometrics().then((value) => value.contains(BiometricType.face));

      if (!isEnrolled) {
        // Face recognition is not enrolled, show permission dialog
        bool canAuthenticate = await auth.canCheckBiometrics;
        if (canAuthenticate) {
          await auth.authenticate(
            localizedReason: 'To use face authentication, you must first enroll your face on the device',
          );
          widget.onAuthentication(true); // Call the callback with true for successful authentication
        } else {
          widget.onAuthentication(false); // Call the callback with false for failed authentication
          // Device does not support biometrics
          _showErrorDialog(context, 'Biometric authentication is not available on this device.');
        }
      } else {
        // Face recognition is enrolled, proceed with authentication
        bool authenticated = await auth.authenticate(
          localizedReason: 'Authenticate to access the app',
        );
        print('Authenticated: $authenticated');
        if (authenticated) {
          print('Authentication successful');
        } else {
          print('Authentication failed');
        }
      }
    }catch (e) {
      // Handle exceptions, if any
      print('Error during authentication: $e');
    }
  }

// Function to show an error dialog if something goes wrong while authenticating
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

