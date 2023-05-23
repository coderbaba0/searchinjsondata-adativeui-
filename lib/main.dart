import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts Demo',
      debugShowCheckedModeBanner: false,
      home: StorageUpload(),
    );
  }
}

class StorageUpload extends StatefulWidget {
  @override
  StorageUploadState createState() => new StorageUploadState();
}

class StorageUploadState extends State<StorageUpload> {
  List results = [];

  var rows = [];
  String query = '';
  late TextEditingController tc;

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
    rows = [
      {
        'contact_name': 'Test User 1',
        'contact_phone': '066 560 4900',
      },
      {
        'contact_name': 'Test User 2',
        'contact_phone': '066 560 7865',
      },
      {
        'contact_name': 'Test User 3',
        'contact_phone': '906 500 4334',
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          " Contacts",
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: tc,
                    decoration: InputDecoration(hintText: 'Search...'),
                    onChanged: (v) {
                      setState(() {
                        query = v;
                        setResults(query);
                      });
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: query.isEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: rows.length,
                    itemBuilder: (con, ind) {
                      return ListTile(
                        title: Text(rows[ind]['contact_name']),
                        subtitle: Text(rows[ind]['contact_phone']),
                        onTap: () {
                          setState(() {
                            tc.text = rows[ind]['contact_name'];
                            query = rows[ind]['contact_name'];
                            setResults(query);
                          });
                        },
                      );
                    },
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (con, ind) {
                      return ListTile(
                        title: Text(results[ind]['contact_name']),
                        subtitle: Text(results[ind]['contact_phone']),
                        onTap: () {
                          setState(() {
                            tc.text = results[ind]['contact_name'];
                            query = results[ind]['contact_name'];
                            setResults(query);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setResults(String query) {
    results = rows
        .where((elem) =>
    elem['contact_name']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        elem['contact_phone']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}