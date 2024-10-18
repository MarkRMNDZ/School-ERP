import 'package:flutter/material.dart';
import 'package:school_erp/pages/school_gallery/widgets/school_gallery_card.dart'; // Update this to the appropriate path for the gallery widget
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class SchoolGalleryPage extends StatefulWidget {
  const SchoolGalleryPage({super.key});

  @override
  _SchoolGalleryPageState createState() => _SchoolGalleryPageState();
}

class _SchoolGalleryPageState extends State<SchoolGalleryPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: "School Gallery", content: [SchoolGalleryCard()]);
  }
}
