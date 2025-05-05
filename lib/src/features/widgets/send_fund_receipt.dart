
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/core/utilities/generate_currency_string.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/flat_tile.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SendFundReceipt extends StatefulWidget {
  final Transaction transaction;

  const SendFundReceipt({super.key, required this.transaction});

  @override
  State<SendFundReceipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<SendFundReceipt> {
  late final List<FlatTile> transactionTiles;

  @override
  void initState() {
    super.initState();
    transactionTiles = [
      FlatTile(
        name: TransactionAttribute.name.displayName,
        value: "${widget.transaction.user!.firstName} ${widget.transaction.user!.lastName}".trim(),
      ),
      FlatTile(
        name: TransactionAttribute.amount.displayName,
        value: generateCurrencyString(amount: widget.transaction.amount),
      ),
      FlatTile(
        name: TransactionAttribute.accountNo.displayName,
        value: "34565454456765",
      ),
      FlatTile(
        name: TransactionAttribute.email.displayName,
        value: 'louisnwadike560@gmail.com',
      ),
      FlatTile(
        name: TransactionAttribute.dateTime.displayName,
        value: "22/01/2025",
      ),
      FlatTile(
        name: TransactionAttribute.category.displayName,
        value: "Salary",
      ),
      FlatTile(
        name: TransactionAttribute.notes.displayName,
        value: "Your Monthly Salary",
      ),
      FlatTile(
        name: TransactionAttribute.status.displayName,
        value: TransactionStatus.completed.displayName,
      ),
    ];
  }

  Future<void> _printReceipt() async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        final pdf = pw.Document();

        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Center(
                    child: pw.Container(
                      width: 100,
                      height: 100,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        color: PdfColors.grey300,
                      ),
                      child: pw.Center(child: pw.Text(
                        (widget.transaction.user!.firstName.isNotEmpty ? widget.transaction.user!.firstName[0] : '') + 
                        (widget.transaction.user!.lastName.isNotEmpty ? widget.transaction.user!.lastName[0] : ''),
                         style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)
                      )),
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  ...transactionTiles.map(
                    (tile) => pw.Padding(
                       padding: const pw.EdgeInsets.symmetric(vertical: 4),
                       child: pw.Text("${tile.name}: ${tile.value}", style: const pw.TextStyle(fontSize: 12))
                    ),
                  ),
                ],
              );
            },
          ),
        );

        return pdf.save();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20.0.h,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.grey[300],
            child: Text(
               (widget.transaction.user!.firstName.isNotEmpty ? widget.transaction.user!.firstName[0] : '') +
               (widget.transaction.user!.lastName.isNotEmpty ? widget.transaction.user!.lastName[0] : ''),
               style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            )
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 32.0.h),
            height: responsiveController.screenHeight * 0.5,
            child: ListView.builder(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.symmetric(vertical: 16.0.h),
              itemCount: transactionTiles.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  transactionTiles[index],
                  SizedBox(height: 20.0.h)
                ]);
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: _printReceipt,
            child: Text(
              "Download Receipt",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
