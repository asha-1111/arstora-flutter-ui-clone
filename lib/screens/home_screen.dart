import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../widgets/brand_logo.dart';
import '../widgets/category_chips.dart';
import '../widgets/featured_banner.dart';
import '../widgets/masonry_grid.dart';
import '../widgets/theme_toggle.dart';
import 'pin_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _category = categories.first;
  final Pin _featured = samplePins[8];

  List<Pin> get _pins => _category == 'All'
      ? samplePins
      : samplePins.where((p) => p.category == _category).toList();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 720;
    final gutter = wide ? 24.0 : 8.0;
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Column(
        children: [
          CategoryChips(
            items: categories,
            selected: _category,
            onSelected: (c) => setState(() => _category = c),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(gutter, 8, gutter, 24),
              child: Column(
                children: [
                  if (_category == 'All')
                    FeaturedBanner(
                      pin: _featured,
                      onTap: () => openPin(context, _featured),
                    ),
                  MasonryGrid(
                    pins: _pins,
                    onTap: (p) => openPin(context, p),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandMark(size: 30),
          SizedBox(width: 10),
          BrandWordmark(fontSize: 24, letterSpacing: 1.5),
        ],
      ),
      actions: const [ThemeToggle()],
    );
  }
}
