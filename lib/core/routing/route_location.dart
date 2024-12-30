enum RouteLocation {
  signUp('/sign-up'),
  signIn('/sign-in'),
  home('/home');

  const RouteLocation(this._path);

  String get path => _path;
  final String _path;

  static const signUpPath = '/sign-up';
  static const signInPath = '/sign-in';
  static const homePath = '/home';
}
