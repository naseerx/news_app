import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/pages/main_screen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  int? _resendToken;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  final focusedPinTheme = const PinTheme().copyWith(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      color: Colors.blue[50],
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  String verificationCode = "";
  var otpController = TextEditingController();

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (kDebugMode) {
            print('Credentials => $credential');
          }
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (kDebugMode) {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$e');
          }
          log('Verification Failed!');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            verificationCode = verificationId;
            _resendToken = resendToken;
          });
          log('OTP Send Successfully');
        },
        forceResendingToken: _resendToken,
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 60));
  }


  @override
  initState() {
    if (kDebugMode) {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${widget.phone}');
    }
    _verifyPhone();
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      body: Padding(
        padding:
        const EdgeInsets.only(left: 20.0, right: 20, bottom: 20, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                ),
                const Text(
                  'Step 1 of 2',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Row(
                  children: [
                    Container(
                      height: 4,
                      width: 60,
                      color: Colors.blue,
                    ),
                    Container(
                      color: Colors.white,
                      height: 4,
                      width: 60,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Verify your phone number',
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Please enter the 6 digit code send to:',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.phone,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Pinput(
              controller: otpController,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
            ),
            const SizedBox(
              height: 40,
            ),
            Visibility(
              visible: enableResend,
              child: TextButton(
                onPressed: ()  {
                  _verifyPhone();
                },
                child: Center(
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Resend in $secondsRemaining''s',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize:
                  Size(MediaQuery.of(context).size.width * 0.7, 70),
                ),
                onPressed: () async {
                  if (otpController.text.isNotEmpty) {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationCode,
                        smsCode: otpController.text);
                    await auth.signInWithCredential(credential).then((value) {
                      log('Login Successfully');
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()));
                      log('Login Successful');
                    });
                  } else {
                    return;
                  }
                },
                child: const Text(
                  'DONE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  // style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}