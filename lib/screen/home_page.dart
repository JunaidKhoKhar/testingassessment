import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testingassessment/screen/details_page.dart';
import 'package:testingassessment/utils/constant.dart';
import 'package:testingassessment/utils/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference product =
      FirebaseFirestore.instance.collection('products');

  String getBrandWatch = 'Casio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.menu,
                                ))),
                        Flexible(
                          flex: 8,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: Constant.productSearch,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        ),
                      ],
                    )),
                const Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        Constant.findSuitableWatch,
                        style: TextStyle(fontSize: 30),
                      ),
                    )),
                SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: listOFBrand.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return customSelectionButton(
                            onTap: () {
                              setState(() {
                                getBrandWatch = listOFBrand[index];
                              });
                            },
                            borderColor: getBrandWatch == listOFBrand[index] ? Colors.blue  :  Colors.grey,
                            title: listOFBrand[index]);
                      },
                    )),
                Flexible(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FutureBuilder(
                        future: product
                            .doc(Constant.collectionDoc)
                            .collection(getBrandWatch)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 250, crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(data: snapshot.data!.docs[index]),));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.blue.shade100,
                                      ),

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Center(
                                                child: Hero(
                                                  tag: snapshot.data!.docs[index][Constant.imageURl],
                                                  child: Image.network(
                                                      snapshot.data!.docs[index]
                                                          [Constant.imageURl]),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    [Constant.name],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                'series ${snapshot.data!.docs[index][Constant.series]}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 8),
                                              child: Text(
                                                "\$ ${snapshot.data!.docs[index][Constant.price].toString()}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold, fontSize: 20),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
