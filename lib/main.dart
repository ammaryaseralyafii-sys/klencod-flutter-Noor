import 'package:flutter/material.dart';

void main() {
  runApp(const NoorApp());
}

/// 👑 App Theme - Dark Luxury Theme
class AppTheme {
  static const Color background = Color(0xFF0F141C);
  static const Color surface = Color(0xFF18202C);
  static const Color surfaceLight = Color(0xFF222B38);
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color textPrimary = Color(0xFFF8F9FA);
  static const Color textSecondary = Color(0xFF94A3B8);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        surface: surface,
      ),
    );
  }
}

/// 🌟 Application Root
class NoorApp extends StatelessWidget {
  const NoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نور',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}

/// ✨ 1. Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const AuthRoleScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.surface,
                border: Border.all(
                  color: AppTheme.primaryGold.withOpacity(0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGold.withOpacity(0.15),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 50,
                color: AppTheme.primaryGold,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'نور',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGold,
                letterSpacing: 3.0,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'تطبيق الحلقات والقرآن الكريم',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔑 2. Role Selection & Registration Screen
class AuthRoleScreen extends StatefulWidget {
  const AuthRoleScreen({super.key});

  @override
  State<AuthRoleScreen> createState() => _AuthRoleScreenState();
}

class _AuthRoleScreenState extends State<AuthRoleScreen> {
  String selectedRole = 'student';
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _progressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _progressController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Text(
                'مرحباً بك في تطبيق نور',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'الرجاء إدخال بياناتك وتحديد صفة الدخول',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: _buildRoleTab('طالب', 'student', Icons.person_outline_rounded),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildRoleTab('معلم', 'teacher', Icons.record_voice_over_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildTextField(
                controller: _nameController,
                label: 'الاسم الثلاثي',
                icon: Icons.badge_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _ageController,
                label: 'العمر',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _progressController,
                label: selectedRole == 'student' ? 'وصفك وكم حفظت (مثال: واصل سورة البقرة - 5 أجزاء)' : 'اسم الحلقة / التخصص الإشرافي',
                icon: Icons.menu_book_outlined,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  if (_nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء إدخال الاسم الثلاثي'))
                    );
                    return;
                  }

                  if (selectedRole == 'teacher') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const TeacherDashboardScreen()),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const StudentHomeScreen()),
                    );
                  }
                },
                child: Text(
                  selectedRole == 'teacher' ? 'الدخول للوحة التحكم (معلم)' : 'دخول منصة الطالب',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentHomeScreen()),
                  );
                },
                child: const Text(
                  'الدخول كـ زائر سريع',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleTab(String title, String roleKey, IconData icon) {
    final bool isSelected = selectedRole == roleKey;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = roleKey;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.surfaceLight : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGold : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryGold : AppTheme.textSecondary,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppTheme.primaryGold : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppTheme.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        prefixIcon: Icon(icon, color: AppTheme.primaryGold),
        filled: true,
        fillColor: AppTheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppTheme.primaryGold, width: 1),
        ),
      ),
    );
  }
}

/// 👨‍🏫 3. Teacher Dashboard
class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم المعلم - نور', style: TextStyle(color: AppTheme.primaryGold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppTheme.primaryGold),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthRoleScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('إجمالي الطلاب', '4 طلاب'),
                  _buildStatItem('نشطون الآن', '3', isGreen: true),
                  _buildStatItem('التقييم العام', 'ممتاز'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'سجل الطلاب ومتابعة الحفظ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: [
                  _buildDetailedStudentCard(
                    fullName: 'عمار ياسر اليافعي',
                    age: '17 سنة',
                    progress: 'واصل في سورة آل عمران - حفظ 7 أجزاء',
                    status: 'متواجد الآن',
                    isOnline: true,
                  ),
                  _buildDetailedStudentCard(
                    fullName: 'عبدالله محمد باوزير',
                    age: '16 سنة',
                    progress: 'واصل في سورة النساء - حفظ 5 أجزاء',
                    status: 'متواجد الآن',
                    isOnline: true,
                  ),
                  _buildDetailedStudentCard(
                    fullName: 'سعيد صالح الكثيري',
                    age: '18 سنة',
                    progress: 'واصل في سورة البقرة - حفظ 3 أجزاء',
                    status: 'متواجد الآن',
                    isOnline: true,
                  ),
                  _buildDetailedStudentCard(
                    fullName: 'فهد أحمد العمودي',
                    age: '16 سنة',
                    progress: 'جزء عمّ - حفظ جزئين',
                    status: 'غير متواجد',
                    isOnline: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryGold,
        onPressed: () {},
        icon: const Icon(Icons.add_task_rounded, color: Colors.black),
        label: const Text('طرح سؤال / واجب جديد', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, {bool isGreen = false}) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isGreen ? Colors.greenAccent : AppTheme.primaryGold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
      ],
    );
  }

  Widget _buildDetailedStudentCard({
    required String fullName,
    required String age,
    required String progress,
    required String status,
    required bool isOnline,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              Text(
                fullName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isOnline ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(fontSize: 10, color: isOnline ? Colors.greenAccent : AppTheme.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'العمر: $age',
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.menu_book, size: 14, color: AppTheme.primaryGold),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  progress,
                  style: const TextStyle(fontSize: 13, color: AppTheme.primaryGold, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 📖 4. Student Home Screen
class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نور - منصة الطالب', style: TextStyle(color: AppTheme.primaryGold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: AppTheme.primaryGold),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthRoleScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'أهلاً بك يا قارئ القرآن\nتم تسجيل بياناتك بنجاح وجاهزون الآن للانتقال لباقي محتوى التطبيق الداخلي!',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.textPrimary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
