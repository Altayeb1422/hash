
class Cars {
  final String type, img, color, transmission, fuel, name, condition, offer, location, seller, sellerLogo;
  final int model, kilometer, doors, cylinders;

  Cars({
    required this.condition,
    required this.name,
    required this.type,
    required this.img,
    required this.color,
    required this.transmission,
    required this.fuel,
    required this.model,
    required this.kilometer,
    required this.doors,
    required this.cylinders,
    required this.offer,
    required this.location,
    required this.seller,
    required this.sellerLogo
  });
}

List<Cars> cars = [
  Cars(
      img: 'assets/car 0.jpg',
      type: 'Saloon',
      fuel: 'Gasoline',
      cylinders: 4,
      model: 2018,
      kilometer: 1024,
      color: 'Black',
      transmission: 'Automatic',
      offer: "SDG 4,450,000",
      doors: 4,
      name: 'Lancer',
      condition: 'Used', location: 'Khartoum - Mecca st.', sellerLogo: 'assets/car_seller.jpg', seller: 'Noon Dealership'),
  Cars(
      img: 'assets/car 1.jpg',
      type: 'SUV',
      cylinders: 6,
      model: 2020,
      kilometer: 0,
      color: 'white',
      transmission: 'Automatic',
      offer: 'SDG 20,980,000',
      doors: 4,
      name: 'Prado',
      condition: 'New',
      fuel: 'Gasoline',
      location: 'Bhari - Ahmed Gasim',
      sellerLogo: 'assets/car_seller.jpg', seller: 'HotWheels Dealership'),
  Cars(
      img: 'assets/car 2.jpg',
      type: 'SUV',
      cylinders: 4,
      model: 2021,
      kilometer: 870,
      color: 'Pearl White',
      transmission: 'Automatic',
      offer: 'SDG 10,900,000',
      doors: 4,
      name: 'RAV-4',
      condition: 'Used',
      fuel: 'Diesel', location: 'Khartoum- Sharq Alneel',
      sellerLogo: 'assets/car_seller.jpg', seller: 'Zoom Car Dealership'),
  Cars(
      img: 'assets/car 3.jpg',
      type: 'SUV',
      cylinders: 8,
      model: 2022,
      kilometer: 0,
      color: 'White',
      transmission: 'Automatic',
      offer: 'SDG 30,000,000',
      doors: 4,
      name: 'Jeep',
      condition: 'New',
      fuel: 'Gasoline', location: 'Almamora - 30th St.',
      sellerLogo: 'assets/car_seller.jpg', seller: 'Mahjoob Lemo'),
];
