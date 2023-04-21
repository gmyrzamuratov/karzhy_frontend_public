import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:karzhy_frontend/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfInvoiceOldApi {
  static Future<Uint8List> generate(Invoice invoice) async {
    var nunitoRegular = await PdfGoogleFonts.nunitoRegular();
    var nunitoBold = await PdfGoogleFonts.nunitoBold();

    final f = DateFormat('dd.MM.yyyy');
    final created = f.format(invoice.created);

    final titles = <String>['Күні:'];
    final data = <String>[
      created,
    ];
    final headers = ['№', 'Тауар', 'Саны', 'Бірл.', 'Бағасы', 'Сомасы'];
    //final invoices_data = [...invoice.products.map((e) => e.toList()).toList()];

    List<List<dynamic>> invoices_data = [];

    for (int i = 0; i < invoice.products.length; i++) {
      List<dynamic> row = [
        i,
        invoice.products[i].name,
        invoice.products[i].quantity,
        invoice.products[i].unit,
        invoice.products[i].price,
        invoice.products[i].sum
      ];
      invoices_data.add(row);
    }

    final pdf = Document();
    pdf.addPage(MultiPage(
      header: null,
      /*header: (context) => Text("Төлем шоты N ${invoice.number}",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, font: nunitoBold)),*/
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
                        : */
                    Text(""),
                    SizedBox(height: 1 * PdfPageFormat.cm),
                    Text(
                        "Назар аударыңыздар! Берілген шотты төлеу - тауарды жеткізу шарттарымен келісуді білдіреді. Төлем",
                        style: TextStyle(font: nunitoRegular, fontSize: 8.0),
                        textAlign: TextAlign.right),
                    Text(
                        "туралы хабарламаның болуы міндетті, болмаған жағдайда тауардың қоймада болуына кепілдік берілмейді.",
                        style: TextStyle(font: nunitoRegular, fontSize: 8.0)),
                    Text(
                        "Тауар Жеткізушінің е/ш ақшаның түсу фактісі бойынша, өзі алып кету арқылы, сенімхат және төлқұжат болған",
                        style: TextStyle(font: nunitoRegular, fontSize: 8.0)),
                    Text("жағдайда жіберіледі.",
                        style: TextStyle(font: nunitoRegular, fontSize: 8.0)),
                    /*
                    Text("Внимание! Оплата данного счета означает согласие с условиями поставки товара.",
                        style: TextStyle(font: nunitoRegular)),
                    Text("Уведомление об оплате обязательно, в противном случае не гарантируется наличие",
                        style: TextStyle(font: nunitoRegular)),
                    Text("товара на складе. Товар отпускается по факту прихода денег на р/с Поставщика,",
                        style: TextStyle(font: nunitoRegular)),
                    Text("самовывозом, при наличии доверенности и документов удостоверяющих личность.",
                        style: TextStyle(font: nunitoRegular)),*/
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
            Table(
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                },
                border: TableBorder.all(color: PdfColors.black),
                children: [
                  TableRow(children: [
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Бенефициар:',
                                  style: TextStyle(font: nunitoBold)),
                              Text(invoice.company.name!,
                                  style: TextStyle(font: nunitoBold)),
                              Text('БСН:${invoice.company.bin}',
                                  style: TextStyle(font: nunitoRegular))
                            ])),
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('ЖИК', style: TextStyle(font: nunitoBold)),
                              Text(invoice.bankAccount.iban!,
                                  style: TextStyle(font: nunitoBold))
                            ])),
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Бек', style: TextStyle(font: nunitoBold)),
                              Text('${invoice.company.kbe}',
                                  style: TextStyle(font: nunitoBold))
                            ])),
                  ]),
                ]),
            Table(
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                },
                border: TableBorder.all(color: PdfColors.black),
                children: [
                  TableRow(children: [
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                            'Бенефициар банкі:\n'
                            '${invoice.bankAccount.bank!.name}\n',
                            style: TextStyle(font: nunitoRegular))),
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(children: [
                          Text('БЖК', style: TextStyle(font: nunitoBold)),
                          Text('${invoice.bankAccount.bank!.swift}',
                              style: TextStyle(font: nunitoBold)),
                        ])),
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(children: [
                          Text('Төлемді тағайындау коды',
                              style: TextStyle(font: nunitoBold)),
                        ])),
                  ])
                ]),
            SizedBox(height: 35.0),
            Text("Төлем шоты № ${invoice.number} ${created}",
                style: TextStyle(font: nunitoBold, fontSize: 20.0)),
            Divider(),
            Table(columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(3),
            }, children: [
              TableRow(children: [
                Text("Жеткізуші:", style: TextStyle(font: nunitoRegular)),
                Text(
                    "${invoice.company.name}, ${invoice.company.address}",
                    style: TextStyle(font: nunitoBold))
              ]),
              TableRow(children: [
                Container(height: 20.0, child: Text("")),
                Container(child: Text("")),
              ]),
              TableRow(children: [
                Text("Сатып алушы:", style: TextStyle(font: nunitoRegular)),
                Text(
                    "ЖСН:${invoice.client.bin}, ${invoice.client.name}, ${invoice.client.address}",
                    style: TextStyle(font: nunitoBold))
              ]),
              TableRow(children: [
                Container(height: 20.0, child: Text("")),
                Container(child: Text("")),
              ]),
              TableRow(children: [
                Text("Келісім-шарт:", style: TextStyle(font: nunitoRegular)),
                Text(invoice.contract.name!, style: TextStyle(font: nunitoBold))
              ]),
            ]),
          ],
        ),
        SizedBox(height: 5.0),
        Table.fromTextArray(
            headers: headers,
            data: invoices_data,
            border: TableBorder.all(color: PdfColors.black),
            headerStyle:
                TextStyle(fontWeight: FontWeight.bold, font: nunitoBold),
            headerAlignment: Alignment.center,
            //headerDecoration: BoxDecoration(color: PdfColors.grey300),
            cellHeight: 30,
            cellAlignments: {
              0: Alignment.center,
              1: Alignment.centerLeft,
              2: Alignment.center,
              3: Alignment.centerRight,
              4: Alignment.centerRight,
              5: Alignment.centerRight,
              6: Alignment.centerRight,
            },
            cellStyle: TextStyle(font: nunitoRegular),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(2),
              5: FlexColumnWidth(2),
            }),
        SizedBox(height: 5.0),
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
                      title: 'Жиыны:',
                      titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          font: nunitoBold),
                      value: "${invoice.total}",
                      unite: true,
                    ),
                    buildText(
                      title: 'ҚҚ-сыз',
                      titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          font: nunitoBold),
                      value: "-",
                      unite: true,
                    ),
                    SizedBox(height: 2 * PdfPageFormat.mm),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text("Барлығы ${invoice.products.length} атау, ${invoice.total} KZT сомасында",
        style: TextStyle(font: nunitoRegular)),
        Text("Барлық төлем сомасы: ${invoice.total}",
            style: TextStyle(font: nunitoBold)),
        Divider(),
        Text("Орындаушы _______________________/ ___________________ /", style: TextStyle(font: nunitoRegular)),
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
                  Text("" //invoice.paymentInstructions,
                      ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child:
                      Container() /*Image(
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

  static buildText(
      {required String title,
      required String value,
      double width = double.infinity,
      TextStyle? titleStyle,
      bool unite = false,
      Font? font}) {
    final style =
        titleStyle ?? TextStyle(fontWeight: FontWeight.bold, font: font);

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
