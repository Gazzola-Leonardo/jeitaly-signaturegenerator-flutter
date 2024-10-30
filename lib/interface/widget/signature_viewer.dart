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
    return SizedBox(
      height: References.signatureEditorHeight,
      width: References.signatureEditorWidth,
      child: IgnorePointer(
        child: InAppWebView(

          onWebViewCreated: (InAppWebViewController controller) {
            webViewController = controller;

            loadEmptySignature();
          },

        ),
      ),
    );
  }

  Future<void> loadEmptySignature() async {
    if (webViewController == null) {
      debugPrint("WebViewController is null");
      return;
    }

    final String compiledSignature = await SignatureProvider(widget.signature).getCompiledSignature();

    final String sizedSignature = """
    <div style='width: width:${HtmlHelper(context).htmlPxToFlutterPx(References.signatureWidthInPx)}px; height:${HtmlHelper(context).htmlPxToFlutterPx(References.signatureHeightInPx)};'>
    $compiledSignature
    </div>
    """;

    await webViewController!.loadData(data: sizedSignature);
  }
}
