import 'package:flutter/material.dart';

/// Colors taken from the Terra brand palette.
const brandPalettes = <List<Color>>[
  [Color(0xFFBBB62F), Color(0xFF6B7312)],
  [Color(0xFFAE0253), Color(0xFF5C0230)],
  [Color(0xFFCA3D0C), Color(0xFF7A1D04)],
  [Color(0xFFE7AB1E), Color(0xFFB3620A)],
];

const categories = ['All', 'Decor', 'Food', 'Travel', 'Fashion', 'Art', 'DIY'];

class Pin {
  final int id;
  final String title;
  final String author;
  final String category;
  final double aspect; // height / width
  final List<Color> colors;
  final IconData icon;

  const Pin({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.aspect,
    required this.colors,
    required this.icon,
  });

  String get heroTag => 'pin-$id';

  String get description =>
      'Save this idea for later and explore more '
      '${category.toLowerCase()} inspiration like it.';
}

const _authors = ['Maya', 'Rafi', 'Nusrat', 'Arif', 'Sadia', 'Tanvir'];

// Grouped by category: Decor, Food, Travel, Fashion, Art, DIY (4 each).
const _seed = <(String, String, IconData)>[
  ('Minimal living room', 'Decor', Icons.chair_outlined),
  ('Indoor plant corner', 'Decor', Icons.local_florist_outlined),
  ('Cozy reading nook', 'Decor', Icons.menu_book_outlined),
  ('Warm lamp lighting', 'Decor', Icons.lightbulb_outline),
  ('Sunday pancakes', 'Food', Icons.breakfast_dining),
  ('Fresh summer salad', 'Food', Icons.eco_outlined),
  ('Homemade pizza night', 'Food', Icons.local_pizza_outlined),
  ('Chocolate dessert', 'Food', Icons.cake_outlined),
  ('Sylhet tea gardens', 'Travel', Icons.landscape_outlined),
  ('Beach sunrise', 'Travel', Icons.beach_access_outlined),
  ('Mountain getaway', 'Travel', Icons.terrain),
  ('City night lights', 'Travel', Icons.location_city),
  ('Streetwear outfit', 'Fashion', Icons.checkroom),
  ('Summer sandals', 'Fashion', Icons.shopping_bag_outlined),
  ('Autumn layers', 'Fashion', Icons.dry_cleaning_outlined),
  ('Vintage sunglasses', 'Fashion', Icons.visibility_outlined),
  ('Abstract watercolor', 'Art', Icons.brush_outlined),
  ('Line art portrait', 'Art', Icons.draw_outlined),
  ('Color palette study', 'Art', Icons.palette_outlined),
  ('Paper cut shapes', 'Art', Icons.category_outlined),
  ('Macrame wall hanging', 'DIY', Icons.interests_outlined),
  ('Handmade candles', 'DIY', Icons.local_fire_department_outlined),
  ('Upcycled jar lamp', 'DIY', Icons.recycling),
  ('Woodwork shelf', 'DIY', Icons.handyman_outlined),
];

const _aspects = [1.3, 1.0, 1.6, 1.15, 1.45];

/// Local sample data (no backend needed). Interleaved so the feed is mixed.
final List<Pin> samplePins = List<Pin>.generate(_seed.length, (i) {
  final s = _seed[(i % 6) * 4 + i ~/ 6];
  return Pin(
    id: i,
    title: s.$1,
    category: s.$2,
    icon: s.$3,
    author: _authors[i % _authors.length],
    aspect: _aspects[i % _aspects.length],
    colors: brandPalettes[i % brandPalettes.length],
  );
});
