import 'package:equatable/equatable.dart';

class MultiLogin extends Equatable {
  const MultiLogin({
    required this.image,
    required this.username,
    required this.name,
    required this.tag,
    required this.password,
  });
  final String image;
  final String username;
  final String name;
  final String tag;
  final String password;

  @override
  List<Object> get props => [
        image,
        username,
        name,
        tag,
        password,
      ];
}
