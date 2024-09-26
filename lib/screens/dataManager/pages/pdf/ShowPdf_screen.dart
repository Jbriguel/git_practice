import 'dart:async';
import 'dart:io';

import 'package:atelier_so/core/modeles/client/client.dart';
import 'package:atelier_so/core/modeles/data_commande/commande/commande.dart';
import 'package:atelier_so/core/theme/theme_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'allCommandes_doc.dart';
import 'customers_doc.dart';
import 'make_commande_details_doc.dart';

class AfficherDataInPDF extends StatefulWidget {
  final String genre;
  final String document_name;
  final List<Commande>? commandes;
  final Client? client;
  AfficherDataInPDF(
      {Key? key,
      required this.genre,
      required this.document_name,
      this.commandes,
      this.client})
      : super(key: key);

  @override
  AfficherDataInPDFState createState() {
    return AfficherDataInPDFState();
  }
}

class AfficherDataInPDFState extends State<AfficherDataInPDF>
    with SingleTickerProviderStateMixin {
  int _tab = 0;
  TabController? _tabController;

  PrintingInfo? printingInfo;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    _init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _init() async {
    final info = await Printing.info();

    setState(() {
      printingInfo = info;
    });
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + '${widget.document_name}.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  String get getTitle {
    switch (widget.genre) {
      case 'cmd':
        return "Exporter Commandes";
      case 'clt':
        return "Exporter Clients";
      case 'comDetails':
        return "Details Commande";
      case 'proprietés':
        return "Exporter Propriétés";
      default:
        return "PDF";
    }
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = false;

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: ThemeColors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          getTitle,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: widget.genre == "cmd"
          ? PdfPreview(
              //maxPageWidth: 700,
              build: (format) => Affichage('RAPPORT', 'Rapport.dart',
                      generateReportAllCommandes) //generateReportCommandes)
                  .builder(
                format,
              ),
              actions: actions,
              onPrinted: _showPrintedToast,
              onShared: _showSharedToast,
            )
          : widget.genre == "clt"
              ? PdfPreview(
                  //maxPageWidth: 700,
                  build: (format) => Affichage(
                          'RAPPORT', 'Rapport.dart', generateReportClients)
                      .builder(
                    format,
                  ),
                  actions: actions,
                  onPrinted: _showPrintedToast,
                  onShared: _showSharedToast,
                )
              : widget.genre == "comDetails"
                  ? PdfPreview(
                      //maxPageWidth: 700,
                      build: (format) => AffichageCommandeDetails(
                              'RAPPORT',
                              'Rapport.dart',
                              generateReportCommandeDetails
                                  as LayoutCallbackWithData2)
                          .builder(
                              format, widget.commandes ?? [], widget.client!),
                      actions: actions,
                      onPrinted: _showPrintedToast,
                      onShared: _showSharedToast,
                    )
                  : const Text("data"),
    );
  }
}

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat);

typedef LayoutCallbackWithData2 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<Commande> commandes, Client client);

class Affichage {
  const Affichage(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}

class AffichageCommandeDetails {
  const AffichageCommandeDetails(this.name, this.file, this.builder,
      [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData2 builder;

  final bool needsData;
}
