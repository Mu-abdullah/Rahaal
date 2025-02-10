import 'package:flutter/material.dart';

import '../../data/account_listview.dart';
import 'account_button_item.dart';

class ButtonsListview extends StatelessWidget {
  const ButtonsListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = AccountListview.accountList(context);
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          var item = items[index];
          return AccountButtonItem(item: item);
        },
      ),
    );
  }
}
