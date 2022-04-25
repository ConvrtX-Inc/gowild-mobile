import 'package:flutter/material.dart';

final TextEditingController _searchController = TextEditingController();
buildSearchTextField() => TextField(
      onChanged: (value) {
        // Method For Searching
      },
      controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xff3B352F),
        hintText: 'Search for trail or activity',
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 34,
        ),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 20.0, top: 20.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3B352F),
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff3B352F),
          ),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
