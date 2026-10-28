// lib/services/leaderboard_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/leaderboard_entry_model.dart';

class LeaderboardService with ChangeNotifier {
  static const _leaderboardKey = 'leaderboard_data';
  static const int maxEntries = 10;

  List<LeaderboardEntry> _entries = [];
  List<LeaderboardEntry> get entries => _entries;

  LeaderboardService() {
    loadLeaderboard();
  }

  // NEW METHOD: To clear all leaderboard data
  Future<void> resetLeaderboard() async {
    _entries.clear(); // Clear the in-memory list
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_leaderboardKey); // Remove from persistent storage
    notifyListeners(); // Notify UI to update
  }

  Future<void> loadLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    final String? leaderboardJson = prefs.getString(_leaderboardKey);

    if (leaderboardJson != null) {
      final List<dynamic> decodedList = jsonDecode(leaderboardJson);
      _entries = decodedList.map((item) => LeaderboardEntry.fromJson(item)).toList();
    }
    _sortEntries();
    notifyListeners();
  }

  Future<void> _saveLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> encodedList =
    _entries.map((entry) => entry.toJson()).toList();
    await prefs.setString(_leaderboardKey, jsonEncode(encodedList));
  }

  Future<void> addEntry(LeaderboardEntry newEntry) async {
    try {
      final existingEntry = _entries.firstWhere((entry) => entry.name == newEntry.name);
      if (newEntry.score > existingEntry.score) {
        _entries.remove(existingEntry);
        _entries.add(newEntry);
      }
    } catch (e) {
      _entries.add(newEntry);
    }

    _sortEntries();

    if (_entries.length > maxEntries) {
      _entries = _entries.sublist(0, maxEntries);
    }

    await _saveLeaderboard();
    notifyListeners();
  }

  void _sortEntries() {
    _entries.sort((a, b) => b.score.compareTo(a.score));
  }

  int getUserRank(String userName) {
    final index = _entries.indexWhere((entry) => entry.name == userName);

    if (index != -1) {
      return index + 1;
    } else {
      return -1;
    }
  }
}