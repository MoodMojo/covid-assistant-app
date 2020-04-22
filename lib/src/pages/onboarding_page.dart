import 'package:flutter/material.dart';
import 'package:covid_assistant_app/services/firestore/firestore_user_service.dart';
import 'package:covid_assistant_app/src/root_page.dart';
import 'package:covid_assistant_app/src/widgets/buttons/custom_wide_flat_button.dart';
import 'package:covid_assistant_app/src/widgets/popups/custom_amount_onboarding_popup.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int selectedAmount = 6;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100, width: double.infinity),
            appIcon(),
            smallTextSpace,
            title(textTheme),
            smallTextSpace,
            subTitle(textTheme),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 16),
                    onPressed: () async {
                      int amount = await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return CustomAmountOnboardingPopup();
                        },
                      );
                      setState(() => selectedAmount = amount);
                    },
                    child: Text(
                      '$selectedAmount washes',
                      style: textTheme.title,
                    ),
                  ),
                ],
              ),
            ),
            CustomWideFlatButton(
              backgroundColor: Colors.pink.shade300,
              foregroundColor: Colors.pink.shade900,
              isRoundedAtBottom: false,
              text: 'Start',
              onPressed: () async {
                await FirestoreUserService.updateTotalcovid(selectedAmount);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RootPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget get smallTextSpace => SizedBox(height: 8);

  Widget appIcon() {
    return Image.asset(
      'assets/sign_in_icon.png',
      width: 125,
      height: 125,
    );
  }

  Text title(TextTheme textTheme) {
    return Text(
      'We help you avoid covid',
      style: textTheme.title.copyWith(
        fontSize: 24,
      ),
    );
  }

  Text subTitle(TextTheme textTheme) {
    return Text(
      'Set your daily handwash goal',
      style: textTheme.subtitle.copyWith(fontWeight: FontWeight.w400),
    );
  }
}
