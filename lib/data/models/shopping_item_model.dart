class ShoppingItem{
  final  int? id;
  final String name;
  final String category;
  bool isBought;

  ShoppingItem({
    this.id,
    required this.name,
    required this.category,
    this.isBought = false,
  });

  //objecy to Map like json
  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'name': name,
      'category': category,
      'isBought': isBought ? 1 : 0, //save bool as int 1 = true,0 false

    };
  }
  
  //Map to object
  factory ShoppingItem.fromMap(Map<String, dynamic> map){
    return ShoppingItem(      id: map['id'],
      name: map['name'],
      category: map['category'],
      isBought: map['isBought'] == 1,);
  }





}