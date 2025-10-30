import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

class CameraPdfLogic {
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? capturedImage;
  List<String> savedPdfs = [];

  Future<void> initCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      controller = CameraController(cameras![0], ResolutionPreset.high);
      await controller!.initialize();
    }
  }

  Future<void> captureImage() async {
    if (controller != null && controller!.value.isInitialized) {
      capturedImage = await controller!.takePicture();
    }
  }

  Future<void> loadSavedPdfs() async {
    final prefs = await SharedPreferences.getInstance();
    savedPdfs = prefs.getStringList('savedPdfs') ?? [];
  }

  Future<void> savePdf(String path) async {
    final prefs = await SharedPreferences.getInstance();
    savedPdfs.add(path);
    await prefs.setStringList('savedPdfs', savedPdfs);
  }

  Future<String?> generatePdf() async {
    if (capturedImage == null) return null;

    final pdf = pw.Document();
    final bytes = await capturedImage!.readAsBytes();
    final image = pw.MemoryImage(bytes);

    pdf.addPage(pw.Page(
      build: (context) => pw.Center(
        child: pw.Image(image),
      ),
    ));

    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/image_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    await savePdf(filePath);

    capturedImage = null;
    return filePath;
  }

  Future<void> deletePdf(int index) async {
    final file = File(savedPdfs[index]);
    if (await file.exists()) {
      await file.delete();
    }
    savedPdfs.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedPdfs', savedPdfs);
  }

  void dispose() {
    controller?.dispose();
  }
}
