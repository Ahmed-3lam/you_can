import 'package:you_can/Models/user.dart';
import 'package:you_can/Services/Auth/api_path.dart';
import 'package:you_can/Services/Auth/firestore_servies.dart';

abstract class Database {
  Future<void> setUser(MyUser user, String uid);
}

class FireStoreDatabase implements Database {
  final _service = FireStoreService.instance;

  @override
  Future<void> setUser(MyUser user, String uid) async => await _service.setData(
        path: APIPath.users(uid),
        data: user.toMap(),
      );
}
