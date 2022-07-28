import 'dart:io';
import 'package:digirental_shop_app/Infrastructure/Helpers/save_file-mobile.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digirental_shop_app/configurations/Utils/Colors.dart';
import 'package:digirental_shop_app/presentation/Widgets/appbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SmartContract extends StatefulWidget {
  String orderID;
  String buyerName;
  String buyeremail;
  String buyerimage;

  String SellerName;
  String SellerEmail;
  String sellerImage;

  String productName;
  String productAmount;
  String productQuanity;
  String ProductImage;
  String totalAmount;

  SmartContract(
      {required this.orderID,
      required this.buyerName,
      required this.buyeremail,
      required this.buyerimage,
      required this.SellerName,
      required this.SellerEmail,
      required this.sellerImage,
      required this.productName,
      required this.productAmount,
      required this.productQuanity,
      required this.ProductImage,
      required this.totalAmount});

  @override
  State<SmartContract> createState() => _SmartContractState();
}

class _SmartContractState extends State<SmartContract> {
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Text("Smart Order Contract Details",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                Text("",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Buyer Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
                height: 65,
                width: 65,
                imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: widget.buyerimage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SpinKitWave(
                        color: MyAppColors.appColor,
                        size: 30,
                        type: SpinKitWaveType.start),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Buyer Name",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.buyerName,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Buyer Email",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.buyeremail,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Seller Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
                height: 65,
                width: 65,
                imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: widget.sellerImage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SpinKitWave(
                        color: MyAppColors.appColor,
                        size: 30,
                        type: SpinKitWaveType.start),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Seller Name",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.SellerName,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Seller Email",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.SellerEmail,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Product Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            CachedNetworkImage(
                height: 65,
                width: 65,
                imageBuilder: (context, imageProvider) => Container(
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: widget.ProductImage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SpinKitWave(
                        color: MyAppColors.appColor,
                        size: 30,
                        type: SpinKitWaveType.start),
                errorWidget: (context, url, error) => Icon(Icons.error)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Name",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.productName,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Price",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.productAmount,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Quantity",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.productQuanity,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Order Information",
                    style: GoogleFonts.roboto(
                        // fontFamily: 'Gilroy',
                        color: MyAppColors.appColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Order Amount",
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                  Text(widget.totalAmount,
                      style: GoogleFonts.roboto(
                          // fontFamily: 'Gilroy',
                          color: MyAppColors.blackcolor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            AppButton(
              //onTap: _generatePDF,
              onTap: (){
                // final pdf = pw.Document();
                //
                //
                // pdf.addPage(pw.Page(
                //     pageFormat: PdfPageFormat.a4,
                //     build: (pw.Context context) {
                //       return pw.Center(
                //         child: pw.Text("Hello World"),
                //       ); // Center
                //     }));
                // pdf.save();

                // P

              },
               // onTap: () async {
                 // _generatePDF,
                  // Create a new PDF document.
//                   final PdfDocument document = PdfDocument();
// // Add a PDF page and draw text.
//                   document.pages.add().graphics.drawString('Hello World!',
//                       PdfStandardFont(PdfFontFamily.helvetica, 12),
//                       brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//                       bounds: const Rect.fromLTWH(0, 0, 150, 20));
// // Save the document.
//                   File('HelloWorld.pdf').writeAsBytes(await document.save());
// // Dispose the document.
//                   document.dispose();
             //   },
                text: "Save Contract as PDF"),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _generatePDF() async {
  //   //Create a PDF document.
  //   final PdfDocument document = PdfDocument();
  //   //Add page to the PDF
  //   final PdfPage page = document.pages.add();
  //   //Get page client size
  //   final Size pageSize = page.getClientSize();
  //   //Draw rectangle
  //   page.graphics.drawRectangle(
  //       bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
  //       pen: PdfPen(PdfColor(142, 170, 219)));
  //   //Generate PDF grid.
  //   final PdfGrid grid = _getGrid();
  //   //Draw the header section by creating text element
  //   final PdfLayoutResult result = _drawHeader(page, pageSize, grid);
  //   //Draw grid
  //   _drawGrid(page, grid, result);
  //   //Add invoice footer
  //   _drawFooter(page, pageSize);
  //   //Save and dispose the document.
  //   final List<int> bytes = await document.save();
  //   document.dispose();
  //   //Launch file.
  //   await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice.pdf');
  // }
  //
  // //Draws the invoice header
  // PdfLayoutResult _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
  //   //Draw rectangle
  //   page.graphics.drawRectangle(
  //       brush: PdfSolidBrush(PdfColor(91, 126, 215)),
  //       bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
  //   //Draw string
  //   page.graphics.drawString(
  //       'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
  //       brush: PdfBrushes.white,
  //       bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
  //       format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
  //   page.graphics.drawRectangle(
  //       bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
  //       brush: PdfSolidBrush(PdfColor(65, 104, 205)));
  //   page.graphics.drawString(r'$' + _getTotalAmount(grid).toString(),
  //       PdfStandardFont(PdfFontFamily.helvetica, 18),
  //       bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
  //       brush: PdfBrushes.white,
  //       format: PdfStringFormat(
  //           alignment: PdfTextAlignment.center,
  //           lineAlignment: PdfVerticalAlignment.middle));
  //   final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  //   //Draw string
  //   page.graphics.drawString('Amount', contentFont,
  //       brush: PdfBrushes.white,
  //       bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
  //       format: PdfStringFormat(
  //           alignment: PdfTextAlignment.center,
  //           lineAlignment: PdfVerticalAlignment.bottom));
  //   //Create data foramt and convert it to text.
  //   final DateFormat format = DateFormat.yMMMMd('en_US');
  //   final String invoiceNumber = 'Invoice Number: 2058557939\r\n\r\nDate: ' +
  //       format.format(DateTime.now());
  //   final Size contentSize = contentFont.measureString(invoiceNumber);
  //   const String address =
  //       'Bill To: \r\n\r\nAbraham Swearegin, \r\n\r\nUnited States, California, San Mateo, \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136';
  //   PdfTextElement(text: invoiceNumber, font: contentFont).draw(
  //       page: page,
  //       bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
  //           contentSize.width + 30, pageSize.height - 120));
  //   return PdfTextElement(text: address, font: contentFont).draw(
  //       page: page,
  //       bounds: Rect.fromLTWH(30, 120,
  //           pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  // }
  //
  // //Draws the grid
  // void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  //   Rect? totalPriceCellBounds;
  //   Rect? quantityCellBounds;
  //   //Invoke the beginCellLayout event.
  //   grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
  //     final PdfGrid grid = sender as PdfGrid;
  //     if (args.cellIndex == grid.columns.count - 1) {
  //       totalPriceCellBounds = args.bounds;
  //     } else if (args.cellIndex == grid.columns.count - 2) {
  //       quantityCellBounds = args.bounds;
  //     }
  //   };
  //   //Draw the PDF grid and get the result.
  //   result = grid.draw(
  //       page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
  //   //Draw grand total.
  //   page.graphics.drawString('Grand Total',
  //       PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
  //       bounds: Rect.fromLTWH(
  //           quantityCellBounds!.left,
  //           result.bounds.bottom + 10,
  //           quantityCellBounds!.width,
  //           quantityCellBounds!.height));
  //   page.graphics.drawString(_getTotalAmount(grid).toString(),
  //       PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
  //       bounds: Rect.fromLTWH(
  //           totalPriceCellBounds!.left,
  //           result.bounds.bottom + 10,
  //           totalPriceCellBounds!.width,
  //           totalPriceCellBounds!.height));
  // }
  //
  // //Draw the invoice footer data.
  // void _drawFooter(PdfPage page, Size pageSize) {
  //   final PdfPen linePen =
  //   PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
  //   linePen.dashPattern = <double>[3, 3];
  //   //Draw line
  //   page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
  //       Offset(pageSize.width, pageSize.height - 100));
  //   const String footerContent =
  //       '800 Interchange Blvd.\r\n\r\nSuite 2501, Austin, TX 78721\r\n\r\nAny Questions? support@adventure-works.com';
  //   //Added 30 as a margin for the layout
  //   page.graphics.drawString(
  //       footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
  //       format: PdfStringFormat(alignment: PdfTextAlignment.right),
  //       bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  // }
  //
  // //Create PDF grid and return
  // PdfGrid _getGrid() {
  //   //Create a PDF grid
  //   final PdfGrid grid = PdfGrid();
  //   //Secify the columns count to the grid.
  //   grid.columns.add(count: 5);
  //   //Create the header row of the grid.
  //   final PdfGridRow headerRow = grid.headers.add(1)[0];
  //   //Set style
  //   headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  //   headerRow.style.textBrush = PdfBrushes.white;
  //   headerRow.cells[0].value = 'Product Id';
  //   headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  //   headerRow.cells[1].value = 'Product Name';
  //   headerRow.cells[2].value = 'Price';
  //   headerRow.cells[3].value = 'Quantity';
  //   headerRow.cells[4].value = 'Total';
  //   _addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
  //   _addProducts(
  //       'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
  //   _addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
  //   _addProducts(
  //       'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
  //   _addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
  //   _addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
  //   grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  //   grid.columns[1].width = 200;
  //   for (int i = 0; i < headerRow.cells.count; i++) {
  //     headerRow.cells[i].style.cellPadding =
  //         PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  //   }
  //   for (int i = 0; i < grid.rows.count; i++) {
  //     final PdfGridRow row = grid.rows[i];
  //     for (int j = 0; j < row.cells.count; j++) {
  //       final PdfGridCell cell = row.cells[j];
  //       if (j == 0) {
  //         cell.stringFormat.alignment = PdfTextAlignment.center;
  //       }
  //       cell.style.cellPadding =
  //           PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  //     }
  //   }
  //   return grid;
  // }
  //
  // //Create and row for the grid.
  // void _addProducts(String productId, String productName, double price,
  //     int quantity, double total, PdfGrid grid) {
  //   final PdfGridRow row = grid.rows.add();
  //   row.cells[0].value = productId;
  //   row.cells[1].value = productName;
  //   row.cells[2].value = price.toString();
  //   row.cells[3].value = quantity.toString();
  //   row.cells[4].value = total.toString();
  // }
  //
  // //Get the total amount.
  // double _getTotalAmount(PdfGrid grid) {
  //   double total = 0;
  //   for (int i = 0; i < grid.rows.count; i++) {
  //     final String value =
  //     grid.rows[i].cells[grid.columns.count - 1].value as String;
  //     total += double.parse(value);
  //   }
  //   return total;
  // }
}
