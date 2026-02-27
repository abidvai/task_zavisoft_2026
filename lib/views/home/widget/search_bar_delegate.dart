import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:task_26/core/navigation/app_route.dart';

/// --- This searchDelegate is responsible for showing the search bar static and also the profile icon
class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController queryController;
  final double topPadding;

  SearchBarDelegate({required this.queryController, required this.topPadding});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, topPadding, 20.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              controller: queryController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),

          /// using dummy network image from pixels website then clicked go to profile picture
          GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/4028398/pexels-photo-4028398.jpeg',
              ),
            ),
            onTap: () {
              Get.toNamed(AppRoute.profile);
            },
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 80.h;

  @override
  double get minExtent => 80.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
