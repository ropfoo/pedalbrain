import 'package:pedalbrain/models/pedal_data.dart';

class User {
  final String email;
  final List<PedalData> pedals;

  User({required this.email, required this.pedals});
}
