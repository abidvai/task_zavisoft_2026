import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_26/views/home/widget/product_card.dart';
import 'package:task_26/views/home/widget/search_bar_delegate.dart';
import 'package:task_26/views/home/widget/tab_bar_delegate.dart';

import '../../model/product_model.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            final handle = NestedScrollView.sliverOverlapAbsorberHandleFor(
              context,
            );

            return [
              /// -------------------------- Search bar section --------------------------------- ///
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(
                  queryController: controller.searchQuery,
                  topPadding: topPadding,
                ),
              ),

              /// --------------------------- Banner Section ----------------------------------- ///
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Image.network(
                      'https://images.pexels.com/photos/5632371/pexels-photo-5632371.jpeg',
                      width: double.infinity,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Abdullah Al Abid',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),

              /// ----------------------- Tab bar section ------------------------------------- ///
              SliverOverlapAbsorber(
                handle: handle,
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: TabBarDelegate(tabs: controller.tabs),
                ),
              ),
            ];
          },

          /// here i show the filtered data though if it fetch data for each tab then i will use the tab controller and then addListner checking the tab switching and index so that i can call separate api from separate tab
          ///
          body: TabBarView(
            children: [
              ProductTab(
                products: controller.productAllList,
                controller: controller,
              ),
              ProductTab(
                products: controller.mensProductList,
                controller: controller,
              ),
              ProductTab(
                products: controller.jewelleryProductList,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// here every tab needs preserved their own scroll position so i use the AutomaticKeepAliveClientMixin to preserve the scroll position
class ProductTab extends StatefulWidget {
  final RxList<ProductModel> products;
  final HomeController controller;

  const ProductTab({
    super.key,
    required this.products,
    required this.controller,
  });

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);

    return RefreshIndicator(
      backgroundColor: Colors.black26,
      color: Colors.white,
      displacement: 50.h,
      onRefresh: () async => widget.controller.fetchingProducts(),
      child: Obx(() {
        if (widget.controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (widget.products.isEmpty) {
          return const Center(child: Text("No products found"));
        }
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(handle: handle),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    ProductCard(product: widget.products[index]),
                childCount: widget.products.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
