import 'package:bank_app/main.dart';
import 'package:bank_app/models/card_model.dart';
import 'package:bank_app/pages/add_card_page.dart';
import 'package:bank_app/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardListPage extends StatefulWidget {
  static const String id = "/card_list_page";

  const CardListPage({Key? key}) : super(key: key);

  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> with RouteAware {
  UserList? userList;
  String data = "no data";
  List colorList = Colors.primaries;

  @override
  void initState() {
    super.initState();
    apiGetUserList();
  }

  void apiGetUserList() async {
    HttpService.GET(HttpService.API_USER_LIST, HttpService.paramEmpty()).then((response) {
      if(response != null) {
        print(response);
        parseResponse(response);
      }
    });
  }

  void parseResponse(String response) {
    setState(() {
      userList = HttpService.parseUserList(response);
    });
  }

  @override
  void didPopNext() {
    super.didPop();
    apiGetUserList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Good Morning",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                "Eugene",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              trailing: CircleAvatar(
                radius: 25,
              ),
            ),
            SizedBox(
              height: 20,
            ),

            /// #cards
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: userList!.userList.length,
              itemBuilder: (context, index) {
                return itemCardList(userList!.userList[index]);
              },
            ),

            /// #list
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddCardList.id);
              },
              child: Card(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.viewfinder,
                          size: 45,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Add new card",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCardList(CardModel card) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade600,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 50,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "VISA",
                      style: TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(card.cardNumber,style: TextStyle(fontSize: 18),),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(card.name,style: TextStyle(fontSize: 18),),
              ),
              Expanded(
                child: Text("${card.date.toString().substring(0,2)} / ${card.date.toString().substring(3,5)}"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
