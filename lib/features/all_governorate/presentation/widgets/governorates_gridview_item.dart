import 'package:flutter/material.dart';
import 'package:getme/core/extextions/extentions.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/style/font/fonts_helper.dart';
import '../../../../core/style/widgets/app_text.dart';
import '../../../home_screen/data/model/governorates_model.dart';
import '../cubits/governorates_cubit/governorates_cubit.dart';

class GridViewGovernoratesItem extends StatelessWidget {
  const GridViewGovernoratesItem({
    super.key,
    required this.governorates,
  });

  final GovernoratesModel governorates;

  @override
  Widget build(BuildContext context) {
    var cubit = GovernoratesCubit.get(context);
    var isArabic = FontsHelper.isArabic(context);
    return InkWell(
      onTap: () => context.pushNamed(
        cubit.isAddedPlace
            ? RoutesNames.addPlaceScreen
            : RoutesNames.governorateScreen,
        arguments: {
          'governorate': governorates,
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(governorates.image!),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            Center(
              child: AppText(
                isArabic ? governorates.nameAr! : governorates.name!,
                color: Colors.white,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
