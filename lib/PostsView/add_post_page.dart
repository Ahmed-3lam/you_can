import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:you_can/ArticlesView/Models/article_model.dart';
import 'package:you_can/Constants/color_constants.dart';
import 'package:you_can/Models/user.dart';
import 'package:you_can/PostsView/Models/post_model.dart';
import 'package:you_can/PostsView/Widgets/floating_button.dart';
import 'package:you_can/Services/Auth/data_base.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  final FocusNode _bodyNode = FocusNode();
  final FocusNode _aboutNode = FocusNode();

  bool haveImage = false;
  bool isArticle = false;
  bool isLoading = false;
  MyUser user;
  String imagePath;
  File image;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<MyUser>(context, listen: false);
    var dataBase = Provider.of<FireStoreDatabase>(context, listen: false);

    print(user.uid);
    print("${user.isDoctor}  ////// isDoctor");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "create",
          style: TextStyle(color: ColorsConstants.blackColor),
        ),
        centerTitle: true,
        backgroundColor: ColorsConstants.whiteColor,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton(
                onPressed: () async {
                  await create(user: user, database: dataBase);
                },
                child: isLoading ? CircularProgressIndicator() : Text("Add")),
          )
        ],
      ),
      backgroundColor: ColorsConstants.whiteColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: ColorsConstants.lightBlueColor,
                    backgroundImage: user.photoUrl != null
                        ? NetworkImage(user.photoUrl)
                        : AssetImage("assets/images/avatar.png"),
                    radius: 30,
                  ),
                  SizedBox(width: 5),
                  Text(user.name),
                ],
              ),
              SizedBox(height: 10),
              Offstage(
                offstage: !isArticle,
                child: TextField(
                  controller: titleController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: " title",
                  ),
                ),
              ),
              SizedBox(height: 10),
              image == null
                  ? Container()
                  : Offstage(
                      offstage: !haveImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsConstants.lightGreenColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.file(
                          image,
                          height: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              isArticle
                  ? Offstage(
                      offstage: !isArticle,
                      child: TextField(
                        controller: aboutController,
                        focusNode: _aboutNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          _aboutNode.unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: " about",
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 20),
              TextField(
                controller: bodyController,
                focusNode: _bodyNode,
                textInputAction: TextInputAction.newline,
                onEditingComplete: () {
                  _bodyNode.unfocus();
                },
                decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    filled: true,
                    fillColor: ColorsConstants.whiteColor,
                    hintText: "what is in your mind? "),
                // expands: true,
                minLines: null,
                maxLines: null,
                enabled: true,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingAddPostButton(
                      title: "Gallery",
                      icon: Icons.image_outlined,
                      backGround: ColorsConstants.whiteColor,
                      forGround: ColorsConstants.lightBlueColor,
                      onPressed: () {
                        uploadImage();
                      },
                    ),
                    SizedBox(width: 10),
                    Offstage(
                      offstage: !user.isDoctor,
                      child: FloatingAddPostButton(
                        title: "Article",
                        icon: Icons.article_outlined,
                        backGround: isArticle
                            ? ColorsConstants.lightBlueColor
                            : ColorsConstants.whiteColor,
                        forGround: isArticle
                            ? ColorsConstants.whiteColor
                            : ColorsConstants.lightBlueColor,
                        onPressed: () {
                          isArticle = !isArticle;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 150)
            ],
          ),
        ),
      ),
    );
  }

  void uploadImage() async {
    try {
      var pickedFile =
          await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        isLoading = true;
        setState(() {});
        print(pickedFile.path);
        image = File(pickedFile.path);
        uploadImageToFirebase(image);
        haveImage = true;
        setState(() {});
      } else {
        print("no image selected");
      }
    } finally {}
  }

  Future uploadImageToFirebase(File image) async {
    String fileName = image.path.split('/').last;
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('uploads/$fileName');

    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(image);
    // uploadTask.snapshot;
    // imagePath = await firebase_storage.FirebaseStorage.instance
    //     .ref()
    //     .child("uploads/")
    //     .getDownloadURL();
    //
    // print(imagePath);
    uploadTask.whenComplete(() async {
      try {
        imagePath = await firebaseStorageRef.getDownloadURL();
        isLoading = false;
        setState(() {});
      } catch (onError) {
        print("Error");
      }
      print(imagePath);
    });
  }

  Future<void> create({
    @required MyUser user,
    @required FireStoreDatabase database,
  }) async {
    isLoading = true;
    setState(() {});
    if (isArticle) {
      if (bodyController.text.isNotEmpty &&
          aboutController.text.isNotEmpty &&
          titleController.text.isNotEmpty) {
        isLoading = true;
        setState(() {});
        ArticleModel model = ArticleModel(
            uid: user.uid,
            title: titleController.text,
            body: bodyController.text,
            haveImage: haveImage,
            imageUrl: imagePath,
            time: DateTime.now().toIso8601String(),
            about: aboutController.text);
        await database.setArticle(model);

        isLoading = false;
        bodyController.text = "";
        aboutController.text = "";
        setState(() {});
      } else {
        final snackBar =
            SnackBar(content: Text('add your article and what it about'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      if (bodyController.text.isNotEmpty) {
        isLoading = true;
        setState(() {});
        PostModel model = PostModel(
            uid: user.uid,
            body: bodyController.text,
            haveImage: haveImage,
            imageUrl: imagePath,
            time: DateTime.now().toIso8601String(),
            comments: [],
            likes: []);
        await database.setPost(model);
        bodyController.text = "";
        isLoading = false;
        setState(() {});
      } else {
        final snackBar = SnackBar(content: Text('add your post'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
