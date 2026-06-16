import 'package:flutter/material.dart';
import 'package:demo_app/thank_you_page.dart';

class CivicIssue {
  final String title;
  final String icon;
  int votes;

  CivicIssue({
    required this.title,
    required this.icon,
    this.votes = 0,
  });
}

class CivicDashboardPage extends StatefulWidget {
  final String schoolName;

  const CivicDashboardPage({super.key, required this.schoolName});

  @override
  State<CivicDashboardPage> createState() => _CivicDashboardPageState();
}

class _CivicDashboardPageState extends State<CivicDashboardPage> {
  final TextEditingController _issueController = TextEditingController();

  // =================================================================
  // TODO: KID CODER TASK - ADD YOUR OWN COMMUNITY ISSUES IN CODE!
  // You can add a new issue here! Use this format inside the list below:
  // CivicIssue(title: "Your issue description here", icon: "emoji", votes: 10),
  // Make sure to save (Ctrl + S) to see it appear in the dashboard list!
  // =================================================================
  late List<CivicIssue> _issues;

  @override
  void initState() {
    super.initState();
    _issues = [
      CivicIssue(
        title: "Fix potholes on Teshie Beach Road",
        icon: "🕳️",
        votes: 12,
      ),
      CivicIssue(
        title: "Install solar streetlights near Methodist Church",
        icon: "💡",
        votes: 8,
      ),
      CivicIssue(
        title: "Open a free youth coding lab in Accra",
        icon: "💻",
        votes: 25,
      ),
    ];
  }

  void _addCustomIssue() {
    final text = _issueController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _issues.add(CivicIssue(title: text, icon: "📢", votes: 1));
    });
    _issueController.clear();
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("New community issue reported!"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // =================================================================
    // TODO: KID CODER TASK - CHANGE THE PAGE TITLE!
    // Edit the text inside the quotes below to rename this dashboard page.
    // Save (Ctrl + S) to see the title change at the top of the screen!
    // =================================================================
    const String pageTitle = "🗳️ CivicVoice Teshie";

    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: [
              // Top Banner info
              Container(
                color: Colors.teal.withOpacity(0.15),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                width: double.infinity,
                child: Text(
                  "Active School: ${widget.schoolName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
                  ),
                ),
              ),

              // Main Issues List
              Expanded(
                child: _issues.isEmpty
                    ? const Center(
                        child: Text("No reported issues yet. Be the first!"))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: _issues.length,
                        itemBuilder: (context, index) {
                          final issue = _issues[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    issue.icon,
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          issue.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${issue.votes} supports",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton.filled(
                                    onPressed: () {
                                      setState(() {
                                        issue.votes++;
                                      });
                                    },
                                    icon: const Icon(Icons.thumb_up_rounded),
                                    style: IconButton.styleFrom(
                                      backgroundColor:
                                          Colors.teal.withOpacity(0.25),
                                      foregroundColor: Colors.tealAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Submit Area & Finish Button
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _issueController,
                            decoration: InputDecoration(
                              hintText: "Report a new local issue...",
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _addCustomIssue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                          ),
                          child: const Icon(Icons.send),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThankYouPage(
                              bgColor: Colors.teal.shade800,
                              customMessage:
                                  "Thank you for advocating, ${widget.schoolName}!",
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit Report & Finish 🚀",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
