import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/bloc/search_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/widgets/search_location_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search/';
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends SafeState<SearchPage, SearchBloc> {
  late FocusNode searchTextFocus;

  @override
  void initState() {
    searchTextFocus = FocusNode();
    searchTextFocus.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                controller: bloc.searchTextController,
                focusNode: searchTextFocus,
                labelText: S.current.textSearch,
                prefixIcon: const Icon(Icons.search),
                onEditingComplete: () async {
                  searchTextFocus.unfocus();
                  await bloc.searchLocation();
                },
              ),
              SafeBuilder<List<LocationEntity>>(
                stream: bloc.locations,
                builder: (locations) {
                  if (locations.isEmpty && bloc.isSearchEmpty) {
                    return SafeEmptyCard.searchInitial();
                  }
                  if (locations.isEmpty && !bloc.isSearchEmpty) {
                    return Column(
                      children: [
                        SafeEmptyCard.search(),
                        SafeTextButton(
                          text: S.current.textAddLocation,
                          onTap: bloc.navigateToAddLocationPage,
                        ),
                      ],
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    itemCount: locations.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 15),
                    itemBuilder: (context, index) => SearchLocationCard(
                      location: locations[index],
                      onTap: () => bloc.navigateToLocationPage(
                        locations[index],
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
}
