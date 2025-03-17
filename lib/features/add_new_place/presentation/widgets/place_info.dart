import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getme/core/extextions/extentions.dart';
import 'package:getme/core/functions/generate_id.dart';
import 'package:getme/core/routes/routes_name.dart';
import 'package:getme/core/style/widgets/app_text.dart';

import '../../../../core/language/lang_keys.dart';
import '../../../../core/services/supabase/backend_points.dart';
import '../../../../core/style/widgets/app_button.dart';
import '../../../../core/style/widgets/app_text_form_felid.dart';
import '../../data/model/new_place_model.dart';
import '../cubits/images_cubit/get_image_cubit.dart';
import '../cubits/upload_images_cubit/upload_images_cubit.dart';

class PlaceInfo extends StatelessWidget {
  const PlaceInfo({
    super.key,
    required this.cubit,
  });

  final GetImageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(
                  child: AppText(
                cubit.city?.nameAr ?? "",
                isTitle: true,
              )),
            ],
          ),
          AppTextFormField(
            controller: cubit.placeName,
            type: TextInputType.text,
            hint: context.translate(LangKeys.placeName),
            validate: (value) {
              if (value!.isEmpty) {
                return context.translate(LangKeys.requiredValue);
              }
              return null;
            },
          ),
          AppTextFormField(
            controller: cubit.placeLocation,
            type: TextInputType.text,
            hint: context.translate(LangKeys.placelocation),
            validate: (value) {
              if (value!.isEmpty) {
                return context.translate(LangKeys.requiredValue);
              }
              return null;
            },
          ),
          AppTextFormField(
            controller: cubit.placeDescription,
            type: TextInputType.text,
            hint: context.translate(LangKeys.placeDescription),
            validate: (value) {
              if (value!.isEmpty) {
                return context.translate(LangKeys.requiredValue);
              }
              return null;
            },
          ),
          BlocConsumer<UploadImagesCubit, UploadImagesState>(
            listener: (context, state) {
              if (state is ImageUploadRemoteSuccess) {
                context.pushNamedAndRemoveUntil(RoutesNames.homeScreen);
              }
            },
            builder: (context, state) {
              var uploadCubit = UploadImagesCubit.get(context);
              return AppButton(
                isLoading: state is ImageUploadLoading,
                onTap: () async {
                  if (cubit.images.isNotEmpty) {
                    if (cubit.formKey.currentState!.validate()) {
                      final item = NewPlaceModel(
                        name: cubit.placeName.text,
                        location: cubit.placeLocation.text,
                        description: cubit.placeDescription.text,
                        cityId: cubit.city!.id,
                        placeId: await GenerateId.generateDocumentId(),
                        status: PlaceStatus.pending,
                      );
                      uploadCubit.addItem(placeModel: item).then((onValue) {
                        uploadCubit.submitForm(
                          images: cubit.images,
                          cityName: cubit.city!.name!,
                          country: cubit.city!.country!,
                        );
                      });
                    }
                  }
                },
                text: LangKeys.save,
              );
            },
          ),
        ],
      ),
    );
  }
}
