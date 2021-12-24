import 'dart:io';
import 'dart:async';
import 'dart:convert';

void main() async {

final todofuken = [
  {
    "code": 1,
    "ja": "北海道",
    "en": "Hokkaido"
  },
  {
    "code": 2,
    "ja": "青森県",
    "en": "Aomori"
  },
  {
    "code": 3,
    "ja": "岩手県",
    "en": "Iwate"
  },
  {
    "code": 4,
    "ja": "宮城県",
    "en": "Miyagi"
  },
  {
    "code": 5,
    "ja": "秋田県",
    "en": "Akita"
  },
  {
    "code": 6,
    "ja": "山形県",
    "en": "Yamagata"
  },
  {
    "code": 7,
    "ja": "福島県",
    "en": "Fukushima"
  },
  {
    "code": 8,
    "ja": "茨城県",
    "en": "Ibaraki"
  },
  {
    "code": 9,
    "ja": "栃木県",
    "en": "Tochigi"
  },
  {
    "code": 10,
    "ja": "群馬県",
    "en": "Gunma"
  },
  {
    "code": 11,
    "ja": "埼玉県",
    "en": "Saitama"
  },
  {
    "code": 12,
    "ja": "千葉県",
    "en": "Chiba"
  },
  {
    "code": 13,
    "ja": "東京都",
    "en": "Tokyo"
  },
  {
    "code": 14,
    "ja": "神奈川県",
    "en": "Kanagawa"
  },
  {
    "code": 15,
    "ja": "新潟県",
    "en": "Niigata"
  },
  {
    "code": 16,
    "ja": "富山県",
    "en": "Toyama"
  },
  {
    "code": 17,
    "ja": "石川県",
    "en": "Ishikawa"
  },
  {
    "code": 18,
    "ja": "福井県",
    "en": "Fukui"
  },
  {
    "code": 19,
    "ja": "山梨県",
    "en": "Yamanashi"
  },
  {
    "code": 20,
    "ja": "長野県",
    "en": "Nagano"
  },
  {
    "code": 21,
    "ja": "岐阜県",
    "en": "Gifu"
  },
  {
    "code": 22,
    "ja": "静岡県",
    "en": "Shizuoka"
  },
  {
    "code": 23,
    "ja": "愛知県",
    "en": "Aichi"
  },
  {
    "code": 24,
    "ja": "三重県",
    "en": "Mie"
  },
  {
    "code": 25,
    "ja": "滋賀県",
    "en": "Shiga"
  },
  {
    "code": 26,
    "ja": "京都府",
    "en": "Kyoto"
  },
  {
    "code": 27,
    "ja": "大阪府",
    "en": "Osaka"
  },
  {
    "code": 28,
    "ja": "兵庫県",
    "en": "Hyogo"
  },
  {
    "code": 29,
    "ja": "奈良県",
    "en": "Nara"
  },
  {
    "code": 30,
    "ja": "和歌山県",
    "en": "Wakayama"
  },
  {
    "code": 31,
    "ja": "鳥取県",
    "en": "Tottori"
  },
  {
    "code": 32,
    "ja": "島根県",
    "en": "Shimane"
  },
  {
    "code": 33,
    "ja": "岡山県",
    "en": "Okayama"
  },
  {
    "code": 34,
    "ja": "広島県",
    "en": "Hiroshima"
  },
  {
    "code": 35,
    "ja": "山口県",
    "en": "Yamaguchi"
  },
  {
    "code": 36,
    "ja": "徳島県",
    "en": "Tokushima"
  },
  {
    "code": 37,
    "ja": "香川県",
    "en": "Kagawa"
  },
  {
    "code": 38,
    "ja": "愛媛県",
    "en": "Ehime"
  },
  {
    "code": 39,
    "ja": "高知県",
    "en": "Kochi"
  },
  {
    "code": 40,
    "ja": "福岡県",
    "en": "Fukuoka"
  },
  {
    "code": 41,
    "ja": "佐賀県",
    "en": "Saga"
  },
  {
    "code": 42,
    "ja": "長崎県",
    "en": "Nagasaki"
  },
  {
    "code": 43,
    "ja": "熊本県",
    "en": "Kumamoto"
  },
  {
    "code": 44,
    "ja": "大分県",
    "en": "Oita"
  },
  {
    "code": 45,
    "ja": "宮崎県",
    "en": "Miyazaki"
  },
  {
    "code": 46,
    "ja": "鹿児島県",
    "en": "Kagoshima"
  },
  {
    "code": 47,
    "ja": "沖縄県",
    "en": "Okinawa"
  }
];

for (var i=1;i <= todofuken.length; i++){
  if(i == 1){
    for(var j=1; j <= 3; j++){
      final path = '0$i-$j.csv';
      // print(path);
      final outputPath = '${todofuken[i-1]['en']}_${j}_latlng.dart';
      final Set<String> nijiCode = await openFile(path: path);

      final latAndLngList = caluculateLatAntLng(nijiCode);

      writeFile(outputPath: outputPath, latAndLngList: latAndLngList);
    }
  }
  else {
    // print(i);
    final num = i.toString().padLeft(2,'0');
    final path = '$num.csv';
    final outputPath = '${todofuken[i-1]['en']}_latlng.dart';
    final Set<String> nijiCode = await openFile(path: path);

    final latAndLngList = caluculateLatAntLng(nijiCode);

    writeFile(outputPath: outputPath, latAndLngList: latAndLngList);

  }
}

}

Future<Set<String>> openFile({required String path}) async {
  Set<String> nijiCode = {};
  final File file = new File(path); // open-fileName
  Stream fread = file.openRead().transform(utf8.decoder).transform(new LineSplitter());
  
  Set<String> meshCode = {};
  var i=0;
  await for (var line in fread) {
    // print(i);
    if(i == 0){
    } else {
      List rows = line.split(',');
      if(rows.length != 0) {
        final m1 = rows[2];
      if(m1.length == 8){
        final m2 = m1.substring(0,6);
            nijiCode.add(m2);
      }
      } 

      
    }
      i++;
    }
    // print(nijiCode);
  return nijiCode;
}

List<Map<String,double>> caluculateLatAntLng(Set<String> nijiCode) {
  List<Map<String,double>> latAndLngList = [];

  for (var niji in nijiCode){

    final double lat = (double.parse(niji.substring(0,2))/ 1.5 * 3600 +
              double.parse(niji.substring(4,5)) * 5 * 60)/3600;
    final double lang = ((int.parse(niji.substring(2,4))+ 100)* 3600+int.parse(niji.substring(5,6))* 7.5 * 60)/3600;
    Map<String,double> latlang = {"lng":lang,"lat":lat,};
    // print(niji);
    latAndLngList.add(latlang);
    // print(latAndLngList);
  }

  return latAndLngList;
}

void writeFile({
  required String outputPath,
  required List<Map<String,double>> latAndLngList,
}) {
  final File file = File(outputPath);
  var sink = file.openWrite();

  try {
    sink.write(latAndLngList);
    print('---complete!');
  } catch (e) {
    print('-----------error : $e');
  }

  sink.close();
}
