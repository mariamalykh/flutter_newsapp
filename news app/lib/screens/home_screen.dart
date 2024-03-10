import 'package:flutter/material.dart';
import 'package:mytest/screens/item_screen.dart';
import 'package:mytest/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../help/feed.dart';
import '../models/article.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change theme here"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          }, child: const Text("Change Theme"),
        ),
      ),
    );
  }
  
}

class _HomePageState extends State<HomePage> {

  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getFeed();
  }
  getFeed() async {
     Feed feed = Feed();
     await feed.getFeed();
     articles = feed.feed;
     setState(() {
       _loading = false;
     });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar:  AppBar(
        title: Row  (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Latest News", style: Theme.of(context).textTheme.titleLarge)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: TabBarView(
        children: [
          _loading ? const Center(
            child: CircularProgressIndicator(),
          ) : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child:  ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index){
                          return Announcement(imageAddress:  articles[index].urlToImage,
                            heading: articles[index].title,
                            description: articles[index].description, url: articles[index].url,
                            content: articles[index].content,);
                        }),
                  )
                ],
              ),
            ),
          ),
          const ChangeThemeButton(),
        ],
      ),
      bottomNavigationBar: const TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.fiber_new),
            text: "News",
          ),
          Tab(
            icon: Icon(Icons.brightness_3),
            text: "Theme",
          )
        ],
      ),
    ));

  }
}

class Announcement extends StatelessWidget {
  // const Announcement({super.key});
  final String imageAddress, heading, description, url, content;
  const Announcement({super.key, required this.imageAddress, required this.heading, required this.description, required
  this.url, required this.content});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticlePage(url: url, imageAddress: imageAddress,description: description, heading: heading,
          content: content,),
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(imageAddress,
                  errorBuilder:
                      (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Text('Error loading image T-T', style: Theme.of(context).textTheme.titleMedium);
                  },),),
            const SizedBox(height: 8, ),
            Text(heading, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8, ),
            Text(description, style: Theme.of(context).textTheme.titleSmall,),
          ],
        ),
      ),
    );
  }
}


