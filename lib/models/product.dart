enum ProductCategory { tire, sparePart }

class Product {
  final String id;
  final String name;
  final ProductCategory category;
  final String brand;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviews;
  final bool inStock;
  final IconSpec icon;
  final String imageUrl;

  // مواصفات خاصة بالإطارات
  final String? size; // e.g. 225/45R17
  final String? loadSpeedRating; // e.g. 94V (الحمل والسرعة يعكس القساوة/التحمل)
  final String? season; // صيفي / شتوي / كل الفصول

  // مواصفات خاصة بقطع الغيار
  final String? carMake;
  final String? carModel;
  final String? partNumber;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.reviews,
    required this.inStock,
    required this.icon,
    required this.imageUrl,
    this.size,
    this.loadSpeedRating,
    this.season,
    this.carMake,
    this.carModel,
    this.partNumber,
  });
}

/// اسم أيقونة Material مرتبط بالمنتج (لتفادي الاعتماد على صور خارجية)
class IconSpec {
  final String name;
  const IconSpec(this.name);
}

final List<Product> demoProducts = [
  const Product(
    id: 't1',
    name: 'إطار ميشلان بايلوت سبورت',
    category: ProductCategory.tire,
    brand: 'Michelin',
    price: 145,
    oldPrice: 170,
    rating: 4.8,
    reviews: 214,
    inStock: true,
    icon: IconSpec('tire'),
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Replacement_of_car_tires.jpg?width=400',
    size: '225/45R17',
    loadSpeedRating: '94V',
    season: 'صيفي',
  ),
  const Product(
    id: 't2',
    name: 'إطار بريجستون دوراڤيس',
    category: ProductCategory.tire,
    brand: 'Bridgestone',
    price: 128,
    rating: 4.6,
    reviews: 132,
    inStock: true,
    icon: IconSpec('tire'),
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Changing_car_tire_20170513_01.jpg?width=400',
    size: '215/60R16',
    loadSpeedRating: '95H',
    season: 'كل الفصول',
  ),
  const Product(
    id: 't3',
    name: 'إطار كونتيننتال وينتر',
    category: ProductCategory.tire,
    brand: 'Continental',
    price: 160,
    rating: 4.7,
    reviews: 88,
    inStock: false,
    icon: IconSpec('tire'),
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Replacement_of_car_tires.jpg?width=400',
    size: '205/55R16',
    loadSpeedRating: '91T',
    season: 'شتوي',
  ),
  const Product(
    id: 'p1',
    name: 'طقم تيل فرامل أمامي',
    category: ProductCategory.sparePart,
    brand: 'Bosch',
    price: 34,
    oldPrice: 42,
    rating: 4.5,
    reviews: 301,
    inStock: true,
    icon: IconSpec('brake'),
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Brake_pads.JPG?width=400',
    carMake: 'Toyota',
    carModel: 'Camry 2018-2023',
    partNumber: 'BP-2231',
  ),
  const Product(
    id: 'p2',
    name: 'فلتر زيت المحرك',
    category: ProductCategory.sparePart,
    brand: 'Mann Filter',
    price: 9,
    rating: 4.9,
    reviews: 512,
    inStock: true,
    icon: IconSpec('filter'),
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Oil_filter.JPG?width=400',
    carMake: 'Hyundai',
    carModel: 'Elantra 2016-2021',
    partNumber: 'MF-1187',
  ),
  const Product(
    id: 'p3',
    name: 'بطارية سيارة 70 أمبير',
    category: ProductCategory.sparePart,
    brand: 'Varta',
    price: 76,
    rating: 4.7,
    reviews: 175,
    inStock: true,
    icon: IconSpec('battery'),
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Car_battery.jpg?width=400',
    carMake: 'عام',
    carModel: 'يناسب أغلب السيارات',
    partNumber: 'VB-70A',
  ),
];
