import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:video_player/video_player.dart';
import "colors.dart" as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  VideoPlayerController? _contoller;
  bool _isPlaying = false;

  bool _disposed = false;
  int _isPlayingIndex = -1;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    //_onTapVideo(-1);
  }

  @override
  void dispose() {
    _disposed = true;
    _contoller?.pause();
    _contoller?.dispose();
    _contoller = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(
              colors: [
                color.AppColor.gradientFirst.withOpacity(0.9),
                color.AppColor.gradientSecond
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ))
          : BoxDecoration(color: color.AppColor.gradientSecond),
      child: Column(
        children: [
          _playArea == false
              ? Container(
                  padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Legs Toning",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "and Glutes Workout",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "68 min",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 250,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.handyman_outlined,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Resistent band, kettebell",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                debugPrint("Tapped");
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                            ),
                            Icon(Icons.info_outline,
                                size: 20,
                                color: color.AppColor.secondPageTopIconColor)
                          ],
                        ),
                      ),
                      _playyView(context),
                      _controlView(context),
                    ],
                  ),
                ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Circuit 1: Legs Toning",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Icon(Icons.loop,
                            size: 30, color: color.AppColor.loopColor),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "3 sets",
                          style: TextStyle(
                            fontSize: 15,
                            color: color.AppColor.setsColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _listView(),
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;

  void _contollerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;

    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _contoller;
    if (controller == null) {
      debugPrint("Controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("Controller is not initialized");
      return;
    }
    if (_duration == null) {
      _duration = _contoller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;
    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;

    if (playing) {
      // handle progresss indicator
      if (_disposed) return;
      setState(() {
        //
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _playView(BuildContext context) {}

  _listView() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8,
        ),
        itemCount: videoInfo.length,
        itemBuilder: (_, index) {
          return GestureDetector(
              onTap: () {
                _onTapVideo(index);
                debugPrint(index.toString());
                setState(() {
                  if (_playArea == false) {
                    _playArea = true;
                  }
                });
              },
              child: builcard(index));
        });
  }

  builcard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(videoInfo[index]["thumbnail"]))),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]["title"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      videoInfo[index]["time"],
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "15s rest",
                    style: TextStyle(color: Color(0xFF839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3)),
                                color: Color(0xFF839fed)),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                          )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_contoller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0; // if isseconds is null
    final head = _position?.inSeconds ?? 0;
    final remainded = max(0, duration - head);
    final mins = convertTwo(remainded ~/ 60.0); //22 ~/7 = 3
    final secs = convertTwo(remainded % 60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.red[700],
                inactiveTickMarkColor: Colors.red[100],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.redAccent,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.red[700],
                inactiveTrackColor: Colors.red[100],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.redAccent,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                )),
            child: Slider(
              value: max(0, min(_progress * 100, 100)),
              min: 0,
              max: 100,
              divisions: 100,
              label: _position?.toString().split(".")[0],
              onChanged: (value) {
                setState(() {
                  _progress = value * 0.01;
                });
              },
              onChangeStart: (value) {
                _contoller?.pause();
              },
              onChangeEnd: (value) {
                final duration = _contoller?.value?.duration;
                if (duration != null) {
                  var newValue = max(0, min(value, 99)) * 0.01;
                  var millis = (duration.inMilliseconds * newValue).toInt();
                  _contoller?.seekTo(Duration(milliseconds: millis));
                  _contoller?.play();
                }
              },
            )),
        Container(
          height: 40,
          margin: EdgeInsets.only(bottom: 5),
          width: MediaQuery.of(context).size.width,
          color: color.AppColor.gradientSecond,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (noMute) {
                    _contoller?.setVolume(0);
                  } else {
                    _contoller?.setVolume(1.0);
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(50, 0, 0, 0))
                    ]),
                    child: Icon(
                      noMute ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final index = _isPlayingIndex - 1;
                    if (index >= 0 && videoInfo.length >= 0) {
                      _onTapVideo(index);
                    } else {
                      Get.snackbar("Video", "",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: Icon(
                            Icons.face,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: color.AppColor.gradientSecond,
                          colorText: Colors.white,
                          messageText: Text(
                            "No More Video ahead",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ));
                    }
                  },
                  icon: Icon(
                    Icons.fast_rewind,
                    size: 36,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () async {
                    if (_isPlaying) {
                      setState(() {
                        _isPlaying = false;
                      });
                      _contoller!.pause();
                    } else {
                      setState(() {
                        _isPlaying = true;
                      });
                      _contoller!.play();
                    }
                  },
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 36,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () async {
                    final index = _isPlayingIndex + 1;
                    if (index <= videoInfo.length - 1) {
                      _onTapVideo(index);
                    } else {
                      Get.snackbar("Video List", "",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: Icon(
                            Icons.face,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: color.AppColor.gradientSecond,
                          colorText: Colors.white,
                          messageText: Text(
                            "No More Video in the list",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ));
                    }
                  },
                  icon: Icon(
                    Icons.fast_forward,
                    size: 36,
                    color: Colors.white,
                  )),
              Text(
                "$mins:$secs",
                style: TextStyle(
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _playyView(BuildContext context) {
    final controller = _contoller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Text(
            "Preparing",
            style: TextStyle(),
          ));
    }
  }

  _onTapVideo(int index) {
    final controller = VideoPlayerController.networkUrl(
        Uri.parse(videoInfo[index]["videoUrl"]));
    final old = _contoller;

    _contoller = controller;
    if (old != null) {
      old.removeListener(_contollerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_contollerUpdate);
        controller.play();
        setState(() {});
      });
  }
}
