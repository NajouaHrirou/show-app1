import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'add_show_page.dart';
import 'update_show_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> shows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchShows();
  }

  // 🔹 Fonction pour récupérer les shows depuis l'API
  Future<void> fetchShows() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/shows'));

      if (response.statusCode == 200) {
        setState(() {
          shows = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load shows")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // 🔹 Fonction pour supprimer un show
  Future<void> deleteShow(int id) async {
    try {
      final response = await http.delete(Uri.parse('${ApiConfig.baseUrl}/shows/$id'));

      if (response.statusCode == 200) {
        fetchShows(); // Rafraîchir la liste après suppression
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete show")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // 🔹 Fonction pour afficher une boîte de confirmation avant suppression
  void confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Show"),
        content: const Text("Are you sure you want to delete this show?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteShow(id);
            },
            child: const Text("Yes, Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Show App")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
            ),
            ListTile(
              title: const Text("Add Show"),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddShowPage()),
                );
                if (result == true) {
                  fetchShows(); // Rafraîchir après ajout
                }
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Affichage du chargement
          : RefreshIndicator(
              onRefresh: fetchShows,
              child: ListView.builder(
                itemCount: shows.length,
                itemBuilder: (context, index) {
                  final show = shows[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: show['image'] != null
                          ? Image.network('${ApiConfig.baseUrl}${show['image']}',
                              width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.image),
                      title: Text(show['title']),
                      subtitle: Text(show['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 🔹 Bouton Modifier (Update Show)
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UpdateShowPage(show: show)),
                              );
                              if (result == true) {
                                fetchShows(); // Rafraîchir après modification
                              }
                            },
                          ),
                          // 🔹 Bouton Supprimer (Delete Show)
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => confirmDelete(show['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
