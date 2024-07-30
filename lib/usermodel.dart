class Address {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final String country;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      stateCode: json['stateCode'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }
}

class Company {
  final String department;
  final String name;
  final String title;
  final Address address;

  Company({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      department: json['department'],
      name: json['name'],
      title: json['title'],
      address: Address.fromJson(json['address']),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String birthDate;
  final String imageUrl;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;
  final String hairColor;
  final String hairType;
  final String ip;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.imageUrl,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
    required this.hairType,
    required this.ip,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      maidenName: json['maidenName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      birthDate: json['birthDate'],
      imageUrl: json['image'] ?? 'https://i.pravatar.cc/150?img=${json['id']}',
      bloodGroup: json['bloodGroup'],
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      eyeColor: json['eyeColor'],
      hairColor: json['hair']['color'],
      hairType: json['hair']['type'],
      ip: json['ip'],
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }
}
