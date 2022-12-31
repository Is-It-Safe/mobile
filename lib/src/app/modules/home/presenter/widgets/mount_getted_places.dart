import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../components/config/safe_event.dart';
import '../../../../../components/config/safe_layout.dart';
import '../../../../../domain/entity/location_entity.dart';
import '../../../location/location_module.dart';
import '../../../location/review/presenter/pages/review_page.dart';
import 'home_location_card.dart';

class MountGettePlaces extends StatelessWidget {
  final Stream<SafeEvent<List<LocationEntity>>> stream;
  final List<LocationEntity> list;
  final Widget? onEmpty;
  const MountGettePlaces({
    Key? key,
    required this.stream,
    required this.list,
    this.onEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SafeEvent<List<LocationEntity>>>(
      stream: stream,
      builder: (context, snapshot) {
        return SafeLayout(
          snapshot: snapshot,
          onEmpty: onEmpty ?? const SizedBox.shrink(),
          onCompleted: _mountSepararedList(),
        );
      },
    );
  }

  Widget _mountSepararedList() {
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
