import 'package:agri_tech/components/badge_icon.dart';
import 'package:agri_tech/theme/colors.dart';
import 'package:agri_tech/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> ads = [
    {
      "title": "Contract Farming",
      "content":
          "Grow crops for BayKart verified companies to make consistent profits.",
      "cta": {"label": "Get Call", "link": "#"},
      "image": 'assets/farm.png'
    },
    {
      "title": "Sell Easily",
      "content":
          "Choose from a wide list of verified buyers and sell commodities directly.",
      "cta": {"label": "Sell Now", "link": "#"},
      "image": 'assets/sell.png'
    }
  ];
  CarouselController carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        centerTitle: false,
        title: const Text(
          'Hi! Isatou 👋🏽',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 24,
          ),
        ),
        actions: const [
          BadgeIcon(
            text: '3',
            icon: CupertinoIcons.cart_fill_badge_plus,
            color: Colors.white,
          ),
          BadgeIcon(
            text: '5',
            icon: CupertinoIcons.bell_fill,
            color: Colors.white,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: primaryLightColor.withOpacity(.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'How to use the app',
                              style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Learn about all the features of the app',
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.play_arrow_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/how-to.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    onPageChanged: ((index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: ads
                      .map(
                        (item) => Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: primaryLightColor.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['content'],
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      child: Text(
                                        item['cta']['label'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(item['image']),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                carouselPins(
                    context,
                    (key) => carouselController.animateToPage(key),
                    _current,
                    ads),
                const SizedBox(height: 10),
                const Text(
                  "Today's Weather",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Lato',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        offset: const Offset(0, 0),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.locationDot,
                            color: primaryColor,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Serrekunda',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/cloud.png'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    offset: const Offset(0, -1),
                                    blurRadius: 30,
                                  )
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Market Views",
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Lato',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
