class Bookmark{
  final int? id;
  final String title;
  final String url;
  final String category;
  final int? userId;

  Bookmark({this.id, required this.title, required this.url, required this.category, this.userId});
  
  //obj to json
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'url':url,
      'category':category,
      'userId':userId,

    };
  }
  
  //json to obj
  factory Bookmark.fromMap(Map<String,dynamic> map){
    return Bookmark(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      category: map['category'],
      userId: map['userId'],
    );
  }
}