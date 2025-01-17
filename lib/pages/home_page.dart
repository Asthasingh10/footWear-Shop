import 'package:flutter/material.dart';
import 'package:footware_client/controller/home_controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/pages/product_description_page.dart';
import 'package:footware_client/widgets/drop_down_btn.dart';
import 'package:footware_client/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: ()async{
           ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Footware Store", style: TextStyle(fontWeight: FontWeight.bold),),
            actions: [
              IconButton(onPressed: () {
                GetStorage box = GetStorage();
                box.erase();
                Get.offAll(LoginPage());
              }, icon: Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:ctrl.productCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                        ctrl.filterByCategory(ctrl.productCategory[index].name ?? '');
                        },
                        child: Padding(padding: const EdgeInsets.all(6),
                            child: Chip(label: Text(ctrl.productCategory[index].name ?? 'Error'),)
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(items: ['Rs:Low to High', 'Rs: High to Low'],
                      selectedItemText: 'Sort',
                      onSelected: (selected) {
                      print(selected);
                      ctrl.sortByPrice(ascending:selected == 'Rs:Low to High'?true:false);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No name',
                        ImageUrl:ctrl.productShowInUi[index].Image ?? 'url',
                        price:ctrl.productShowInUi[index].price ?? 00,
                        offerTag: '20 % off',
                        onTap: () {
                          Get.to(ProductDescriptionPage(),arguments: {'data':ctrl.productShowInUi[index]});
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}