import 'package:flutter/material.dart';
import 'package:whiskflourish/widget/navbar_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giới thiệu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //Chuyen ve home
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (context) => const NavBarWidget(),
              ),
            );
          },
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(100.0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Center(
                        child: Text(
                          'Whisk & Flourish',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Center(
                        child: Text(
                          'Phiên bản alpha',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
