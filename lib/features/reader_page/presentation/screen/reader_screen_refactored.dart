import 'package:easy_book/core/model/book_model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_book/features/reader_page/presentation/viewmodel/cubit/reader_cubit.dart';
import 'package:easy_book/features/reader_page/data/repo/reader_repo.dart';
import 'package:easy_book/features/reader_page/data/repo/reader_repo_impl.dart';
import 'package:http/http.dart' as http;

/// شاشة القارئ المحسنة مع تنظيم أفضل للكود
class ReaderScreenNew extends StatefulWidget {
  const ReaderScreenNew({super.key, required this.bookModel});
  final BookModel bookModel;

  @override
  State<ReaderScreenNew> createState() => _ReaderScreenNewState();
}

class _ReaderScreenNewState extends State<ReaderScreenNew> {
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
  String _bookText = "";
  List<String> _pages = [];
  bool isLoading = true;
  double _fontSize = _defaultFontSize;
  double lineHeight = _defaultLineHeight;
  Color _textColor = _lightTextColor;
  Color _backgroundColor = _lightBackgroundColor;
  int _currentPage = 0;
  bool _showControls = false;

  // متغيرات الأداء
  late final ReaderCubit _readerCubit;

  @override
  void initState() {
    super.initState();
    _readerCubit = ReaderCubit(ReaderRepoImpl(client: http.Client()));
  }

  @override
  void dispose() {
    _readerCubit.close();
    super.dispose();
  }

  /// حساب عدد الأحرف المناسب لكل صفحة بناءً على حجم الشاشة
  /// مع الحفاظ على عدد الصفحات الأصلي للكتاب من API
  int _calculateCharsPerPage(BuildContext context) {
    // إذا كان المستخدم يفضل الحفاظ على عدد الصفحات الأصلي والنص متوفر

    // الطريقة الافتراضية إذا لم يكن النص متوفراً
    final screenSize = MediaQuery.of(context).size;

    // حساب مساحة النص الفعلية (مع مراعاة الهوامش)
    const double textAreaWidthRatio = 0.85; // 85% من عرض الشاشة
    const double textAreaHeightRatio = 0.75; // 75% من ارتفاع الشاشة
    final textWidth = screenSize.width * textAreaWidthRatio;
    final textHeight = screenSize.height * textAreaHeightRatio;

    // متوسط عرض الحرف بناءً على حجم الخط
    const double avgCharWidthRatio = 0.6;
    final avgCharWidth = _fontSize * avgCharWidthRatio;
    final charsPerLine = (textWidth / avgCharWidth).floor();

    // حساب عدد الأسطر في الصفحة
    final lineHeightPx = _fontSize * lineHeight;
    final linesPerPage = (textHeight / lineHeightPx).floor();

    return charsPerLine * linesPerPage;
  }

  /// تقسيم النص إلى صفحات مع تحسينات
  List<String> _splitTextIntoPages(String text, int charsPerPage) {
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
    final charsPerPage = _calculateCharsPerPage(context);

    // استخدام compute لتشغيل العملية في خلفية منفصلة
    Future.microtask(() {
      final newPages = _splitTextIntoPages(_bookText, charsPerPage);
      if (mounted) {
        setState(() {
          _pages = newPages;
          // التأكد من أن الصفحة الحالية ضمن النطاق الجديد
          if (_currentPage >= _pages.length && _pages.isEmpty) {
            _currentPage = _pages.length - 1;
          }
        });
      }
    });
  }

  /// تبديل بين الوضع الفاتح والداكن
  void _toggleTheme() {
    setState(() {
      if (_backgroundColor == _lightBackgroundColor) {
        _backgroundColor = _darkBackgroundColor;
        _textColor = _darkTextColor;
      } else {
        _backgroundColor = _lightBackgroundColor;
        _textColor = _lightTextColor;
      }
    });
  }

