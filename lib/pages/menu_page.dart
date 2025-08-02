import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/language_provider.dart';
import './widgets/customAppBar.dart';

class MenuPage extends StatefulWidget {
  static const routeName = '/menu';
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedCategoryIndex = 0;
  final ScrollController _scrollController = ScrollController();

  // Texts for languages
  static final Map<String, Map<String, String>> _texts = {
    'en': {'menu': 'Menu', 'contact': 'Contact'},
    'el': {'menu': 'Μενού', 'contact': 'Επικοινωνία'},
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesProvider>().fetchCategories();
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 150,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoriesProvider>();
    final langProvider = context.watch<LanguageProvider>();
    final lang = langProvider.lang;
    final t = _texts[lang]!;

    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!))
          : Column(
              children: [
                Container(height: 3, color: Color.fromRGBO(231, 121, 3, 1)),
                Container(
                  color: Colors.black,
                  height: 140,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: _scrollLeft,
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.categories.length,
                          itemBuilder: (context, i) {
                            final cat = provider.categories[i];
                            final isSelected = i == _selectedCategoryIndex;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = i;
                                });
                              },
                              child: Container(
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? Color.fromRGBO(231, 121, 3, 1)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        cat.image,
                                        height: 80,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      lang == 'el' ? cat.nameEl : cat.nameEn,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: _scrollRight,
                      ),
                    ],
                  ),
                ),

                // PRODUCTS LIST
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(231, 121, 3, 1),
                    ),
                    child: _buildProductsList(
                      provider.categories[_selectedCategoryIndex],
                      lang,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProductsList(category, String lang) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: category.products.length,
      itemBuilder: (context, index) {
        final product = category.products[index];
        return Card(
          color: const Color.fromARGB(255, 239, 228, 212),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(lang == 'el' ? product.nameEl : product.nameEn),
            trailing: Text('${product.price.toStringAsFixed(2)}€'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 239, 228, 212),
                  title: Text(lang == 'el' ? product.nameEl : product.nameEn),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(product.image),
                      const SizedBox(height: 12),
                      Text(
                        lang == 'el'
                            ? product.descriptionEl
                            : product.descriptionEn,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${product.price.toStringAsFixed(2)}€',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // black background
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        lang == 'el' ? 'Κλείσιμο' : 'Close',
                        style: const TextStyle(
                          color: Colors.white,
                        ), // white text
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
