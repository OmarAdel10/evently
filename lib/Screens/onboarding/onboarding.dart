import 'package:eventlyy/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Onboarding {
  static List<String> images = [
    'assets/images/onboarding_screen2.png',
    'assets/images/onboarding_screen3.png',
    'assets/images/onboarding_screen4.png',
  ];

  static List<String> getTitle(BuildContext context) {
    return [
      AppLocalizations.of(context)!.onboarding_p2_title,
      AppLocalizations.of(context)!.onboarding_p3_title,
      AppLocalizations.of(context)!.onboarding_p4_title,
    ];
  }

  static List<String> getSubTitle(BuildContext context) {
    return [
      AppLocalizations.of(context)!.onboarding_p2_description,
      AppLocalizations.of(context)!.onboarding_p3_description,
      AppLocalizations.of(context)!.onboarding_p4_description,
    ];
  }
}