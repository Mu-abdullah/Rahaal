import 'package:flutter/material.dart';
import 'package:getme/core/extextions/extentions.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/style/widgets/app_button.dart';

class AddNewPlaceFloatingButton extends StatelessWidget {
  const AddNewPlaceFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      isCircle: true,
      icon: HugeIcons.strokeRoundedImageAdd02,
      backGroundColor: Colors.lightBlueAccent,
      onTap: () {
        context.pushNamed(RoutesNames.addPlaceScreen);
      },
    );
  }
}
