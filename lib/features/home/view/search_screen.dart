import 'package:clinikk/features/home/view/home_screen.dart';
import 'package:clinikk/features/search/logic/search/search_cubit.dart';
import 'package:clinikk/shared/global_controllers/theme_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_cubit/get_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    GetCubit.put(SearchCubit());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: ThemeHandler().themeData.greyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomSearchBar(
                isReadOnly: false,
                focusNode: focusNode,
                onSearch: (query) {
                  final id = int.tryParse(query);
                  GetCubit.find<SearchCubit>().search(id ?? 0);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          BlocBuilder<SearchCubit, SearchState>(
            bloc: GetCubit.find<SearchCubit>(),
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SearchError) {
                return Center(child: Text(state.message));
              } else if (state is SearchLoaded) {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.post?.length ?? 0,
                    itemBuilder: (context, index) {
                      final currPost = state.post?[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            currPost?.id.toString() ?? '',
                            style: TextStyle(
                              color: ThemeHandler().themeData.iconColor,
                            ),
                          ),
                        ),
                        dense: false,
                        title: Text(
                          currPost?.title.toString() ?? '',
                          style: TextStyle(
                            color: ThemeHandler().themeData.iconColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          currPost?.body.toString() ?? '',
                          style: TextStyle(
                            color: ThemeHandler().themeData.iconColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
