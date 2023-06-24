import 'package:demo_meal/data/models/user_model.dart';
import 'package:demo_meal/domain/base_repository/base_user_repository.dart';
import 'package:demo_meal/domain/entity/user.dart';
import 'package:demo_meal/utils/app_constansts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data_source/remote_data_source/remote_data_source.dart';

class UserRepository extends BaseUserRepository{
  RemoteDataSource remoteDataSource;
  UserRepository({required this.remoteDataSource});
  @override
  Future<void> signOut() async {
   await remoteDataSource.signOut();
  }

  @override
   singIn(String email, String password)async {
    try{ await remoteDataSource.signIn(email, password);}
        catch (e)
    {
      print(e);
    }
  }

  @override
  Future<UserModel> getUserInfo() async {
    // default invalid format to detect if no user data fetched

    UserModel userModel=UserModel(name: "", phone: "", email: "", address: "", level: -1);
    var user=FirebaseAuth.instance.currentUser;
    // check If I logged in successfully
    if(user!=null)
  {var users= await remoteDataSource.getDataDocumentation(AppConstants.usersPath,user.email!);
// check if get user info correct else return default user
  try{

    userModel=UserModel.fromJson(users);
  }
  catch(e)
  {
    print(e);
  }
    }

        return userModel;
  }

}