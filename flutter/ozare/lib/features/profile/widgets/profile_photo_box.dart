// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart'; //STUB - ON WHEN DEPLOY FOR WEB
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class ProfilePhotoBox extends StatelessWidget {
  const ProfilePhotoBox({
    required this.page,
    required this.imageUrl,
    super.key,
  });

  final ProfileRoutes page;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 110,
          width: 110,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(
                imageUrl!,
              ), // const AssetImage('assets/images/default.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (page == ProfileRoutes.editAccount)
          Positioned(
            bottom: 2,
            right: 24,
            child: GestureDetector(
              onTap: () async {
                // create a dialog to select image from gallery and upload it
                showDialog(
                  context: context,
                  builder: (_) => BlocProvider<ProfileBloc>.value(
                    value: context.read<ProfileBloc>(),
                    child: ProfilePhotoDialog(
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: 22,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProfilePhotoDialog extends StatefulWidget {
  const ProfilePhotoDialog({
    required this.imageUrl,
    super.key,
  });

  final String? imageUrl;

  @override
  State<ProfilePhotoDialog> createState() => _ProfilePhotoDialogState();
}

class _ProfilePhotoDialogState extends State<ProfilePhotoDialog> {
  XFile? _newImageFile;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      //STUB - ON WHEN DEPLOY FOR WEB
      final pickedFile = await ImagePickerWeb.getImageInfo;
      if (pickedFile != null) {
        setState(() {
          // _newImageFile = File.fromRawPath(pickedFile);
          _newImageFile = XFile.fromData(
            pickedFile.data!,
            name: pickedFile.fileName,
          );
        });
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          _newImageFile = XFile(pickedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Change Profile Photo',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 110,
                width: 110,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  color: Colors.white,
                  image: DecorationImage(
                    image: _newImageFile != null
                        // ? FileImage(File(_newImageFile!.path))
                        ? (kIsWeb
                            ? Image.network(_newImageFile!.path).image
                            : FileImage(
                                File(_newImageFile!.path),
                              ))
                        : kIsWeb
                            ? Image.network(widget.imageUrl!).image
                            : NetworkImage(widget.imageUrl!),
                    // image: Image.file(_imageFile!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 24,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(
                            0,
                            1,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      size: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_newImageFile != null) {
                context.read<ProfileBloc>().add(
                      ProfilePhotoUploadRequested(
                        _newImageFile!,
                      ),
                    );
                Navigator.of(context).pop();
              } else {
                showSnackBar(context, 'Please select an image');
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
