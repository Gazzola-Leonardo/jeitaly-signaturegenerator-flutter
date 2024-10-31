import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jeitaly_signaturegenerator_flutter/interface/widget/signature_editor.dart';
import 'package:jeitaly_signaturegenerator_flutter/interface/widget/signature_viewer.dart';
import 'package:jeitaly_signaturegenerator_flutter/references.dart';
import 'dart:html' as html;

import 'package:jeitaly_signaturegenerator_flutter/resources/provider/signature_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/homeScreen";

  const HomeScreen({super.key});

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
    if(isMobile()) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Questa applicazione non è supportata su dispositivi mobili\nAccedi da computer"),
        ),
      );
    }

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

  bool isMobile() {
    final userAgent = html.window.navigator.userAgent.toLowerCase();

    return userAgent.contains("iphone") || userAgent.contains("android") || userAgent.contains("ipad") || MediaQuery.of(context).size.width < 600;
  }
}
