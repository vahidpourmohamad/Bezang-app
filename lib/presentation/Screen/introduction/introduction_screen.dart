import 'package:bestbuy/presentation/Screen/welcome/welcome_screen.dart';
import 'package:bestbuy/presentation/themes/light_color.dart';
import 'package:bestbuy/presentation/widget/RoundedButton.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class IntroductionScreenWidget extends StatefulWidget {

  @override
  _IntroductionScreen createState() => _IntroductionScreen();
  const IntroductionScreenWidget({Key? key}) : super(key: key);
}

class _IntroductionScreen extends State<IntroductionScreenWidget> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
    );
  }

//  Widget _buildFullScreenImage() {
//    return Image.asset(
//      'assets/fullscreen.jpg',
//      fit: BoxFit.cover,
//      height: double.infinity,
//      width: double.infinity,
//      alignment: Alignment.center,
//    );
//  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,

    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalFooter: SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        height: MediaQuery.of(context).size.height*0.1,
        child: RoundedButton(
          text: 'بزن بریم',
          press: () {
            _onIntroEnd(context);
          },
        ),
      ),
      pages: [
        PageViewModel(
          title: "برنامه ریزی تماسها",
          body: "با بزنگ بهترین برنامه ریزی وکنترل را داشته باشید",
          image: _buildImage('assets/images/img1.jpg'),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "کار گروهی",
          body: "تیم خودت رو بساز و با تیمت پیشرفت کن",
          image: _buildImage('assets/images/img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "موفقیت",
          body: "100 درصد پیشرفت با بزنگ",
          image: _buildImage('assets/images/img3.jpg'),
          decoration: pageDecoration,
        )
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      // Display as right-to-left
      rtl: true,
      skip: const Text('رد شدن'),
      next: const Icon(Icons.arrow_forward,color:LightColor.kPrimaryColor),
      done: const Text('تمام',
          style: TextStyle(
              color: LightColor.kPrimaryColor, fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: LightColor.kPrimaryColor,
        activeSize: Size(22.0, 10.0),
        activeColor: LightColor.kPrimaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      skipColor: Colors.black,
      dotsContainerDecorator: const ShapeDecoration(
        color: LightColor.kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
