import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/language_provider.dart';
import '../providers/product_provider.dart';
import './menu_page.dart';
import './widgets/customAppBar.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  // Texts for languages
  static final Map<String, Map<String, String>> _texts = {
    'en': {'menu': 'Menu'},
    'el': {'menu': 'Μενού'},
  };

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    final lang = langProvider.lang;
    final t = _texts[lang]!;

    return Scaffold(
      appBar: CustomAppBar(),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/sample_logo.png',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.menu_book, color: Colors.black),
                    label: Text(
                      t['menu']!,
                      style: const TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        200,
                        60,
                      ), // width: 200, height: 60
                      textStyle: const TextStyle(fontSize: 20), // bigger font
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: 'Facebook',
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        tooltip: 'Instagram',
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        tooltip: 'TikTok',
                        icon: const FaIcon(FontAwesomeIcons.tiktok),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      IconButton(
                        tooltip: 'YouTube',
                        icon: const FaIcon(FontAwesomeIcons.youtube),
                        color: Colors.white,
                        onPressed: () {},
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
