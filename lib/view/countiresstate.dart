import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/view/detail_country_cases.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 90, 20),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 70,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: 70,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 70,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (_searchController.text.isEmpty) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailCountryCases(
                                              country_name: snapshot
                                                  .data![index]['country'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                            ))),
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Image(
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              );
                            } else if (name.toLowerCase().contains(
                                _searchController.text.toLowerCase())) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailCountryCases(
                                              country_name: snapshot
                                                  .data![index]['country'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                            ))),
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Image(
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ],
      )),
    );
  }
}
