import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shea/models/post.dart';
import 'package:shea/screens/view_image.dart';
import 'package:shea/screens/view_video.dart';
import 'package:shea/widgets/cached_image.dart';
import 'package:shea/widgets/indicators.dart';
import 'package:video_player/video_player.dart';

class PostTileVideo extends StatefulWidget {
  final PostModel? post;

  PostTileVideo({this.post});

  @override
  _PostTileVideoState createState() => _PostTileVideoState();
}

class _PostTileVideoState extends State<PostTileVideo> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.post?.mediaUrl ?? "")
      ..initialize().then((_) {
        setState(() {});  //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (_) => ViewVideo(post: widget.post),
        ));
      },
      child: Container(
        height: 100,
        width: 150,
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(3.0),
                ),
                child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : circularProgress(context),
              ),
            ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: Icon(
                Icons.videocam_outlined, 
                size: 30, 
                color: Theme.of(context).colorScheme.secondary,
              )
            )
          ],
        ),
      ),
    );
  }
}
