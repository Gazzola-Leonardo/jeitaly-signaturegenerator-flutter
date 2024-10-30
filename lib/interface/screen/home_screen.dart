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
      child: ListView(
        shrinkWrap: true,
        children: [
          Center(child: SignatureEditor(key: signatureEditorKey)),
          SizedBox(height: 32.0),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: References.maxEditorWidth),
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
          SizedBox(height: 64.0),
          Center(
            child: (signatureEditorKey.currentState?.hasBeenValidated ?? false)
                ? SignatureViewer(signature: signatureEditorKey.currentState!.getSignature()!)
                : SizedBox(
                    height: References.signatureEditorHeight,
                    width: References.signatureEditorWidth,
                    child: Center(child: Text("Compila tutti i campi per generare la firma")),
                  ),
          ),
        ],
      ),
    );
  }
}
