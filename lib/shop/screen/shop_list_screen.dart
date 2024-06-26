import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_app/core/bloc/sql_read_state.dart';
import 'package:inventory_management_app/repo/shop_repo/shop_entity.dart';
import 'package:inventory_management_app/route/route_name.dart';
import 'package:inventory_management_app/shop/controller/shop_listbloc/shop_list_bloc.dart';
import 'package:inventory_management_app/widget/button/bloc_outlinded_button.dart';
import 'package:starlight_utils/starlight_utils.dart';

class ShopListScreen extends StatelessWidget {
  const ShopListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: FlutterLogo(
              size: 80,
            ),
          ),
          const ShopList(),
          Container(
            width: context.width * 0.87,
            margin: const EdgeInsets.only(left: 2, right: 2, top: 20),
            child: CustomOutLinededButton(
                onPressed: () {
                  StarlightUtils.pushNamed(RouteNames.createNewShop);
                },
                label: "Create New Shop"),
          ),
        ],
      ),
    );
  }
}

class ShopList extends StatelessWidget {
  const ShopList({super.key});

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(const Duration(seconds: 3), (timer) async {
    //   await context.read<ShopListBloc>().shop.create(ShopParams.toCreate(
    //       name: "Shop name ${timer.tick}", cover_photo: "test ${timer.tick}"));
    // });
    return BlocBuilder<ShopListBloc, SqliteState<Shop>>(builder: (_, state) {
      final shop = state.list;
      final int totalShops = shop.length;
      double shopListHeight = context.height * 0.38;
      if (totalShops == 0) {
        return SizedBox(
          width: context.width,
        );
      }
      if (totalShops == 1) {
        shopListHeight = context.height * 0.098;
      } else if (totalShops == 2) {
        shopListHeight /= 2;
      } else if (totalShops == 3) {
        shopListHeight = context.height * 0.28;
      }
      final width = context.width;
      return SizedBox(
        width: context.width,
        height: shopListHeight,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: totalShops,
              itemBuilder: (_, i) {
                return Card(
                  elevation: 0.5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      print(shop[i].name);
                      _gotoDashboardScreen(shop[i].name);
                    },
                    child: Container(
                      height: 69,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                FileImage(File(shop[i].cover_photo)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(" ${shop[i].name}"),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }

  void _gotoDashboardScreen(String shopName) {
    StarlightUtils.pushReplacementNamed(RouteNames.dashboardloader,
        arguments: shopName);
  }
}
