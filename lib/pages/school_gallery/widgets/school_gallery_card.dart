import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SchoolGalleryCard extends StatelessWidget {
  const SchoolGalleryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen height using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;

    final calculatedHeight =
        screenHeight > 800 ? screenHeight * 0.875 : screenHeight * 0.85;

    // Sample image URLs or File paths
    final List<String> imageUrls = [
      'https://via.placeholder.com/300x200',
      'https://via.placeholder.com/300x600',
      'https://via.placeholder.com/300x300',
      'https://via.placeholder.com/600x600',
      'https://via.placeholder.com/400x200',
      'https://via.placeholder.com/300x200',
      'https://via.placeholder.com/300x600',
      'https://via.placeholder.com/300x300',
      'https://via.placeholder.com/600x600',
      'https://via.placeholder.com/400x200',
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: SizedBox(
        height: calculatedHeight,
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 17.0,
          itemCount: imageUrls.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
