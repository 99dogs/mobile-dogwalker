import 'package:dogwalker/modules/perfil/foto_perfil/foto_perfil_controller.dart';
import 'package:dogwalker/repositories/usuario_repository.dart';
import 'package:dogwalker/shared/enum/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotoPerfil extends StatefulWidget {
  final int id;
  const FotoPerfil({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _FotoPerfilState createState() => _FotoPerfilState();
}

class _FotoPerfilState extends State<FotoPerfil> {
  final controller = FotoPerfilController();
  final usuarioRepository = UsuarioRepository();

  String fotoUrl = "";

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.buscarInformacoes();
    fotoUrl = controller.usuario.fotoUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateEnum state = value as StateEnum;
          if (state == StateEnum.loading) {
            return CircularProgressIndicator();
          } else {
            return Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    fotoUrl,
                  ),
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
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? imagePicker = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (imagePicker != null) {
                            try {
                              String? newFotoUrl =
                                  await controller.atualizarFoto(
                                imagePicker,
                              );
                              if (newFotoUrl != null) {
                                controller.buscarInformacoes();
                                setState(() {
                                  fotoUrl = newFotoUrl;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Imagem atualizada com sucesso.",
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Ocorreu um problema ao atualizar a foto.",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
