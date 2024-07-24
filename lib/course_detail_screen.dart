import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  CourseDetailScreen({required this.courseId});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Map<String, dynamic>? courseDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  fetchCourseDetails() async {
    try {
      final response = await http.get(
          Uri.parse('https://cefis.com.br/api/v1/event/${widget.courseId}'));

      if (response.statusCode == 200) {
        setState(() {
          courseDetails = json.decode(response.body)['data'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load course details');
      }
    } catch (e) {
      print('Error fetching course details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 47, 73),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 39, 59),
        title: Text('Detalhes do Curso',
            style: TextStyle(color: Color.fromARGB(255, 8, 171, 231))),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : courseDetails == null
              ? Center(child: Text('Detalhes do curso não encontrados'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(courseDetails!['banner']),
                        SizedBox(height: 16),
                        Text(
                          courseDetails!['title'],
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          courseDetails!['subtitle'],
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Resumo:',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          courseDetails!['resume'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Objetivo:',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          courseDetails!['goal'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
