import 'package:agri_tech/pages/auth/login.dart';
import 'package:agri_tech/pages/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agri_tech/models/user.dart';
import 'package:agri_tech/theme/colors.dart';
import 'package:agri_tech/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final languages = ['english', 'wolof', 'mandinka'];
  final regions = [
    'Banjul',
    'KMC',
    'West Coast Region',
    'Upper River Region',
    'Lower River Region',
    'Central River Region',
    'North Bank Region'
  ];
  bool loading = false;
  bool _accepted = false;
  int? selectedIdx;
  int? selectedRegionIdx;

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
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Scrollbar(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: primaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'BayKart',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            color: bgColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Create Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 24,
                            letterSpacing: 1.2,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.only(bottom: 15),
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
                              hintText: 'Enter phone number*',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 87, 86, 86),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 55,
                          margin: const EdgeInsets.only(bottom: 15),
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
                            keyboardType: TextInputType.text,
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: 'Fullname*',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 87, 86, 86),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 55,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 215, 214, 214),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: DropdownButton<int?>(
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            value: selectedIdx,
                            elevation: 0,
                            underline: const Visibility(
                              visible: false,
                              child: Text(''),
                            ),
                            hint: const Text(
                              'Language choice*',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Wolof'),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('Mandinka'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedIdx = int.parse(value.toString());
                              });
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 55,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 215, 214, 214),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: DropdownButton<int?>(
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            value: selectedRegionIdx,
                            elevation: 0,
                            underline: const Visibility(
                              visible: false,
                              child: Text(''),
                            ),
                            hint: const Text(
                              'Region*',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                            items: regions
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: regions.indexOf(item),
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRegionIdx = int.parse(value.toString());
                              });
                            },
                          ),
                        ),
                        CheckboxListTile(
                          activeColor: primaryColor,
                          checkColor: secondaryLightColor,
                          title: GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse('#'),
                                mode: LaunchMode.inAppWebView,
                              );
                            },
                            child: const Text(
                              'I accept the terms and conditions',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 10, 122, 213),
                              ),
                            ),
                          ),
                          value: _accepted,
                          onChanged: (value) {
                            setState(() {
                              _accepted = value!;
                            });
                          },
                        ),
                        loading
                            ? const CircularProgressIndicator()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_accepted) {
                                      if (_phoneController.text
                                              .trim()
                                              .isNotEmpty &&
                                          _nameController.text
                                              .trim()
                                              .isNotEmpty &&
                                          selectedIdx != null) {
                                        if (_phoneController.text
                                                .trim()
                                                .length ==
                                            7) {
                                          setState(() {
                                            loading = true;
                                          });
                                          await createAccount();
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
                                            'Fill in the required fields',
                                            Colors.red);
                                      }
                                    } else {
                                      showSnackBar(
                                          'You have to accept the terms and conditions.',
                                          Colors.red);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12),
                                    backgroundColor: bgColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    'Register',
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
                          height: 10,
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
                          'Already have an account?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => Get.offAll(() => const LoginPage()),
                          child: const Text(
                            'Login',
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
      ),
    );
  }

  Future<void> createAccount() async {
    try {
      final data = User(
        phone: _phoneController.text.trim(),
        fullname: _nameController.text.trim(),
        language: languages[selectedIdx!],
        acceptedTerms: _accepted,
        org: '',
      );
      Get.to(
        () => OtpPage(
          user: data,
        ),
      );
    } catch (e) {
      showSnackBar(e.toString(), Colors.red, const Duration(seconds: 3));
    }
  }
}
