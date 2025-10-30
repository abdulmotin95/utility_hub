import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import '../logic/text_pdf_logic.dart';

class TextPdfPage extends StatefulWidget {
  const TextPdfPage({super.key});

  @override
  State<TextPdfPage> createState() => _TextPdfPageState();
}

class _TextPdfPageState extends State<TextPdfPage> {
  final TextEditingController _controller = TextEditingController();
  final TextPdfLogic logic = TextPdfLogic();

  @override
  void initState() {
    super.initState();
    logic.loadSavedTexts().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5C91D4),
              Color(0xFF4451C8),
              Color(0xFF1F4ABE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Text PDF Generator 📑",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      hintText: "Type your text here...",
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final text = _controller.text.trim();
                        if (text.isEmpty) return;
                        await logic.generatePDFAuto(text);
                        _controller.clear();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15,),
                      ),
                      child: const Text(
                        "Generate PDF",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Saved PDFs (${logic.savedTexts.length})",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                flex: 2,
                child: logic.savedTexts.isEmpty
                    ? const Center(child: Text("No saved PDFs yet.", style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                  itemCount: logic.savedTexts.length,
                  itemBuilder: (context, index) {
                    final path = logic.savedTexts[index];
                    final fileName = path.split('/').last;
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(fileName),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await logic.deleteText(index);
                            setState(() {});
                          },
                        ),
                        onTap: () => OpenFile.open(path),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
