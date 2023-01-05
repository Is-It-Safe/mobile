import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../components/config/safe_event.dart';
import '../../../../../components/config/safe_layout.dart';
import '../../../../../domain/entity/location_entity.dart';
import '../../../location/location_module.dart';
import '../../../location/review/presenter/pages/review_page.dart';
import 'home_location_card.dart';

class MountGettedPlaces extends StatelessWidget {
  final Stream<SafeEvent<List<LocationEntity>>> stream;
  final List<LocationEntity> list;
  final Widget? onEmpty;
  final Widget? onError;
  final bool showErrorDialog;
  const MountGettedPlaces({
    Key? key,
    required this.stream,
    required this.list,
    this.onEmpty,
    this.showErrorDialog = true,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeEvent<List<LocationEntity>>>(
      stream: stream,
      builder: (context, snapshot) {
        return SafeLayout(
          snapshot: snapshot,
          showErrorDialog: showErrorDialog,
          onEmpty: onEmpty ?? const SizedBox.shrink(),
          onError: onError ?? const SizedBox.shrink(),
          onCompleted: _SepararedList(list: list),
        );
      },
    );
  }
}

class _SepararedList extends StatelessWidget {
  final List<LocationEntity> list;
  const _SepararedList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      itemCount: list.length,
      separatorBuilder: (_, i) => const SizedBox(height: 15),
      itemBuilder: (context, index) => HomeLocationCard(
        location: list[index],
        onTap: () => Modular.to.pushNamed(
          LocationModule.route + ReviewPage.route,
          arguments: list[index],
        ),
      ),
    );
  }
}
