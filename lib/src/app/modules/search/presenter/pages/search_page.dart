import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/bloc/search_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/widgets/search_location_card.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search/';
  final Function()? addButton;
  const SearchPage({
    Key? key,
    this.addButton,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchBloc> {
  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
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
      initialData: SafeEvent.initial(),
      builder: (context, snapshot) {
        return SafeLayout(
          snapshot: snapshot,
          onCompleted: _mountResultList(),
          onEmpty: _mountEmptyCard(),
        );
      },
    );
  }

  ListView _mountResultList() {
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

  Widget _mountEmptyCard() {
    return Column(
      children: [
        SafeEmptyCard.search(),
        SafeTextButton(
          preText: S.current.textDontFoundThePlace,
          text: S.current.textCreateHere,
          onTap: () {
            return SafeSnackBar(
              message: S.current.textFeatureAvailableSoon,
              type: SnackBarType.info,
            ).show(context);
          },
        ),
      ],
    );
  }
}
