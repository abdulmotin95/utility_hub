import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';

class TextPdfLogic {
  List<String> savedTexts = [];

  Future<void> loadSavedTexts() async {
    final prefs = await SharedPreferences.getInstance();
    savedTexts = prefs.getStringList('savedTexts') ?? [];
    savedTexts = savedTexts.reversed.toList();
  }

  Future<void> deleteText(int index) async {
    final prefs = await SharedPreferences.getInstance();

    final file = File(savedTexts[index]);
    if (await file.exists()) await file.delete();

    savedTexts.removeAt(index);
    await prefs.setStringList('savedTexts', savedTexts.reversed.toList().reversed.toList());
  }

  Future<String> generatePDFAuto(String text) async {
    if (text.trim().isEmpty) return "";

    final pdf = pw.Document();

    final paragraphs = text.split('\n');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return paragraphs.map((p) => pw.Text(
            p,
            style: const pw.TextStyle(fontSize: 12, height: 1.4),
            textAlign: pw.TextAlign.justify,
          )).toList();
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/text_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    savedTexts.insert(0, filePath);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedTexts', savedTexts.reversed.toList().reversed.toList());

    await OpenFile.open(file.path);

    return filePath;
  }
}
