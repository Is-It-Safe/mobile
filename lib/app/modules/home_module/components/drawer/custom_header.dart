import 'package:flutter/material.dart';

class CustomHeaderDrawer extends StatelessWidget {
  const CustomHeaderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            //TODO: Verificar ajuste para imagem
            backgroundImage: AssetImage('images/app/home/drawer/user.png')
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Usuário Com Um Longo Nome',
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
