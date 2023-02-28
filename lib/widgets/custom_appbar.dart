import 'package:flutter/material.dart';
import 'package:movies/search/search_delegate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.arrowBack = true,
    this.height = kToolbarHeight,
  }) : super(key: key);

  final String title;
  final bool arrowBack;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: arrowBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : const SizedBox(),
      title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title),
      ]),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
        )
      ],
    );
  }
}
