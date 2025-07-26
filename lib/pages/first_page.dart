import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/language_provider.dart';
import '../providers/product_provider.dart';
import './menu_page.dart';
import './widgets/customAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  // Texts for languages
  static final Map<String, Map<String, String>> _texts = {
    'en': {'menu': 'Menu'},
    'el': {'menu': 'Μενού'},
  };

  double _getLogoHeight(double width) {
    if (width < 370) return 50; // very small screens
    if (width < 550) return 70; // medium screens
    return 100; // default
  }

  Future<void> openSocialLink(Uri appUri, Uri webUri) async {
    if (await canLaunchUrl(appUri)) {
      await launchUrl(appUri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    final lang = langProvider.lang;
    final t = _texts[lang]!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 227, 208, 41),
              Color.fromARGB(255, 203, 98, 17),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),

                  // Responsive Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/sample_logo.png',
                      height: _getLogoHeight(screenWidth),
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Menu Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.menu_book, color: Colors.black),
                    label: Text(
                      t['menu']!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 60),
                      textStyle: const TextStyle(fontSize: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () async {
                      await context
                          .read<CategoriesProvider>()
                          .fetchCategories();
                      Navigator.pushNamed(context, MenuPage.routeName);
                    },
                  ),

                  const Spacer(),

                  // Social Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: 'Facebook',
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        color: Colors.white,
                        onPressed: () {
                          openSocialLink(
                            Uri.parse(
                              'fb://profile/your_page_id',
                            ), // App deep link
                            Uri.parse(
                              'https://www.facebook.com/your_page_name',
                            ), // Web fallback
                          );
                        },
                      ),
                      IconButton(
                        tooltip: 'Instagram',
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                        color: Colors.white,
                        onPressed: () {
                          openSocialLink(
                            Uri.parse(
                              'instagram://user?username=your_username',
                            ),
                            Uri.parse(
                              'https://www.instagram.com/your_username/',
                            ),
                          );
                        },
                      ),
                      IconButton(
                        tooltip: 'TikTok',
                        icon: const FaIcon(FontAwesomeIcons.tiktok),
                        color: Colors.white,
                        onPressed: () {
                          openSocialLink(
                            Uri.parse('snssdk1128://user/profile/your_user_id'),
                            Uri.parse('https://www.tiktok.com/@your_username'),
                          );
                        },
                      ),
                      IconButton(
                        tooltip: 'YouTube',
                        icon: const FaIcon(FontAwesomeIcons.youtube),
                        color: Colors.white,
                        onPressed: () {
                          openSocialLink(
                            Uri.parse(
                              'youtube://www.youtube.com/channel/your_channel_id',
                            ),
                            Uri.parse(
                              'https://www.youtube.com/channel/your_channel_id',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
