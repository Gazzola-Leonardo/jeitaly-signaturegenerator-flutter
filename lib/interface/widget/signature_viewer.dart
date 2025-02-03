import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String signatureHtml = "";

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
            initialData: InAppWebViewInitialData(
              data: '',
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webViewController = controller;
              getSignature().then((signature) {
                webViewController?.loadData(data: signature);
              });
            },
              onContentSizeChanged: (InAppWebViewController controller, Size before, Size after) {
                debugPrint("Content size changed: $after");
              },
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text("Copia e incolla la firma nel tuo client di posta elettronica"),

        Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                if (webViewController == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('WebView not initialized yet!')),
                  );
                  return;
                }
                try {
                  // Use JavaScript to get the rendered HTML
                  final renderedHtml = await webViewController!.evaluateJavascript(
                    source: "document.documentElement.outerHTML",
                  );

                  if (renderedHtml != null && renderedHtml is String) {
                    // Copy to clipboard if the result is valid
                    Clipboard.setData(ClipboardData(text: renderedHtml));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Interpreted HTML copied!')),
                    );
                  } else {
                    // Handle case when result is null or not a string
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No valid HTML content to copy!')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to copy HTML: $e')),
                  );
                }
              },
              child: Text('Copy Rendered HTML'),
            ),
          ),


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

    signatureHtml = """
    $compiledSignature
    """;

    await webViewController!.loadData(data: signatureHtml);
  }

  Future<String> getSignature() async {
    if (webViewController == null) {
      debugPrint("WebViewController is null");
      return "";
    }

    final String compiledSignature = await SignatureProvider(widget.signature).getCompiledSignature();
    final String style =
        "width: width:${HtmlHelper(context).htmlPxToFlutterPx(References.signatureWidthInPx)}px; height:${HtmlHelper(context).htmlPxToFlutterPx(References.signatureHeightInPx)};";

    String signatureHtml = """
    $compiledSignature
    """;
    return signatureHtml;
    //await webViewController!.loadData(data: signatureHtml);
  }
}
