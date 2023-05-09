import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/widgets/home_location_card.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';

class MountGettedPlaces extends StatelessWidget {
  final List<LocationEntity> list;
  final Widget? onEmpty;
  const MountGettedPlaces({
    Key? key,
    required this.list,
    this.onEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return onEmpty ?? const SizedBox();
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      itemCount: list.length,
      separatorBuilder: (_, i) => const SizedBox(height: 15),
      itemBuilder: (context, index) => HomeLocationCard(
        location: list[index],
        onTap: () async {
          await Modular.to.pushNamed(
            LocationModule.route + LocationPage.route,
            arguments: list[index],
          );
        },
      ),
    );
  }
}
