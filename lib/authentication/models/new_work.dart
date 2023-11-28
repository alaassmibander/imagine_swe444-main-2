class NewWork {
  final int id;
  final String imgUrl;

  NewWork({
    required this.id,
    required this.imgUrl,
  });

  NewWork copyWith({
    int? id,
    String? imgUrl,
  }) {
    return NewWork(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}

List<NewWork> work= [
  NewWork(
    id: 1,
    imgUrl:
        'assets/images/pablo-virtual-friend.png',
  ),
   NewWork(
    id: 2,
    imgUrl:
        'assets/images/pablo-family-evening.png',
  ),
    NewWork(
    id: 3,
    imgUrl:
        'assets/images/pablo-page-is-under-construction.png',
  ),
];
