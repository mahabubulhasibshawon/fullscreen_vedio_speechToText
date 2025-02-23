import 'package:flutter/material.dart';
import 'package:fullscreen_vedio_app/screens/learning_module/widgets/build_lesson_tile.dart';

import 'model/lesson_data.dart';

class LearningModule extends StatelessWidget {
  LearningModule({Key? key}) : super(key: key);

  // List of lesson data
  final List<LessonData> lessons = [
    LessonData(
      title: 'Hello!',
      iconPath: 'assets/image.jpg',
    ),
    LessonData(
      title: 'Introducing yourself',
      iconPath: 'assets/image.jpg',
      isLocked: true,
    ),
    LessonData(
      title: 'Ending a conversation',
      iconPath: 'assets/image.jpg',
      isLocked: true,
    ),
    LessonData(
      title: 'Speaking English',
      iconPath: 'assets/image.jpg',
      isLocked: true,
      hasPracticeBadge: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const Text(
                'Beginner A1',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Progress Bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.20,
                  heightFactor: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Chapter Title
              const Text(
                'Chapter 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                '0/${lessons.length} lessons completed',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 20),

              // Dynamic Lessons List
              Expanded(
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) => BuildLessonTile( lesson: lessons[index],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}