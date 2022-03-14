import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sm_to_do_list/common/styles.dart';

class AboutMe extends StatelessWidget {
  static const ROUTE_NAME = '/about-me';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Me"),
          backgroundColor: Colors.blue[900],
        ),
        // backgroundColor: Colors.blue[100],
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff022D75FF), Colors.blueAccent],
                        )),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 45 / 100,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    "https://csui2020.github.io/static/img/buku_angkatan/SR50.jpg",
                                  ),
                                  radius:
                                      MediaQuery.of(context).size.height / 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Sabyna Maharani",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "Sabyn",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.00, horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Hobbies",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20.0,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Belajar hal baru",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Tidur",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Berkhayal di isekai :)",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Contact Me",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 20.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                  color: kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Instagram: @sabyn_",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.contact_phone_outlined,
                                  color: kPrimaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    "Phone: (+62)82363211681",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  color: kPrimaryColor,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Email: sabynamaharani@gmail.com",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
