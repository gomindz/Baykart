import 'package:agri_tech/pages/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agri_tech/models/user.dart';
import 'package:agri_tech/providers/auth_provider.dart';
import 'package:agri_tech/theme/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool loading = false;
  final PageController pageController = PageController();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => checkTerm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: ((value) => setState(() => _page = value)),
        children: const [
          HomePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        selectedItemColor: primaryColor,
        unselectedItemColor: soilLightColor,
        backgroundColor: const Color.fromRGBO(1, 24, 47, 1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.seedling),
            label: 'Crop Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.store,
            ),
            label: 'Butik',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            label: 'Account',
          ),
        ],
        currentIndex: _page,
        onTap: (value) {
          pageController.animateToPage(value,
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn);
        },
      ),
    );
  }

  void setProvider(User user) {
    context.read<AuthProvider>().setUser(user);
  }

  void checkTerm() async {
    // final user = context.read<AuthProvider>().user;
    // if (user.acceptedTerms != null && !user.acceptedTerms!) {
    //   await _showAcceptTermModal();
    // }
  }
}
