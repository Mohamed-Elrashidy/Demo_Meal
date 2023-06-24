import 'package:demo_meal/domain/base_repository/base_user_repository.dart';

import '../entity/user.dart';

class GetUserInfoUseCase{
  BaseUserRepository baseUserRepository;
  GetUserInfoUseCase({required this.baseUserRepository});
 Future<User> execute()
  async {
 return await  baseUserRepository.getUserInfo( );
  }
}