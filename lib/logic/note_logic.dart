import 'dart:convert';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class NotesLogic {
  List<Map<String, String>> notes = [];


  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final storedNotes = prefs.getString('notes');
    if (storedNotes != null && storedNotes.isNotEmpty) {
      final List decoded = jsonDecode(storedNotes);
      notes = decoded.map((e) => Map<String, String>.from(e)).toList();
    }
  }


  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notes);
    await prefs.setString('notes', encoded);
  }


  Future<void> addNote(Map<String, String> note) async {
    final text = note['content'] ?? '';
    String pdfPath = '';

    if (text.isNotEmpty) {
      final file = await _generatePDF(text, note['title'] ?? 'Untitled');
      pdfPath = file.path;
    }

    final noteWithPDF = {
      'title': note['title'] ?? 'Untitled',
      'content': text,
      'pdfPath': pdfPath,
    };

    notes.add(noteWithPDF);
    await saveNotes();
  }

  Future<void> deleteNoteAt(int index) async {
    final pdfPath = notes[index]['pdfPath'] ?? '';
    if (pdfPath.isNotEmpty) {
      final file = File(pdfPath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    notes.removeAt(index);
    await saveNotes();
  }

  Future<void> openNotePDF(int index) async {
    if (index < 0 || index >= notes.length) return;
    final pdfPath = notes[index]['pdfPath'] ?? '';
    if (pdfPath.isNotEmpty) {
      final file = File(pdfPath);
      if (await file.exists()) {
        await OpenFile.open(file.path);
      } else {
        print("PDF not found: $pdfPath");
      }
    } else {
      print("No PDF path for this note");
    }
  }


  Future<File> _generatePDF(String text, String title) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) => [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 20,
            ),
          ),

          pw.SizedBox(height: 12),
          pw.Text(
            text,
            style: const pw.TextStyle(fontSize: 14, height: 1.4),
            textAlign: pw.TextAlign.justify,
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/note_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
