import 'package:flutter/material.dart';
import 'package:demo_app/thank_you_page.dart';
import 'package:demo_app/history_state.dart';

class ArtStudioPage extends StatefulWidget {
  final String schoolName;

  const ArtStudioPage({super.key, required this.schoolName});

  @override
  State<ArtStudioPage> createState() => _ArtStudioPageState();
}

class _ArtStudioPageState extends State<ArtStudioPage> {
  // =================================================================
  // TODO: KID CODER TASK 1 - CHANGE THE GRID CANVAS SIZE!
  // Find the number 6 below. Change it to 4 or 8 to resize the drawing board!
  // Note: After saving, press Hot Restart (Shift + R in the console) to reset the grid!
  // =================================================================
  static const int _gridSize = 6;
  late List<Color> _gridColors;
  Color _selectedColor = Colors.red;

  // =================================================================
  // TODO: KID CODER TASK 2 - ADD NEW COLORS TO THE PAINT PALETTE!
  // Try adding a new color to this list, like: Colors.pink, Colors.orange,
  // Colors.deepOrange, Colors.lime, Colors.cyan, or Colors.brown.
  // Save (Ctrl + S) to see the new paint circles appear in the color row!
  // =================================================================
  final List<Color> _paletteColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    _resetGrid();
    // Set default selected color to the first color in the palette
    if (_paletteColors.isNotEmpty) {
      _selectedColor = _paletteColors.first;
    }
  }

  void _resetGrid() {
    setState(() {
      _gridColors = List.filled(_gridSize * _gridSize, Colors.grey.shade800);
    });
  }

  void _colorPixel(int index) {
    setState(() {
      // If the cell is already colored with the selected color, clear it (toggle behavior)
      if (_gridColors[index] == _selectedColor) {
        _gridColors[index] = Colors.grey.shade800;
      } else {
        _gridColors[index] = _selectedColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const indigoColor = Colors.indigoAccent;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("🎨 Pixel Art Studio"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.indigoAccent,
            labelColor: Colors.indigoAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Canvas", icon: Icon(Icons.palette_rounded)),
              Tab(text: "Gallery", icon: Icon(Icons.photo_library_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Active Drawing Canvas
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Banner info (edge-to-edge)
                  Container(
                    color: indigoColor.withOpacity(0.15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    width: double.infinity,
                    child: Text(
                      "Artist: ${widget.schoolName}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ),
                  // Padded content area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Pixel Drawing Board
                          AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade700, width: 2),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _gridSize,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0,
                                ),
                                itemCount: _gridSize * _gridSize,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => _colorPixel(index),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 150),
                                      decoration: BoxDecoration(
                                        color: _gridColors[index],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black45,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Color Palette Picker Title
                          const Text(
                            "Pick a Paint Color:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          // Color Palette Picker List
                          SizedBox(
                            height: 48,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _paletteColors.length,
                              itemBuilder: (context, index) {
                                final color = _paletteColors[index];
                                final isSelected = _selectedColor == color;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedColor = color;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12.0),
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected ? Colors.white : Colors.transparent,
                                        width: 3.0,
                                      ),
                                      boxShadow: [
                                        if (isSelected)
                                          BoxShadow(
                                            color: color.withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                      ],
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.black87,
                                            size: 20,
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          const Spacer(),

                          // Grid Reset and Navigation Options
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _resetGrid,
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text("Clear Canvas"),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // Save the artwork to persistent global gallery
                                    await HistoryState.addArt(widget.schoolName, _gridColors, _gridSize);

                                    if (context.mounted) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ThankYouPage(
                                            bgColor: Colors.indigo.shade800,
                                            customMessage:
                                                "Beautiful artwork, ${widget.schoolName}!",
                                          ),
                                        ),
                                      );
                                      if (mounted) {
                                        _resetGrid(); // Clears active canvas and refreshes/updates the Gallery tab
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: indigoColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Submit & Launch 🚀",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Tab 2: Gallery
            _buildGalleryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryTab() {
    final artworks = HistoryState.artGallery;
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.indigoAccent.withOpacity(0.05),
            width: double.infinity,
            child: const Text(
              "🖼️ Gallery of Outreach Masterpieces 🎨",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.indigoAccent),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: artworks.isEmpty
                ? const Center(child: Text("No artworks submitted yet. Draw first!"))
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: artworks.length,
                    itemBuilder: (context, index) {
                      final art = artworks[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              // Mini grid display
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(4.0),
                                    child: GridView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: art.gridSize,
                                        crossAxisSpacing: 2.0,
                                        mainAxisSpacing: 2.0,
                                      ),
                                      itemCount: art.gridColors.length,
                                      itemBuilder: (context, pixelIndex) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: art.gridColors[pixelIndex],
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // School / Creator name
                              Text(
                                art.schoolName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Artist",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade400,
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
