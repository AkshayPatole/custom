import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../const/app_strings.dart';
import '../const/custom_button_widget.dart';
import '../model/post_model.dart';
import '../repo/post_repository.dart';

class UpdatePostScreen extends StatefulWidget {
  final GetAllPostsModel post;
  const UpdatePostScreen({super.key, required this.post});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  late final _titleController = TextEditingController(text: widget.post.title);
  late final _bodyController = TextEditingController(text: widget.post.body);
  final _postRepository = PostRepository();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _updatePost() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty || body.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final updated = await _postRepository.updatePost(
        id: widget.post.id,
        title: title,
        body: body,
        userId: widget.post.userId,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.postUpdatedSuccess} (ID: ${updated.id})'),
            backgroundColor: AppColors.greenColor,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.orangeColor),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text('${AppStrings.updatePostTitle} #${widget.post.id}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator(color: AppColors.orangeColor)
                : CustomButton(
                    text: AppStrings.updatePost,
                    onPressed: _updatePost,
                  ),
          ],
        ),
      ),
    );
  }
}
