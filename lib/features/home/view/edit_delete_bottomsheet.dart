import 'package:clinikk/features/home/logic/post/post_cubit_cubit.dart';
import 'package:clinikk/features/home/repos/post_repos.dart';
import 'package:clinikk/features/home/static/models/post_model.dart';
import 'package:clinikk/shared/global_controllers/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_cubit/get_cubit.dart';

class EditDeleteBottomsheet {
  static Future<void> showOptions(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: ThemeHandler().themeData.greyColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:
                    Icon(Icons.edit, color: ThemeHandler().themeData.iconColor),
                title: Text(
                  'Edit',
                  style: TextStyle(
                    color: ThemeHandler().themeData.iconColor,
                  ),
                ),
                onTap: () {
                  onEdit();
                  // Navigator.pop(context);
                },
              ),
              Divider(
                color: ThemeHandler().themeData.greyColor,
              ), // Optional: Adds a divider between options
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: ThemeHandler().themeData.iconColor,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    color: ThemeHandler().themeData.iconColor,
                  ),
                ),
                onTap: () {
                  onDelete();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showEditSheet(
    Post currPost,
    BuildContext context,
  ) async {
    final theme = ThemeHandler().themeData;

    // Controllers for text fields
    final titleController = TextEditingController(text: currPost.title);
    final subtitleController = TextEditingController(text: currPost.body);

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: theme.greyColor,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title Field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: theme.iconColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.iconColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.iconColor, width: 2),
                  ),
                ),
                style: TextStyle(color: theme.iconColor),
              ),
              const SizedBox(height: 16),
              // Subtitle Field
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(
                  labelText: 'Subtitle',
                  labelStyle: TextStyle(color: theme.iconColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.iconColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.iconColor, width: 2),
                  ),
                ),
                style: TextStyle(color: theme.iconColor),
              ),
              const SizedBox(height: 24),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final subtitle = subtitleController.text.trim();
                  PostRepos.editPost(currPost.id, title, subtitle);
                  GetCubit.find<PostCubit>().getPost();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.iconColor,
                  foregroundColor: theme.greyColor,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showDeleteWarning(
    Post currPost,
    BuildContext context,
  ) async {
    final theme = ThemeHandler().themeData;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: theme.greyColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon and Text
              Icon(
                Icons.warning_amber_rounded,
                color: theme.iconColor,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to delete this item?',
                style: TextStyle(
                  color: theme.iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Confirmation Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.greyColor,
                        foregroundColor: theme.iconColor,
                        side: BorderSide(color: theme.iconColor),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // onConfirm();
                        PostRepos.deletePost(currPost.id ?? 0);
                        GetCubit.find<PostCubit>().getPost();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.iconColor,
                        foregroundColor: theme.greyColor,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
