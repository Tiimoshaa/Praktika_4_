import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Странички',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[800],
        ),
      ),
      home: const MyHomePage(title: 'Странички'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  List<String> groups = List.generate(10, (index) => '${index + 1}');
  List<String> students = List.generate(10, (index) => '${index + 10}');
  List<String> groups2 = List.generate(10, (index) => '${index + 20}');

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void removeItem(int index) {
    setState(() {
      if (_currentIndex == 0) {
        groups.removeAt(index);
      } else if (_currentIndex == 1) {
        students.removeAt(index);
      } else {
        groups2.removeAt(index);
      }
    });
  }

  void addItem() {
    setState(() {
      if (_currentIndex == 0) {
        groups.add('123');
      } else if (_currentIndex == 1) {
        students.add('456');
      } else {
        groups2.add('789');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentList;
    if (_currentIndex == 0) {
      currentList = groups;
    } else if (_currentIndex == 1) {
      currentList = students;
    } else {
      currentList = groups2;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _currentIndex == 0
          ? Column(
        children: [
          for (var item in currentList)
            ListTile(
              title: Text(item),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => removeItem(currentList.indexOf(item)),
              ),
            ),
        ],
      )
          : _currentIndex == 1
          ? ListView.builder(
        itemCount: currentList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currentList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeItem(index),
            ),
          );
        },
      )
          : ListView.separated(
        itemCount: currentList.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currentList[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeItem(index),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '1 (Column)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '2 (ListView.builder)',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '3 (ListView.separated)',
          ),
        ],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey[800],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        tooltip: 'Добавить',
        child: Icon(Icons.add),
      ),
    );
  }
}
