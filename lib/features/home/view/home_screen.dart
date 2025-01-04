import 'package:clinikk/features/home/controllers/home_controller.dart';
import 'package:clinikk/features/home/logic/post/post_cubit_cubit.dart';
import 'package:clinikk/features/home/static/models/post_model.dart';
import 'package:clinikk/features/home/view/edit_delete_bottomsheet.dart';
import 'package:clinikk/shared/global_controllers/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    GetCubit.put(PostCubit()).getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostCubitState>(
      bloc: GetCubit.find<PostCubit>(),
      builder: (context, state) {
        if (state is PostCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostCubitError) {
          return Center(child: Text(state.message));
        } else if (state is PostCubitLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: ThemeHandler().themeData.greyColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomeController>().navToTab(1);
                      },
                      child: AbsorbPointer(
                        child: CustomSearchBar(
                          isReadOnly: true,
                          onSearch: null,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.post.length,
                    itemBuilder: (context, index) {
                      final currPost = state.post[index];
                      return PostTile(currPost: currPost);
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({required this.currPost, super.key});

  final Post currPost;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        EditDeleteBottomsheet.showOptions(
          context,
          onDelete: () {
            EditDeleteBottomsheet.showDeleteWarning(currPost, context);
          },
          onEdit: () async{
            await EditDeleteBottomsheet.showEditSheet(currPost, context,true,);

            Navigator.pop(context);
          },
        );
      },
      leading: CircleAvatar(
        child: Text(
          currPost.id.toString(),
          style: TextStyle(
            color: ThemeHandler().themeData.iconColor,
          ),
        ),
      ),
      dense: false,
      title: Text(
        currPost.title.toString(),
        style: TextStyle(
          color: ThemeHandler().themeData.iconColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        currPost.body.toString(),
        style: TextStyle(
          color: ThemeHandler().themeData.iconColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar(
      {required this.onSearch, super.key, this.isReadOnly, this.focusNode,});

  final void Function(String)? onSearch;
  bool? isReadOnly = false;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      readOnly: isReadOnly ?? false,
      onChanged: onSearch,
      style: TextStyle(
        color: ThemeHandler().themeData.iconColor,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: 'Search',
        hintStyle: TextStyle(
          color: ThemeHandler().themeData.greyColor,
        ),
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: ThemeHandler().themeData.iconColor,
        ),
      ),
    );
  }
}
