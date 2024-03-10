import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  final String imageAddress;
  final String heading;
  final String description;
  final String url;
  final String content;
  // ArticlePage({required this.blogUrl});
  const ArticlePage({super.key, required this.imageAddress, required this.heading,
  required this.description, required this.url, required this.content});

  // _launchURL() async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }


  // @override
  // State<ArticlePage> createState() => _ArticlePageState();


// class _ArticlePageState extends State<ArticlePage> {

  // final Completer<WebViewController> _completer = Completer<WebViewController>();


  void _handleURLButtonPress(BuildContext context, String url, String title, WebViewController controller) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewWidget(controller: controller,)));
  }

  @override
  Widget build(BuildContext context) {
    late final WebViewController controller;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
    title: Row  (
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Latest News", style: Theme.of(context).textTheme.titleLarge)
      ],
    ),
    actions: <Widget>[
      Opacity(
        opacity: 0,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.save)),
      )
    ],
    centerTitle: true,
    elevation: 0.0,
    ),
        body:
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.network(imageAddress,
                  errorBuilder:
                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Text('Error loading image T-T', style: Theme.of(context).textTheme.titleMedium);
                  },),
              ),
              Padding(padding: const EdgeInsets.all(10),
              child: Text(heading,
              style: Theme.of(context).textTheme.titleMedium,),
              ),
              Padding(padding: const EdgeInsets.all(10),
              child: Text(content, style: Theme.of(context).textTheme.titleSmall,),
              ),
              Padding(padding: const EdgeInsets.all(10),
                child: MaterialButton(
                  color: Colors.deepPurple,
                  child: Text("Read more...", style: Theme.of(context).textTheme.titleMedium,),
                  onPressed: () {
                    _handleURLButtonPress(context, url, "Original Source", controller);
                  },
                ),)
              
              // Padding(padding: const EdgeInsets.all(10),
              //
              // child: ElevatedButton(
              //   onPressed: () {  },
              //   child: Text('read more...'),
              // ),),
            ],
          ),
        )
    );
  }
 }



