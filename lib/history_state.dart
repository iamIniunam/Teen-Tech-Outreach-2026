import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CivicSubmission {
  final String schoolName;
  final String issueTitle;
  final String icon;
  int votes;

  CivicSubmission({
    required this.schoolName,
    required this.issueTitle,
    required this.icon,
    required this.votes,
  });

  Map<String, dynamic> toJson() => {
        'schoolName': schoolName,
        'issueTitle': issueTitle,
        'icon': icon,
        'votes': votes,
      };

  factory CivicSubmission.fromJson(Map<String, dynamic> json) => CivicSubmission(
        schoolName: json['schoolName'] as String,
        issueTitle: json['issueTitle'] as String,
        icon: json['icon'] as String,
        votes: json['votes'] as int,
      );
}

class LeaderboardEntry {
  final String schoolName;
  int score;
  int trials;
  final DateTime timestamp;

  LeaderboardEntry({
    required this.schoolName,
    required this.score,
    required this.trials,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'schoolName': schoolName,
        'score': score,
        'trials': trials,
        'timestamp': timestamp.toIso8601String(),
      };

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      LeaderboardEntry(
        schoolName: json['schoolName'] as String,
        score: json['score'] as int,
        trials: json['trials'] as int? ?? 1,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
}

class ArtSubmission {
  final String schoolName;
  final List<Color> gridColors;
  final int gridSize;

  ArtSubmission({
    required this.schoolName,
    required this.gridColors,
    required this.gridSize,
  });

  Map<String, dynamic> toJson() => {
        'schoolName': schoolName,
        'gridColors': gridColors.map((c) => c.value).toList(),
        'gridSize': gridSize,
      };

  factory ArtSubmission.fromJson(Map<String, dynamic> json) => ArtSubmission(
        schoolName: json['schoolName'] as String,
        gridSize: json['gridSize'] as int,
        gridColors: (json['gridColors'] as List<dynamic>)
            .map((v) => Color(v as int))
            .toList(),
      );
}

class HistoryState {
  static SharedPreferences? _prefs;

  // Active entries - all initialized to start completely empty
  static final List<CivicSubmission> civicSubmissions = [];
  static final List<LeaderboardEntry> speedLeaderboard = [];
  static final List<ArtSubmission> artGallery = [];

  // Keys for SharedPreferences
  static const String _keyCivic = 'civic_submissions_v1';
  static const String _keySpeed = 'speed_leaderboard_v1';
  static const String _keyArt = 'art_gallery_v1';

  // Initialize SharedPreferences and load data
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();
  }

  static void _loadData() {
    if (_prefs == null) return;

    // Load Civic Submissions
    final List<String>? civicJsonList = _prefs!.getStringList(_keyCivic);
    if (civicJsonList != null) {
      civicSubmissions.clear();
      for (final jsonStr in civicJsonList) {
        try {
          final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
          civicSubmissions.add(CivicSubmission.fromJson(decoded));
        } catch (_) {}
      }
    }

    // Load Speed Leaderboard
    final List<String>? speedJsonList = _prefs!.getStringList(_keySpeed);
    if (speedJsonList != null) {
      speedLeaderboard.clear();
      for (final jsonStr in speedJsonList) {
        try {
          final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
          speedLeaderboard.add(LeaderboardEntry.fromJson(decoded));
        } catch (_) {}
      }
      speedLeaderboard.sort((a, b) => b.score.compareTo(a.score));
    }

    // Load Art Gallery Masterpieces
    final List<String>? artJsonList = _prefs!.getStringList(_keyArt);
    if (artJsonList != null) {
      artGallery.clear();
      for (final jsonStr in artJsonList) {
        try {
          final decoded = jsonDecode(jsonStr) as Map<String, dynamic>;
          artGallery.add(ArtSubmission.fromJson(decoded));
        } catch (_) {}
      }
    }
  }

  // Save persistence operations
  static Future<void> _saveCivic() async {
    if (_prefs == null) return;
    final jsonList = civicSubmissions.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs!.setStringList(_keyCivic, jsonList);
  }

  static Future<void> _saveSpeed() async {
    if (_prefs == null) return;
    final jsonList = speedLeaderboard.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs!.setStringList(_keySpeed, jsonList);
  }

  static Future<void> _saveArt() async {
    if (_prefs == null) return;
    final jsonList = artGallery.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs!.setStringList(_keyArt, jsonList);
  }

  // Add Entries & persist
  static Future<void> addCivic(String schoolName, String issueTitle, String icon) async {
    civicSubmissions.add(CivicSubmission(
      schoolName: schoolName,
      issueTitle: issueTitle,
      icon: icon,
      votes: 1,
    ));
    await _saveCivic();
  }

  // Increment support vote on a global submission
  static Future<void> incrementCivicVote(int index) async {
    if (index >= 0 && index < civicSubmissions.length) {
      civicSubmissions[index].votes++;
      await _saveCivic();
    }
  }

  static Future<void> addSpeedScore(String schoolName, int score) async {
    final existingIndex = speedLeaderboard.indexWhere(
      (e) => e.schoolName.toLowerCase() == schoolName.toLowerCase(),
    );

    if (existingIndex != -1) {
      final entry = speedLeaderboard[existingIndex];
      entry.trials++;
      if (score > entry.score) {
        entry.score = score;
      }
    } else {
      speedLeaderboard.add(LeaderboardEntry(
        schoolName: schoolName,
        score: score,
        trials: 1,
        timestamp: DateTime.now(),
      ));
    }

    speedLeaderboard.sort((a, b) => b.score.compareTo(a.score));
    await _saveSpeed();
  }

  static Future<void> addArt(String schoolName, List<Color> gridColors, int gridSize) async {
    artGallery.add(ArtSubmission(
      schoolName: schoolName,
      gridColors: List.from(gridColors),
      gridSize: gridSize,
    ));
    await _saveArt();
  }
}
