import 'package:flutter/material.dart';

void main() {
  runApp(const NameManagerApp());
}

class NameManagerApp extends StatelessWidget {
  const NameManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "NAME MANAGER",
      theme: ThemeData(primaryColor: Colors.blue),
      home: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({super.key});

  @override
  State<_HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _names = [];
  final TextEditingController _nameController = TextEditingController();

  void _addName(String name) {
    setState(() {
      _names.add(name);
    });
    _nameController.clear();
  }

  void _editName(int index, String newName) {
    setState(() {
      _names[index] = newName;
    });
  }

  void _deleteName(int index) {
    setState(() {
      _names.removeAt(index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Name managemnent')),
      body: _selectedIndex == 0 ? _addNameScreen() : _viewNamesScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Addation"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'view'),
        ],
      ),
    );
  }

  Widget _addNameScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Enter name"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                _addName(_nameController.text);
              }
            },
            child: const Text("Add The Name"),
          ),
        ],
      ),
    );
  }

  Widget _viewNamesScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _names.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(_names[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditDialog(index), // فتح نافذة التعديل.
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.blue),
                  onPressed: () => _deleteName(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(int index) {
    TextEditingController editingController = TextEditingController(
      text: _names[index],
    );
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Name'),
            content: TextField(
              controller: editingController,
              decoration: const InputDecoration(labelText: "new name"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _editName(index, editingController.text);
                  Navigator.pop(context);
                },
                child: const Text("Edit"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
    );
  }
}
