import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/auth_buttons.dart';
import '../Blocs/auth_bloc/auth_bloc.dart';
import '../Blocs/auth_bloc/auth_events.dart';
import '../Blocs/auth_bloc/auth_states.dart';
import '../common/color.dart';
import '../common/global_widgets.dart';
import '../common/validate_factory.dart';
import '../widgets/DefaultTextFeild.dart';
import '../widgets/snackbar_textwidget.dart';
import 'HomeScreen.dart';
import 'Signup_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obscure = true;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthStates>(
      listener: (context, state) {
        if(state is AuthLoading) {
          isLoading = true;
        }

        if(state is LoginFailed) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: commonColor,
              content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.black, text: "${state.msg}",),
            ),
          );
        }


        if(state is SuccessfullyLogin) {
          navigateToScreen(context, HomeScreen());
        }

      },
      builder: (context, state) {

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.yellowAccent),
                  child: Padding(
                    padding: const EdgeInsets.only(top:88.0,left: 25.0, right: 25.0),
                    child: SizedBox.shrink(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Already registered login to continue",
                            style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 45.0),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                style: GoogleFonts.ubuntu(fontWeight: FontWeight.normal, fontSize: 15.0),),
                              InkWell(
                                onTap: () {
                                  navigateToScreen(context, SignupScreen());
                                },
                                child: Text("Sign In",
                                  style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 15.0),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.45,
                    decoration: const BoxDecoration(color: Colors.black,
                        borderRadius:BorderRadius.only(
                            topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DefaultTextField(controller:emailController,
                              prefixWidget: const Icon(Icons.account_box, color: commonColor, ), hint: "Enter your email",),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DefaultTextField(controller:passwordController, max: 1,
                              suffixWidget: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if(obscure){
                                        obscure = false;
                                      }else{
                                        obscure = true;
                                      }

                                    });
                                  },
                                  child: Icon(obscure? CupertinoIcons.eye_slash: CupertinoIcons.eye_fill, color: commonColor,)),
                              pass: obscure,
                              prefixWidget: const Icon(CupertinoIcons.padlock, color: commonColor,), hint: "Enter password",),
                          ),

                          isLoading ? const Center(child: CircularProgressIndicator(color: commonColor,),)
                              : LoginAccountButton(
                              color: commonColor,
                              onPressed: (){
                                 Validate(email: emailController.text, password: passwordController.text).commonFunction(context);
                                 context.read<AuthBloc>().add(
                                     LoginRequested(email: emailController.text, password: passwordController.text)
                                 );
                              }
                          )


                        ]),
                  ),
                )


              ]),
        );
      }
    );
  }
}

