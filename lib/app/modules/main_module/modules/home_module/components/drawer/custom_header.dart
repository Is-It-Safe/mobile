import 'package:flutter/material.dart';

class CustomHeaderDrawer extends StatelessWidget {
  final String name;
  final String? profileImagePath;
  const CustomHeaderDrawer(
      {Key? key, required this.name, this.profileImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*
          1. Criar 2 componente para foto
              foto != null -> Exibe componente de foto
              foto == null -> exibe componente de placeholder
          */
          //TODO Modificar para componentes
          const CircleAvatar(
              radius: 30,
              //TODO: Verificar ajuste para imagem
              backgroundImage: AssetImage('images/app/home/drawer/user.png')),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                name,
                maxLines: 3,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
