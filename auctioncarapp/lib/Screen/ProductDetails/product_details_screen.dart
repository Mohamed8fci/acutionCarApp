import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _user = FirebaseAuth.instance.currentUser;
  var _fireStoreInstance = FirebaseFirestore.instance;
  List bids = [];
  final itemPriceController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  Future addBid() async {
    final db = FirebaseFirestore.instance
        .collection('Items')
        .doc(widget._product['documentId'])
        .collection('Bid')
        .add({
      'price': itemPriceController.text,
      'userEmail': _user!.email,
      'userPhoto': _user!.photoURL,
      'userName': _user!.displayName,
    });
    print("data add Complete");
  }

  fetchBid() async {
    QuerySnapshot qn = await _fireStoreInstance
        .collection("Items")
        .doc(widget._product['documentId'])
        .collection('Bid')
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        bids.add({
          "documentId": qn.docs[i].id,
          "userEmail": qn.docs[i]["userEmail"],
          "price": qn.docs[i]["price"],
          "userPhoto": qn.docs[i]["userPhoto"],
          "userName": qn.docs[i]["userName"],
        });
      }
    });

    // return list;
  }

  void initState() {
    super.initState();
    fetchBid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                  aspectRatio: 3,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2Fyc3xlbnwwfHwwfHw%3D&w=1000&q=80',
                    fit: BoxFit.fitWidth,
                  )),
              SizedBox(
                height: 5,
              ),
              Text(
                widget._product['title'],
                style: TextStyle(
                    color: textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                widget._product['desc'],
                style: TextStyle(
                    color: textColor1,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Bid End : "
                "end in 2 days",
                style: TextStyle(color: textColor1, fontSize: 10),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Min: " "${widget._product['price'].toString()}" " EGP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.red),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLines: 1,
                minLines: 1,
                style: TextStyle(color: textColor1),
                controller: itemPriceController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                //maxLength: 11,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Amount';
                  } else {
                    /*if(value < Min price ){
                              return null;
                            }else{
                              return 'Please Getter Then minimum price ';
                            }*/

                    return null;
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter Ammount',
                    hintStyle: TextStyle(fontSize: 10, color: textColor1),
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 300,
                height: 30,
                child: ElevatedButton(
                  // onPressed: () {
                  //   final isValid = _keyForm.currentState!.validate();
                  //   if (!isValid==true) {
                  //     print("Please Input Something ");
                  //   }
                  //   else
                  //   {
                  //     addBid().then((value){
                  //       itemPriceController.clear();
                  //     });
                  //
                  //   }
                  //   _keyForm.currentState!.save();
                  //
                  // },
                  onPressed: () {
                    addBid().then((value) =>
                        {print("Bid Add"), itemPriceController.clear()});
                  },
                  child: Text(
                    "Bid",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    elevation: 10,
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: bids.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: itemCardColor,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${bids[index]["userPhoto"]}"),
                                  )),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${bids[index]["userName"]}",
                                  style: TextStyle(
                                      color: textColor1.withOpacity(1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${bids[index]["price"].toString()}" " EGP",
                                  style: TextStyle(
                                      color: textColor1, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
