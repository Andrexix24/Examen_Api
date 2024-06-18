import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class File{
  File(String path);
  
  get path => null;
  
}

class Foto extends StatefulWidget {
  const Foto({super.key});

  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  final ImagePicker _picker = ImagePicker();

  Future<File?> takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar foto'),
      ),
      body: ElevatedButton(
        onPressed: () async {
          final file = await takePhoto();
          if (file != null) {
            // Use the file object for further processing (e.g., display, upload)
            print('Image path: ${file.path}');
          } else {
            print('No image selected');
          }
        },
        child: Text('Tomar foto'),
      ),
    );
  }
}
