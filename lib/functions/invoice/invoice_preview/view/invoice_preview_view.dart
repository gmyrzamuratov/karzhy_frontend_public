import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/core/controllers/auth_controller.dart';
import 'package:karzhy_frontend/core/utils/colors.dart';
import 'package:karzhy_frontend/core/utils/dimensions.dart';
import 'package:karzhy_frontend/functions/home/controllers/home_controller.dart';
import 'package:karzhy_frontend/functions/invoice/invoice_preview/view/pdf_ai.dart';
import 'package:karzhy_frontend/functions/invoice/invoice_preview/view/pdf_old.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InvoicePreviewView extends StatelessWidget {

  static const routeNamed = "/invoice/print";

  Map<String, dynamic> args = Get.arguments;

  InvoicePreviewView({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => PdfInvoiceOldApi.generate(args['invoice'])
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: PdfInvoiceApi.generate(args['invoice']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic _documentBytes = snapshot.data;

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.calcW(15),
                              vertical: Dimensions.calcH(8)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: SfPdfViewer.memory(
                            _documentBytes,
                            initialZoomLevel: 0.5,
                          )),
                    ),
                    /*
                    SizedBox(
                      height: Get.size.height * 0.2,
                      child: Column(
                        children: [
                          CustomBtn(
                            label: AppStrings.SAVE_BTN,
                            action: () {
                              Get.find<AllInvoiceController>()
                                  .createNewInvoice(args["invoice"]);
                              Get.back();
                            },
                            color: AppColors.kPrimaryColor,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    )*/
                  ]);
            } else {
              return Center(
                child: SizedBox(
                  height: Dimensions.calcH(80),
                  width: Dimensions.calcW(80),
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              );
            }
          }),
    );
  }*/
}
