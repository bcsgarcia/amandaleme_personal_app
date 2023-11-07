import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherAdapter {
  static Future<void> phone(String phone) async {
    try {
      final uri = Uri.parse('tel:$phone');

      final canLaunch = await canLaunchUrl(Uri(scheme: 'tel', path: '+351912616264'));

      if (canLaunch) {
        await launchUrl(uri);
      }
    } catch (e) {
      throw Exception();
    }
  }

  static Future<void> website(String url) async {
    if (!await launchUrl(
      Uri.parse('https://www.google.com'),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> map(String address) async {
    if (!await launchUrl(createQueryUri(address))) {
      throw Exception('Could not launch $address');
    }
  }

  static Uri createQueryUri(String query) {
    Uri uri;

    if (kIsWeb) {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': query});
    } else if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      uri = Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      uri = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': query});
    }

    return uri;
  }
}
