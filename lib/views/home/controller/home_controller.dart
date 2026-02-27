import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/product_model.dart';
import '../../../service/product_service.dart';

class HomeController extends GetxController {
  final ProductService _productService = ProductService();

  TextEditingController searchQuery = TextEditingController();

  /// for the tabs name
  final tabs = ["All", "Mens World", 'Jewellery'];

  /// ---- here store the api data in a reactive List to notify ui that this data is reactive and can be changed this is handled by getx
  RxList<ProductModel> productAllList = <ProductModel>[].obs;
  RxList<ProductModel> mensProductList = <ProductModel>[].obs;
  RxList<ProductModel> jewelleryProductList = <ProductModel>[].obs;

  RxBool isLoading = RxBool(false);

  /// -------- here i call the api service class that hey i need products can you get product for me
  /// it is a like waiter that call the kitchen for the ordered from the ui
  Future<void> fetchingProducts() async {
    isLoading.value = true;
    final response = await _productService.fetchProduct();
    if (response.isNotEmpty) {
      isLoading.value = false;
      productAllList.assignAll(response);
      applyFilter();
    } else {
      isLoading.value = false;
      Get.snackbar('Something went wrong', 'please try again...');
    }
  }

  /// here i filtered the data to separately show data in 3 tabs
  void applyFilter() {
    mensProductList.assignAll(
      productAllList
          .where(
            (product) =>
            /// checking that products category named is equal to desire category named
                product.category.name == CategoryType.MEN_S_CLOTHING.name,
          )
          .toList(),
    );
    jewelleryProductList.assignAll(
      productAllList
          .where(
            (product) => product.category.name == CategoryType.JEWELERY.name,
          )
          .toList(),
    );
  }

  /// when this controller initialized or when home page shown that exact time data should be fetch from the api
  @override
  void onInit() {
    fetchingProducts();
    super.onInit();
  }

  /// -------- disposing for system dont cached the data on the memory
  @override
  void onClose() {
    searchQuery.dispose();
    super.onClose();
  }
}

/// i use for this to store desire category name preserved to avoid typing mistake
enum CategoryType { All, MEN_S_CLOTHING, JEWELERY }
