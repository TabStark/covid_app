import 'package:covid_app/view/reusableWidget.dart';
import 'package:flutter/material.dart';

class DetailCountryCases extends StatefulWidget {
  String country_name;
  String image;
  int totalCases, totalDeaths, totalRecovered, critical, todayRecovered;
  DetailCountryCases(
      {super.key,
      required this.country_name,
      required this.critical,
      required this.image,
      required this.todayRecovered,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered});

  @override
  State<DetailCountryCases> createState() => _DetailCountryCasesState();
}

class _DetailCountryCasesState extends State<DetailCountryCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 90, 20),
        centerTitle: true,
        title: Text(
          widget.country_name,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                      child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      ReusableWidget(
                          title: "Cases", value: widget.totalCases.toString()),
                      ReusableWidget(
                          title: "Total Recovered",
                          value: widget.totalRecovered.toString()),
                      ReusableWidget(
                          title: "Total Deaths",
                          value: widget.totalDeaths.toString()),
                      ReusableWidget(
                          title: "Today Recovered",
                          value: widget.todayRecovered.toString()),
                      ReusableWidget(
                          title: "Critical", value: widget.critical.toString()),
                    ],
                  )),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
