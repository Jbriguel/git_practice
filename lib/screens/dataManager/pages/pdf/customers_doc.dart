import 'dart:math';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateReportClients(

    // DatabaseHelper database = getIt<DatabaseHelper>();

    PdfPageFormat pageFormat) async {
  final doc = pw.Document(pageMode: PdfPageMode.outlines);

  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();

  final profileImage = pw.MemoryImage(
    (await rootBundle.load(Images.logo_noBack)).buffer.asUint8List(),
  );

  const tableHeaders = ['NoS', 'Nom Complet', 'Adresse', 'Numero'];
  List<Client> clientsData =
      await getIt<DatabaseHelper>().obtenirTousLesClients();

  print("clientsData : ${clientsData}");

  const baseColor = PdfColors.cyan;

  // Create a PDF document.
  final document = pw.Document();

//Diviser le tableau
  // Data table

  InfoClient(Client client, pw.Context context) => pw.Padding(
      padding: const pw.EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 30,
      ),
      child: pw.Column(children: [
        pw.SizedBox(height: 10),
        pw.Text('# ${client.id}',
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(
                fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
        pw.Table.fromTextArray(
            data: client
                .toMap_forPdf()
                .entries
                .map(
                  (e) => <String>[e.key, e.value ?? '--'],
                )
                .toList()
            // <List<String>>[
            // <String>[
            //   'Données',
            //   'Valeurs',
            // ],
            // <String>['NoS', client.uid ?? '--'],
            // <String>['Nom Complet', client.name],
            // <String>['Adresse', client.adresse],
            // <String>['Téléphone', client.tel],
            // ]
            )
      ]));

  /////////////////////////////////////

  document.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat.copyWith(
          marginBottom: 0,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
        ),
        orientation: pw.PageOrientation.portrait,
        theme: pw.ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
      ),
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(
            left: 60,
            right: 60,
            bottom: 30,
          ),
          child: pw.Column(
            children: [
              pw.Spacer(),
              pw.RichText(
                  text: pw.TextSpan(children: [
                pw.TextSpan(
                  text: DateTime.now().day.toString() +
                      '-' +
                      DateTime.now().month.toString() +
                      '-' +
                      DateTime.now().year.toString() +
                      '\n',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                    fontSize: 30,
                  ),
                ),
                pw.TextSpan(
                  text: 'Données des clients',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ])),
              pw.Spacer(),
              pw.Container(
                alignment: pw.Alignment.center,
                height: 200,
                child: pw.Image(profileImage),
              ),
              pw.Spacer(flex: 2),
              pw.Align(
                alignment: pw.Alignment.topLeft,
                child: pw.Text(
                  '--- |' + DateTime.now().year.toString(),
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  /////////////////////////////////////

  document.addPage(pw.MultiPage(
    pageTheme: pw.PageTheme(
      pageFormat: pageFormat.copyWith(
        marginBottom: 2.0 * PdfPageFormat.cm,
        marginLeft: 2.0 * PdfPageFormat.cm,
        marginRight: 2.0 * PdfPageFormat.cm,
        marginTop: 2.0 * PdfPageFormat.cm,
      ),
      orientation: pw.PageOrientation.portrait,
      theme: pw.ThemeData.withFont(
        base: font1,
        bold: font2,
      ),
    ),
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    header: (pw.Context context) {
      if (context.pageNumber == 1) {
        return pw.SizedBox();
      }
      return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          child: pw.Text('Tela',
              style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(color: PdfColors.grey)));
    },
    footer: (pw.Context context) {
      return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                '--- |' + DateTime.now().year.toString(),
                style: const pw.TextStyle(
                  color: PdfColors.black,
                ),
              ),
            ),
            pw.Container(
                alignment: pw.Alignment.centerRight,
                margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                child: pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.black)))
          ]);
    },
    build: (pw.Context context) => <pw.Widget>[
      pw.Header(
          level: 0,
          title: 'tela',
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Text("Présentation des données", textScaleFactor: 2),
                pw.Container(
                  alignment: pw.Alignment.topRight,
                  height: 50,
                  child: pw.Image(profileImage),
                ),
              ])),
      for (Client client in clientsData) InfoClient(client, context),
      pw.SizedBox(height: 20),
    ],
  ));

  // Return the PDF file content
  return document.save();
}
