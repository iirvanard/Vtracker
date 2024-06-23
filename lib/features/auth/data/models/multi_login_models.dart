import 'package:equatable/equatable.dart';

class AccountLogin extends Equatable {
  const AccountLogin({
    this.image,
    required this.name,
    required this.tag,
    required this.username,
    required this.password,
  });
  final String? image;
  final String name;
  final String tag;
  final String username;
  final String password;

  @override
  List<Object?> get props => [image, name, tag, username, password];

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "tag": tag,
        "username": username,
        "password": password,
      };

  factory AccountLogin.fromMap(Map<String, dynamic> map) => AccountLogin(
        image: map['image'],
        name: map['name'],
        tag: map['tag'],
        username: map['username'],
        password: map['password'],
      );

  factory AccountLogin.fromEntity(AccountLogin account) => AccountLogin(
        image: account.image,
        name: account.name,
        tag: account.tag,
        username: account.username,
        password: account.password,
      );

  AccountLogin toEntity() {
    return AccountLogin(
      image: image,
      name: name,
      tag: tag,
      username: username,
      password: password,
    );
  }
}
