import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agri_tech/models/user.dart';
import 'package:agri_tech/pages/main.dart';
import 'package:agri_tech/providers/auth_provider.dart';
import 'package:agri_tech/theme/colors.dart';
import 'package:agri_tech/utils.dart';

class OtpPage extends StatefulWidget {
  final User user;
  const OtpPage({super.key, required this.user});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 30);
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool loading = false;
  bool hasError = false;
  bool _countingDown = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setCountDown(),
    );
    if (mounted) {
      setState(() {
        _countingDown = true;
      });
    }
  }

  void stopTimer() {
    if (mounted) {
      setState(() => {
            countdownTimer!.cancel(),
            _countingDown = false,
            myDuration = const Duration(seconds: 30),
            _countingDown = false
          });
    }
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        stopTimer();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            const Text(
                              'OTP Verification',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.3,
                                wordSpacing: 2,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'We have sent a verification code to ${widget.user.phone}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 113, 113, 113),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 320,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/otp.png'),
                        opacity: .8,
                      ),
                    ),
                  ),
                ),
                otpLayout(seconds),
                InkWell(
                  onTap: () => Get.back(),
                  child: const Text(
                    'Change phone number',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: soilColor,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget otpLayout(String seconds) {
    const focusedBorderColor = primaryColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.8);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              enabled: !loading,
              autofocus: true,
              forceErrorState: hasError,
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              onClipboardFound: (value) {
                pinController.setText(value);
              },
              hapticFeedbackType: HapticFeedbackType.heavyImpact,
              onCompleted: (pin) {
                verifyOTP(pin);
              },
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    hasError = false;
                  });
                }
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: !_countingDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: loading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () => resendPin(),
                      child: const Text(
                        'Send the code again',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: soilColor,
                          fontSize: 17,
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Visibility(
              visible: _countingDown,
              child: loading
                  ? const CircularProgressIndicator()
                  : Text('Request OTP in 00:$seconds'),
            ),
          ),
        ],
      ),
    );
  }

  void setLoadingAndError(bool isLoading, bool error) {
    if (mounted) {
      setState(() {
        loading = isLoading;
        hasError = error;
      });
    }
  }

  void verifyOTP(String pin) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setLoadingAndError(true, false);
      pref.setString('user', jsonEncode({}));
      pref.setBool('hasLoginHistory', true);
      Get.offAll(
        () => const Main(),
      );
      setLoadingAndError(false, false);
    } catch (e) {
      setLoadingAndError(false, true);
      showSnackBar(e.toString(), Colors.red, const Duration(seconds: 3));
    }
  }

  void setProvider(User user) {
    context.read<AuthProvider>().setUser(user);
  }

  void resendPin() async {
    try {
      setState(() => loading = true);
      if (mounted) {
        setState(() => loading = false);
      }
      startTimer();
      showSnackBar('Code resent', Colors.green, const Duration(seconds: 3));
    } catch (e) {
      if (mounted) {
        setState(() => loading = false);
      }
      showSnackBar(e.toString(), Colors.red, const Duration(seconds: 3));
    }
  }
}
