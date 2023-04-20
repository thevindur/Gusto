import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildGridTile('Tile 1'),
                _buildGridTile('Tile 2'),
                _buildGridTile('Tile 3'),
                _buildGridTile('Tile 4'),
                _buildGridTile('Tile 5'),
                _buildGridTile('Tile 6'),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildGridTile('Tile 7'),
                _buildGridTile('Tile 8'),
                _buildGridTile('Tile 9'),
                _buildGridTile('Tile 10'),
                _buildGridTile('Tile 11'),
                _buildGridTile('Tile 12'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridTile(String text) {
    return GridTile(
      child: Container(
        color: Colors.grey[300],
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
