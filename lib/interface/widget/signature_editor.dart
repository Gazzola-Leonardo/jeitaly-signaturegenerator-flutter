import 'package:flutter/material.dart';
import 'package:jeitaly_signaturegenerator_flutter/models/signature_model.dart';
import 'package:jeitaly_signaturegenerator_flutter/references.dart';
import 'package:jeitaly_signaturegenerator_flutter/resources/validator/string_validator.dart';

class SignatureEditor extends StatefulWidget {
  const SignatureEditor({super.key});

  @override
  State<SignatureEditor> createState() => SignatureEditorController();
}

class SignatureEditorController extends State<SignatureEditor> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  bool hasBeenValidated = false;

  @override
  void initState() {
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        if (emailController.text.isEmpty) {
          emailController.text = "${nameController.text.toLowerCase()}.${surnameController.text.replaceAll(" ", "").toLowerCase()}";
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: References.maxEditorWidth),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nome"),
              validator: StringValidator.requiredValidator,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: surnameController,
              decoration: const InputDecoration(labelText: "Cognome"),
              validator: StringValidator.requiredValidator,
            ),
            TextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(labelText: "Email", suffixText: "@${References.emailDomain}"),
              validator: StringValidator.emailValidator,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: "Telefono", prefixText: References.phonePrefix),
              validator: StringValidator.phoneNumberValidator,
            ),
            TextFormField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Ruolo"),
              validator: StringValidator.requiredValidator,
            ),
          ],
        ),
      ),
    );
  }

  bool validate() {
    if (formKey.currentState!.validate()) {
      hasBeenValidated = true;
      return true;
    }

    return false;
  }

  void clear() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    roleController.clear();
  }

  SignatureModel? getSignature() {
    if (!hasBeenValidated) {
      return null;
    }

    if (!validate()) {
      return null;
    }

    return SignatureModel(
      name: nameController.text,
      surname: surnameController.text,
      emailName: emailController.text,
      phoneNumber: phoneNumberController.text,
      role: roleController.text,
    );
  }
}
