import 'package:flutter/material.dart';

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
}

class LeaderboardEntry {
  final String schoolName;
  final int score;
  final DateTime timestamp;

  LeaderboardEntry({
    required this.schoolName,
    required this.score,
    required this.timestamp,
  });
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
}

class HistoryState {
  // Pre-populated data for Accra schools to make it look active and exciting!
  static final List<CivicSubmission> civicSubmissions = [
    CivicSubmission(
      schoolName: "Teshie Presby",
      issueTitle: "Provide more waste bins along the Teshie Beach Road",
      icon: "🗑️",
      votes: 18,
    ),
    CivicSubmission(
      schoolName: "La Bone SHS",
      issueTitle: "Install solar streetlights near the community market",
      icon: "💡",
      votes: 24,
    ),
    CivicSubmission(
      schoolName: "Osu Prep School",
      issueTitle: "Build a tech lab for kids at Osu Library",
      icon: "💻",
      votes: 35,
    ),
  ];

  static final List<LeaderboardEntry> speedLeaderboard = [
    LeaderboardEntry(schoolName: "Achimota School", score: 52, timestamp: DateTime.now()),
    LeaderboardEntry(schoolName: "Accra Academy", score: 48, timestamp: DateTime.now()),
    LeaderboardEntry(schoolName: "Teshie Tech Club", score: 45, timestamp: DateTime.now()),
    LeaderboardEntry(schoolName: "La Bone SHS", score: 39, timestamp: DateTime.now()),
  ];

  static final List<ArtSubmission> artGallery = [
    // Pre-populate with a simple pixel heart and a smile!
    ArtSubmission(
      schoolName: "Teshie Presby",
      gridSize: 6,
      gridColors: [
        Colors.grey.shade800, Colors.red, Colors.grey.shade800, Colors.grey.shade800, Colors.red, Colors.grey.shade800,
        Colors.red, Colors.red, Colors.red, Colors.red, Colors.red, Colors.red,
        Colors.red, Colors.red, Colors.red, Colors.red, Colors.red, Colors.red,
        Colors.grey.shade800, Colors.red, Colors.red, Colors.red, Colors.red, Colors.grey.shade800,
        Colors.grey.shade800, Colors.grey.shade800, Colors.red, Colors.red, Colors.grey.shade800, Colors.grey.shade800,
        Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800,
      ],
    ),
    ArtSubmission(
      schoolName: "Accra Academy",
      gridSize: 6,
      gridColors: [
        Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800,
        Colors.grey.shade800, Colors.yellow, Colors.grey.shade800, Colors.grey.shade800, Colors.yellow, Colors.grey.shade800,
        Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800,
        Colors.yellow, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.yellow,
        Colors.grey.shade800, Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow, Colors.grey.shade800,
        Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800, Colors.grey.shade800,
      ],
    ),
  ];

  static void addCivic(String schoolName, String issueTitle, String icon) {
    civicSubmissions.add(CivicSubmission(
      schoolName: schoolName,
      issueTitle: issueTitle,
      icon: icon,
      votes: 1,
    ));
  }

  static void addSpeedScore(String schoolName, int score) {
    speedLeaderboard.add(LeaderboardEntry(
      schoolName: schoolName,
      score: score,
      timestamp: DateTime.now(),
    ));
    // Sort highest to lowest
    speedLeaderboard.sort((a, b) => b.score.compareTo(a.score));
  }

  static void addArt(String schoolName, List<Color> gridColors, int gridSize) {
    artGallery.add(ArtSubmission(
      schoolName: schoolName,
      gridColors: List.from(gridColors),
      gridSize: gridSize,
    ));
  }
}
