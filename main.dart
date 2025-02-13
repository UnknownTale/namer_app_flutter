// Memasukkann package yang dibutuhkan aplikasi
import 'package:english_words/english_words.dart'; //Paket Bahasa inggris
import 'package:flutter/material.dart'; //Paket tampilan UI (material ui)
import 'package:provider/provider.dart'; //Paket interaksi aplikasi

void main() {
  runApp(MyApp());
}

//Membuat abstrak aplikasi dari StatelessWidget( template aplikasi) aplikasinya bernama myApp
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key}); //Menunjukkan bahwa aplikasi ini akan tetap, tidak berubah setelah di-build

  @override //Mengganti nilai lama yang sudah ada di template, dengan nilai nilai yang baru
  Widget build(BuildContext context) {
    //Fungsi build adalah fungsi yang membangun UI (Mengatur posisi widget, dst)
    //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi yang terjadi di aplikasi
    return ChangeNotifierProvider(
      create: (context) =>
          MyAppState(), //Membuat suatu state bernama MyAppState
      child: MaterialApp(
        //Pada state ini, menggunakan style desain MaterialUI
        title: 'Namer App', //Diberi judul Namer App
        theme: ThemeData(
          //Data tema aplikasi, diberi warna DeepOrange
          useMaterial3: true, //Versi MaterialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home:
            MyHomePage(), //Nama Halaman "MyHomePage" yang menggunakan state "MyAppState"
      ),
    );
  }
}

//Mendefisikan isi MyAppSite
class MyAppState extends ChangeNotifier {
  //State MyAppSate diisi dengan 2 kata random yang di gabung. Kata random tersebut disimpan di variable WordPair
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

//Membuat layout dalam halaman MyHomePage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState =
        context.watch<MyAppState>(); //Widget menggunakan state MyAppState
    //Di bawah ini adalah kode program untuk menyusun layout
    var pair = appState
        .current; //Variabel pair menyimpan kata yang sedang tampil/aktif

    return Scaffold(//Base (canvas) dari layout
      body: Center(
        child: Column(//Di atas Scaffold, ada body. Bodynya diberi kolom
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Di dalam kolom, diberi teks
            BigCard(pair: pair),
            SizedBox(height: 10), //Mengambil nilai dari variabel pair, Lalu diubah menjadi huruf kecil semua dan ditampilkan sebagai BigCard
            ElevatedButton(
              //Membuat button timbul di dalam body
              onPressed: () {//Fungsi yang dieksekusi ketika button ditekan
                appState.getNext(); //Tampilkan teks "button pressed!" diterminal saat button di tekan
              },
              child:
                  Text('Next'), //Berikan teks "Next" pada button (sebagai child)
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card( //membungkus padding di dalam widget Card
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style, semanticsLabel: "${pair.first} ${pair.second}",), //membuat kata menjadi huruf kecil
      ),
    );
  }
}
