import 'package:firebase_auth/firebase_auth.dart';
import 'package:imagine_swe/authentication/models/usermodel.dart';
import 'package:imagine_swe/repository/user_repository.dart';

class profile_controller {
  final _user = FirebaseAuth.instance.currentUser;
  final _UserRepo = user_repository();

  getUserData() {
    final email = _user!.email;
    return _UserRepo.getUserDetails(email!);
  }
  updateUserData(usermodel user) async {
    await _UserRepo.updateUser(user);
  }

  getCurrentUserId() {}
}

