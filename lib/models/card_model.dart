

class UserList {
  late List<CardModel> userList;

  UserList({required this.userList});

  UserList.fromJson(List json) {
    userList = json.map((map) => CardModel.fromJson(map)).toList();
  }

  List toJson() {
    List list;
    list = userList.map((user) => user.toJson()).toList();
    return list;
  }
}

class CardModel {
  late int id;
  late String name;
  late String cardNumber;
  DateTime? date;
  late String cvv;

  CardModel(
      {required this.id,
      required this.name,
      required this.cardNumber,
      required this.date,
      required this.cvv});

  CardModel.fromJson(Map<String,dynamic> json) {
    id = json["id"];
    name = json["name"];
    cardNumber = json["cardNumber"];
    date = DateTime.parse(json['date']);
    cvv = json["cvv"];
  }

  Map<String,dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "cardNumber" : cardNumber,
    "date" : date.toString(),
    "cvv" : cvv,
};
}