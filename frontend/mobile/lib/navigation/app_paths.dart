class AppPaths {
  static const homePage = '/';
  static const profilePage = '/profile';
  static const signInPage = '/sign-in';
  static const wizzard = '/create';
  static const recommendationDetails = '/recomendation/:id';

  static String recommendationDetailsPath(String id) =>
      recommendationDetails.replaceFirst(':id', id);
}
