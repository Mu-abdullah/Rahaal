import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getme/core/extextions/extentions.dart';

import 'package:hugeicons/hugeicons.dart';

import '../../../main_app/main_app.dart';
import '../../language/lang_keys.dart';
import '../../style/color/color_light.dart';
import '../../style/statics/app_statics.dart';
import '../../style/widgets/app_text.dart';
import '../../style/widgets/custom_app_bar.dart';
import 'language_cubit/language_cubit.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        translatedTitle: LangKeys.changeLanguage,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorsLight.scaffoldBackground.withValues(alpha: 0.9),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<LanguageCubit, String>(
                builder: (context, selectedLanguage) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsLight.scaffoldBackground
                              .withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListView.separated(
                          padding: EdgeInsets.all(16),
                          itemCount: 2,
                          separatorBuilder: (_, __) => Divider(
                            color: ColorsLight.black.withValues(alpha: 0.1),
                            height: 24,
                          ),
                          itemBuilder: (context, index) {
                            final languages = [
                              {
                                'name': LangKeys.english,
                                'code': 'en',
                                'flag': '🇬🇧'
                              },
                              {
                                'name': LangKeys.arabic,
                                'code': 'ar',
                                'flag': '🇸🇦'
                              },
                            ];
                            return _buildLanguageTile(
                              context,
                              languages[index]['name']!,
                              languages[index]['code']!,
                              languages[index]['flag']!,
                              selectedLanguage,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String languageName,
    String languageCode,
    String flag,
    String selectedLanguage,
  ) {
    final isSelected = selectedLanguage == languageCode;

    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: isSelected ? 1.02 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.largeRadius,
          color: isSelected ? ColorsLight.white : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? ColorsLight.black
                : ColorsLight.black.withValues(alpha: 0.1),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorsLight.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: AppBorderRadius.largeRadius,
            onTap: () => _handleLanguageChange(context, languageCode),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  AppText(
                    flag,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppText(
                      context.translate(languageName),
                      fontSize: isSelected
                          ? context.titleLarge!.fontSize
                          : context.bodyLarge!.fontSize,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? ColorsLight.black : ColorsLight.gray,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isSelected
                        ? Icon(
                            HugeIcons.strokeRoundedCheckmarkCircle03,
                            color: ColorsLight.black,
                            size: 28,
                          )
                        : const SizedBox(width: 28),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLanguageChange(BuildContext context, String languageCode) {
    context.read<LanguageCubit>().changeLanguage(languageCode);
    final newLocale = Locale(languageCode);
    MainApp.updateAppLocale(context, newLocale);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorsLight.black,
        content: AppText(
          '${context.translate(LangKeys.changeLanguage)} '
          '${context.translate(LangKeys.english)}',
          color: ColorsLight.white,
        ),
        action: SnackBarAction(
          label: context.translate(LangKeys.cancel),
          textColor: ColorsLight.white,
          onPressed: () {
            // Handle undo logic
          },
        ),
      ),
    );
  }
}
