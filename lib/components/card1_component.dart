import 'package:flutter/material.dart';

class CardBelowComponent extends StatelessWidget {
  final String text1;
  final String text2;
  final IconData img;
  final Color color1;
  final Color color2;

  const CardBelowComponent({
    super.key,
    required this.text1,
    required this.text2,
    required this.img,
    required this.color1,
    required this.color2,
  });

  static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 200,
      height: 140,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    color1,
                    color2,
                  ],
                ),
              ),
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      img,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      text1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
    
  }
}