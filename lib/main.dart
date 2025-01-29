import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => CardCustomizationProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CardCustomizationScreen(),
    );
  }
}

class CardCustomizationProvider extends ChangeNotifier {
  File? _backgroundImage;
  Color _backgroundColor = Colors.blue;
  double _blur = 0;
  bool _useImage = true;
  double _scale = 1.0;
  Offset _position = Offset.zero;
  final List<Color> _predefinedColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple
  ];

  CardCustomizationProvider() {
    _backgroundColor =
        _predefinedColors[Random().nextInt(_predefinedColors.length)];
  }

  File? get backgroundImage => _backgroundImage;
  Color get backgroundColor => _backgroundColor;
  double get blur => _blur;
  bool get useImage => _useImage;
  double get scale => _scale;
  Offset get position => _position;

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _backgroundImage = File(pickedFile.path);
      _useImage = true;
      notifyListeners();
    }
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    _useImage = false;
    notifyListeners();
  }

  void setBlur(double value) {
    _blur = value;
    notifyListeners();
  }

  void updateScale(double newScale) {
    _scale = newScale;
    notifyListeners();
  }

  void updatePosition(Offset newPosition) {
    _position = newPosition;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://your-mock-server.com/upload'));
      request.fields['backgroundColor'] =
          _backgroundColor.value.toRadixString(16);
      request.fields['blur'] = _blur.toString();
      request.fields['scale'] = _scale.toString();
      request.fields['position'] = "${_position.dx},${_position.dy}";

      if (_backgroundImage != null) {
        var compressedFile = await _compressImage(_backgroundImage!);
        request.files.add(await http.MultipartFile.fromPath(
            'backgroundImage', compressedFile.path));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Changes saved successfully.");
      } else {
        print("Failed to save changes.");
      }
    } catch (e) {
      print("Failed to save changes: $e");
    }
  }

  Future<File> _compressImage(File file) async {
    final image = img.decodeImage(await file.readAsBytes());
    if (image == null) return file;
    final compressedImage = img.encodeJpg(image, quality: 70);
    final directory = await getTemporaryDirectory();
    final targetPath = '${directory.path}/compressed.jpg';
    final result = File(targetPath)..writeAsBytesSync(compressedImage);
    return result;
  }
}

class CardCustomizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardCustomizationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Customize Card")),
      body: Column(
        children: [
          const Spacer(),
          Container(
              width: 300,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(15),
            child: GestureDetector(
                onPanUpdate: (details) {
                  provider.updatePosition(provider.position + details.delta);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: provider.position,
                      child: Transform.scale(
                        scale: provider.scale,
                        child: Container(
                          width: 300,
                          height: 180,
                          decoration: BoxDecoration(
                            color: provider.useImage
                                ? null
                                : provider.backgroundColor,
                            image: provider.useImage &&
                                    provider.backgroundImage != null
                                ? DecorationImage(
                                    image: FileImage(provider.backgroundImage!),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                        ),
                      ),
                    ),
                    if (provider.blur > 0)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: provider.blur, sigmaY: provider.blur),
                          child: Container(
                            width: 300,
                            height: 180,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 16,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("1234 5678 9012 3456",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("CARDHOLDER NAME",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                Text("VALID THRU 12/26",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 10)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Slider(
            min: 0.8,
            max: 3.0,
            value: provider.scale,
            onChanged: provider.updateScale,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: provider.pickImage, child: Text("Pick Image")),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Pick Color"),
                      content: BlockPicker(
                        pickerColor: provider.backgroundColor,
                        onColorChanged: provider.setBackgroundColor,
                      ),
                    ),
                  );
                },
                child: const Text("Pick Color"),
              ),
            ],
          ),
          Slider(
            min: 0,
            max: 10,
            value: provider.blur,
            onChanged: provider.setBlur,
          ),
          ElevatedButton(
            onPressed: provider.saveChanges,
            child: const Text("Save"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
