import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/views/pages/all_product.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_dialog.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';

class Bag extends StatelessWidget {
  Bag({Key? key}) : super(key: key);
  int count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          _buildMyText('سبد خرید', 30, FixedVariables.purple1,
                              FontWeight.bold),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.refresh)),
                          const Spacer(),
                          _buildMyText(' $count  مورد ', 20,
                              FixedVariables.purple1, FontWeight.normal),
                        ],
                      ),
                    ),
                    FixedVariables.normalHeight,
                    _buildMyText(
                        'پس از هر بار تغییر دکمه بروزرسانی را فشار دهید',
                        20,
                        FixedVariables.red,
                        FontWeight.normal),
                    FixedVariables.normalHeight,
                    Center(
                        child: (count == 0)
                            ? Column(
                              children: [
                                const SizedBox(height: 170,),
                                _buildMyText('سبد خرید خالی می باشد', 20,
                                FixedVariables.purple1, FontWeight.normal),
                                const SizedBox(height: 170,),
                              ],
                            )
                            : _buildListView()),
                    FixedVariables.normalHeight,
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          _buildMyText('مجموع', 30, FixedVariables.purple1,
                              FontWeight.bold),
                          const Spacer(),
                          _buildMyText(' $count  تومان ', 20,
                              FixedVariables.purple1, FontWeight.normal),
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          _buildMyText('مقدار پرداختی', 30,
                              FixedVariables.purple1, FontWeight.bold),
                          const Spacer(),
                          _buildMyText(' ${count - 1}  تومان ', 20,
                              FixedVariables.purple1, FontWeight.normal),
                        ],
                      ),
                    ),
                    FixedVariables.littleHeight,
                    _buildMyButton('پرداخت', context),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyText(String text, double fontSize, Color color,
      FontWeight fontWeight) {
    return MyText(
      text: text,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  Widget _buildListView() {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              height: 190,
              child: Card(
                elevation: 8.0,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: FlutterLogo(
                          size: 60.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            _buildMyText('نام محصول', 20,
                                FixedVariables.purple1, FontWeight.normal),
                            _buildMyText(' قیمت اصلی : $countتومان ', 20,
                                FixedVariables.purple1, FontWeight.normal),
                            _buildMyText(' قیمت با تخفیف : ${count - 1}تومان  ',
                                20, FixedVariables.purple1, FontWeight.normal),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      count++;
                                    },
                                    icon: const Icon(
                                      Icons.add_circle_rounded,
                                      color: Colors.red,
                                    )),
                                _buildMyText(' $count ', 20,
                                    FixedVariables.purple1, FontWeight.normal),
                                IconButton(
                                    onPressed: () {
                                      count--;
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle_rounded,
                                      color: Colors.purpleAccent,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget _buildMyButton(String text, BuildContext context) {
    return MyButton(
      text: text,
      textColor: Colors.white,
      onPressed: () {
        _showMyDialog(context);
      },
      backgroundColor: FixedVariables.purple1,
      borderSideColor: FixedVariables.purple1,
      borderSideWidth: 2,
      buttonHeight: 70,
      buttonWidth: null,
      fontSize: 20,
      borderRadius: 10,
      padding: 5,
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            Directionality(
              textDirection: TextDirection.rtl,
              child: MyDialog(
                textChoice1: 'منم خوشحالم',
                  textChoice2: 'نیاز به تلاش بیشتر',
                  text: 'از خرید و اعتماد شما متشکریم :)',
                  onPressedCh1:() {
                    Navigator.pop(context);
                    Get.to(AllProduct());
                    count = 0;
                    },
                onPressedCh2:() {
                    Navigator.pop(context);
                    Get.to(AllProduct());
                    count = 0;
                    },
              ),
            )
    );
  }
}
