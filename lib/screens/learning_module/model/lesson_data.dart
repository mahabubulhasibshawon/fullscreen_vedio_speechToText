// Model class for lesson data
class LessonData {
  final String title;
  final String iconPath;
  final bool isCompleted;
  final bool isLocked;
  final bool hasPracticeBadge;

  LessonData({
    required this.title,
    required this.iconPath,
    this.isCompleted = false,
    this.isLocked = false,
    this.hasPracticeBadge = false,
  });
}