enum MediaType { movie, book, series }

class MediaItem {
  final int? id;
  final String title;
  final MediaType type;
  final String status; //Like ... "Watching", "Completed", "Plan to Watch"
  final int rating; // ratting 1 to 5 star
  final String review;

  MediaItem({
    this.id,
    required this.title,
    required this.type,
    this.status = 'Plan to Watch',
    this.rating = 0,
    this.review = '',
  });

  //Serializer
  //Flutter objecy to Map like json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type.name, // savae Enum as String
      'status': status,
      'rating': rating,
      'review': review,
    };
  }

  //Deserializer
  //Map to Flutter Object
  factory MediaItem.fromMap(Map<String, dynamic> map) {
    return MediaItem(
      id: map['id'],
      title: map['title'],
      //convert String to Enum
      type: MediaType.values.byName(map['type']),
      status: map['status'],
      rating: map['rating'],
      review: map['review'],
    );
  }
}
