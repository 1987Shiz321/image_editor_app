import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_editor_app/l10n/app_localizations.dart';
import 'package:image_editor_app/gen/assets.gen.dart';
import 'package:image/image.dart' as image_lib;

class ImageEditScreen extends StatefulWidget {
  const ImageEditScreen({super.key, required this.imageBitmap});

  final Uint8List imageBitmap;

  @override
  State<ImageEditScreen> createState() => _ImageEditScreenSatte();
}

class _ImageEditScreenSatte extends State<ImageEditScreen> {
  late Uint8List _imageBitmap;

  @override
  void initState() {
    super.initState();
    _imageBitmap = widget.imageBitmap;
  }

  void _rotateImage() {
    //画像のデコード
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;
    //画像を時計回りに90度回転
    final rotateImage = image_lib.copyRotate(image, angle: 90);
    //画像をエンコードして状態更新
    setState(() {
      _imageBitmap = image_lib.encodeBmp(rotateImage);
    });
  }

  void _flipImage() {
    //画像のデコード
    final image = image_lib.decodeImage(_imageBitmap);
    if (image == null) return;
    // 画像を水平方向に反転する
    final flipImage = image_lib.copyFlip(
      image,
      direction: image_lib.FlipDirection.horizontal,
    );
    //画像をエンコードして状態更新
    setState(() {
      _imageBitmap = image_lib.encodeBmp(flipImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l10n.imageSelectScreenTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(_imageBitmap),
            IconButton(
              onPressed: () => _rotateImage(),
              icon: Assets.rotateIcon.svg(width: 24, height: 24),
            ),
            IconButton(
              onPressed: () => _flipImage(),
              icon: Assets.flipIcon.svg(width: 24, height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
