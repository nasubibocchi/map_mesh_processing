import 'dart:io';
import 'dart:async';
import 'dart:convert';

void main() {
  final path =
      '';
  final outputPath =
      '';

  final List<String> nijiCode = openFile(path: path);

  final latAndLngList = caluculateLatAntLng(nijiCode);

  writeFile(outputPath: outputPath, latAndLngList: latAndLngList);
}

List<String> openFile({required String path}) {
  List<String> nijiCode = [];
  final File file = new File(path); // open-fileName
  Stream fread = file.openRead();
  List<String> meshCode = [];

  fread.transform(utf8.decoder).transform(new LineSplitter()).listen((String line) {
    List rows = line.split(',');
    for (int i = 1; i < rows.length; i ++) {
      meshCode.add(rows[i][2]);
    }
  });

  nijiCode = meshCode.map((e) => e.substring(0, 6)).toList();
  return nijiCode;
}

List<List<double>> caluculateLatAntLng(List<String> nijiCode) {
  List<List<double>> latAndLngList = [];

  final latitudeList = nijiCode
      .map((e) =>
          (double.parse(e.substring(0, 2)) / 1.5 * 3600 +
              double.parse(e.substring(5)) * 5 * 60) /
          3600)
      .toList();

  final longitudeList = nijiCode
      .map((e) =>
          ((double.parse(e.substring(3, 4)) + 100) * 3600 +
              (double.parse(e.substring(6)) * 7.5 * 60)) /
          3600)
      .toList();

  print(latitudeList[0]); // debug
  print(longitudeList[0]); //debug

  latAndLngList = [latitudeList, longitudeList];

  return latAndLngList;
}

void writeFile({
  required String outputPath,
  required List<List<double>> latAndLngList,
}) {
  final File file = File(outputPath);
  var sink = file.openWrite();
  List<Map<String, double>> latAndLngMapJsonList = [];

  for (int i = 0; i < latAndLngList.length; i++) {
    latAndLngMapJsonList.add({
      'lat': latAndLngList[0][i],
      'lng': latAndLngList[1][i],
    });
  }
  try {
    sink.write(latAndLngMapJsonList);
    print('---complete!');
  } catch (e) {
    print('-----------error : $e');
  }
  
  sink.close();
}
