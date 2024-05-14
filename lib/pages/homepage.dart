
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  final List<Team> teams = []; // step 2

  Future getTeams() async {
    // step1
    var url = Uri.https('api.balldontlie.io', '/v1/teams');
    var headers = {'Authorization': 'cbbaec0d-989f-49ec-ade4-8e96945f3238'};
    var response = await http.get(url, headers: headers);
//2 step
    var jsonData = jsonDecode(response.body);
    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: teams.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(teams[index].abbreviation),  // put the api data name
                          subtitle: Text(teams[index].city),// put the api data name
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}