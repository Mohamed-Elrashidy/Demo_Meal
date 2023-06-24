import 'package:demo_meal/domain/base_repository/base_user_repository.dart';

class SignInUseCase{
  BaseUserRepository baseUserRepository;
  SignInUseCase({required this.baseUserRepository});
  execute(String email,String password)
  async {
   await baseUserRepository.singIn( email,password);
  }
}