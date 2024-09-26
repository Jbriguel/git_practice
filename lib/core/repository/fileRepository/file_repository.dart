import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart'; // Importez ce package pour utiliser basename
import 'package:path_provider/path_provider.dart';

@singleton
class FileRepository {
  String mainFolder = "tela";

  FileRepository() {
    initAppFiles();
  }

  Future<void> initAppFiles() async {
    Directory(
            '${(await getApplicationDocumentsDirectory()).path}/$mainFolder/Sqlite_Backup')
        .create(recursive: true);
    Directory(
            '${(await getApplicationDocumentsDirectory()).path}/$mainFolder/modeles')
        .create(recursive: true);
    Directory(
            '${(await getApplicationDocumentsDirectory()).path}/$mainFolder/habits')
        .create(recursive: true);
    Directory(
            '${(await getApplicationDocumentsDirectory()).path}/$mainFolder/clients')
        .create(recursive: true);
  }

  Future<File?> getLocalImageFile(String imageUrl, String folderName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String fileName =
        basename(imageUrl); // Utilisez basename pour obtenir le nom du fichier
    final File localImageFile =
        File('${directory.path}/$mainFolder/$folderName/$fileName');

    if (imageUrl.startsWith('http')) {
      // Si l'image est une URL, vérifiez si le fichier existe déjà localement
      if (await localImageFile.exists()) {
        return localImageFile;
      } else {
        // L'URL ne doit pas être utilisée comme fichier local
        // Vous pouvez gérer le cas où vous devez télécharger l'image si nécessaire
        return File(imageUrl);
      }
    } else {
      // Sinon, copiez le fichier à partir de la source
      final File sourceFile = File(imageUrl);
      if (await sourceFile.exists()) {
        if (!await localImageFile.exists()) {
          await sourceFile.copy(localImageFile.path);
        }
        return localImageFile;
      } else {
        // throw FileSystemException('File does not exist', imageUrl);
        return null;
      }
    }
  }
}
