import 'package:admin/config/constants.dart';
import 'package:admin/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatelessWidget {
  const PDFViewerScreen({Key? key}) : super(key: key);

  static String routeName() => '/pdf_viewer_screen';

  @override
  Widget build(BuildContext context) {
    // GET OPENED FILE NAME FROM ARGUMENTS
    final String fileUrl = ModalRoute.of(context)!.settings.arguments as String;
    Helper.logger.i(fileUrl);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          basenameWithoutExtension(fileUrl).toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        elevation: 0,
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          splashRadius: 20,
        ),
      ),
      body: SfPdfViewer.network(
        fileUrl,
        pageLayoutMode: PdfPageLayoutMode.single,
      ),
    );
  }
}
