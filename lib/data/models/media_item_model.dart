enum MediaType { movie, book, series }

class MediaItem {
  final int? id;
  final String title;
  final MediaType type;
  final String status; //Like ... "Watching", "Completed", "Plan to Watch"
  final int rating; // ratting 1 to 5 star
  final String review;
  final int? userId;

  MediaItem({
    this.id,
    required this.title,
    required this.type,
    this.status = 'Plan to Watch',
    this.rating = 0,
    this.review = '',
    this.userId,
  });

  //Serializer
  //Flutter objecy to Map like json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'type': type.name.toUpperCase(),
      'status': status,
      'rating': rating,
      'review': review,
      'userId': userId,
    };
  }

  //Deserializer
  //Map to Flutter Object
  factory MediaItem.fromMap(Map<String, dynamic> map) {
    String rawType = map['type']?.toString().toLowerCase() ?? 'movie';

    return MediaItem(
      id: map['id'],
      title: map['title'] ?? '',
      type: MediaType.values.byName(rawType),
      status: map['status'] ?? 'Plan to Watch',
      rating: (map['rating'] as num?)?.toInt() ?? 0,
      review: map['review'] ?? '',
      userId: map['userId'],
    );
  }
}
