import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'pdf_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF viewer',
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: const PdfCreatorPage(),
    );
  }
}

class PdfCreatorPage extends StatefulWidget {
  const PdfCreatorPage({super.key});

  @override
  State<PdfCreatorPage> createState() => _PdfCreatorPageState();
}

class _PdfCreatorPageState extends State<PdfCreatorPage> {
  bool _useDoubleColumn = true; // 두 단 레이아웃 사용 여부

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF 문서 생성기'),
        actions: [
          // 두 단 레이아웃 전환 버튼
          Switch(
            value: _useDoubleColumn,
            onChanged: (value) {
              setState(() {
                _useDoubleColumn = value;
              });
            },
          ),
          // 두 단 레이아웃 라벨
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text('두 단 레이아웃'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder<Uint8List>(
            future: PdfGenerator().generatePdf(
              headerText: '테스트 입니다.',
              headerStyle: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
              contentsText: '''
# 첫 번째 대제목
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fringilla ante sit amet aliquet blandit. Etiam a feugiat massa, tincidunt ultrices arcu. Aenean congue turpis eget ligula cursus, accumsan porttitor felis efficitur. Phasellus erat urna, rhoncus vel urna non, faucibus cursus arcu. Nunc ut venenatis eros. Integer nibh erat, accumsan nec feugiat ut, congue mollis purus. Proin venenatis, risus non auctor facilisis, elit eros dictum dolor, eu aliquet dui sapien id purus. Aliquam at elit diam. Nam varius vitae lectus eget rhoncus. Sed quis lacinia purus.

Pellentesque rutrum ornare odio id mollis. Donec et semper nunc. Cras ac consequat ipsum. Donec iaculis quam et justo viverra pharetra. Proin gravida nisl nec orci efficitur, nec fringilla dui mattis. Nunc ac neque a nisl auctor pellentesque quis a lorem. In tristique ligula vitae nisl mollis, ut ornare nisl tincidunt. Sed consequat congue nulla in euismod. Proin cursus luctus ante eu porttitor. Sed vel ligula nulla.

Aenean id magna interdum, fringilla odio eget, sodales ipsum. Nam in augue sapien. Sed vel sem eget nisl venenatis iaculis. In vulputate vulputate leo quis lacinia. In quis tempus enim, in tincidunt tortor. Aliquam euismod aliquet nulla in placerat. Nam blandit mi mi. Morbi dictum bibendum quam, sed finibus nisl suscipit efficitur. Nullam fringilla ante vel felis hendrerit, non blandit neque hendrerit. Sed molestie, leo a tempus mattis, arcu enim sodales libero, non ornare elit dui ac erat.

Vestibulum in lectus nunc. Sed egestas, justo sed mattis scelerisque, erat sem molestie urna, vel bibendum est tellus et dui. Sed eu eleifend arcu. Sed faucibus scelerisque velit a pharetra. Duis nunc purus, sagittis nec egestas et, eleifend nec purus. Maecenas ultricies magna nulla, quis iaculis ipsum faucibus sit amet. Nam posuere interdum hendrerit. Donec ac imperdiet ipsum, sed tristique ligula. Ut lacinia velit orci, ac convallis dolor sollicitudin a. Curabitur eu nulla varius, venenatis purus accumsan, convallis nunc. Ut bibendum sem ut metus malesuada tincidunt. Sed pharetra pharetra purus, ac venenatis lacus tempor ut. Suspendisse mi sem, tempus a quam vitae, commodo euismod elit.

In lacinia nunc a augue vehicula aliquam. Vivamus auctor lectus mauris, eu volutpat nibh pulvinar et. In sit amet elementum lectus. Sed ornare dolor non iaculis varius. Quisque ut ligula auctor, efficitur ex et, laoreet lectus. Nam vulputate sapien vel ex malesuada euismod. Proin erat nisl, laoreet eu nisl sit amet, sodales sollicitudin augue. Vestibulum suscipit congue luctus. Cras elit urna, pretium mollis commodo vitae, molestie sit amet velit. Proin ut ex maximus, auctor nunc a, sagittis purus. Proin feugiat rhoncus sapien, in efficitur nisi vehicula faucibus. Praesent et felis nisi.

Praesent condimentum sapien vitae quam consequat sollicitudin. Donec in fringilla est. Aenean justo elit, malesuada quis dignissim a, varius in mauris. Pellentesque commodo metus sit amet dui accumsan congue. Integer cursus congue malesuada. Ut fermentum accumsan leo. In molestie, magna cursus dapibus accumsan, odio velit sodales turpis, at malesuada odio sapien quis risus.

Nam auctor nisi elit, a suscipit enim facilisis faucibus. Donec sagittis pulvinar consectetur. Mauris quis tincidunt magna. Vestibulum blandit tortor a leo dictum sollicitudin. Proin suscipit orci ac massa luctus interdum. Morbi dignissim vitae lorem id pretium. Ut sed faucibus est. Maecenas vehicula leo lectus, sit amet vulputate nisi facilisis sit amet. Nulla aliquet sit amet diam volutpat efficitur. Maecenas nec mauris eget mi ultrices ullamcorper. Pellentesque condimentum est et vulputate eleifend. Duis aliquet purus ipsum, non sagittis ipsum eleifend nec. Integer commodo, lacus ac faucibus ultricies, ligula felis venenatis mauris, sed fringilla nulla enim non eros. Pellentesque in sollicitudin sapien.

Fusce sed massa volutpat, sodales sem sit amet, accumsan lacus. Etiam in ipsum congue, dignissim augue sed, venenatis sem. Morbi aliquam quam vel mauris hendrerit, vitae auctor arcu euismod. Integer auctor tortor vel rutrum rhoncus. Morbi nec augue tincidunt, auctor quam ut, pretium dolor. Aliquam erat volutpat. Nam vel mauris eget lorem luctus pharetra at ac ante. Aenean nibh est, placerat aliquam sapien eu, vestibulum vehicula justo. Mauris dignissim malesuada egestas. Phasellus in volutpat urna, a eleifend ante. Etiam ut ligula id dolor rhoncus sollicitudin eu a velit. Fusce porttitor nisi et vestibulum viverra. Proin ac tellus vestibulum, placerat lorem quis, tincidunt justo. Nullam ut purus sed massa dignissim tempor sed non magna. Proin tincidunt enim at ornare pulvinar.

Vestibulum porta purus vitae lorem lacinia, luctus tristique nisl interdum. Proin in sem id est feugiat viverra. Fusce convallis diam sit amet accumsan accumsan. Mauris ac nibh a eros vestibulum fringilla id blandit magna. Phasellus eget facilisis libero, eget tempor dolor. Vestibulum lacus leo, vulputate in venenatis eget, tempus vitae arcu. Pellentesque porta tristique luctus. Nulla condimentum semper ornare. Nam vitae eros nisi.

Curabitur sed tempus orci. Nunc eros velit, varius sed felis non, sodales pellentesque arcu. Vestibulum id fermentum lectus, laoreet pellentesque neque. Donec turpis magna, venenatis id velit in, facilisis molestie orci. Donec massa sem, varius at lorem at, commodo aliquet nulla. Quisque et luctus nunc, sed venenatis justo. Mauris vitae augue id dui facilisis scelerisque.

Etiam ac cursus nunc. Pellentesque molestie purus quam, quis convallis augue rutrum imperdiet. Curabitur finibus non odio nec feugiat. Nunc et massa et nisi viverra molestie. Etiam dapibus consequat enim non vestibulum. Praesent at diam sed arcu finibus ornare eu a purus. Vivamus mauris sem, mattis in odio sit amet, tincidunt varius sapien. Aliquam ligula massa, convallis bibendum ultrices quis, commodo id metus. Nam fringilla turpis ex, vel gravida dui posuere ac. Cras at dictum diam. Proin ac imperdiet nisi, id dignissim erat. Donec vel bibendum tellus. Vestibulum sit amet tortor ipsum. Etiam ultricies porttitor velit vitae malesuada. Vivamus laoreet neque at fringilla consectetur. Maecenas vitae vestibulum enim, sed suscipit orci.

Ut ut urna tristique, feugiat sapien non, commodo lorem. Aliquam condimentum, nisi quis tincidunt gravida, nulla justo euismod turpis, in iaculis elit elit quis magna. Phasellus fermentum vulputate velit ac iaculis. In sed tempor lectus. Nulla facilisi. Aenean elementum, lacus nec interdum ultricies, dolor tortor iaculis odio, ac laoreet justo diam eu odio. Sed porta urna in nulla scelerisque, ornare accumsan nisi facilisis. Nullam vestibulum malesuada enim, vel ultrices urna molestie eu. Nulla sem ex, porttitor id tincidunt nec, elementum nec sem. Etiam et eros at mauris consequat vestibulum. Integer dignissim, nulla congue lobortis bibendum, purus massa laoreet lacus, non dignissim purus tellus vel dui. Aliquam accumsan erat ac hendrerit ullamcorper. Vivamus at magna at lorem feugiat finibus vitae eu massa. Nunc nec arcu ut mauris aliquet tristique. Quisque auctor elit ut nunc sagittis rhoncus. Integer euismod urna sed ipsum ornare, at aliquet mi fringilla.

In sodales purus elit, ut pretium felis interdum non. Aenean accumsan ligula sit amet quam vehicula pretium. Donec luctus tortor vitae nisl tristique blandit. Phasellus id ex porttitor, dignissim nibh vehicula, vehicula massa. Sed interdum vehicula ligula a rutrum. Cras posuere ex fermentum risus blandit porttitor. Phasellus ut commodo leo. Sed ante arcu, bibendum et pellentesque aliquam, faucibus a nisi.

Fusce id eros sagittis, pretium nisi eget, elementum nisl. Sed ullamcorper iaculis egestas. Duis metus lacus, dictum euismod urna a, placerat lacinia ex. Etiam pellentesque felis at tempor ullamcorper. In imperdiet aliquam tincidunt. Quisque vel molestie neque, a fermentum est. Cras volutpat eleifend risus, in scelerisque diam dapibus at. Curabitur lorem orci, dignissim vulputate odio quis, laoreet congue velit. Fusce et posuere lorem, a vulputate eros. Etiam porttitor nisi sed orci mattis, rhoncus consectetur justo dapibus.

Aliquam erat volutpat. Donec sit amet ipsum vitae odio ultrices luctus at eu mauris. Donec non lorem non dui laoreet finibus. Praesent tristique diam id dolor molestie pellentesque. Morbi suscipit metus vel auctor viverra. Fusce viverra sit amet ex a viverra. Sed in euismod risus.

Mauris eros lorem, euismod vitae enim vitae, euismod varius sem. Nam eu lobortis metus. Vestibulum auctor nunc libero, laoreet auctor nisi elementum a. Vivamus facilisis nibh et felis auctor venenatis. Integer consequat mollis diam. Proin vehicula tellus libero, ut fermentum metus mollis non. Praesent ut arcu tellus. Mauris vel turpis quis ipsum suscipit fermentum a id diam.

Nullam et urna nulla. Duis hendrerit a elit sed laoreet. Curabitur sit amet enim ligula. Fusce sollicitudin ultricies mi, at bibendum augue tempus non. Nam quis erat quis est lacinia egestas luctus ut nisi. Etiam vitae pellentesque augue. Nunc egestas justo erat, nec sodales est rhoncus at. Pellentesque vel mi vestibulum, tincidunt magna id, malesuada ipsum. Proin blandit viverra ipsum euismod varius. Nulla maximus ligula at quam feugiat placerat. Nulla efficitur turpis in ornare ornare. Mauris tempus maximus libero, at euismod justo suscipit ac. Pellentesque imperdiet in quam in tincidunt.

Quisque eget odio vel dolor efficitur porttitor a sed ante. Sed eros metus, feugiat ac libero tristique, convallis varius mi. Vestibulum cursus arcu a libero egestas sodales. Pellentesque at risus mauris. Mauris luctus, tellus ut tincidunt fringilla, quam turpis vulputate magna, id fringilla sem neque ac turpis. Maecenas non nulla metus. Vestibulum quis fringilla ligula. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel erat leo. Nulla sagittis vulputate convallis. Vestibulum blandit eleifend malesuada.

In nec tellus in libero mattis lacinia quis nec magna. Nulla facilisi. Vivamus semper vulputate condimentum. Nullam sit amet lacus convallis, placerat quam eget, sollicitudin tortor. Nulla tempus egestas metus. Aenean sodales nisi in orci ultrices, nec rutrum mauris lobortis. Pellentesque congue eros tortor, non maximus velit sodales ut. Nam vehicula purus dolor, at ultrices dolor ornare ac.

Cras dapibus in lectus nec porta. Vestibulum pretium faucibus ex non lobortis. Nullam vestibulum magna nec arcu convallis dapibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam malesuada felis eu porta varius. Cras laoreet condimentum luctus. Vivamus consectetur magna sit amet feugiat ultricies. In hac habitasse platea dictumst. Nulla id orci non ante cursus lacinia. Nunc quis consectetur diam. Mauris tempus maximus tempor. Etiam ut ex vestibulum nisi imperdiet imperdiet. Nullam dignissim blandit sem et accumsan. Phasellus convallis, sem at ultrices pulvinar, justo libero interdum lacus, vitae consectetur libero lacus sit amet diam. In egestas, lectus ut pellentesque venenatis, diam dolor congue libero, id vehicula quam velit id urna.

''',
              contentsStyle: pw.TextStyle(
                fontSize: 12,
              ),
              pageFormat: PdfPageFormat.a4,
              headerHeight: 20.0,
              useDoubleColumn: _useDoubleColumn, // 두 단 레이아웃 옵션 전달
              columnSpacing: 15.0, // 두 단 사이의 간격
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('오류 발생: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return PdfPreview(
                  build: (_) => snapshot.data!,
                  maxPageWidth: 700,
                  allowPrinting: false,
                  allowSharing: false,
                  canChangePageFormat: false,
                  canChangeOrientation: false,
                  canDebug: false,
                );
              } else {
                return Text('PDF를 생성할 수 없습니다.');
              }
            },
          ),
        ),
      ),
    );
  }
}