  /// زيادة حجم الخط
  void _increaseFontSize() {
    if (_fontSize < _maxFontSize) {
      setState(() {
        _fontSize++;
      });
      _rebuildPages();
    }
  }

  /// تقليل حجم الخط
  void _decreaseFontSize() {
    if (_fontSize > _minFontSize) {
      setState(() {
        _fontSize--;
      });
      _rebuildPages();
    }
  }

  /// بناء واجهة المستخدم للتحكم في القراءة
  Widget _buildControls() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: _showControls ? 20 : -100,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .9),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
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
                  '${_currentPage + 1}/${_pages.length}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _textColor.withValues(alpha: .7),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(
                    value: _pages.isNotEmpty
                        ? (_currentPage + 1) / _pages.length
                        : 0,
                    backgroundColor: _textColor.withValues(alpha: .2),
                    valueColor: AlwaysStoppedAnimation<Color>(_textColor),
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
              'Page ${index + 1} of ${_pages.length}',
              style: TextStyle(
                fontSize: _fontSize * 0.7,
                color: _textColor.withValues(alpha: .6),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // محتوى الصفحة
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                // إضافة فحص أمان للفهرس
                _pages.isNotEmpty && index < _pages.length
                    ? _pages[index]
                    : "لا يوجد محتوى لعرضه",
                style: TextStyle(
                  fontSize: _fontSize,
                  height: lineHeight,
                  color: _textColor,
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
                fontSize: _fontSize * 0.8,
                color: _textColor.withValues(alpha: .6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// بناء واجهة المستخدم الرئيسية
  Widget _buildMainContent() {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        child: Stack(
          children: [
            // الصفحة الرئيسية
            PageView.builder(
              onPageChanged: (int page) {
                setState(() {
                  // التأكد من أن الفهرس ضمن النطاق الصحيح
                  _currentPage = _pages.isNotEmpty
                      ? page.clamp(0, _pages.length - 1)
                      : 0;
                });
              },
              itemCount: _pages.isNotEmpty ? _pages.length : 1,
              itemBuilder: (context, index) => _buildPageContent(index),
            ),

            // عناصر التحكم
            _buildControls(),
          ],
        ),
      ),
    );
  }

  /// بناء واجهة التحميل
  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: _backgroundColor,
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
  Widget _buildErrorScreen(String message) {
    return Scaffold(
      backgroundColor: _backgroundColor,
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
      backgroundColor: _backgroundColor,
      body: const Center(
        child: Text(
          "عذراً، هذا الكتاب غير متاح للقراءة حالياً",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _readerCubit,
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (context, state) {
          // عند فتح الشاشة، قم بتحميل نص الكتاب
          if (state is ReaderInitial) {
            // التحقق من وجود formats و textPlainCharsetUsAscii
            if (widget.bookModel.formats == null ||
                widget.bookModel.formats!.textPlainCharsetUsAscii == null) {
              return _buildUnavailableBookScreen();
            }

            // تحميل نص الكتاب
            _readerCubit.loadBookText(
              widget.bookModel.formats!.textPlainCharsetUsAscii!,
            );
            return _buildLoadingScreen();
          }

          // عرض مؤشر التحميل
          if (state is ReaderLoading) {
            return _buildLoadingScreen();
          }

          // عرض رسالة الخطأ
          if (state is ReaderError) {
            return _buildErrorScreen(state.message);
          }

          // عند تحميل النص بنجاح
          if (state is BookTextLoaded) {
            // تحديث النص وإعادة بناء الصفحات
            _bookText = state.bookText;
            if (_pages.isEmpty) {
              _rebuildPages();
              return _buildLoadingScreen();
            }

            return _buildMainContent();
          }

          // حالة افتراضية (يجب ألا نصل هنا أبداً)
          return Scaffold(
            backgroundColor: _backgroundColor,
            body: const Center(child: Text("حدث خطأ غير متوقع")),
          );
        },
      ),
    );
  }
}
