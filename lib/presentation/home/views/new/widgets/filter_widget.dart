import 'package:fdelux_source_neytrip/presentation/home/views/new/classes/data.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filters"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        height: 60,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: AppData.filterOptions.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return FilterButton(text: AppData.filterOptions[index]);
          },
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;

  const FilterButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.teal, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.teal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
