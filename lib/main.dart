import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Jonathan I De Guzman', 'Dumpay, Basista, Pangasinan', 'March 21, 2002',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/337521870_807131840967066_6432217150994845262_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHoEi-5BmtRrgFtjplBOcLVbrp5L_Fm9b9uunkv8Wb1v_hL3vs7vXXGx4F1yn1O3BRP2hI6E2k_3bCKVvxwzw6V&_nc_ohc=opGasJRbUXIAX9A1PWG&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfDn5iAlNiMok1IqLYiBVxGT939uzP3vf1Z2IIuJQlLIkg&oe=6450EF29'),
    Person('Edrysa Lucena', 'Mapolopolo, Basista, Pangasinan', 'November 2, 2005',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/329612113_674116901067285_3481394974332228678_n.jpg?stp=cp6_dst-jpg&_nc_cat=103&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGX7R7czrFEEgtTyvvIQxvyR_zRRhOxlrhH_NFGE7GWuClZANR4fSn6RhKJN74oGd03A2n5zkrGZeQQhorFkinP&_nc_ohc=aY5YiBBiFsMAX-uT8Ar&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfB_RfY3VUx3sBD_Iju9dCcD3NwFhGne_XXk-4EdaUNo9g&oe=6450E902'),
    Person('Joshua I De Guzman', 'Dumpay, Basista, Pangasinan', 'January 20, 2005',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/326188144_1113022862724142_5709827841482573842_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_eui2=AeGIJ9q6osnlJrrVgavxIfOZ9f5f1VWe7PX1_l_VVZ7s9Tr9tBl7CDIRUA3wFEO7LtlIFjkpFlME5-JLI2YpNiiE&_nc_ohc=w7i-m88QHAUAX8ct71T&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfDHelJdh13JxFiaURl-D7I80Oecfo5qO54Cu_bgQm2EOw&oe=6452CD58'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'midExam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tit.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 5, 5),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 12, 12),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 22, 21, 21),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
