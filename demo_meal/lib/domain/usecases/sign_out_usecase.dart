import 'package:demo_meal/domain/base_repository/base_user_repository.dart';

class SignOutUseCase{
  BaseUserRepository baseUserRepository;
  SignOutUseCase({required this.baseUserRepository});
  execute()
  async {
    await baseUserRepository.signOut();
  }
}