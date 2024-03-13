import 'package:flutter/material.dart';
import 'secure_share_state.dart';
import 'shared_state.dart';
import 'url/registercompanyAction.dart';
import 'url/registeruseraction.dart';
import 'user/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isUser = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController companyPasswordController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController companyVatController = TextEditingController();
  TextEditingController companyCountryController = TextEditingController();
  TextEditingController companyCityController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController companyZipcodeController = TextEditingController();

  void switchForm() {
    setState(() {
      isUser = !isUser;
    });
  }

  Widget buildUserForm() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        ),
        TextField(
          controller: bioController,
          decoration: const InputDecoration(
            labelText: 'Bio',
          ),
        ),
      ],
    );
  }

  Widget buildCompanyForm() {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Company Name',
          ),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Company Email',
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Company Password',
          ),
        ),
        TextField(
          controller: companyNameController,
          decoration: const InputDecoration(
            labelText: 'Company Name',
          ),
        ),
        TextField(
          controller: companyDescriptionController,
          decoration: const InputDecoration(
            labelText: 'Company Description',
          ),
        ),
        TextField(
          controller: companyVatController,
          decoration: const InputDecoration(
            labelText: 'Company VAT',
          ),
        ),
        TextField(
          controller: companyCountryController,
          decoration: const InputDecoration(
            labelText: 'Company Country',
          ),
        ),
        TextField(
          controller: companyCityController,
          decoration: const InputDecoration(
            labelText: 'Company City',
          ),
        ),
        TextField(
          controller: companyAddressController,
          decoration: const InputDecoration(
            labelText: 'Company Address',
          ),
        ),
        TextField(
          controller: companyZipcodeController,
          decoration: const InputDecoration(
            labelText: 'Company Zipcode',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: switchForm,
              child: Text(isUser ? 'Switch to Company' : 'Switch to User'),
            ),
            const SizedBox(height: 16.0),
            isUser ? buildUserForm() : buildCompanyForm(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (isUser) {
                  var result = await registeruserCall(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      bioController.text);
                  SharedState.setBearerToken(result.token);
                  SecureSharedState.setEmail(emailController.text);
                  SecureSharedState.setPassword(passwordController.text);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const User()));
                } else {
                  var result = await RegistercompanyCall(
                      nameController.text,
                      emailController.text,
                      passwordController.text,
                      companyNameController.text,
                      companyDescriptionController.text,
                      companyVatController.text,
                      companyCountryController.text,
                      companyCityController.text,
                      companyAddressController.text,
                      companyZipcodeController.text);
                  SharedState.setBearerToken(result.token);
                  SecureSharedState.setEmail(emailController.text);
                  SecureSharedState.setPassword(passwordController.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const User()));
                }
              },
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
