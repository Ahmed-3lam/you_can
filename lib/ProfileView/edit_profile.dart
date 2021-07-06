import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:you_can/Services/Auth/data_base.dart';

class EditProfile extends StatefulWidget {
  final MyUser user;
  const EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController specializationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool mainLoading = false;
  bool buttonLoading = false;

  String imagePath;
  File image;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    bioController.text = widget.user.bio;
    specializationController.text = widget.user.specialization;
    imagePath = widget.user.photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: ColorsConstants.blackColor),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorsConstants.blackColor,
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: uploadImage,
                child: Stack(
                  children: [
                    mainLoading
                        ? CircularProgressIndicator()
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: imagePath == null
                                ? AssetImage("assets/images/profile.jpg")
                                : NetworkImage(imagePath),
                            radius: 70,
                          ),
                    PositionedDirectional(
                      bottom: 15,
                      end: 15,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorsConstants.lightBlueColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("Full name"),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    hintText: "name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter correct name';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("bio"),
                ),
                TextFormField(
                  controller: bioController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.article_outlined),
                    hintText: "bio",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("specialization"),
                ),
                Offstage(
                  offstage: false,
                  child: TextFormField(
                    controller: specializationController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title_outlined),
                      hintText: "specialization",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your specialization';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await save();
              },
              style: ElevatedButton.styleFrom(
                primary: ColorsConstants.lightBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: buttonLoading
                  ? CircularProgressIndicator(color: ColorsConstants.whiteColor)
                  : Text(
                      "Save",
                      style: TextStyle(
                        color: ColorsConstants.whiteColor,
                        fontSize: 18,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void uploadImage() async {
    try {
      mainLoading = true;
      setState(() {});
      var pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        print(pickedFile.path);
        image = File(pickedFile.path);
        await uploadImageToFirebase(image);
      } else {
        mainLoading = false;
        setState(() {});
        print("no image selected");
      }
    } catch (e) {
      mainLoading = false;
      setState(() {});
      print(e.toString());
    }
  }

  Future uploadImageToFirebase(File image) async {
    final database = Provider.of<FireStoreDatabase>(context, listen: false);
    String fileName = image.path.split('/').last;
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profiles/$fileName');

    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(image);
    uploadTask.whenComplete(() async {
      try {
        imagePath = await firebaseStorageRef.getDownloadURL();
        MyUser model = MyUser(
          photoUrl: imagePath,
        );
        await database.updateUserImage(model, widget.user.uid);
        mainLoading = false;
        setState(() {});
      } catch (onError) {
        print("Error");
      }
      print(imagePath);
    });
  }

  Future<void> save() async {
    final database = Provider.of<FireStoreDatabase>(context, listen: false);
    if (specializationController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      buttonLoading = true;
      setState(() {});

      MyUser model = MyUser(
        email: widget.user.email,
        isDoctor: widget.user.isDoctor,
        name: nameController.text,
        bio: bioController.text,
        specialization: specializationController.text,
      );
      await database.updateUser(model, widget.user.uid);

      final snackBar = SnackBar(content: Text('data saved'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      buttonLoading = false;
      setState(() {});
    } else {
      final snackBar = SnackBar(content: Text('Complete missing Fields'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
