//rename user to myuser bcs firebase change to you user
class MyUser {
  MyUser({
    this.uid,
    this.name,
    this.photoUrl,
    this.email,
    this.isNewUser,
    this.isDoctor,
    this.specialization,
    this.bio,
  });
  final String uid;
  final String name;
  final String email;
  final bool isDoctor;
  final String specialization;
  final String bio;
  final String photoUrl;
  final bool isNewUser; //get it from user firebase not stream

  factory MyUser.fromMap(Map<dynamic, dynamic> value, String id) {
    return MyUser(
      uid: id,
      name: value['name'],
      email: value['email'],
      isDoctor: value['isDoctor'],
      specialization: value['specialization'],
      bio: value['bio'],
      photoUrl: value['photoUrl'],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'isDoctor': isDoctor,
      'specialization': specialization,
      'bio': bio,
      'photoUrl': photoUrl,
    };
  }
}
