import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grateful/models/post.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late double _deviceHeight, _deviceWidth;

  String? _newPostContent;
  Box? _box;

  final String _instructions = "✍🏾 write what (or who) you are grateful for\n💌 act upon it and check it off\n🗑️ delete by pressing down and holding it";

  _PostsPageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(_padding(_deviceWidth)),
              child: _postPageTitleBanner(colorScheme),
            ), 
            _postsView(),
            Padding(
              padding: EdgeInsets.all(_padding(_deviceWidth)),
              child: _addPostButton(),
            ),
          ],
        ),
      )
    );
  }

  double _padding(double _deviceWidth) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return _deviceWidth * 0.05;
    } else {
      return _deviceWidth * 0.03;
    }
  }

  Column _postPageTitleBanner(ColorScheme colorScheme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Posts",
          style: TextStyle(
            fontSize: 18,
            color: colorScheme.primary,
            decoration: TextDecoration.underline,
            letterSpacing: 1.0
          )
        ),
        Text(
          _instructions,
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.primary,
          )
        ),
        Image.asset(
          "assets/images/grateful_cat.png",
          height: _deviceHeight * 0.15,
          width: _deviceWidth * 0.15,
        )
      ],
    );
  }

  Widget _postsView() {
    return Expanded(
      child: FutureBuilder(
        future: Hive.openBox('tasks'),
        builder:(context, _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;
            return _postsList();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
    
  Widget _postsList() {
    var colorScheme = Theme.of(context).colorScheme;

    List posts = _box!.values.toList();

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder:(context, _index) {
        var post = Post.fromMap(posts[_index]);
        return ListTile(
          title: Text(
            post.content,
            style: TextStyle(
              color: colorScheme.primary,
              decoration: post.done ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            post.timestamp.toString(),
            style: TextStyle(
              color: colorScheme.secondary,
            )
          ),
          trailing: Icon(
            post.done 
              ? Icons.check_box
              : Icons.volunteer_activism_outlined,
            color: colorScheme.primary,
          ),
          onTap: () {
            setState(() {
              post.done = !post.done;
              _box!.putAt(_index, post.toMap());
            });
          },
          onLongPress: () {
            _box!.deleteAt(_index);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _addPostButton() {
    var colorScheme = Theme.of(context).colorScheme;
    return FloatingActionButton(
      tooltip: "Tap here to write about what or who you're grateful for.",
      onPressed: _displayPostPopup,
      backgroundColor: colorScheme.primaryContainer,
      splashColor: colorScheme.primary,
      child: Icon(
        Icons.note_add, 
        color: Theme.of(context).colorScheme.onPrimaryContainer
      ),
    ); 
  }


  void _displayPostPopup() {
    showDialog(
      context: context, 
      builder:(BuildContext _context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            "Write a new post & press enter to save",
            style: TextStyle(color: Theme.of(_context).colorScheme.primary),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                "Cancel", 
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.error
                )
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: "I'm grateful for ... because ...",
                  ),
                  onChanged:(_value) {
                    setState(() => _newPostContent = _value);
                  }, 
                  onSubmitted: (_) {
                    if (_newPostContent != null) {
                      var _post = Post(
                        content: _newPostContent!, 
                        timestamp: DateTime.now(), 
                        done: false,
                      );
                      _box!.add(_post.toMap());
                      setState(() {
                        _newPostContent = null;
                        Navigator.pop(context);
                      });
                    } 
                  },
                ),
              ],
            )
          ),
        );
      },
    );
  }
  

}
