
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:login_test/Blocs/auth_bloc/auth_bloc.dart';
import 'package:login_test/Blocs/auth_bloc/auth_events.dart';
import 'package:login_test/Blocs/auth_bloc/auth_states.dart';
import 'package:login_test/common/global_widgets.dart';
import 'package:login_test/common/validate_factory.dart';
import 'package:login_test/repository/auth_repository.dart';
import 'package:login_test/screens/HomeScreen.dart';

import '../../widgets/auth_buttons.dart';
import '../common/color.dart';
import '../widgets/DefaultTextFeild.dart';
import '../widgets/snackbar_textwidget.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmCode = TextEditingController();
  bool obscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthStates>(
      listener: (context,state) {

        if(state is AuthLoading) {
            isLoading = true;
        }

        if(state is SigInSuccess) {
          navigateToScreen(context, HomeScreen());
        }

        if(state is SigInFailed) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              backgroundColor: commonColor,
              content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.black, text: "${state.msg}",),
            ),
          );
        }


      },
      builder: (context, snapshot) {
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
                      child: Text("Hello let'\s get started",
                        style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold, fontSize: 45.0),),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.65,
                    decoration: const BoxDecoration(color: Colors.black,
                        borderRadius:BorderRadius.only(
                            topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DefaultTextField(controller:nameController,
                              prefixWidget: Icon(CupertinoIcons.profile_circled, color: commonColor,),
                              hint: "Enter your name",),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DefaultTextField(
                              controller:emailController,
                              prefixWidget: Icon(CupertinoIcons.mail, color: commonColor,),
                              hint: "Enter your email",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DefaultTextField(
                              controller:mobileController,
                              length: 10,
                              prefixWidget: Icon(CupertinoIcons.phone_circle, color: commonColor,),
                              hint: "Enter your mobile number",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: DefaultTextField(controller:passwordController,
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
                              prefixWidget: Icon(CupertinoIcons.padlock, color: commonColor,), hint: "Enter password", max: 1,),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: isLoading ? const Center(child: CircularProgressIndicator(color: commonColor,),) : CreateAccountButton(
                              diffColor: commonColor,
                              onPressed: () async {
                                 SignInValidate(email: emailController.text, password: passwordController.text,
                                     name: nameController.text, mobile: mobileController.text).commonFunction(context);

                                 context.read<AuthBloc>().add(SignInRequested(
                                     email: emailController.text,
                                     password: passwordController.text,
                                     name: nameController.text,
                                     mobile: mobileController.text )
                                 );

                              },),
                          ),
                        ]),
                  ),
                )


              ]),
        );
      }
    );
  }
}



