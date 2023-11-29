import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:med_manager_app/core/functions/custom_progress_indicator.dart';
import 'package:med_manager_app/core/functions/custom_snack_bar.dart';
import 'package:med_manager_app/core/utils/size_config.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/cubit/favorite_state.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/screens/widgets/favorite_icon_bloc_builder.dart';
import 'package:med_manager_app/features/patient_features/home_patient/presentation/screens/widgets/custom_doctor_item.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteCubit cubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      listener: (context, state) {
        if (state is! FavoriteLoading) {
          if (CustomProgressIndicator.isOpen) {
            Navigator.pop(context);
          }
          if (state is FavoriteFailure) {
            CustomSnackBar.showErrorSnackBar(context,
                message: state.failureMsg);
          }
        }
      },
      builder: (context, state) {
        if (state is FavoriteLoading && !(CustomProgressIndicator.isOpen)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomProgressIndicator.showProgressIndicator(context);
          });
        } else if (state is FavoriteEmptyState) {
          return Center(
            child: Text(
              'Favorite is Empty',
              style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig.defaultSize * 3.3,
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => cubit.indexFavorite(),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: SizeConfig.defaultSize * 30,
            ),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                columnCount: 2,
                position: index,
                duration: const Duration(milliseconds: 500),
                child: ScaleAnimation(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: CustomDoctorItem(
                      doctorModel: cubit.favDoctors[index],
                      index: index,
                      favoriteIcon: FavoriteIconBuilder(
                        doctorModel: cubit.favDoctors[index],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: cubit.favDoctors.length,
          ),
        );
      },
    );
  }
}
