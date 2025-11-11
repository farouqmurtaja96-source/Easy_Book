import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:easy_book/features/library/presentation/view_model/cubit/library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_book/features/reader_page/presentation/viewmodel/cubit/reader_cubit.dart';
import 'package:easy_book/features/reader_page/data/repo/reader_repo_impl.dart';
import 'package:http/http.dart' as http;

/// شاشة القارئ مع تحسينات الأداء والتنظيم

class ReaderScreenRefactored extends StatefulWidget {
  const ReaderScreenRefactored({super.key, required this.bookModel});
  final BookModel bookModel;
  @override
  State<ReaderScreenRefactored> createState() => _ReaderScreenRefactoredState();
}

class _ReaderScreenRefactoredState extends State<ReaderScreenRefactored> {
  // ثوابت التخصيص
  static const double _minFontSize = 12.0;
  static const double _maxFontSize = 24.0;
  static const double _defaultFontSize = 18.0;
  static const double _defaultLineHeight = 1.5;
  static const Color _lightBackgroundColor = Color(0xFFF8F5F0);
  static const Color _darkBackgroundColor = Color(0xFF2D3436);
  static const Color _lightTextColor = Colors.black87;
  static const Color _darkTextColor = Colors.white;

  // متغيرات الحالة
  String mockBookText = ""; // تهيئة النص الفارغي لتجنب الخطأ
  List<String> pages = []; // تهيئة القائمة لتجنب الخطأ
  bool isLoading = true; // لتتبع حالة تحميل الكتاب
  double fontSize = _defaultFontSize;
  double lineHeight = _defaultLineHeight;
  Color textColor = _lightTextColor;
  Color backgroundColor = _lightBackgroundColor;
  int currentPage = 0;
  bool showControls = false;

  /// حساب عدد الأحرف المناسب لكل صفحة بناءً على حجم الشاشة
  /// مع تحسينات الأداء والتنظيم
  int calculateCharsPerPage(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // حساب مساحة النص الفعلية (مع مراعاة الهوامش)
    const double textAreaWidthRatio = 0.85; // 85% من عرض الشاشة
    const double textAreaHeightRatio = 0.75; // 75% من ارتفاع الشاشة
    final textWidth = screenSize.width * textAreaWidthRatio;
    final textHeight = screenSize.height * textAreaHeightRatio;

    // متوسط عرض الحرف بناءً على حجم الخط
    const double avgCharWidthRatio = 0.6;
    final avgCharWidth = fontSize * avgCharWidthRatio;
    final charsPerLine = (textWidth / avgCharWidth).floor();

    // حساب عدد الأسطر في الصفحة
    final lineHeightPx = fontSize * lineHeight;
    final linesPerPage = (textHeight / lineHeightPx).floor();

    return charsPerLine * linesPerPage;
  }

  /// تقسيم النص إلى صفحات مع تحسينات الأداء والتنظيم
  List<String> splitTextIntoPages(String text, int charsPerPage) {
    // التعامل مع النص الفارغ
    if (text.isEmpty) {
      return ["لا يوجد محتوى لعرضه"];
    }

    final result = <String>[];
    int startIndex = 0;

    // تحديد عدد الصفحات التقريبي مسبقاً لتحسين الأداء
    final estimatedPages = (text.length / charsPerPage).ceil();
    result.addAll(List.filled(estimatedPages, ''));

    int pageIndex = 0;

    while (startIndex < text.length) {
      // حساب نهاية الصفحة
      int endIndex = startIndex + charsPerPage;

      if (endIndex >= text.length) {
        // التأكد من أن pageIndex ضمن النطاق
        _safeAddPage(result, pageIndex, text.substring(startIndex));
        break;
      }

      // البحث عن أقرب مسافة أو نقطة أو فاصلة لقطع النص عندها
      int breakPoint = _findBreakPoint(text, startIndex, endIndex);

      _safeAddPage(result, pageIndex, text.substring(startIndex, breakPoint));
      startIndex = breakPoint;
      pageIndex++;
    }

    // تقليم القائمة إذا كانت أطول من اللازم
    if (result.length > pageIndex) {
      return result.sublist(0, pageIndex);
    }

    return result;
  }

  /// البحث عن نقطة قطع مناسبة للنص
  int _findBreakPoint(String text, int startIndex, int endIndex) {
    // محارف القطع الممكنة
    const breakChars = [' ', '.', '!', '?'];

    for (int i = endIndex; i > startIndex; i--) {
      if (breakChars.contains(text[i])) {
        return i + 1;
      }
    }

    return endIndex; // إذا لم يتم العثور على نقطة قطع مناسبة
  }

  /// إضافة صفحة بأمان مع التحقق من الفهرس
  void _safeAddPage(List<String> pages, int index, String content) {
    if (index < pages.length) {
      pages[index] = content;
    } else {
      pages.add(content);
    }
  }

