import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agri_tech/theme/colors.dart';

final List<Map<String, String>> emergencyContacts = [
  {"name": "Nearest Police", "number": "+220 555 5555"},
  {"name": "Nearest Military Baracks", "number": "+220 555 5555"},
  {"name": "Nearest Women Group", "number": "+220 555 5555"},
  {"name": "Nearest Bureau", "number": "+220 555 5555"},
  {"name": "Anti-Crime", "number": "+220 555 5555"},
  {"name": "Nearest Clinic", "number": "+220 555 5555"},
];

final List<Map<String, String>> emergencyHealthContacts = [
  {"name": "Nearest Health Center", "number": "+220 555 5555"},
  {"name": "Nearest Women Group", "number": "+220 555 5555"},
  {"name": "Nearest Support Center", "number": "+220 555 5555"},
  {"name": "Nearest Clinic", "number": "+220 555 5555"},
  {"name": "Ambulance", "number": "+220 555 5555"},
  {"name": "Nearest Health Center", "number": "+220 555 5555"},
  {"name": "Nearest Women Group", "number": "+220 555 5555"},
  {"name": "Nearest Support Center", "number": "+220 555 5555"},
  {"name": "Nearest Clinic", "number": "+220 555 5555"},
  {"name": "Ambulance", "number": "+220 555 5555"},
];

showSnackBar(String text, [Color? backgroundColor, Duration? duration]) {
  return Get.snackbar(
    '',
    text,
    backgroundColor: backgroundColor ?? Colors.green,
    colorText: Colors.white,
    dismissDirection: DismissDirection.vertical,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.BOTTOM,
    duration: duration ?? const Duration(seconds: 1),
  );
}

Center carouselPins(
    BuildContext context, Function onTap, int current, List<dynamic> entries) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: entries.asMap().entries.map(
        (entry) {
          return GestureDetector(
            onTap: () => onTap(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : primaryColor)
                    .withOpacity(current == entry.key ? 1 : 0.4),
              ),
            ),
          );
        },
      ).toList(),
    ),
  );
}
