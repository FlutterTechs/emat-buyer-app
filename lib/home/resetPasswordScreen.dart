import 'package:ebuuy/consts/consts.dart';

class ResetPasswordScreen extends StatelessWidget{
  String password;
  String email;
  ResetPasswordScreen(this.password,this.email);
  var OldPwd = TextEditingController();
  var NewPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(password);
    print(email);
    var authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        title: "Reset Password".text.bold.white.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextFeild(
              controller: OldPwd,
              title: "Old Password",
              hint: "Enter Old Password"
            ),
            customTextFeild(
              controller: NewPwd,
                title: "New Password",
                hint: "Enter New Password"
            ),
            20.heightBox,
             Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){

                },
                  child: "Using email".text.color(redColor).make().onTap(() {
                    authController.sendPasswordResetEmail(email);
                  })),
            ),
            10.heightBox,
            ourButton(
              title: "Reset Password",
              color: redColor,
              onpress: (){
                 authController.changeAuthPassword(
                   oldPassword: OldPwd.text,
                   newPassword: NewPwd.text,
                   confirmPassword: password
                 );
              },
              textColor: Colors.white
            ).box.width(context.screenWidth -70).make()
          ],
        ),
      ),
    );
  }

}