// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/controllers/home_controller.dart';
import 'package:shopping_store/state_management_get/controllers/product_controller.dart';
import 'package:shopping_store/state_management_get/views/pages/all_product.dart';
import 'package:shopping_store/state_management_get/views/pages/bag.dart';
import 'package:shopping_store/state_management_get/views/pages/profile.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagesSlider(),
            _buildRowOfText('جدید ترین ها'),
            _buildListView(),
            FixedVariables.normalHeight,
            _buildRowOfText('پر طرفدار ترین ها'),
            _buildListView(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: FixedVariables.purple1,
      title: const Text('آسان مارکت'),
      leading: IconButton(
          onPressed: () {
            Get.to(() => Bag());
          },
          icon: const Icon(Icons.shopping_cart)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              Get.to(() => Profile());
            },
            icon: const Icon(Icons.person),
          ),
        ),
      ],
    );
  }

  Widget _buildRowOfText(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: const MyText(
              text: 'دیدن همه',
              fontSize: 20,
            ),
            onTap: () {
              Get.to(() => AllProduct());
            },
          ),
          const Spacer(),
          MyText(
            text: text,
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              width: 250,
              child: InkWell(
                onTap: () {
                  // Get.to(() => AllProduct());
                },
                child: const Card(
                  elevation: 8.0,
                  child: FlutterLogo(
                    size: 60.0,
                  ),
                ),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  // Widget _buildImageSlideshow() {
  //   return ImageSlideshow(
  //     width: double.infinity,
  //     height: 250,
  //     initialPage: 0,
  //     indicatorColor: FixedVariables.purple1,
  //     indicatorBackgroundColor: Colors.grey,
  //     onPageChanged: (value) {
  //       // print('Page changed: $value');
  //     },
  //     autoPlayInterval: 3000,
  //     isLoop: true,
  //     children: [
  //       Image.asset(
  //         'assets/images/welcome.png',
  //         fit: BoxFit.cover,
  //       ),
  //       Image.asset(
  //         'assets/images/welcome.png',
  //         fit: BoxFit.cover,
  //       ),
  //       Image.asset(
  //         'assets/images/welcome.png',
  //         fit: BoxFit.cover,
  //       ),
  //     ],
  //   );
  // }

  Widget _imagesSlider() {
    return CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(homeController.sliderImages[index]));
        },
        options: CarouselOptions(autoPlay: true));
  }
}
