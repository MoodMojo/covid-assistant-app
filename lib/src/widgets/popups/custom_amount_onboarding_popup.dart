import 'package:flutter/material.dart';
import 'package:covid_assistant_app/src/widgets/buttons/custom_wide_flat_button.dart';

class CustomAmountOnboardingPopup extends StatefulWidget {
  @override
  _CustomAmountOnboardingPopupState createState() => _CustomAmountOnboardingPopupState();
}

class _CustomAmountOnboardingPopupState extends State<CustomAmountOnboardingPopup> {
  final _controller = TextEditingController();
  Icon _errorIcon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
            child: Column(
              children: <Widget>[
                Text(
                  'Enter your amount',
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                ),
                smallSpace,
                Text(
                  'Enter a custom goal between 6 - 12',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle.copyWith(),
                ),
                largeSpace,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) => setValue(value),
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: _errorIcon,
                        suffixText: 'wash',
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          largeSpace,
          CustomWideFlatButton(
            text: 'Ok',
            onPressed: () => setValue(_controller.text),
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.pink.shade900,
          ),
        ],
      ),
    );
  }

  Widget get largeSpace => SizedBox(height: 24);
  Widget get smallSpace => SizedBox(height: 12);

  void setValue(String amountAsString) {
    Icon error = Icon(Icons.error, color: Colors.red);
    if (amountAsString.isEmpty) {
      setState(() {
        _errorIcon = error;
      });
      return;
    }
    int amount = int.parse(amountAsString);
    if (amount < 6 || amount > 12) {
      setState(() {
        _errorIcon = error;
      });
      return;
    }
    setState(() {
      _errorIcon = null;
    });

    Navigator.of(context).pop(amount);
  }
}