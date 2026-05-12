import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/theme.dart';
import '../providers/app_provider.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDark = provider.isDarkMode;
    final classStats = provider.classStats;
    final violationDist = provider.violationCategoryDistribution;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Text('Laporan', style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),

            // Summary Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        isDark: isDark,
                        icon: Icons.trending_down_rounded,
                        title: 'Total Poin\nPelanggaran',
                        value: '${provider.totalViolationPoints}',
                        color: AppColors.violation,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        isDark: isDark,
                        icon: Icons.trending_up_rounded,
                        title: 'Total Poin\nPrestasi',
                        value: '${provider.totalAchievementPoints}',
                        color: AppColors.achievement,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Violation Distribution Pie Chart
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.cardDark : AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Distribusi Pelanggaran', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: Row(
                          children: [
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 40,
                                  sections: _buildPieSections(violationDist),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: violationDist.entries.map((e) {
                                final colorIndex = violationDist.keys.toList().indexOf(e.key);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 10, height: 10,
                                        decoration: BoxDecoration(
                                          color: _getPieColor(colorIndex),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '${e.key} (${e.value})',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Class Rankings
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text('Statistik Per Kelas', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final className = classStats.keys.toList()[index];
                  final stats = classStats[className]!;
                  return _buildClassCard(context, className, stats, isDark);
                },
                childCount: classStats.length,
              ),
            ),

            // Top Students
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text('Siswa Berprestasi Terbaik', style: Theme.of(context).textTheme.titleLarge),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final topStudents = provider.students.toList()
                    ..sort((a, b) => b.totalAchievementPoints.compareTo(a.totalAchievementPoints));
                  if (index >= 5 || index >= topStudents.length) return null;
                  final student = topStudents[index];
                  return _buildTopStudentCard(context, student, index + 1, isDark);
                },
                childCount: 5,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required bool isDark,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieSections(Map<String, int> data) {
    final total = data.values.fold(0, (a, b) => a + b);
    return data.entries.map((e) {
      final index = data.keys.toList().indexOf(e.key);
      final percentage = total > 0 ? (e.value / total * 100) : 0.0;
      return PieChartSectionData(
        value: e.value.toDouble(),
        color: _getPieColor(index),
        radius: 32,
        title: '${percentage.toStringAsFixed(0)}%',
        titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
      );
    }).toList();
  }

  Color _getPieColor(int index) {
    const colors = [
      Color(0xFFEF4444), Color(0xFFF59E0B), Color(0xFF10B981),
      Color(0xFF06B6D4), Color(0xFF6366F1), Color(0xFFEC4899),
      Color(0xFFF97316), Color(0xFF8B5CF6), Color(0xFF14B8A6),
      Color(0xFF64748B),
    ];
    return colors[index % colors.length];
  }

  Widget _buildClassCard(BuildContext context, String className, Map<String, int> stats, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
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
                  className,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kelas $className',
                    style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${stats['students']} siswa',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildMiniStat(Icons.warning_amber_rounded, '${stats['violations']}', AppColors.violation),
                const SizedBox(width: 10),
                _buildMiniStat(Icons.emoji_events_rounded, '${stats['achievements']}', AppColors.achievement),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _buildTopStudentCard(BuildContext context, dynamic student, int rank, bool isDark) {
    final medalColors = [const Color(0xFFFFD700), const Color(0xFFC0C0C0), const Color(0xFFCD7F32)];
    final medalColor = rank <= 3 ? medalColors[rank - 1] : AppColors.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: rank <= 3 ? medalColor.withOpacity(0.3) : (isDark ? AppColors.borderDark : AppColors.border),
          ),
        ),
        child: Row(
          children: [
            // Rank Badge
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: medalColor.withOpacity(rank <= 3 ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: rank <= 3
                    ? Icon(Icons.emoji_events_rounded, color: medalColor, size: 20)
                    : Text(
                        '#$rank',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: medalColor),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Kelas ${student.className}',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.achievement.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '+${student.totalAchievementPoints} poin',
                style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.achievement,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
