import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm_practice_app/res/components/contact.dart';
import 'package:mvvm_practice_app/res/my_app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardScreen extends StatefulWidget {
  final petimage;

  var username;
  String contact_no;
  var petname;
  var petDescription;
  var petAvalability;
  int price;
  int userId;
  String userImage;

  OnBoardScreen(
      {required this.petimage,
      required this.username,
      required this.petname,
      required this.petDescription,
      required this.petAvalability,
      required this.price,
      required this.userId,
      required this.userImage,
      required this.contact_no,
      super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var petimage;
  var username;
  var petname;
  var petDescription;
  var petAvalability;
  var price;
  var userImage;
  var userid;
  var contact_no;

  @override
  void initState() {
    petimage = widget.petimage;
    username = widget.username;
    petname = widget.petname;
    petDescription = widget.petDescription;
    petAvalability = widget.petAvalability;
    price = widget.price;
    userid = widget.userId;
    userImage = widget.userImage;
    contact_no = widget.contact_no;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(backgroundColor: MyColors.kPrimary),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(alignment: Alignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.network(
                    widget.petimage,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),

              // arrow back button
              Padding(
                padding: EdgeInsets.only(
                  top: 48,
                  left: 32,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: MyColors.kSecondary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: MyColors.kPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //for radius on top of bottom container ,the one after the piture
              Positioned(
                bottom: 0,
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(29),
                        topRight: Radius.circular(29),
                      ),
                      color: MyColors.kSecondary),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: MyColors.kSecondary),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundImage:
                            widget.userImage == null || widget.userImage == "no"
                                ? AssetImage('assets/images/pet.jpg')
                                    as ImageProvider<Object>
                                : NetworkImage(
                                    widget.userImage,
                                  ),
                        radius: 40,
                      ),
                    ),
                  ))
            ]),
          ),
          Expanded(
              flex: 2,
              child: Container(
                color: MyColors.kSecondary,
                width: double.infinity,
                // height: double.infinity,
                child: Column(
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                          color: MyColors.kPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(29),
                          ),
                          color: MyColors.KWhite),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(widget.petname,
                                      style: TextStyle(
                                        color: MyColors.kPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Spacer(),
                                  Text(
                                      widget.petAvalability == 'Yes'
                                          ? "Available"
                                          : "Sold Out",
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 50,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  // width: MediaQuery.of(context).size.width / 1.6,
                                  child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Text(
                                        widget.petDescription,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ))),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 50,
                              ),
                              Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(
                                      'assets/images/rupee-sign.png',
                                    ),
                                    color: MyColors.kPrimary,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        widget.price.toString(),
                                        style: TextStyle(
                                          color: MyColors.kPrimary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25))),
                            context: context,
                            builder: (context) => ContactBottomModel(
                                  buttonOneTitle: 'Whats App',
                                  whatsapp_no: contact_no,
                                  buttonTwoTitle: 'Phone Call',
                                  phone_no: contact_no,
                                ));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(29),
                            ),
                            color: MyColors.KWhite),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Take me home",
                                          style: TextStyle(
                                            color: MyColors.kPrimary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                        color: MyColors.kPrimary,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void _openWhatsApp(String phoneNumber) async {
    String url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openPhoneDialer(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
