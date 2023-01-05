import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_status.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';

class SearchBloc extends SafeBloC {
  final GetLocationsByNameUseCase getLocationsByNameUseCase;
  final ISafeSnackBar safeSnackBar;

  final searchResult = SafeStream<List<LocationEntity>>(
    data: [],
    status: SafeStatus.initial,
  );
  final searchText = TextEditingController();

  String lastSearch = StringConstants.empty;

  SearchBloc({
    required this.getLocationsByNameUseCase,
    required this.safeSnackBar,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
  }

  Future<void> searchLocation() async {
    searchResult.data = [];
    searchResult.initial();

    try {
      if (searchText.text.isEmpty) {
        searchResult.data = [];
        searchResult.initial();
        return;
      }
      if (searchText.text == lastSearch) return;
      searchResult.loading();
      final result = await getLocationsByNameUseCase.call(
        searchText.text.trim(),
      );
      searchResult.data = result;
      searchResult.show();
      lastSearch = searchText.text;
    } on Exception catch (e) {
      searchResult.show();
      safeSnackBar.error('$e');
    }
  }

  void naviateToCreateLocation() {
    //TODO Alterar para a tela de criar local
    safeSnackBar.info(S.current.textFeatureAvailableSoon);
  }

  @override
  Future<void> dispose() async {
    searchResult.data = [];
    lastSearch = StringConstants.empty;
    searchText.clear();
  }
}
