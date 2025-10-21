class UserEntity {
  String id="";
  final String userName;
  final String email;
  final String avatarUrl;
  int level = 0;

  UserEntity({required this.email, required this.userName,this.id="",this.level=0,this.avatarUrl=""});

  UserEntity copyWith({String? userName, String? email, int? level, String? id,String? avatarUrl}) {
    return UserEntity(
      id: id ?? this.id, 
      level:level ?? this.level,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return "UserName: $userName , Email: $email , Level: $level, ID:$id , Avatar url:$avatarUrl";
  }
}
