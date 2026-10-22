import 'package:flutter/material.dart';

void main() {
  runApp(const NoorApp());
}

/// 👑 App Theme - Dark Luxury Theme
class AppTheme {
  // الألوان الرئيسية للتطبيق (أسود فاخر، كحلي داكن، وذهبي مائل للنور)
  static const Color background = Color(0xFF0F141C); // خلفية داكنة مريحة للعين
  static const Color surface = Color(0xFF18202C);    // كروت الشاشة والبطاقات
  static const Color primaryGold = Color(0xFFD4AF37); // الذهبي الفاخر
  static const Color accentLight = Color(0xFFF3E5AB); // نور ناعم
  static const Color textPrimary = Color(0xFFF5F5F7); // نص أبيض ناصع ومريح
  static const Color textSecondary = Color(0xFFA0AAB8); // نص فرعي هادئ

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        surface: surface,
        background: background,
      ),
      fontFamily: 'Roboto', // يمكنك استبداله بخط عربي مثل Tajawal أو Amiri لاحقاً
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

/// 🌟 Application Root
class NoorApp extends StatelessWidget {
  const NoorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نور',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}

/// 🕌 Home Screen - الشاشة الرئيسية لـ "نور"
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'نور',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // كارت الترحيب والنور
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primaryGold.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGold.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.auto_awesome,
                      size: 40,
                      color: AppTheme.primaryGold,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'حلقة نور القرآنية',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'مرحباً بك في أفق القرآن الكريم والذكر',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // عنوان القسم
              const Text(
                'الخدمات السريعة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // شبكة الخيارات الرئيسية
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildFeatureCard(
                      icon: Icons.menu_book_rounded,
                      title: 'المصحف الشريف',
                    ),
                    _buildFeatureCard(
                      icon: Icons.groups_rounded,
                      title: 'الحلقات القرآنيّة',
                    ),
                    _buildFeatureCard(
                      icon: Icons.bookmark_added_rounded,
                      title: 'متابعة الحفظ',
                    ),
                    _buildFeatureCard(
                      icon: Icons.access_time_filled_rounded,
                      title: 'مواقيت الصلاة',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ودجت بناء البطاقات البرمجية
  Widget _buildFeatureCard({required IconData icon, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 36,
                color: AppTheme.primaryGold,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
