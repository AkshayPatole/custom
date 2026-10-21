// Step 3: View (UI Screen)

import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../const/app_strings.dart';
import '../model/post_model.dart';
import '../repo/post_repository.dart';
import 'create_post_screen.dart';
import 'update_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostRepository _postRepository = PostRepository();
  late Future<List<GetAllPostsModel>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() {
    _futurePosts = _postRepository.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.postsTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.orangeColor,
        onRefresh: () async {
          setState(() {
            _loadPosts();
          });
        },
        child: FutureBuilder<List<GetAllPostsModel>>(
          future: _futurePosts,
          builder: (context, snapshot) {
            // State 1:(Loading State)
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingView();
            }

            // State 2:(Error State)
            if (snapshot.hasError) {
              return _buildErrorView(snapshot.error.toString());
            }

            // State 3:(Empty State)
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildEmptyView();
            }

            // State 4:(Success State)
            final posts = snapshot.data!;
            return _buildPostList(posts);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.orangeColor,
        foregroundColor: AppColors.whiteColor,
        icon: const Icon(Icons.add),
        label: const Text('Create Post'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
      ),
    );
  }

  //  Loading Indicator. (Loading State)
  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.orangeColor,
      ),
    );
  }
  //  Posts ListView (Success State)
  Widget _buildPostList(List<GetAllPostsModel> posts) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _buildPostItem(posts[index]);
      },
    );
  }
   //  Single Post Card Item (Success State)
  Widget _buildPostItem(GetAllPostsModel post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post ID Badge & User ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.orangeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '#${post.id}',
                  style: const TextStyle(
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'User: ${post.userId}',
                    style: const TextStyle(color: AppColors.blackColor, fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePostScreen(post: post),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 15,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Post Title
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 8),

          // Post Body
          Text(
            post.body,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.blackColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

 //  Error Widget with Retry Option (Error State)
  Widget _buildErrorView(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 50, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.blackColor, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangeColor,
                foregroundColor: AppColors.whiteColor,
              ),
              onPressed: () {
                setState(() {
                  _loadPosts();
                });
              },
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
//  Empty State Widget
  Widget _buildEmptyView() {
    return const Center(
      child: Text(
        AppStrings.noPostsFound,
        style: TextStyle(fontSize: 16, color: AppColors.blackColor),
      ),
    );
  }
  
}
