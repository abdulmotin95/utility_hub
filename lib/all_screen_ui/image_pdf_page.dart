import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:camera/camera.dart';
import '../logic/image_pdf_logic.dart';

class CameraPdfPage extends StatefulWidget {
  const CameraPdfPage({super.key});

  @override
  State<CameraPdfPage> createState() => _CameraPdfPageState();
}

class _CameraPdfPageState extends State<CameraPdfPage> {
  final CameraPdfLogic logic = CameraPdfLogic();

  @override
  void initState() {
    super.initState();
    logic.loadSavedPdfs().then((_) => setState(() {}));
    logic.initCamera().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    logic.dispose();
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
                          'Camera to PDF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: logic.capturedImage == null
                    ? logic.controller != null && logic.controller!.value.isInitialized
                    ? CameraPreview(logic.controller!)
                    : const Center(
                  child: Text(
                    "Open Camera and Take photo",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Stack(
                  children: [
                    Image.file(
                      File(logic.capturedImage!.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green, size: 40),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await logic.captureImage();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Capture Image",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final path = await logic.generatePdf();
                          if (path != null) OpenFile.open(path);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Generate PDF",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white70),
              Expanded(
                child: ListView.builder(
                  itemCount: logic.savedPdfs.length,
                  itemBuilder: (context, index) {
                    final fileName = logic.savedPdfs[index].split('/').last;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: ListTile(
                        title: Text(fileName),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await logic.deletePdf(index);
                            setState(() {});
                          },
                        ),
                        onTap: () => OpenFile.open(logic.savedPdfs[index]),
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
