

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_test/Blocs/auth_bloc/auth_events.dart';
import 'package:login_test/Blocs/auth_bloc/auth_states.dart';
import 'package:login_test/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
     AuthBloc() : super(AuthInitial()) {
       on<LoginRequested>(_onUserLoginRequest);
       on<ValidateEmailRequest>(_onValidateEmailRequest);
       on<SignInRequested>(_onUserSignInRequest);
     }

     AuthService service = AuthService()..initializeInstances();

     void _onUserLoginRequest( LoginRequested event, Emitter<AuthStates> emit) async{
          emit(AuthLoading());
          try {
            await service.loginInUserWithEmailAndPassword(email: event.email, password: event.password);
            emit(SuccessfullyLogin());
          }catch(e) {
            emit(LoginFailed(msg: "$e"));
            throw Exception("login error _onUserLoginRequest :: () = $e");
          }
     }

     void _onValidateEmailRequest( ValidateEmailRequest event, Emitter<AuthStates> emit) {

     }

     void _onUserSignInRequest(SignInRequested event, Emitter<AuthStates> emit) async{
       emit(AuthLoading());
       try {
         await service.signInUserWithEmailAndPassword(email: event.email, password: event.password,
           mobile: event.mobile, name: event.name,);
         emit(SigInSuccess());
       }catch(e) {
         emit(SigInFailed(msg: '$e'));
         throw Exception("login error _onUserLoginRequest :: () = $e");
       }
     }







}