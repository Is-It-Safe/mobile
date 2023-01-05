import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/widgets/search_empty_card_widget.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:is_it_safe_app/src/core/state/safe_state.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/bloc/search_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/widgets/search_location_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_empty_card.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

class SearchPage extends StatefulWidget {
  static const route = '/search/';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends SafeState<SearchPage, SearchBloc> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              SafeTextFormField(
                controller: bloc.searchText,
                labelText: S.current.textSearch,
                prefixIcon: const Icon(Icons.search),
                onEditingComplete: () => bloc.searchLocation(),
              ),
              const SizedBox(height: 20.0),
              SafeBuilder<List<LocationEntity>>(
                stream: bloc.searchResult,
                onInitial: () => SafeEmptyCard.search(
                  message: S.current.textSearchAPlace,
                ),
                builder: (searchResult) {
                  if (searchResult.isEmpty) {
                    return SearchEmptyCard(
                      onTapAction: () => bloc.naviateToCreateLocation(),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: searchResult.length,
                    separatorBuilder: (_, i) => const SizedBox(height: 15),
                    itemBuilder: (context, index) => SearchLocationCard(
                      location: searchResult[index],
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
