import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobile_app/app/order/detail_order_page.dart';
import 'package:mobile_app/app/order/order_card.dart';
import 'package:mobile_app/models/response/order_model.dart';
import 'package:mobile_app/services/order_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final orderService = OrderService();
  final PagingController<int, OrderModel> _pagingController =
      PagingController(firstPageKey: 0);
  final _pageSize = 10;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final orderItems = await orderService.getOrderList(pageKey, _pageSize);
      final isLastPage = orderItems.result?.nextPageUrl == null;
      if (isLastPage) {
        _pagingController.appendLastPage(orderItems.result!.data);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(orderItems.result!.data, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _pagingController.refresh(),
        child: PagedListView<int, OrderModel>(
          pagingController: _pagingController,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          builderDelegate: PagedChildBuilderDelegate<OrderModel>(
            itemBuilder: (context, item, index) => OrderCard(
              data: item,
              onTap: () => Get.to<void>(
                () => DetailOrderPage(
                  data: item,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
