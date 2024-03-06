import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
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
          decoration: InputDecoration(
            labelText: 'Name',
          ),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
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
          controller: companyNameController,
          decoration: InputDecoration(
            labelText: 'Company Name',
          ),
        ),
        TextField(
          controller: companyEmailController,
          decoration: InputDecoration(
            labelText: 'Company Email',
          ),
        ),
        TextField(
          controller: companyPasswordController,
          decoration: InputDecoration(
            labelText: 'Company Password',
          ),
        ),
        TextField(
          controller: companyDescriptionController,
          decoration: InputDecoration(
            labelText: 'Company Description',
          ),
        ),
        TextField(
          controller: companyVatController,
          decoration: InputDecoration(
            labelText: 'Company VAT',
          ),
        ),
        TextField(
          controller: companyCountryController,
          decoration: InputDecoration(
            labelText: 'Company Country',
          ),
        ),
        TextField(
          controller: companyCityController,
          decoration: InputDecoration(
            labelText: 'Company City',
          ),
        ),
        TextField(
          controller: companyAddressController,
          decoration: InputDecoration(
            labelText: 'Company Address',
          ),
        ),
        TextField(
          controller: companyZipcodeController,
          decoration: InputDecoration(
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
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: switchForm,
              child: Text(isUser ? 'Switch to Company' : 'Switch to User'),
            ),
            SizedBox(height: 16.0),
            isUser ? buildUserForm() : buildCompanyForm(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                print(nameController.text);
                print(emailController.text);
                print(passwordController.text);
                print(bioController.text);
                print(companyNameController.text);
                print(companyEmailController.text);
                print(companyPasswordController.text);
                print(companyDescriptionController.text);
                print(companyVatController.text);
                print(companyCountryController.text);
                print(companyCityController.text);
                print(companyAddressController.text);
                print(companyZipcodeController.text);
              },
              child: Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
