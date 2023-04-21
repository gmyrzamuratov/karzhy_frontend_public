import 'dart:typed_data';

import 'package:karzhy_frontend/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generate(Invoice invoice) async {

    var nunitoRegular = await PdfGoogleFonts.nunitoRegular();
    var nunitoBold = await PdfGoogleFonts.nunitoBold();

    final titles = <String>['Күні:'];
    final data = <String>[
      invoice.created.toString(),
    ];
    final headers = ['Аты', 'Өлш', 'Саны', 'Бағасы', 'Сомасы'];
    //final invoices_data = [...invoice.products.map((e) => e.toList()).toList()];

    List<List<dynamic>> invoices_data = [];

    for(int i=0; i<invoice.products.length; i++) {
      List<dynamic> row = [
        invoice.products[i].name,
        invoice.products[i].unit,
        invoice.products[i].quantity,
        invoice.products[i].price,
        invoice.products[i].sum
      ];
      invoices_data.add(row);
    }

    final pdf = Document();
    pdf.addPage(MultiPage(
      header: (context) => Text("Төлем шоты N ${invoice.number}",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, font: nunitoBold)),
      build: (context) => [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*(invoice.from.logo != null)
                        ? Image(
                      MemoryImage(invoice.from.logo!),
                      height: 80,
                      width: 80,
                    )
                        : */Text(""),
                    SizedBox(height: 1 * PdfPageFormat.cm),
                    Text(invoice.company.name!,
                        style: TextStyle(fontWeight: FontWeight.bold, font: nunitoBold)),
                    SizedBox(height: 1 * PdfPageFormat.mm),
                    Text(invoice.company.address!, style: TextStyle(font: nunitoRegular)),
                  ],
                ),
                /*
                Container(
                  height: 80,
                  width: 80,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: invoice.documentId!,
                  ),
                ),*/
              ],
            ),
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoice.client.name!,
                        style: TextStyle(fontWeight: FontWeight.bold, font: nunitoBold)),
                    Text(invoice.client.address!, style: TextStyle(font: nunitoRegular)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(titles.length, (index) {
                    final title = titles[index];
                    final value = data[index];

                    return buildText(title: title, value: value, width: 200, font: nunitoRegular);
                  }),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 3 * PdfPageFormat.cm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Мәліметтер',
              style: TextStyle(fontSize: 18, font: nunitoRegular),
            ),
            SizedBox(height: 0.8 * PdfPageFormat.cm),
          ],
        ),
        Table.fromTextArray(
          headers: headers,
          data: invoices_data,
          border: null,
          headerStyle: TextStyle(fontWeight: FontWeight.bold, font: nunitoBold),
          headerDecoration: BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: Alignment.centerLeft,
            1: Alignment.centerRight,
            2: Alignment.centerRight,
            3: Alignment.centerRight,
            4: Alignment.centerRight,
            5: Alignment.centerRight,
          },
          cellStyle: TextStyle(font: nunitoRegular)
        ),
        Divider(),
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Spacer(flex: 6),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      title: 'Барлығы',
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        font: nunitoBold
                      ),
                      value: "${invoice.total}тг",
                      unite: true,
                    ),
                    SizedBox(height: 2 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                    SizedBox(height: 0.5 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3 * PdfPageFormat.mm),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    ""//invoice.paymentInstructions,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container()/*Image(
                  MemoryImage(
                    invoice.signature.buffer.asUint8List(),
                  ),
                  height: 80,
                ),*/
              )
            ]),
      ],
      footer: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 8 * PdfPageFormat.mm),
          buildSimpleText(title: 'karzhy.kz', value: ""),
          SizedBox(height: 5 * PdfPageFormat.mm),
          /*
          buildSimpleText(
              title: '',
              value:
              "email: ${invoice.company.email!} / tel: ${invoice.from.phone!}"),*/
        ],
      ),
    ));
    Uint8List bytes = await pdf.save();
    return bytes;
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
    Font? font
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold, font: font);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}