import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.height = 100,
    this.showBackButton = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    final lang = langProvider.lang;
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.black,
      leadingWidth: showBackButton ? 140 : 100,
      leading: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/sample_logo_icon.png',
                height: height * 0.7,
                width: height * 0.7,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      title: screenWidth > 550
          ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/sample_logo.png',
                height: height * 0.7,
                fit: BoxFit.cover,
              ),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: lang,
              icon: const Icon(Icons.language, color: Colors.white),
              dropdownColor: Colors.black,
              style: const TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('EN', style: TextStyle(color: Colors.white)),
                ),
                DropdownMenuItem(
                  value: 'el',
                  child: Text('EL', style: TextStyle(color: Colors.white)),
                ),
              ],
              onChanged: (val) {
                if (val != null) langProvider.setLanguage(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
