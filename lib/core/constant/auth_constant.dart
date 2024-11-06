enum AuthStatus {
  init("Initial"),
  authenticated("Authenticated"),
  unauthenticated("Unauthenticated"),
  notVerified("Not Verified"),
  requireData("Require Data");

  final String title;

  const AuthStatus(this.title);
}
