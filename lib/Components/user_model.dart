import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String profilePictureUrl;
  String role;
  DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
    required this.role,
    this.createdAt,
  });

  // Factory constructor to create a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePictureUrl: map['profilePictureUrl'] ?? '',
      role: map['role'] ?? 'user', // Default to 'user' if role is not specified
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null, // Convert Firestore Timestamp to DateTime
    );
  }

  // Method to convert UserModel to a map (e.g., for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
