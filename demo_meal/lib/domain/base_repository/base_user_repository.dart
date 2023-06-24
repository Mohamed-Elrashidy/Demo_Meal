import '../entity/user.dart';

abstract class BaseUserRepository
{
   Future singIn(String email,String password);
  Future signOut();
   Future<User> getUserInfo();
}