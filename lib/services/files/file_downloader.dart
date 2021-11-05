import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  static Future<void> openFileFromUrl({
    required String url,
    String filename = '',
    bool getFilenameFromHeader = false,
    String? bearer,
  }) async {
    final file = await getFileFromUrl(
        url: url,
        filename: filename,
        getFilenameFromHeader: getFilenameFromHeader,
        bearer: bearer);

    if (file == null) {
      throw FileDownloaderException("Napaka pri pridobivanju datoteke");
    } else {
      OpenFile.open(file.path);
    }
  }

  static Future<File?> getFileFromUrl({
    required String url,
    String filename = '',
    bool getFilenameFromHeader = false,
    String? bearer,
  }) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
            headers: {"Authorization": bearer}),
      );

      if (getFilenameFromHeader) {
        final contentDispositionHeader =
            response.headers.value("Content-Disposition");
        if (contentDispositionHeader == null) {
          throw FileDownloaderException(
              "Napaka pri pridobivanju imena datoteke");
        } else {
          filename =
              contentDispositionHeader.split("filename=\"")[1].split("\";")[0];
        }
      }

      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$filename');

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}

class FileDownloaderException implements Exception {
  String message;

  FileDownloaderException(this.message);
}
