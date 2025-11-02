import 'package:flutter/material.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final String mockBookText = '''
  Chapter 1
  
  Once upon a time, in a small quiet village surrounded by forests and hills...
  The people lived peacefully, following the rhythm of nature and seasons.
  
  Chapter 2
  
  One day, a strange traveler appeared carrying a book that glowed faintly in the dark...
  
  Chapter 3
  
  As the story unfolds, you will discover that every word has its own magic.
  This is just a demo for UI design. 
    Chapter 1
  
  Once upon a time, in a small quiet village surrounded by forests and hills...
  The people lived peacefully, following the rhythm of nature and seasons.
  
  Chapter 2
  
  One day, a strange traveler appeared carrying a book that glowed faintly in the dark...
  
  Chapter 3
  
  As the story unfolds, you will discover that every word has its own magic.
  This is just a demo for UI design. 
    Chapter 1
  
  Once upon a time, in a small quiet village surrounded by forests and hills...
  The people lived peacefully, following the rhythm of nature and seasons.
  
  Chapter 2
  
  One day, a strange traveler appeared carrying a book that glowed faintly in the dark...
  
  Chapter 3
  
  As the story unfolds, you will discover that every word has its own magic.
  This is just a demo for UI design. 
    Chapter 1
  
  Once upon a time, in a small quiet village surrounded by forests and hills...
  The people lived peacefully, following the rhythm of nature and seasons.
  
  Chapter 2
  
  One day, a strange traveler appeared carrying a book that glowed faintly in the dark...
  
  Chapter 3
  
  As the story unfolds, you will discover that every word has its own magic.
  This is just a demo for UI design. 
    Chapter 1
  
  Once upon a time, in a small quiet village surrounded by forests and hills...
  The people lived peacefully, following the rhythm of nature and seasons.
  
  Chapter 2
  
  One day, a strange traveler appeared carrying a book that glowed faintly in the dark...
  
  Chapter 3
  
  As the story unfolds, you will discover that every word has its own magic.
  This is just a demo for UI design. 
    Chapter 1
  
  Once upon a time, in a small quiet village surrounded by forests and hills...
  The people lived peacefully, following the rhythm of nature and seasons.
  
  Chapter 2
  
  One day, a strange traveler appeared carrying a book that glowed faintly in the dark...
  
  Chapter 3
  
  As the story unfolds, you will discover that every word has its own magic.
  This is just a demo for UI design. 
  ''';

  late List<String> pages;
  double fontSize = 18.0;
  double lineHeight = 1.5;
  Color textColor = Colors.black87;
  Color backgroundColor = const Color(0xFFF8F5F0); // لون ورقي فاتح
  int currentPage = 0;
  bool showControls = false;

  // حساب عدد الأحرف المناسب لكل صفحة بناءً على حجم الشاشة
  int calculateCharsPerPage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // حساب مساحة النص الفعلية (مع مراعاة الهوامش)
    final textWidth = screenWidth * 0.85; // 85% من عرض الشاشة
    final textHeight = screenHeight * 0.75; // 75% من ارتفاع الشاشة

    // استخدام طريقة أبسط لحساب عدد الأحرف
    // متوسط عرض الحرف بناءً على حجم الخط
    final avgCharWidth = fontSize * 0.6; // تقدير متوسط عرض الحرف
    final charsPerLine = (textWidth / avgCharWidth).floor();

    // حساب عدد الأسطر في الصفحة
    final lineHeightPx = fontSize * lineHeight;
    final linesPerPage = (textHeight / lineHeightPx).floor();

    // حساب عدد الأحرف في الصفحة
    return charsPerLine * linesPerPage;
  }

  List<String> splitTextIntoPages(String text, int charsPerPage) {
    List<String> result = [];
    int startIndex = 0;

    // تحديد عدد الصفحات التقريبي مسبقاً لتحسين الأداء
    final estimatedPages = (text.length / charsPerPage).ceil();
    result = List.generate(estimatedPages, (_) => '');

    int pageIndex = 0;

    while (startIndex < text.length) {
      // حساب نهاية الصفحة
      int endIndex = startIndex + charsPerPage;
      if (endIndex >= text.length) {
        result[pageIndex] = text.substring(startIndex);
        break;
      }

      // البحث عن أقرب مسافة أو نقطة أو فاصلة لقطع النص عندها
      int breakPoint = endIndex;
      for (int i = endIndex; i > startIndex; i--) {
        if (text[i] == ' ' ||
            text[i] == '.' ||
            text[i] == '!' ||
            text[i] == '?') {
          breakPoint = i + 1;
          break;
        }
      }

      result[pageIndex] = text.substring(startIndex, breakPoint);
      startIndex = breakPoint;
      pageIndex++;
    }

    // تقليم القائمة إذا كانت أطول من اللازم
    if (result.length > pageIndex + 1) {
      result = result.sublist(0, pageIndex + 1);
    }

    return result;
  }

  void _rebuildPages() {
    // استخدام compute لتشغيل العملية في خلفية منفصلة
    final charsPerPage = calculateCharsPerPage(context);

    // استخدام Future.microtask لتنفيذ العملية بشكل غير متزامن
    Future.microtask(() {
      final newPages = splitTextIntoPages(mockBookText, charsPerPage);
      if (mounted) {
        // التحقق من أن الـ widget لا يزال موجوداً
        setState(() {
          pages = newPages;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // سيتم حساب الصفحات بعد بناء الواجهة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rebuildPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    // إذا لم يتم حساب الصفحات بعد، عرض مؤشر تحميل
    if (pages.isEmpty) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            // الصفحة الرئيسية
            PageView.builder(
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // رقم الصفحة في الأعلى
                      Center(
                        child: Text(
                          'Page ${index + 1} of ${pages.length}',
                          style: TextStyle(
                            fontSize: fontSize * 0.7,
                            color: textColor.withValues(alpha: .6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // محتوى الصفحة
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            pages[index],
                            style: TextStyle(
                              fontSize: fontSize,
                              height: lineHeight,
                              color: textColor,
                              fontFamily: 'Georgia',
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),

                      // رقم الصفحة في الأسفل
                      Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: fontSize * 0.8,
                            color: textColor..withValues(alpha: .6),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // عناصر التحكم
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: showControls ? 20 : -100,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white..withValues(alpha: .9),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black..withValues(alpha: .1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // شريط التقدم
                    Row(
                      children: [
                        Text(
                          '${currentPage + 1}/${pages.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor..withValues(alpha: .7),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (currentPage + 1) / pages.length,
                            backgroundColor: textColor..withValues(alpha: .2),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // أزرار التحكم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // زر تقليل حجم الخط
                        IconButton(
                          onPressed: () {
                            if (fontSize > 12) {
                              setState(() {
                                fontSize -= 1;
                              });
                              _rebuildPages();
                            }
                          },
                          icon: Icon(Icons.text_decrease),
                        ),

                        // زر زيادة حجم الخط
                        IconButton(
                          onPressed: () {
                            if (fontSize < 24) {
                              setState(() {
                                fontSize += 1;
                              });
                              _rebuildPages();
                            }
                          },
                          icon: Icon(Icons.text_increase),
                        ),

                        // زر تغيير لون الخلفية
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (backgroundColor == const Color(0xFFF8F5F0)) {
                                backgroundColor = const Color(0xFF2D3436);
                                textColor = Colors.white;
                              } else {
                                backgroundColor = const Color(0xFFF8F5F0);
                                textColor = Colors.black87;
                              }
                            });
                          },
                          icon: Icon(Icons.brightness_6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
