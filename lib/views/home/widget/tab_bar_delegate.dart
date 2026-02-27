import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabs;

  TabBarDelegate({required this.tabs});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      height: 80.h,
      child: TabBar(
        indicatorColor: Colors.blueGrey,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.deepPurple,
        physics: AlwaysScrollableScrollPhysics(),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
