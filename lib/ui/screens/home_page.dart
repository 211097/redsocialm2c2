import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../controllers/auth_controller.dart';
import 'posts_list.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController postController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  HomePage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await authController.signOut();  // Ajusta esto según tu método de signOut en AuthController
    Get.offAllNamed('/sign-in');  // Ajusta esta ruta según tu configuración de rutas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: const Color.fromARGB(255, 38, 22, 110), // Cambiado de Colors.blue a Colors.purple
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: postController,
              decoration: InputDecoration(
                labelText: '¿en qué estás pensando?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white70,
              ),
              maxLines: null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _pickMedia(context, 'image'),
                  child: Center(child: Text('⬆️Imagen')),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 22, 110),
                  ),
                ),
              ),
              SizedBox(width: 10), // Añadir espacio entre los botones
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _pickMedia(context, 'video'),
                  child: Center(child: Text('⬆️Video')),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 22, 110),
                  ),
                ),
              ),
              SizedBox(width: 10), // Añadir espacio entre los botones
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _pickMedia(context, 'audio'),
                  child: Center(child: Text('⬆️Audio')),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 22, 110),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                if (postController.text.isNotEmpty) {
                  authController.createPostWithMedia(postController.text, null);
                  postController.clear();
                }
              },
              child: Center(child: Text('Publicar Texto')),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 38, 22, 110),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: PostsList(),
          ),
        ],
      ),
    );
  }

  void _pickMedia(BuildContext context, String mediaType) async {
    final XFile? mediaFile;
    if (mediaType == 'image') {
      mediaFile = await picker.pickImage(source: ImageSource.gallery);
      print("Imagen seleccionada: ${mediaFile?.path}");
    } else if (mediaType == 'video') {
      mediaFile = await picker.pickVideo(source: ImageSource.gallery);
      print("Video seleccionado: ${mediaFile?.path}");
    } else if (mediaType == 'audio') {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        mediaFile = XFile(file.path);
        print("Audio seleccionado: ${mediaFile.path}");
      } else {
        mediaFile = null;
        print("No se seleccionó ningún audio.");
      }
    } else {
      mediaFile = null;
    }

    if (mediaFile != null) {
      authController.createPostWithMedia(postController.text, mediaFile,
          isVideo: mediaType == 'video',
          isAudio: mediaType == 'audio');
      postController.clear();
    } else {
      print("No se seleccionó ningún archivo.");
    }
  }
}
