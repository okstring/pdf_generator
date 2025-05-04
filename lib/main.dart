import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

void main() {
  runApp(MaterialApp(home: Scaffold(body: PdfGeneratorWithBackgroundImage())));
}

class PdfGeneratorWithBackgroundImage extends StatefulWidget {
  const PdfGeneratorWithBackgroundImage({super.key});

  @override
  State<PdfGeneratorWithBackgroundImage> createState() =>
      _PdfGeneratorWithBackgroundImageState();
}

class _PdfGeneratorWithBackgroundImageState
    extends State<PdfGeneratorWithBackgroundImage> {
  // 예시 문제 데이터
  final List<String> questions = [
    "1. What is the past tense of 'go'?",
    "2. Choose the correct sentence: A. She don't like coffee. B. She doesn't like coffee.",
    "3. Fill in the blank: I ___ studying English for 3 years.",
    "4. What is the opposite of 'expensive'?",
    "5. Choose the correct word: The book is ___ (their/there/they're) on the table.",
  ];

  Future<void> generatePdf() async {
    // PDF 문서 생성
    final pdf = pw.Document();

    // A4 사이즈 정의
    final a4Size = PdfPageFormat.a4;

    // 두 단 사이의 간격
    final columnGap = 10.0;

    // 페이지 여백
    final pageMargin = 20.0;

    // 각 단의 너비 계산
    final columnWidth = (a4Size.width - (2 * pageMargin) - columnGap) / 2;

    // 문제를 두 그룹으로 나누기
    final leftColumnQuestions = questions.sublist(
      0,
      questions.length ~/ 2 + questions.length % 2,
    );
    final rightColumnQuestions = questions.sublist(
      questions.length ~/ 2 + questions.length % 2,
    );

    // 배경 이미지 로드
    final backgroundImageData = await rootBundle.load(
      'images/activity.png',
    );
    final backgroundImage = pw.MemoryImage(
      backgroundImageData.buffer.asUint8List(),
    );

    // 헤더 로고 이미지 로드
    final headerLogoData = await rootBundle.load('images/city.png');
    final headerLogo = pw.MemoryImage(headerLogoData.buffer.asUint8List());

    // 한글 폰트 로드 (필요한 경우)
    final fontData = await rootBundle.load(
      'fonts/NanumGothic.ttf',
    );
    final ttf = pw.Font.ttf(fontData);

    // 페이지 1: 전체 배경 이미지 + 콘텐츠
    pdf.addPage(
      pw.Page(
        pageFormat: a4Size,
        margin: pw.EdgeInsets.all(pageMargin),
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              // 배경 이미지
              pw.Positioned.fill(
                child: pw.Image(backgroundImage, fit: pw.BoxFit.cover),
              ),

              // 콘텐츠 레이어
              pw.Container(
                width: a4Size.width,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    // 로고 이미지
                    pw.Container(
                      width: 100,
                      height: 100,
                      child: pw.Image(headerLogo),
                    ),

                    pw.SizedBox(height: 20),

                    // 제목
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Text(
                        'English Test - Part 1',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                    ),

                    pw.SizedBox(height: 40),

                    // 문제 영역 (배경 흰색으로 덮어서 가독성 향상)
                    pw.Container(
                      width: a4Size.width - (2 * pageMargin),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.white,
                        borderRadius: pw.BorderRadius.circular(8),
                        boxShadow: [
                          pw.BoxShadow(
                            color: PdfColors.black,
                            offset: PdfPoint(2, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Answer the following questions:',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),

                          pw.SizedBox(height: 20),

                          // 두 단 레이아웃
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              // 왼쪽 단
                              pw.Container(
                                width: columnWidth - 20, // 패딩 고려
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children:
                                      leftColumnQuestions.map((question) {
                                        return pw.Container(
                                          margin: pw.EdgeInsets.only(
                                            bottom: 15,
                                          ),
                                          child: pw.Text(
                                            question,
                                            style: pw.TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),

                              // 간격
                              pw.SizedBox(width: columnGap),

                              // 오른쪽 단
                              pw.Container(
                                width: columnWidth - 20, // 패딩 고려
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children:
                                      rightColumnQuestions.map((question) {
                                        return pw.Container(
                                          margin: pw.EdgeInsets.only(
                                            bottom: 15,
                                          ),
                                          child: pw.Text(
                                            question,
                                            style: pw.TextStyle(fontSize: 12),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 푸터
              pw.Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Page 1/2',
                    style: pw.TextStyle(color: PdfColors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // 페이지 2: 배경 이미지가 상단에만 있는 디자인
    pdf.addPage(
      pw.Page(
        pageFormat: a4Size,
        margin: pw.EdgeInsets.all(pageMargin),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 상단 배경 이미지
              pw.Container(
                width: a4Size.width - (2 * pageMargin),
                height: 150,
                child: pw.Stack(
                  children: [
                    // 이미지
                    pw.Positioned.fill(
                      child: pw.Image(backgroundImage, fit: pw.BoxFit.cover),
                    ),

                    // 이미지 위에 오버레이 텍스트
                    pw.Positioned(
                      bottom: 20,
                      left: 20,
                      child: pw.Container(
                        padding: pw.EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(4),
                        ),
                        child: pw.Text(
                          'English Test - Part 2',
                          style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // 본문 내용
              pw.Container(
                width: a4Size.width - (2 * pageMargin),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Reading Comprehension',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    pw.Text(
                      'Read the following passage and answer the questions below:',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),

                    pw.SizedBox(height: 15),

                    // 샘플 지문
                    pw.Container(
                      padding: pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey100,
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: pw.TextStyle(fontSize: 10),
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    // 문제 목록
                    pw.Text(
                      '6. What is the main idea of the passage?',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      '7. What does the author imply in the second sentence?',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      '8. Which of the following best summarizes the passage?',
                      style: pw.TextStyle(fontSize: 12),
                    ),

                    // 답안 작성 영역
                    pw.SizedBox(height: 30),
                    pw.Text(
                      'Write your answers below:',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      width: a4Size.width - (2 * pageMargin),
                      height: 200,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black),
                      ),
                    ),
                  ],
                ),
              ),

              // 푸터
              pw.Spacer(),
              pw.Container(
                width: a4Size.width - (2 * pageMargin),
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Page 2/2',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                ),
              ),
            ],
          );
        },
      ),
    );

    // PDF를 바이트 데이터로 변환
    final Uint8List pdfBytes = await pdf.save();

    // 웹에서 다운로드 처리
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor =
        html.AnchorElement(href: url)
          ..setAttribute('download', 'english_test_with_background.pdf')
          ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('배경 이미지 PDF 생성기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: generatePdf,
              child: const Text('배경 이미지 PDF 생성 및 다운로드'),
            ),
            const SizedBox(height: 20),
            const Text('배경 이미지가 포함된 A4 PDF가 생성됩니다.'),
            const SizedBox(height: 10),
            const Text('(참고: 실제 사용 시 assets/images 폴더에 이미지 파일을 추가해야 합니다)'),
          ],
        ),
      ),
    );
  }
}
