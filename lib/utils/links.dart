import 'package:url_launcher/url_launcher.dart';

class Links {
  static const String email = "jatinchaudhary41@gmail.com";
  static const String github = "https://github.com/jatinchaudhary";
  static const String linkedin = "http://www.linkedin.com/in/jatinchaudhary41";
  static const String locusPlay = "https://locus.jatinchaudhary.com";
  static const String astroRegal = "https://astroregal.com/";

  // Served from web/resume.pdf, resolved against the page so it also works
  // when the site is hosted under a sub-path.
  static String get resume => Uri.base.resolve("resume.pdf").toString();

  static Future<void> open(String url) =>
      launchUrl(Uri.parse(url), webOnlyWindowName: "_blank");

  static Future<void> mail() => launchUrl(Uri(scheme: "mailto", path: email));
}
