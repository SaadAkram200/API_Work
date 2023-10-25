import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';



class MyImageUploadApp extends StatefulWidget {
  @override
  _MyImageUploadAppState createState() => _MyImageUploadAppState();
}

class _MyImageUploadAppState extends State<MyImageUploadApp> {
  File? _selectedImage;
  bool isUploading = false;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      // No image selected.
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      // No image to upload.
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      final url = Uri.parse('https://httpbin.org/post');

      final request = http.MultipartRequest('POST', url);
      final mimeType = lookupMimeType(_selectedImage!.path) ?? 'application/octet-stream';
      final file = await http.MultipartFile.fromPath('image', _selectedImage!.path, contentType: MediaType.parse(mimeType));
      request.files.add(file);

      final response = await request.send();

      if (response.statusCode == 200) {
        // Image uploaded successfully
        print('Image uploaded successfully.');
      } else {
        // Handle the error
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error uploading image: $e');
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? Text('No image selected.')
                : SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.file(_selectedImage!)),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: isUploading ? null : _pickImage,
              child: Text('Pick Image from Gallery'),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: isUploading ? null : _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}