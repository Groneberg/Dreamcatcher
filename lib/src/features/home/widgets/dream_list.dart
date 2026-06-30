import 'package:dreamcatcher/src/common/widget/frosted_glass_box.dart';
import 'package:dreamcatcher/src/data/model/dream.dart';
import 'package:dreamcatcher/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

typedef DreamCallback = void Function(Dream dream);

class DreamList extends StatelessWidget {
  final List<Dream> dreams;
  final DreamCallback onTap;
  final DreamCallback onDelete;
  final EdgeInsetsGeometry padding;

  const DreamList({
    Key? key,
    required this.dreams,
    required this.onTap,
    required this.onDelete,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dreams.length,
      padding: padding,
      itemBuilder: (context, index) {
        final dream = dreams[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Dismissible(
            key: ValueKey(dream.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => onDelete(dream),
            child: FrostedGlassBox(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  dream.title?.isNotEmpty == true
                      ? dream.title!
                      : 'Unknown Dream',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    dream.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppTheme.lightSterlingSilver),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${dream.date.day}.${dream.date.month}',
                      style: const TextStyle(
                        color: AppTheme.lavender,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Icon(
                      Icons.chevron_right,
                      color: AppTheme.lightSterlingSilver,
                      size: 20,
                    ),
                  ],
                ),
                onTap: () => onTap(dream),
              ),
            ),
          ),
        );
      },
    );
  }
}
