enum JpgImageItems { loginBgOne, loginBgTwo, loginBgThree }

// This extension provides utility methods for JpgImageItems(its returns my assets for jpg paths)
extension JpgImageItemsExtension on JpgImageItems {
  String _imagePath() {
    switch (this) {
      case JpgImageItems.loginBgOne:
        return "login_bg_1";

      case JpgImageItems.loginBgTwo:
        return "login_bg_2";

      case JpgImageItems.loginBgThree:
        return "login_bg_3";
    }
  }

  String get imagePath => "assets/images/${_imagePath()}.jpg";
}
