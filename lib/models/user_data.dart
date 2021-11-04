import 'package:pedalbrain/models/pedal_data.dart';

class UserData {
  final String email;
  final List<PedalData> pedals;

  UserData({required this.email, required this.pedals});
}
