// import 'package:flutter/material.dart';
//
// class HorizontalScrollableContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           // Set a specific height for the outer container.
//           height: 200.0,
//           // The width can be as wide as the screen or a specific value.
//           width: double.infinity,
//           child: SingleChildScrollView(
//             // Set scroll direction to horizontal.
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate(
//                 10,
//                     (index) => Container(
//                   // Each container having a width of 150.0 and the same height as the outer container.
//                   width: 150.0,
//                   height: 200.0,
//                   // Adding some margin to visually separate them.
//                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                   // Changing the color based on the index.
//                   color: Colors.teal[100 * ((index % 8) + 1)],
//                   // You can add more child content here.
//                   child: Center(
//                     child: Text(
//                       'Item $index',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class CategorySelectorScreen extends StatefulWidget {
  @override
  _CategorySelectorScreenState createState() => _CategorySelectorScreenState();
}

class _CategorySelectorScreenState extends State<CategorySelectorScreen> {
  // Current selected category index. By default, it's the first one.
  int _selectedCategoryIndex = 0;

  // Example categories list
  final List<String> _categories = ['For You', 'Following', 'Popular'];

  // Example data for the list items under each category
  final List<List<String>> _categoryItems = [
    ['For You 1', 'For You 2', 'For You 3'], // Items for 'For You'
    ['Following 1', 'Following 2', 'Following 3'], // Items for 'Following'
    ['Popular 1', 'Popular 2', 'Popular 3'], // Items for 'Popular'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(height: 350,
          width: double.infinity,
          color: Colors.red,),
          // Category Tabs
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: _selectedCategoryIndex == index
                        ? Colors.blueAccent
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: _selectedCategoryIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Horizontal List for Selected Category
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categoryItems[_selectedCategoryIndex]
                    .map(
                      (item) => Container(
                    width: 160,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}