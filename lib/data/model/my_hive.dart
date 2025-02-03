import 'package:find_friend/data/model/user.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const USER = "user";

class MyHiveHelper {
  late Box box;
  MyHiveHelper() {
    box = Hive.box(USER);
  }
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(UserAdapter());
    await Hive.openBox(USER);
  }

  void setUser(User user) {
    box.clear();
    box.put(USER, user);
  }
  User getUser(){
    return box.get(USER, defaultValue: User(id: "", lat: "${41.311158}", long: "${69.279737}", name: "", email: "", password: "", image: "")) as User;
  }
  void clear() {
    box.clear();
  }
}
