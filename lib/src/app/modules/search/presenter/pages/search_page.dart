import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/bloc/search_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/widgets/search_location_card.dart';
import 'package:is_it_safe_app/src/components/config/safe_layout.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

import '../../../location/location_module.dart';
import '../../../location/presenter/pages/location_page.dart';

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
              SafeTextFormField(
                controller: controller.placeSearchController,
                labelText: S.current.textSearch,
                prefixIcon: const Icon(Icons.search),
                onEditingComplete: () => controller.searchLocation(),
              ),
              StreamBuilder<SafeStream<List<LocationEntity>>>(
                stream: controller.searchController.stream,
                initialData: SafeStream.initial(),
                builder: (context, snapshot) {
                  return SafeLayout(
                    snapshot: snapshot,
                    onEmpty: _mountEmptyCard(),
                    onCompleted: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      itemCount: controller.searchResultLocations.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 15),
                      itemBuilder: (context, index) => SearchLocationCard(
                        location: controller.searchResultLocations[index],
                        onTap: () async {
                          await Modular.to.pushNamed(
                            LocationModule.route + LocationPage.route,
                            arguments: controller.searchResultLocations[index],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
            controller.safeSnackBar.error(
              S.current.textFeatureAvailableSoon,
            );
          },
        ),
      ],
    );
  }
}
