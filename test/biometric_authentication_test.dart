import 'package:biometric_authentication/biometric_authentication.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('test for bio metric auth', () {
    final biometeric = BiometricAuthService(onAuthentication: (bool authenticate){});
    biometeric;
  });
}
