import 'package:flutter/material.dart';
import 'package:footware_client/controller/login_%20controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/widgets/otp_txt_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create Your Account !!", style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple
              ),
              ),
              const SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNameCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: 'Your Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNumberCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: 'Mobile Number',
                  hintText: 'Enter Your mobile number',
                ),
              ),
              SizedBox(height: 20,),
              OtpTextField(otpController: ctrl.otpController,
                  visble:ctrl.otpFieldShow,
              onComplete: (otp){
                ctrl.otpEnter=int.tryParse(otp ?? "0000");
              },),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                if (ctrl.otpFieldShow) {
                  ctrl.addUser();
                } else {
                  ctrl.sendOtp();
                }
              },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(ctrl.otpFieldShow?'Register':"Send OTP")),
              TextButton(onPressed: () {
                Get.to(const LoginPage());
              },
                  child: const Text('Login'))
            ],
          ),
        ),
      );
    });
  }
}