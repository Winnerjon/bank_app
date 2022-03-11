import 'package:bank_app/models/card_model.dart';
import 'package:bank_app/services/http_service.dart';
import 'package:flutter/material.dart';

class AddCardList extends StatefulWidget {
  static const String id = "/add_card_page";

  const AddCardList({Key? key}) : super(key: key);

  @override
  _AddCardListState createState() => _AddCardListState();
}

class _AddCardListState extends State<AddCardList> {
  TextEditingController numberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void createCard() {
    String name = nameController.text.trim().toString();
    String number = numberController.text.trim().toString();
    String cvv = cvvController.text.trim().toString();

    if (name != null && number != null && cvv != null) return;

    CardModel newCard = CardModel(
        id: 0,
        name: name,
        cardNumber: number,
        date: DateTime.now(),
        cvv: cvv);

    apiCreateUser(newCard);
  }


  void apiCreateUser(CardModel user) {

    HttpService.POST(HttpService.API_CREATE_USER, HttpService.paramsCreate(user)).then((value) {


      if(value != null) {
        CardModel user = HttpService.parseCreateUser(value);
        print(user.id);
        Navigator.pop(context, true);
      } else {
        // error msg
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue.shade800,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              ListTile(
                title: Text(
                  "Add your card",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.zoom_out_map,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Fill in the fields below or use camera phone",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  "Your card number",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 60,
                    width: double.infinity - 125,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Card Number"),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expiry date",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "06",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                )),
                                Container(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                    child: Text(
                                  "22",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CVV2",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: cvvController,
                              keyboardType: TextInputType.number,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "CVV",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: MaterialButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: createCard,
                  child: Text(
                    "Add Card",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
