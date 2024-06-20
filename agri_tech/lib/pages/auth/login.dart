import 'package:agri_tech/pages/auth/otp.dart';
import 'package:agri_tech/pages/auth/register.dart';
import 'package:agri_tech/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agri_tech/theme/colors.dart';
import 'package:agri_tech/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const CircleAvatar(
                            radius: 60,
                            backgroundColor: primaryColor,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'BayKart',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              color: bgColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            'Welcome back!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: double.infinity,
                            height: 55,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 215, 214, 214),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(fontFamily: 'Poppins'),
                              maxLines: 1,
                              minLines: 1,
                              keyboardType: TextInputType.number,
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                hintText: 'Enter phone number',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          loading
                              ? const CircularProgressIndicator()
                              : Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_phoneController.text
                                          .trim()
                                          .isNotEmpty) {
                                        if (_phoneController.text
                                                .trim()
                                                .length ==
                                            7) {
                                          setState(() {
                                            loading = true;
                                          });
                                          await authenticate();
                                          if (mounted) {
                                            setState(() {
                                              loading = false;
                                            });
                                          }
                                        } else {
                                          showSnackBar(
                                              'Please enter a valid phone number',
                                              Colors.red);
                                        }
                                      } else {
                                        showSnackBar(
                                            'Fill in the required field',
                                            Colors.red);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(12),
                                      backgroundColor: bgColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () => Get.offAll(() => const RegisterPage()),
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: bgColor,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> authenticate() async {
    try {
      Get.to(
        () => OtpPage(
          user: User(
            phone: _phoneController.text.trim(),
            fullname: '_nameController.text.trim()',
            language: 'languages[selectedIdx!]',
            acceptedTerms: true,
            org: '',
          ),
        ),
      );
    } catch (e) {
      showSnackBar(e.toString(), Colors.red, const Duration(seconds: 3));
    }
  }
}
