import 'package:covid_app/Model/world_states_model.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/view/countiresstate.dart';
import 'package:covid_app/view/reusableWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  final ColorList = <Color>[Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Covid App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 17, 90, 20),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50,
                          controller: _controller,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: ColorList,
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 2.8,
                          animationDuration: const Duration(milliseconds: 1200),
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableWidget(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                ReusableWidget(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString()),
                                ReusableWidget(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                ReusableWidget(
                                    title: "Active",
                                    value: snapshot.data!.active.toString()),
                                ReusableWidget(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString()),
                                ReusableWidget(
                                    title: "Today's Recovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                ReusableWidget(
                                    title: "Today's Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CountriesListScreen())),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 17, 90, 20),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}
