import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../providers/app_provider.dart';
import '../data/models/violation.dart';
import '../data/models/achievement.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> with TickerProviderStateMixin {
  final _nisController = TextEditingController();
  bool _studentFound = false;
  String? _foundStudentId;
  String? _foundStudentName;
  String? _foundStudentClass;
  bool _isSearching = false;
  
  // For adding violation/achievement
  String _selectedType = 'violation'; // 'violation' or 'achievement'
  String? _selectedCategory;
  String _description = '';
  bool _isSubmitting = false;
  
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedType = _tabController.index == 0 ? 'violation' : 'achievement';
        _selectedCategory = null;
      });
    });
  }

  @override
  void dispose() {
    _nisController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _searchStudent() {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final nis = _nisController.text.trim();
    if (nis.isEmpty) return;
    
    setState(() => _isSearching = true);
    
    try {
      final student = provider.students.firstWhere((s) => s.nis == nis);
      setState(() {
        _studentFound = true;
        _foundStudentId = student.id;
        _foundStudentName = student.name;
        _foundStudentClass = student.className;
        _isSearching = false;
      });
    } catch (_) {
      setState(() {
        _studentFound = false;
        _foundStudentId = null;
        _foundStudentName = null;
        _foundStudentClass = null;
        _isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Siswa dengan NIS "$nis" tidak ditemukan'),
          backgroundColor: AppColors.violation,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  Future<void> _submit() async {
    if (_selectedCategory == null || _foundStudentId == null) return;
    
    setState(() => _isSubmitting = true);
    final provider = Provider.of<AppProvider>(context, listen: false);
    
    try {
      if (_selectedType == 'violation') {
        final points = AppConstants.violationPoints[_selectedCategory] ?? 5;
        final severity = AppConstants.violationSeverity[_selectedCategory] ?? 'Ringan';
        await provider.addViolation(Violation(
          id: '',
          studentId: _foundStudentId!,
          studentName: _foundStudentName!,
          className: _foundStudentClass!,
          category: _selectedCategory!,
          severity: severity,
          points: points,
          description: _description.isEmpty ? _selectedCategory! : _description,
          date: DateTime.now(),
          reportedBy: provider.userName,
        ));
      } else {
        final points = AppConstants.achievementPoints[_selectedCategory] ?? 5;
        await provider.addAchievement(Achievement(
          id: '',
          studentId: _foundStudentId!,
          studentName: _foundStudentName!,
          className: _foundStudentClass!,
          category: _selectedCategory!,
          level: 'Sekolah',
          points: points,
          title: _selectedCategory!,
          description: _description.isEmpty ? _selectedCategory! : _description,
          date: DateTime.now(),
          verifiedBy: provider.userName,
        ));
      }
      
      if (!mounted) return;
      
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_selectedType == 'violation'
              ? 'Pelanggaran berhasil dicatat untuk $_foundStudentName'
              : 'Prestasi berhasil dicatat untuk $_foundStudentName'),
          backgroundColor: AppColors.achievement,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal: ${e.toString().replaceAll("Exception: ", "")}'),
          backgroundColor: AppColors.violation,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDark = provider.isDarkMode;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Scan QR Siswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scan & Input Poin',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Masukkan NIS siswa untuk menambah poin pelanggaran atau prestasi',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // NIS Input
            Text(
              'NIS Siswa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _nisController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan NIS dari QR Code',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    onFieldSubmitted: (_) => _searchStudent(),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isSearching ? null : _searchStudent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: _isSearching
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.search_rounded, size: 24),
                  ),
                ),
              ],
            ),
            
            // Student Found Card
            if (_studentFound) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.achievement.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _foundStudentName != null && _foundStudentName!.length >= 2
                              ? _foundStudentName!.substring(0, 2).toUpperCase()
                              : '??',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _foundStudentName ?? '',
                            style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'NIS: ${_nisController.text} • $_foundStudentClass',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle_rounded, color: AppColors.achievement, size: 24),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Type selection tabs
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: _selectedType == 'violation' ? AppColors.violation : AppColors.achievement,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  dividerHeight: 0,
                  tabs: const [
                    Tab(text: '⚠️ Pelanggaran'),
                    Tab(text: '🏆 Prestasi'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Category selection
              Text(
                'Pilih Jenis',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (_selectedType == 'violation'
                    ? AppConstants.violationCategories
                    : AppConstants.achievementCategories
                ).map((cat) {
                  final isSelected = _selectedCategory == cat;
                  final color = _selectedType == 'violation' ? AppColors.violation : AppColors.achievement;
                  final points = _selectedType == 'violation'
                      ? AppConstants.violationPoints[cat] ?? 5
                      : AppConstants.achievementPoints[cat] ?? 5;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withOpacity(0.15) : (isDark ? AppColors.surfaceDark : AppColors.surface),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? color : (isDark ? AppColors.borderDark : AppColors.border),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            cat,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? color : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${_selectedType == 'violation' ? '-' : '+'}$points',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              
              // Description
              Text(
                'Keterangan (opsional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Tambahkan keterangan...',
                ),
                onChanged: (val) => _description = val,
              ),
              const SizedBox(height: 24),
              
              // Submit
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: (_selectedCategory == null || _isSubmitting) ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedType == 'violation' ? AppColors.violation : AppColors.achievement,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: (_selectedType == 'violation' ? AppColors.violation : AppColors.achievement).withOpacity(0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  icon: _isSubmitting
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Icon(_selectedType == 'violation' ? Icons.warning_amber_rounded : Icons.emoji_events_rounded, size: 20),
                  label: Text(
                    _isSubmitting
                        ? 'Menyimpan...'
                        : _selectedType == 'violation'
                            ? 'Catat Pelanggaran'
                            : 'Catat Prestasi',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
