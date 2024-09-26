import 'dart:math';

import 'package:atelier_so/core/database/database_hepler.dart';
import 'package:atelier_so/core/database/table_manager/client_helper.dart';
import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/repository/commandeRepository/commande_repository.dart';
import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:atelier_so/di/global_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateReportAllCommandes(PdfPageFormat pageFormat) async {
  final doc = pw.Document(pageMode: PdfPageMode.outlines);

  final font1 = await PdfGoogleFonts.openSansRegular();
  final font2 = await PdfGoogleFonts.openSansBold();

  final profileImage = pw.MemoryImage(
    (await rootBundle.load(Images.logo_noBack)).buffer.asUint8List(),
  );

  // Create a PDF document.
  final document = pw.Document();
  List<Client> clientsData =
      await getIt<DatabaseHelper>().obtenirTousLesClients();
  final List<Commande> commandesListData =
      await getIt<CommandeRepository>().getCommandesWithHabitsAndProprieties();

  Client getCommandeClient(String cltUid) {
    return clientsData.where((element) => element.uid == cltUid).toList()[0];
  }
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
                  .toList())
        ]),
      );

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
            child: pw.Column(children: [
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
                    text: 'Rapport des commandes\n',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ]),
              ),
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
                  'AtelierSo |' + DateTime.now().year.toString(),
                  style: const pw.TextStyle(
                    color: PdfColors.black,
                  ),
                ),
              ),
            ]),
          );
        }),
  );
  /////////////////////////////////////

  document.addPage(
    pw.MultiPage(
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
              child: pw.Text('AtelierSo',
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
                    'AtelierSo |' + DateTime.now().year.toString(),
                    style: const pw.TextStyle(
                      color: PdfColors.black,
                    ),
                  ),
                ),
                pw.Container(
                    alignment: pw.Alignment.centerRight,
                    margin:
                        const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                    child: pw.Text(
                        'Page ${context.pageNumber} of ${context.pagesCount}',
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                            .copyWith(color: PdfColors.black)))
              ]);
        },
        build: (pw.Context context) => <pw.Widget>[
              entete(context, profileImage, "Detais"),
              for (Commande commande in commandesListData) ...{
                // pw.Header(level: 2, text: 'Information sur la commande :'),
                pw.Header(level: 1, text: '📋 Commande : ${commande.uid}'),
                pw.Bullet(
                    text:
                        'Client : ${getCommandeClient(commande.clientUid!).nomComplet}'),
                pw.Bullet(
                    text:
                        'Tel : ${getCommandeClient(commande.clientUid!).phone}'),
                pw.Bullet(
                    text:
                        'Date de remise : ${DateFormat('dd MMMM yyyy').format(DateTime.parse(commande.deliveryDate))}'),
                pw.Bullet(text: 'Prix : ${commande.price} Fcfa'),
                pw.Bullet(
                    text: 'information supplémentaire : ${commande.details}'),
                pw.Header(level: 2, text: '# les Habits'),
                pw.ListView.builder(
                  itemCount: commande.habits!.length,
                  itemBuilder: (context, index) {
                    final habit = commande.habits![index];
                    return pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(vertical: 5),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Header(level: 2, text: '${habit.name}'),
                            pw.ListView.builder(
                              itemCount: habit.proprieties!.length,
                              itemBuilder: (context, index) {
                                final propiety = habit.proprieties![index];
                                return pw.Bullet(
                                    bulletColor: PdfColors.grey400,
                                    bulletShape: pw.BoxShape.rectangle,
                                    text:
                                        '${propiety.name}: ${propiety.value}');
                              },
                            ),
                            pw.Divider(color: PdfColors.grey200),
                          ]),
                    );
                  },
                ),
                pw.Header(level: 1, text: 'Informations sur le client:'),
                InfoClient(getCommandeClient(commande.clientUid!), context),
              },
              pw.SizedBox(height: 20),
              pw.Divider(color: PdfColors.grey200),
            ]),
  );

  // Return the PDF file content
  return document.save();
}

pw.Widget entete(pw.Context context, image, String titre) {
  return pw.Header(
    level: 0,
    title: 'AtelierSo',
    child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: <pw.Widget>[
          pw.Text(titre, textScaleFactor: 2),
          pw.Container(
            alignment: pw.Alignment.topRight,
            height: 50,
            child: pw.Image(image),
          ),
        ]),
  );
}
