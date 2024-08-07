import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'course_detail_screen.dart'; // Importe a tela de detalhes do curso
import 'about_screen.dart'; // Importe a tela Sobre
import 'contact_screen.dart'; // Importe a tela Contato

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> coursesFiscal = [];
  List<dynamic> coursesContabil = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  fetchCourses() async {
    try {
      final responseFiscal = await http
          .get(Uri.parse('https://cefis.com.br/api/v1/event?c=fiscal'));
      final responseContabil = await http
          .get(Uri.parse('https://cefis.com.br/api/v1/event?c=contabil'));

      if (responseFiscal.statusCode == 200 &&
          responseContabil.statusCode == 200) {
        setState(() {
          coursesFiscal = json.decode(responseFiscal.body)['data'];
          coursesContabil = json.decode(responseContabil.body)['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print('Error fetching courses: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToCourseDetail(int courseId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseDetailScreen(courseId: courseId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 47, 73),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 8, 171, 231), // Cor do ícone do Drawer
          size: 30, // Tamanho do ícone do Drawer
        ),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 29, 39, 59),
        title: Text(
          'Learnance',
          style: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 8, 171, 231)),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 39, 59),
              ),
              child: Text(
                'Learnance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('Contato'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        'images/text_HOME.png',
                        width: 450,
                        height: 250,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Confira nossos cursos abaixo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Categoria Fiscal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 5),
                  coursesFiscal.isEmpty
                      ? Center(child: Text('Nenhum curso encontrado'))
                      : CarouselSlider(
                          options: CarouselOptions(
                              height: 200,
                              enlargeCenterPage: true,
                              autoPlay: true),
                          items: coursesFiscal.map((course) {
                            return GestureDetector(
                              onTap: () => navigateToCourseDetail(course['id']),
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network(course['banner'],
                                        fit: BoxFit.cover,
                                        width: double.infinity),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Text(
                                        course['title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            backgroundColor: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Categoria Contábil',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 10),
                  coursesContabil.isEmpty
                      ? Center(child: Text('Nenhum curso encontrado'))
                      : CarouselSlider(
                          options: CarouselOptions(
                              height: 200,
                              enlargeCenterPage: true,
                              autoPlay: true),
                          items: coursesContabil.map((course) {
                            return GestureDetector(
                              onTap: () => navigateToCourseDetail(course['id']),
                              child: Card(
                                child: Stack(
                                  children: [
                                    Image.network(course['banner'],
                                        fit: BoxFit.cover,
                                        width: double.infinity),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Text(
                                        course['title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            backgroundColor: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
