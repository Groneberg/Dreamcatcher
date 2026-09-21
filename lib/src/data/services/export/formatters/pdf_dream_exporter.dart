import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/data/services/export/formatters/dream_exporter.dart';

class PdfDreamExporter implements DreamExporter {
  @override
  String get fileExtension => 'pdf';

  @override
  String get mimeType => 'application/pdf';

  @override
  Future<Uint8List> generateData(List<Dream> dreams) async {
    final pdf = pw.Document(
      title: 'DreamCatcher Journal',
      author: 'DreamCatcher App',
    );

    final fontBase = pw.Font.helvetica();
    final fontBold = pw.Font.helveticaBold();
    final fontOblique = pw.Font.helveticaOblique();

    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    /// Define color palette for the PDF
    const primaryColor = PdfColor.fromInt(0xFF1B1464);
    const accentColor = PdfColor.fromInt(0xFF8A6D1C);  
    const textColor = PdfColor.fromInt(0xFF222222);
    const mutedColor = PdfColor.fromInt(0xFF666666);
    const borderColor = PdfColor.fromInt(0xFFDDDDDD);
    const tagBgColor = PdfColor.fromInt(0xFFF0EDF6);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 48),
        theme: pw.ThemeData.withFont(
          base: fontBase,
          bold: fontBold,
          italic: fontOblique,
        ),
        header: (context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 20),
            padding: const pw.EdgeInsets.only(bottom: 8),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: borderColor, width: 0.8),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'DREAMCATCHER JOURNAL',
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 10,
                    color: primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
                pw.Text(
                  'Clinical & Personal Archive',
                  style: pw.TextStyle(
                    font: fontBase,
                    fontSize: 9,
                    color: mutedColor,
                  ),
                ),
              ],
            ),
          );
        },
        footer: (context) {
          return pw.Container(
            margin: const pw.EdgeInsets.only(top: 16),
            padding: const pw.EdgeInsets.only(top: 8),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(color: borderColor, width: 0.8),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Generated on ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                  style: pw.TextStyle(fontSize: 8, color: mutedColor),
                ),
                pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.TextStyle(fontSize: 8, color: mutedColor),
                ),
              ],
            ),
          );
        },
        build: (context) {
          return [
            pw.Header(
              level: 0,
              text: 'Dream Journal Report',
              textStyle: pw.TextStyle(
                font: fontBold,
                fontSize: 22,
                color: primaryColor,
              ),
            ),
            pw.Text(
              'Total entries recorded: ${dreams.length}',
              style: pw.TextStyle(
                font: fontBase,
                fontSize: 11,
                color: mutedColor,
              ),
            ),
            pw.SizedBox(height: 20),
            ...dreams.map((dream) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 18),
                padding: const pw.EdgeInsets.all(14),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: borderColor, width: 0.8),
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Text(
                            dream.title?.isNotEmpty == true
                                ? dream.title!
                                : 'Untitled Memory',
                            style: pw.TextStyle(
                              font: fontBold,
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        pw.Text(
                          dateFormat.format(dream.date),
                          style: pw.TextStyle(
                            font: fontBase,
                            fontSize: 9,
                            color: mutedColor,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 6),
                    pw.Row(
                      children: [
                        pw.Text(
                          'Clarity Score: ',
                          style: pw.TextStyle(font: fontBold, fontSize: 9, color: mutedColor),
                        ),
                        pw.Text(
                          '${dream.clarityScore} / 5',
                          style: pw.TextStyle(font: fontBold, fontSize: 9, color: accentColor),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      dream.content,
                      style: pw.TextStyle(
                        font: fontBase,
                        fontSize: 10,
                        lineSpacing: 2,
                        color: textColor,
                      ),
                    ),
                    if (dream.tags.isNotEmpty) ...[
                      pw.SizedBox(height: 10),
                      pw.Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: dream.tags.map((tag) {
                          return pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: const pw.BoxDecoration(
                              color: tagBgColor,
                              borderRadius: pw.BorderRadius.all(
                                pw.Radius.circular(4),
                              ),
                            ),
                            child: pw.Text(
                              '#$tag',
                              style: pw.TextStyle(
                                font: fontBase,
                                fontSize: 8,
                                color: primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ];
        },
      ),
    );

    return pdf.save();
  }
}