import 'package:flutter/material.dart';
import 'package:fullscreen_vedio_app/screens/learning_module/model/lesson_data.dart';

class BuildLessonTile extends StatelessWidget {
  BuildLessonTile({super.key, required this.lesson});
  LessonData lesson;

  @override
  Widget build(BuildContext context) {
    return lesson.hasPracticeBadge ? Card(child: Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8 ),
      child: Row(
        children: [
          // Person Icon
          Column(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    lesson.iconPath,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                    // color: lesson.isLocked ? Colors.grey : null,
                  ),
                ),
              ),
              VerticalDivider()
            ],
          ),
          const SizedBox(width: 16),
          // Lesson Title and Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lesson.hasPracticeBadge)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'SPEAKING PRACTICE',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Text(
                  lesson.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: lesson.isLocked ? Colors.grey : Colors.black,
                  ),
                ),

              ],
            ),
          ),
          // Download Icon
          Icon(
            lesson.hasPracticeBadge ? null : Icons.cloud_download_outlined,
            color: lesson.isLocked ? Colors.grey : Colors.blue,
          ),
        ],
      ),
    ),) :  Container(
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      child: Row(
        children: [
          // Person Icon
          Column(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    lesson.iconPath,
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                    // color: lesson.isLocked ? Colors.grey : null,
                  ),
                ),
              ),
              Container(
                height : 10,
                width : 5,
                color : Colors.grey.shade300,
              )
            ],
          ),
          const SizedBox(width: 16),
          // Lesson Title and Badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lesson.hasPracticeBadge)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'SPEAKING PRACTICE',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.purple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Text(
                  lesson.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: lesson.isLocked ? Colors.grey : Colors.black,
                  ),
                ),

              ],
            ),
          ),
          // Download Icon
          Icon(
            lesson.hasPracticeBadge ? null : Icons.cloud_download_outlined,
            color: lesson.isLocked ? Colors.grey : Colors.blue,
          ),
        ],
      ),
    );
  }
}