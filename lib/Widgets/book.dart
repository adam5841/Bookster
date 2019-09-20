class Book {
  final String auth;
  final String id;
  final bool fav;
  final String title;
  final String img;

  const Book({
    this.id,
    this.fav,
    this.auth,
    this.title,
    this.img
  });

    Book.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          title: data['title'],
          fav: data['fav'],
          auth: data['auth'],
          img: data['image'],
        );
}