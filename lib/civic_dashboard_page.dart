import 'package:flutter/material.dart';
import 'package:demo_app/thank_you_page.dart';
import 'package:demo_app/history_state.dart';

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
      // Save it globally to the shared history board!
      HistoryState.addCivic(widget.schoolName, text, "📢");
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(pageTitle),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.tealAccent,
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Report Board", icon: Icon(Icons.edit_document)),
              Tab(text: "Accra Voices", icon: Icon(Icons.campaign)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Active Report Board
            GestureDetector(
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
                              child:
                                  Text("No reported issues yet. Be the first!"))
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
                                          icon: const Icon(
                                              Icons.thumb_up_rounded),
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
                                  onChanged: (text) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Report a new local issue...",
                                    suffixIcon: _issueController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear_rounded),
                                            onPressed: () {
                                              setState(() {
                                                _issueController.clear();
                                              });
                                            },
                                          )
                                        : null,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16),
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
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
            // Tab 2: Accra Voices History list
            _buildHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    final submissions = HistoryState.civicSubmissions;
    return SafeArea(
      child: Column(
        children: [
          // Accra Voices Header
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.teal.withOpacity(0.05),
            width: double.infinity,
            child: const Text(
              "📢 Persistent Reports from all Accra Schools:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.tealAccent),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: submissions.isEmpty
                ? const Center(
                    child: Text("No community reports yet. Be the first!"))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: submissions.length,
                    itemBuilder: (context, index) {
                      final submission = submissions[index];
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
                                submission.icon,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      submission.issueTitle,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "Reported by: ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        Text(
                                          submission.schoolName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${submission.votes} supports",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton.filled(
                                onPressed: () async {
                                  await HistoryState.incrementCivicVote(index);
                                  setState(() {});
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
        ],
      ),
    );
  }
}
