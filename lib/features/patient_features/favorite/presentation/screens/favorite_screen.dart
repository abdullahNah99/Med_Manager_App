import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manager_app/core/utils/service_locator.dart';
import 'package:med_manager_app/core/widgets/custom_scaffold.dart';
import 'package:med_manager_app/features/patient_features/favorite/data/repos/favorite_repo_impl.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:med_manager_app/features/patient_features/favorite/presentation/screens/widgets/favorite_view_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoriteCubit(favoriteRepo: getIt.get<FavoriteRepoImpl>())
            ..indexFavorite(),
      child: CustomScaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
        ),
        body: const FavoriteViewBody(),
      ),
    );
  }
}
