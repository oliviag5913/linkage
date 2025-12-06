class AppUser {
  final String uid;
  final String email;
  final String name;
  final String ageGroup; // "Senior" or "Youth"
  final String location;
  final List<String> hobbies;
  final List<String> interests;
  final String pastJobs;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.ageGroup,
    required this.location,
    required this.hobbies,
    required this.interests,
    required this.pastJobs,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'ageGroup': ageGroup,
      'location': location,
      'hobbies': hobbies,
      'interests': interests,
      'pastJobs': pastJobs,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      ageGroup: map['ageGroup'] ?? 'Senior',
      location: map['location'] ?? '',
      hobbies: List<String>.from(map['hobbies'] ?? []),
      interests: List<String>.from(map['interests'] ?? []),
      pastJobs: map['pastJobs'] ?? '',
    );
  }
}