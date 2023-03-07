import 'package:flutter/material.dart';
import 'package:shopping_store/fixed_variables.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_button.dart';
import 'package:shopping_store/state_management_get/views/widgets/my_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              FixedVariables.bigHeight,
              Image.asset(
                'assets/images/welcome.png',
              ),
              _buildDetailCard(context),
              FixedVariables.normalHeight,
              _buildMyButton('افزودن', FixedVariables.purple1)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context) {
    return SizedBox(
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            side: BorderSide(width: 2, color: Colors.purple)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildMyText(
                          'نام محصول', 25, Colors.black, FontWeight.bold),
                      const Spacer(),
                      _buildMyText('5000 تومان', 20, FixedVariables.purple1,
                          FontWeight.normal),
                    ],
                  ),
                  Row(
                    children: [
                      _buildMyText(
                          'قیمت با تخفیف', 25, Colors.red, FontWeight.bold),
                      const Spacer(),
                      _buildMyText(
                          '2000 تومان', 20, Colors.red, FontWeight.normal),
                    ],
                  ),
                  FixedVariables.littleHeight,
                  Row(
                    children: [
                      _ratingBar(),
                      const Spacer(),
                      _buildMyText(
                          ' 5.0 ', 20, FixedVariables.purple1, FontWeight.bold),
                    ],
                  ),
                  FixedVariables.littleHeight,
                  _buildMyText(' توضیحات: ', 20, FixedVariables.purple1,
                      FontWeight.bold),
                  FixedVariables.littleHeight,
                  _buildMyText(
                      ' این یک محصول خوب است این یک محصول خوب است این یک محصول خوب است این یک محصول خوب است این یک محصول خوب است این یک محصول خوب است این یک محصول خوب است ',
                      20,
                      FixedVariables.purple1,
                      FontWeight.normal),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _ratingBar() {
    return RatingBar(
      initialRating: 3,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ratingWidget: RatingWidget(
        full: Image.asset(
          'assets/images/heart.png',
          color: Colors.amber,
        ),
        half: Image.asset('assets/images/heart_half.png', color: Colors.amber),
        empty:
            Image.asset('assets/images/heart_border.png', color: Colors.amber),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
      onRatingUpdate: (rating) {
        // print(rating);
      },
    );
  }

  Widget _buildMyButton(String text, Color backgroundColor) {
    return MyButton(
      text: text,
      textColor: Colors.white,
      backgroundColor: backgroundColor,
      borderSideColor: backgroundColor,
      borderSideWidth: 2,
      buttonHeight: 70,
      buttonWidth: 400,
      fontSize: 22,
      borderRadius: 10,
      padding: 5,
    );
  }

  Widget _buildMyText(
      String text, double fontSize, Color color, FontWeight fontWeight) {
    return MyText(
      text: text,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
