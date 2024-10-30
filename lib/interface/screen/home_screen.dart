import 'package:flutter/material.dart';
import 'package:jeitaly_signaturegenerator_flutter/interface/widget/signature_editor.dart';
import 'package:jeitaly_signaturegenerator_flutter/interface/widget/signature_viewer.dart';
import 'package:jeitaly_signaturegenerator_flutter/references.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SignatureEditorController> signatureEditorKey = GlobalKey<SignatureEditorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(References.appName)),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SignatureEditor(key: signatureEditorKey),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: References.maxEditorWidth),
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ElevatedButton(
                  onPressed: () {
                    if (signatureEditorKey.currentState!.validate()) {
                      setState(() {});
                    }
                  },
                  child: const Text("Genera firma"),
                ),
              ),
            ),
          ),
          if (!(signatureEditorKey.currentState?.validate() ?? false)) Container() else SignatureViewer(signature: signatureEditorKey.currentState!.getSignature()!),
        ],
      ),
    );
  }
}
