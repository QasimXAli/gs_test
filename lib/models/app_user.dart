
//Thoughts: Using json_serializable/freezed would be overkill for this simple model
//and I prefer to keep the dependencies minimal

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}