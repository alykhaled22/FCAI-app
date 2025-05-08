import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FakeRestaurantsItem extends StatelessWidget {
  const FakeRestaurantsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Skeletonizer(
        enabled: true,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/market.png",
                    width: 50, height: 50, fit: BoxFit.cover),
                SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fake Name",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "GT Sectra Fine"),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Fake Category",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Fake a little long Address to make it look close",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "10 km",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  color: Colors.red,
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
              thickness: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
