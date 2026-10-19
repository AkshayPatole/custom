// Step 3: View (POST API Screen)

import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../const/app_strings.dart';
import '../const/custom_button_widget.dart';
import '../model/post_model.dart';
import '../repo/post_repository.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final PostRepository _postRepository = PostRepository();

  bool _isLoading = false;
  GetAllPostsModel? _createdPost;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  // POST API Call Function
  Future<void> _submitPost() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    // Validation: 
    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.fillAllFields),
          backgroundColor: AppColors.orangeColor,
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _postRepository.createPost(
        title: title,
        body: body,
      );

      setState(() {
        _createdPost = result;
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppStrings.postCreatedSuccess} (ID: ${result.id})'),
            backgroundColor: AppColors.greenColor,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.orangeColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.createPostTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _titleController,
                hintText: AppStrings.enterPostTitle,
                maxLines: 1,
              ),

              const SizedBox(height: 20),

              // 2. Body / Description Input Field
              const Text(
                'Description / Body',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _bodyController,
                hintText: AppStrings.enterPostBody,
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.orangeColor,
                      ),
                    )
                  : CustomButton(
                      text: AppStrings.submitPost,
                      onPressed: _submitPost,
                    ),

              const SizedBox(height: 30),

              if (_createdPost != null) _buildResponseCard(_createdPost!),
            ],
          ),
        ),
      ),
    );
  }


  //  TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.greyColor),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(14),
        ),
      ),
    );
  }

  Widget _buildResponseCard(GetAllPostsModel post) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greenColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.greenColor, size: 22),
              const SizedBox(width: 8),
              Text(
                AppStrings.responseResult,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenColor,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Text(
            'Generated ID: #${post.id}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            'Title: ${post.title}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            'Body: ${post.body}',
            style: TextStyle(color: AppColors.greyColor, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            'User ID: ${post.userId}',
            style: TextStyle(color: AppColors.greyColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
