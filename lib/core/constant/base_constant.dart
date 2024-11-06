enum BaseStatus {
  init("Initial"),
  loading("Loading"),
  success("Success"),
  error("Error"),
  empty("Empty"),
  loadMore("Load More");

  final String title;

  const BaseStatus(this.title);
}
