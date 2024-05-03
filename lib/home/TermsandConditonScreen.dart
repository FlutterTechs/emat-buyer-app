import 'package:ebuuy/consts/consts.dart';

class TermsAndConditionScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: redColor,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        title: "Terms & Condition".text.white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Text("Welcome to Emart By accessing our application or using our services, you agree to comply with the following terms and conditions. Please read them carefully."),
            10.heightBox,
            "1 User Agreement: ".text.bold.make(),
            Text("You must be at least 18 years old to use our services. Prohibited activities include hacking, spamming, and any unlawful behavior."),
            10.heightBox,

            "2 Registration and Accounts:  ".text.bold.make(),
            Text("ou agree to provide accurate information when creating an account and to keep your password secure. You are responsible for all activities that occur under your account."),
            10.heightBox,

            "3 Product Information:".text.bold.make(),
            Text("While we strive for accuracy, product descriptions, pricing, and availability may contain errors. We reserve the right to correct any inaccuracies."),
            10.heightBox,

            "4 Ordering Process: ".text.bold.make(),
            Text("Placing an order constitutes an offer to purchase. We reserve the right to refuse or cancel orders at our discretion. Payment methods accepted are [list payment methods]."),
            10.heightBox,

            "5 Shipping and Delivery:".text.bold.make(),
            Text("Shipping rates and delivery times vary. International shipping is available, subject to additional terms. Customers are responsible for inspecting and accepting deliveries."),
            10.heightBox,

            "6 Returns and Refunds: ".text.bold.make(),
            Text("Returns and exchanges are accepted under certain conditions. Refunds are processed according to our refund policy. Defective or damaged products will be replaced or refunded."),
            10.heightBox,

            "7 Intellectual Property Rights: ".text.bold.make(),
            Text("All content on our website, including logos and images, is owned by us. Unauthorized use is prohibited."),
            10.heightBox,

            "8 Privacy Policy: ".text.bold.make(),
            Text("We collect and use customer information in accordance with our privacy policy, which outlines data protection measures and customer rights."),
            10.heightBox,

            "9 Liability and Disclaimers:".text.bold.make(),
            Text(" We are not liable for any damages beyond the purchase price. We disclaim warranties and guarantees to the extent permitted by law."),
            10.heightBox,

            "10 Termination of Services: ".text.bold.make(),
            Text("We may terminate services or accounts for violations of these terms. Customers may also terminate services according to our cancellation policy."),
            10.heightBox,
            "11 Governing Law and Dispute Resolution: ".text.bold.make(),
            Text("These terms are governed by [Jurisdiction]'s laws. Disputes will be resolved through arbitration or mediation."),
             10.heightBox,
            "12 Changes to Terms and Conditions: ".text.bold.make(),
            Text("We reserve the right to update these terms. Changes will be communicated to customers."),




          ],
        ),
      ),
    );
  }

}

