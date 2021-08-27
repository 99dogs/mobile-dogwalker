import 'package:flutter/material.dart';
import 'package:dogwalker/shared/auth/auth_controller.dart';
import 'package:dogwalker/shared/models/usuario_logado_model.dart';
import 'package:dogwalker/shared/themes/app_images.dart';

class FotoPerfil extends StatefulWidget {
  const FotoPerfil({Key? key}) : super(key: key);

  @override
  _FotoPerfilState createState() => _FotoPerfilState();
}

class _FotoPerfilState extends State<FotoPerfil> {
  final authController = AuthController();
  UsuarioLogadoModel _usuario = UsuarioLogadoModel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          FutureBuilder(
            future: authController.obterSessao(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _usuario = snapshot.data as UsuarioLogadoModel;
                String fotoUrl = "";
                if (_usuario.fotoUrl!.isNotEmpty) {
                  fotoUrl = _usuario.fotoUrl!;
                } else {
                  fotoUrl =
                      "https://cdn4.iconfinder.com/data/icons/user-people-2/48/5-512.png";
                }
                return CircleAvatar(
                  backgroundImage: NetworkImage(fotoUrl),
                );
              } else {
                return Container();
              }
            },
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
