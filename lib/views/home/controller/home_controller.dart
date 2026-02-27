import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/product_model.dart';
import '../../../service/product_service.dart';

class HomeController extends GetxController {
  TextEditingController searchQuery = TextEditingController();
  final tabs = ["All", "Mens World", 'Jewellery'];
  RxList<ProductModel> productAllList = <ProductModel>[].obs;
  RxList<ProductModel> mensProductList = <ProductModel>[].obs;
  RxList<ProductModel> jewelleryProductList = <ProductModel>[].obs;
  RxBool isLoading = RxBool(false);

  final ProductService _productService = ProductService();

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

  void applyFilter() {
    mensProductList.assignAll(
      productAllList
          .where(
            (product) =>
                product.category.name == CategoryType.MEN_S_CLOTHING.name,
          )
          .toList(),
    );
    jewelleryProductList.assignAll(
      productAllList.where(
        (product) => product.category.name == CategoryType.JEWELERY.name,
      ).toList(),
    );
  }

  @override
  void onInit() {
    fetchingProducts();
    super.onInit();
  }

  @override
  void onClose() {
    searchQuery.dispose();
    super.onClose();
  }
}

enum CategoryType { All, MEN_S_CLOTHING, JEWELERY }
