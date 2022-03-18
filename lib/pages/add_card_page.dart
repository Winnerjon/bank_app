import 'package:bank_app/models/card_model.dart';
import 'package:bank_app/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class AddCardList extends StatefulWidget {
  static const String id = "/add_card_page";

  const AddCardList({Key? key}) : super(key: key);

  @override
  _AddCardListState createState() => _AddCardListState();
}

class _AddCardListState extends State<AddCardList> {
  TextEditingController numberController = MaskedTextController(mask: "0000 0000 0000 0000");
  TextEditingController dateController = MaskedTextController(mask: "00 / 00");
  TextEditingController cvvController = MaskedTextController(mask: "0 0 0");
  TextEditingController nameController = TextEditingController();

  void addCard() async {
    String cardName = nameController.text.trim().toString().replaceAll("\'", "");
    String cardNumber = numberController.text.trim().toString();
    String cardDate = dateController.text.trim().toString();
    String cvv = cvvController.text.trim().toString().replaceAll(" ", "");


    if(cardName.isEmpty || cardNumber.isEmpty || cardDate.isEmpty || cvv.isEmpty || cardNumber.length != 19)return;

    CardModel card = CardModel(cardName: cardName, cardNumber: cardNumber, cardDate: cardDate, cvv: cvv);
    
    HttpService.POST(HttpService.API_CREATE, HttpService.bodyCreate(card));

    Navigator.pop(context,true);
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

              /// #appbar
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

              /// #one text
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Fill in the fields below or use camera phone",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              /// #card number
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
                      maxLength: 19,
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          counter: const Offstage(),
                          prefixIconConstraints:
                          const BoxConstraints(maxHeight: 60, maxWidth: 60),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/images/prefix.png"),
                          ),
                          border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              /// #car info
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    /// #card date
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
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: TextField(
                              maxLength: 7,
                              controller: dateController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  counter: const Offstage(),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),

                    /// #cvv
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
                              maxLength: 5,
                              controller: cvvController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                counter: const Offstage(),
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

              /// #card name
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

              /// #card buttom
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: MaterialButton(
                  height: 50,
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: addCard,
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
