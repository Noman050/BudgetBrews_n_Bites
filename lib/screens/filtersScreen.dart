// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import 'package:vibration/vibration.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FilterScreen(this.currentFilters, this.saveFilters, {super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] ?? false;
    _lactoseFree = widget.currentFilters['lactose'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: textColor)),
      subtitle: Text(description, style: const TextStyle(color: white60Color)),
      trailing: Switch(
        activeColor: sliderColor,
        activeTrackColor: white30Color,
        inactiveThumbColor: white54Color,
        inactiveTrackColor: white60Color,
        value: currentValue,
        onChanged: (newValue) async {
          // Check if the device has a vibrator
          bool hasVibrator = await Vibration.hasVibrator() ??
              false; // Use null-aware operator and provide default value
          bool hasAmplitude = await Vibration.hasAmplitudeControl() ??
              false; // Use null-aware operator and provide default value
          if (hasVibrator) {
            Vibration.vibrate(duration: 500);
          } else if (hasAmplitude && hasVibrator) {
            Vibration.vibrate(duration: 500, amplitude: 1);
            Vibration.vibrate(duration: 500, amplitude: 255);
          }
          updateValue(newValue);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Filters saved Successfully")),
              );
              // Clear filters when saved
              setState(() {
                _glutenFree = false;
                _lactoseFree = false;
                _vegan = false;
                _vegetarian = false;
              });
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text('Adjust Your Meal Selection.',
                style: TextStyle(color: textColor)),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Only include gluten-free meal.',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Only include lactose-free meal.',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meal.',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meal.',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