  /// إعادة بناء الصفحات مع تحسينات الأداء
  void _rebuildPages() {
    final charsPerPage = calculateCharsPerPage(context);

    // استخدام Future.microtask لتنفيذ العملية بشكل غير متزامن
    Future.microtask(() {
      final newPages = splitTextIntoPages(mockBookText, charsPerPage);
      if (mounted) {
        setState(() {
          pages = newPages;
          // التأكد من أن الصفحة الحالية ضمن النطاق الجديد
          if (currentPage >= pages.length && pages.length > 0) {
            currentPage = pages.length - 1;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReaderCubit(ReaderRepoImpl(client: http.Client())),
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (context, state) {
          // التعامل مع الحالات المختلفة
          if (state is ReaderInitial) {
            return _buildInitialState(context);
          }

          if (state is ReaderLoading) {
            return _buildLoadingState();
          }

          if (state is ReaderError) {
            return _buildErrorState(state.message);
          }

          if (state is BookTextLoaded) {
            return _buildLoadedState(state);
          }

          // حالة افتراضية (يجب ألا نصل هنا أبداً)
          return _buildDefaultState();
        },
      ),
    );
  }

  /// بناء واجهة الحالة الأولية
  Widget _buildInitialState(BuildContext context) {
    // التحقق من وجود formats و textPlainCharsetUsAscii
    if (widget.bookModel.formats == null ||
        widget.bookModel.formats!.textPlainCharsetUsAscii == null) {
      return _buildUnavailableBookScreen();
    }

    // تحميل نص الكتاب
    context.read<ReaderCubit>().loadBookText(
      widget.bookModel.formats!.textPlainCharsetUsAscii!,
    );
    return _buildLoadingState();
  }

  /// بناء واجهة التحميل
  Widget _buildLoadingState() {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("جاري تحميل الكتاب..."),
          ],
        ),
      ),
    );
  }

  /// بناء واجهة الخطأ
  Widget _buildErrorState(String message) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// بناء واجهة عدم توفر الكتاب
  Widget _buildUnavailableBookScreen() {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text(
          "عذراً، هذا الكتاب غير متاح للقراءة حالياً",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// بناء واجهة الحالة الافتراضية
  Widget _buildDefaultState() {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(child: Text("حدث خطأ غير متوقع")),
    );
  }

  /// بناء واجهة الحالة المحملة
  Widget _buildLoadedState(BookTextLoaded state) {
    // تحديث النص وإعادة بناء الصفحات
    mockBookText = state.bookText;
    if (pages.isEmpty) {
      _rebuildPages();
      return _buildLoadingState();
    }

    return _buildMainContent();
  }

  /// بناء واجهة المستخدم الرئيسية
  Widget _buildMainContent() {
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
                  // التأكد من أن الفهرس ضمن النطاق الصحيح
                  currentPage = pages.isNotEmpty
                      ? page.clamp(0, pages.length - 1)
                      : 0;
                });
              },
              itemCount: pages.isNotEmpty ? pages.length : 1,
              itemBuilder: (context, index) => _buildPageContent(index),
            ),

            // عناصر التحكم
            _buildControls(),
          ],
        ),
      ),
    );
  }

  /// بناء صفحة المحتوى
  Widget _buildPageContent(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رقم الصفحة في الأعلى
          Center(
            child: Text(
              'Page ${index + 1} of ${pages.length}',
              style: TextStyle(
                fontSize: fontSize * 0.7,
                color: textColor.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // محتوى الصفحة
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                // إضافة فحص أمان للفهرس
                pages.isNotEmpty && index < pages.length
                    ? pages[index]
                    : "لا يوجد محتوى لعرضه",
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
                color: textColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// بناء واجهة المستخدم للتحكم في القراءة
  Widget _buildControls() {
    final progress = (currentPage + 1) / pages.length;
    // تحويل نسبة التقدم إلى نسبة مئوية (0-100)
    final progressPercentage = progress * 100;

    // حساب وقت القراءة بشكل أكثر منطقية
    // نعتقد أن المستخدم يحتاج 30 ثانية لكل صفحة في المتوسط
    final double readingMinutes = (currentPage + 1) * 0.5; // 0.5 دقيقة لكل صفحة
    final double readingHours = readingMinutes / 60; // تحويل الدقائق إلى ساعات

    context.read<LibraryCubit>()
      ..updateProgress(widget.bookModel.id!, progress)
      ..updateReadingHours(widget.bookModel.id!, readingHours);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: showControls ? 20 : -100,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
                  '${progressPercentage.round().toString()} %',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(
                    value: pages.isNotEmpty ? progress : 0,
                    backgroundColor: textColor.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
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
                  onPressed: _decreaseFontSize,
                  icon: const Icon(Icons.text_decrease),
                ),

                // زر زيادة حجم الخط
                IconButton(
                  onPressed: _increaseFontSize,
                  icon: const Icon(Icons.text_increase),
                ),

                // زر تغيير لون الخلفية
                IconButton(
                  onPressed: _toggleTheme,
                  icon: const Icon(Icons.brightness_6),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// تبديل بين الوضع الفاتح والداكن
  void _toggleTheme() {
    setState(() {
      if (backgroundColor == _lightBackgroundColor) {
        backgroundColor = _darkBackgroundColor;
        textColor = _darkTextColor;
      } else {
        backgroundColor = _lightBackgroundColor;
        textColor = _lightTextColor;
      }
    });
  }

  /// زيادة حجم الخط
  void _increaseFontSize() {
    if (fontSize < _maxFontSize) {
      setState(() {
        fontSize++;
      });
      _rebuildPages();
    }
  }

  /// تقليل حجم الخط
  void _decreaseFontSize() {
    if (fontSize > _minFontSize) {
      setState(() {
        fontSize--;
      });
      _rebuildPages();
    }
  }
}
