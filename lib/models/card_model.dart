class CardModel {
  String? id;
  late String cardName;
  late String cardNumber;
  late String cardDate;
  late String cvv;

  CardModel(
      {this.id,
      required this.cardName,
      required this.cardNumber,
      required this.cardDate,
      required this.cvv});

  CardModel.fromJson(Map<String,dynamic> json) {
    id = json["id"];
    cardName = json["cardName"];
    cardNumber = json["cardNumber"];
    cardDate = json['cardDate'];
    cvv = json["cvv"];
  }

  Map<String,dynamic> toJson() => {
    "id" : id,
    "cardName" : cardName,
    "cardNumber" : cardNumber,
    "cardDate" : cardDate,
    "cvv" : cvv,
};
}