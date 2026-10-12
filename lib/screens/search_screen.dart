import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../widgets/app_search_bar.dart';
import '../widgets/masonry_grid.dart';
import '../widgets/recent_searches.dart';
import '../widgets/topic_grid.dart';
import 'pin_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final List<String> _recent = ['Decor', 'Travel'];
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Pin> get _results {
    final q = _query.trim().toLowerCase();
    return samplePins
        .where((p) =>
    p.title.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q))
        .toList();
  }

  void _remember(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    setState(() {
      _recent
        ..remove(t)
        ..insert(0, t);
      if (_recent.length > 5) _recent.removeLast();
    });
  }

  void _pick(String topic) {
    _controller.text = topic;
    _controller.selection = TextSelection.collapsed(offset: topic.length);
    _remember(topic);
    setState(() => _query = topic);
  }

  void _clear() {
    _controller.clear();
    setState(() => _query = '');
  }

  Widget _landing() {
    return Column(
      children: [
        if (_recent.isNotEmpty)
          RecentSearches(
            items: _recent,
            onPick: _pick,
            onRemove: (s) => setState(() => _recent.remove(s)),
          ),
        Expanded(child: TopicGrid(onPick: _pick)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final empty = _query.trim().isEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          AppSearchBar(
            controller: _controller,
            hint: 'Search for ideas',
            showClear: _query.isNotEmpty,
            onClear: _clear,
            onChanged: (v) => setState(() => _query = v),
            onSubmitted: _remember,
          ),
          Expanded(
            child: empty ? _landing() : _Results(pins: _results),
          ),
        ],
      ),
    );
  }
}

class _Results extends StatelessWidget {
  final List<Pin> pins;
  const _Results({required this.pins});

  @override
  Widget build(BuildContext context) {
    if (pins.isEmpty) {
      return const Center(child: Text('No pins found. Try another word.'));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              '${pins.length} pins found',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          MasonryGrid(pins: pins, onTap: (p) => openPin(context, p)),
        ],
      ),
    );
  }
}