import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testingassessment/utils/constant.dart';

class DetailsPage extends StatefulWidget {

  final QueryDocumentSnapshot<Map<String, dynamic>> data;

  const DetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(

            children: [
              Hero(
                tag: widget.data[Constant.imageURl],
                child: SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * .4,
                    child: Image.network(widget.data[Constant.imageURl])),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.data[Constant.name]} ${Constant.series} ${widget.data[Constant.series]}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 8),
                    child: Text(
                      "\$ ${widget.data[Constant.price].toString()}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),

              const Text('Details : ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),


               Text('${widget.data[Constant.details]}', style: const TextStyle(fontSize: 15),),


            ],
          ),
        ),
      ),
    );
  }
}
