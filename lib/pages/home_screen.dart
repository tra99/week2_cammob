import 'package:flutter/material.dart';
import 'package:test_week2/components/card_component.dart';
import 'package:test_week2/models/home_data/reponse_home_data.dart';
import 'package:test_week2/services/home_data_service.dart';

import '../components/card1_component.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("នាម​ កត្តនាម",style: TextStyle(color: Colors.white,fontSize: 14),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on,color: Colors.white,size: 20,),
                Text("ឃុំ ភូមិ",style: TextStyle(color: Colors.white,fontSize: 14),)
              ],
            )
          ],
        ),
        backgroundColor: Colors.blue,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10,top: 8,bottom: 8),
          child: CircleAvatar(),
        ),
      ),
      body: FutureBuilder<ReponseHomeData>(
        future: fetchHomeData(context),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }else if(snapshot.hasData){
            final data=snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Column(
                    children: [
                      CardComponent(
                        text1: "កសិករ",
                        text2: "${data.totalServices.farmerCount} នាក់",
                        img: const AssetImage("assets/png/farmer-removebg-preview.png"),
                        color1: const Color.fromARGB(255, 73, 120, 209),
                        color2: const Color.fromARGB(255, 38, 67, 117),
                      ),
                      CardComponent(
                        text1: "កសិករ",
                        text2: "${data.totalServices.supplierCount} នាក់",
                        img: const AssetImage("assets/png/money.png"),
                        color1: const Color.fromARGB(255, 73, 120, 209),
                        color2: const Color.fromARGB(255, 38, 67, 117),
                      ),
                      CardComponent(
                        text1: "កសិករ",
                        text2: "${data.totalServices.buyerCount} នាក់",
                        img: const AssetImage("assets/png/vegetable.png"),
                        color1: const Color.fromARGB(255, 120, 189, 238),
                        color2: const Color.fromARGB(255, 35, 152, 188),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "មុខងារបន្ថែម",
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                            ),
                          ),
                          Row(
                            children:  [
                              Flexible(
                                child: CardBelowComponent(
                                  text1: "បញ្ហាប្រឈម",
                                  text2: '${data.totalServices.challengeCount}',
                                  img: Icons.stop_circle_outlined,
                                  color1: const Color.fromARGB(255, 151, 74, 20),
                                  color2: const Color.fromARGB(255, 235, 166, 3),
                                ),
                              ),
                              Flexible(
                                child: CardBelowComponent(
                                  text1: "ពំនុះកាត់ទទឹងដី",
                                  text2: "${data.totalServices.transectCount}",
                                  img: Icons.follow_the_signs_rounded,
                                  color1: const Color.fromARGB(255, 120, 189, 238),
                                  color2: const Color.fromARGB(255, 35, 152, 188),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else{
            return Container();
          }
        },
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ទំព័រដើម',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_outlined),
            label: 'របាយការណ៍',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'វេទិកា',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'បណ្ណាល័យ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'ផ្សេងៗ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 42, 117, 203),
        onTap: _onItemTapped,
      ),
    );
  }
}
