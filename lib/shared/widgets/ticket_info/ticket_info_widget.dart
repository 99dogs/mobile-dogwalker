import 'package:flutter/material.dart';
import 'package:dogwalker/shared/themes/app_colors.dart';
import 'package:dogwalker/shared/themes/app_text_styles.dart';
import 'package:intl/intl.dart';

class TicketInfoWidget extends StatefulWidget {
  const TicketInfoWidget({Key? key}) : super(key: key);

  @override
  _TicketInfoWidgetState createState() => _TicketInfoWidgetState();
}

class _TicketInfoWidgetState extends State<TicketInfoWidget> {
  final formatCurrency = NumberFormat.currency(locale: "pt_BR");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.confirmation_num_outlined,
              color: AppColors.background,
              size: 40,
            ),
            Container(
              width: 1,
              height: 32,
              color: AppColors.background,
            ),
            Text.rich(TextSpan(
              text: "Preço atual\n",
              style: TextStyles.captionBackground,
              children: [
                TextSpan(
                  text: '1x ${formatCurrency.format(15.00)}',
                  style: TextStyles.captionBoldBackground,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
