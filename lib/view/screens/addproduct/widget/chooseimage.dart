import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class chose_image extends StatefulWidget {
  const chose_image({Key key}) : super(key: key);

  @override
  State<chose_image> createState() => _chose_imageState();
}

class _chose_imageState extends State<chose_image> {
  List _images = [];
  File imagefile;
  final picker = ImagePicker();

  ChooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        itemCount: _images.length + 1,
        itemBuilder: (BuildContext context, index) {
          return index == _images.length
              ? GestureDetector(
                  onTap: () {
                    ChooseImage();
                  },
                  child: Stack(children: [
                    Container(
                      child: DottedBorder(
                        dashPattern: [8, 4],
                        color: Colors.grey,
                        child: ClipRRect(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(_images[index]), fit: BoxFit.cover),
                  ),
                );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.count(
          index == 1 ? 1 : 1,
          index == 1 ? 1 : 1,
        ),
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
    );
  }
}
