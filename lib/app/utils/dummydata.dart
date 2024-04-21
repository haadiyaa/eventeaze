import 'package:eventeaze/app/model/categorymodel.dart';

class DummyData{
  static final List<CategoryModel> categories=[
    CategoryModel(id: '1', name: 'Sports', image: 'assets/categories/sports.jpg', isFeatured: true),
    CategoryModel(id: '2', name: 'Family', image: 'assets/categories/family.jpg', isFeatured: true),
    CategoryModel(id: '3', name: 'Art', image: 'assets/categories/arts.jpg', isFeatured: true),
    CategoryModel(id: '4', name: 'Music', image: 'assets/categories/music.jpg', isFeatured: true),
    CategoryModel(id: '5', name: 'Business', image: 'assets/categories/business.jpg', isFeatured: true),

  ];
}