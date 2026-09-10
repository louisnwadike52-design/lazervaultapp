import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

/// Rasterise page 1 of a generated receipt PDF to a PNG/JPG file.
///
/// Every receipt in the app offers the same PDF / JPG / PNG choice, and the
/// image formats are produced from the SAME PDF layout so all three are a
/// pixel-faithful copy of one document. This lives in core because that
/// promise is shared: tag_pay, send-funds and autosave all route through it,
/// and the two corrections captured below were expensive enough to earn
/// exactly one implementation.
///
/// [ext] is 'jpg' or 'png' — anything else encodes as PNG.
Future<File> rasterizePdfPage({
  required File pdfFile,
  required String baseName,
  required String ext,
  // 200 dpi = crisp on-screen + printable without a huge file.
  double dpi = 200,
}) async {
  final pdfBytes = await pdfFile.readAsBytes();
  final raster = await Printing.raster(pdfBytes, pages: [0], dpi: dpi).first;

  // Decode the raster ONCE, correctly, for both image formats.
  //
  // Two things were wrong here originally and both produced visibly broken
  // files:
  //
  // 1. `raster.pixels.buffer` throws away the view's offset. A Uint8List is a
  //    WINDOW onto a ByteBuffer, and .buffer hands back the whole underlying
  //    buffer ignoring offsetInBytes/lengthInBytes. Whenever that window did
  //    not start at byte 0 the image decoded from the wrong origin, which is
  //    why the exported picture came out skewed/garbled.
  //
  // 2. A rasterised PDF page carries an ALPHA channel, and the receipt card
  //    sits on transparent pixels. JPG has no alpha, so encoding dropped it
  //    and those pixels rendered BLACK; PNG kept them transparent, which
  //    viewers show as black or a checkerboard. Both formats are composited
  //    onto opaque white first, so what is saved is what is seen.
  //
  // Copy into a fresh list so the ByteBuffer handed to the decoder starts at
  // byte 0. Taking .buffer off a view would re-introduce the very offset this
  // is correcting, since .buffer always returns the whole underlying buffer.
  final rgba = Uint8List.fromList(raster.pixels);
  final decoded = img.Image.fromBytes(
    width: raster.width,
    height: raster.height,
    bytes: rgba.buffer,
    numChannels: 4,
    order: img.ChannelOrder.rgba,
  );
  final flattened = img.Image(width: raster.width, height: raster.height)
    ..clear(img.ColorRgb8(255, 255, 255));
  img.compositeImage(flattened, decoded);

  final Uint8List bytes = ext == 'jpg'
      ? img.encodeJpg(flattened, quality: 92)
      : img.encodePng(flattened);
  final out = await getTemporaryDirectory();
  final file = File('${out.path}/$baseName.$ext');
  await file.writeAsBytes(bytes);
  return file;
}
