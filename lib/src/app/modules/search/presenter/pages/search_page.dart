import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/bloc/search_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/widgets/search_location_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search/';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchBloc> {
  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              _mountSearchField(),
              _mountSearchResult(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mountSearchField() {
    return SafeTextFormField(
      controller: controller.placeSearchController,
      labelText: S.current.textSearch,
      prefixIcon: const Icon(Icons.search),
      onEditingComplete: () => controller.searchLocation(),
    );
  }

  Widget _mountSearchResult() {
    return StreamBuilder<SafeEvent<List<LocationEntity>>>(
      stream: controller.searchController.stream,
      builder: (context, snapshot) {
        if (snapshot.data != null ||
            controller.searchResultLocations.isNotEmpty) {
          switch (snapshot.data?.status) {
            case Status.loading:
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: SafeLoading(),
              );
            case Status.error:
              showDialog(
                context: context,
                builder: (context) => SafeDialogs.error(
                  message: snapshot.data?.message,
                ),
              );
              break;
            default:
              if (snapshot.data?.data == null) {
                return _mountEmptyCardAndNavigateToRegisterNewPlace();
              }
              return ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                itemCount: controller.searchResultLocations.length,
                separatorBuilder: (_, i) => const SizedBox(height: 15),
                itemBuilder: (context, index) => SearchLocationCard(
                  location: controller.searchResultLocations[index],
                ),
              );
          }
        }
        return _mountEmptyCardAndNavigateToRegisterNewPlace();
      },
    );
  }

  Widget _mountEmptyCardAndNavigateToRegisterNewPlace() {
    return Column(
      children: [
        SafeEmptyCard.search(),
        //TODO add button to add place
      ],
    );
  }
}
