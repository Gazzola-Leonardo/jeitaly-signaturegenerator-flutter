import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jeitaly_signaturegenerator_flutter/models/signature_model.dart';
import 'package:jeitaly_signaturegenerator_flutter/references.dart';
import 'package:jeitaly_signaturegenerator_flutter/resources/helper/html_helper.dart';
import 'package:jeitaly_signaturegenerator_flutter/resources/provider/signature_provider.dart';

class SignatureViewer extends StatefulWidget {
  final SignatureModel signature;

  const SignatureViewer({super.key, required this.signature});

  @override
  State<SignatureViewer> createState() => _SignatureViewerState();
}

class _SignatureViewerState extends State<SignatureViewer> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(16.0),
          ),
          height: References.signatureEditorHeight,
          width: References.signatureEditorWidth,
          child: IgnorePointer(
            child: InAppWebView(
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;

                loadEmptySignature();
              },
              onContentSizeChanged: (InAppWebViewController controller, Size before, Size after) {
                debugPrint("Content size changed: $after");
              },
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text("Copia e incolla la firma nel tuo client di posta elettronica"),
      ],
    );
  }

  Future<void> loadEmptySignature() async {
    if (webViewController == null) {
      debugPrint("WebViewController is null");
      return;
    }

    final String compiledSignature = await SignatureProvider(widget.signature).getCompiledSignature();
    final String style =
        "width: width:${HtmlHelper(context).htmlPxToFlutterPx(References.signatureWidthInPx)}px; height:${HtmlHelper(context).htmlPxToFlutterPx(References.signatureHeightInPx)};";

    final String sizedSignature = """
    $compiledSignature
    """;

    await webViewController!.loadData(data: sizedSignature);
  }
}
