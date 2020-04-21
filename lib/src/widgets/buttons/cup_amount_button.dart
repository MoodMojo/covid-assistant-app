import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid_assistant_app/src/global_blocs/app_bloc.dart';
import 'package:covid_assistant_app/src/global_blocs/wash_bloc.dart';
import 'package:covid_assistant_app/src/utils/asset_util.dart';
import 'package:covid_assistant_app/src/widgets/popups/custom_amount_popup.dart';

class CupAmountButton extends StatelessWidget {
  const CupAmountButton({
    Key key,
    this.amount = 0,
  }) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    final washBloc = Provider.of<AppBloc>(context).washBloc;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (amount == 0) {
                setCustomAmount(washBloc, context);
              } else {
                setAmount(washBloc);
              }
            },
            child: StreamBuilder<int>(
              stream: washBloc.outSelectedAmount,
              initialData: 1,
              builder: (context, snapshot) {
                final selectedAmount = snapshot.data;
                return CupImage(
                  amount: amount,
                  isSelected: selectedAmount == amount,
                );
              },
            ),
          ),
          SizedBox(height: 8),
          if (amount != 0) Text('$amount washes') else Text('Custom'),
        ],
      ),
    );
  }

  void setCustomAmount(WashBloc washBloc, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CustomAmountPopup();
      },
    );
  }

  void setAmount(WashBloc washBloc) {
    washBloc.setWashAmount = amount;
  }
}

class CupImage extends StatelessWidget {
  const CupImage({
    Key key,
    @required this.amount,
    @required this.isSelected,
    this.width = 50,
    this.height = 50,
  }) : super(key: key);

  final int amount;
  final bool isSelected;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetUtil.assetImage(amount),
      width: isSelected ? width + 10 : width,
      height: isSelected ? height + 10 : height,
    );
  }
}
