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
  List<CardModel> cards = [];

  void _apiPostList() {
    HttpService.GET(HttpService.API_LIST, HttpService.paramsEmpty()).then((response) => {
      _showResponse(response!),
    print("List::::::::: ${cards.length}")
    });
  }

  void _showResponse(String response) {
    List<CardModel> list = HttpService.parseResponse(response);
    setState(() {
      cards = list;
    });
  }

  delete(String id,int index)async{
    await HttpService.DEL(HttpService.API_DELETE + id, HttpService.deleteParam(id)).then((value) => {
    setState(() {
    }),
      _apiPostList(),
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPostList();
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
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 10),
            child: ListTile(
              title: Text("Good Morning",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
              subtitle: Text("Eugene",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
              trailing: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/profil.jpg"),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            /// #cards
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return itemCardList(index);
              },
            ),

            /// #list
            GestureDetector(
              onTap: () async {
                var result = await Navigator.of(context).pushNamed(AddCardList.id);
                if (result != null && result == true) {
                  _apiPostList();
                }
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
                          CupertinoIcons.add_circled,
                          size: 50,
                        ),
                        SizedBox(
                          height: 10,
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

  /// #item card
  Widget itemCardList(int index) {
    return Dismissible(
      key: ValueKey(cards[index]),
        child: Container(
          height: 220,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade900,
                ]
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// #visa card
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 45,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                    Colors.grey.withOpacity(1),
                                    Colors.white.withOpacity(0.5),
                                  ]
                              )
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
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

              /// #card number
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(cards[index].cardNumber.substring(0,4),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                    Expanded(
                      child: Text(cards[index].cardNumber.substring(5,9),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                    Expanded(
                      child: Text(cards[index].cardNumber.substring(10,14),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                    Expanded(
                      child: Text(cards[index].cardNumber.substring(15,19),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

              /// #card infosi
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CARD HOLDER",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text(cards[index].cardName,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("EXPIRES",style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text(cards[index].cardDate,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      confirmDismiss: (DismissDirection direction) async {
        _alertDialog(index);
      }
    );
  }

  void _alertDialog(int index) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this card?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel")
            ),
            TextButton(
              onPressed: () {
                delete(cards[index].id!,index);
                _apiPostList();
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}


