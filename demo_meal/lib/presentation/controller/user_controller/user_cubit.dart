import 'package:bloc/bloc.dart';
import 'package:demo_meal/data/repository/user_repository.dart';
import 'package:demo_meal/domain/usecases/get_user_info_usecase.dart';
import 'package:demo_meal/domain/usecases/sign_in_usecase.dart';
import 'package:demo_meal/domain/usecases/sign_out_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/user.dart';


part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email,String password)
  async {
    // first we sign in
    await SignInUseCase( baseUserRepository: GetIt.instance.get<UserRepository>()).execute(email, password);

     User userInfo = await GetUserInfoUseCase(baseUserRepository: GetIt.instance.get<UserRepository>()).execute();
      // check if real user or default user detected
     if(userInfo.email!="")
       {
         emit(UserInfoLoaded(user: userInfo));
       }

  }
  Future<void> signOut()
  async {
  await  SignOutUseCase(baseUserRepository: GetIt.instance.get<UserRepository>());
  emit(UserLoggedOut());
  }


}