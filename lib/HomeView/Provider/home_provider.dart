import 'package:flutter/material.dart';
import 'package:you_can/ArticlesView/View/articles_page.dart';
import 'package:you_can/PostsView/add_post_page.dart';
import 'package:you_can/PostsView/posts_page.dart';
import 'package:you_can/ProfileView/profile_page.dart';
import 'package:you_can/ViewsView/views_page.dart';

class HomeProvider extends ChangeNotifier {
  Screens currentPage = Screens.PostsPage;

  Widget changeWidget() {
    switch (currentPage) {
      case Screens.PostsPage:
        return PostsPage();
        break;
      case Screens.ArticlesPage:
        return ArticlesPage();

        break;
      case Screens.ViewsPage:
        return ViewsPage();
        break;
      case Screens.ProfilePage:
        return ProfilePage();
        break;
      case Screens.AddPostPage:
        return AddPostPage();
        break;
    }
    return Container();
  }

  int pageIndex = 0;

  void changePages(int index) {
    pageIndex = index;
    switch (index) {
      case 0:
        currentPage = Screens.PostsPage;
        print(currentPage);
        break;
      case 1:
        currentPage = Screens.ArticlesPage;
        print(currentPage);
        break;
      case 2:
        currentPage = Screens.ViewsPage;
        break;
      case 3:
        currentPage = Screens.ProfilePage;
        break;
      case 5:
        currentPage = Screens.AddPostPage;
        break;
    }
    notifyListeners();
  }
}

enum Screens {
  PostsPage,
  ArticlesPage,
  ViewsPage,
  ProfilePage,
  AddPostPage,
}
