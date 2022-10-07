import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_movies_clean_arciteture/src/features/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
  }) : super(
          name: name,
          email: email,
          uid: uid,
          status: status,
          password: password,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      status: snapshot.get('status'),
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      uid: snapshot.get('uid'),
      password: snapshot.get('password'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "name": name,
      "email": email,
      "uid": uid,
      "password": password,
    };
  }
}
