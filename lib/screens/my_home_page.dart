import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordSpoken = '';
  late VideoPlayerController _controller;
  bool _showMicIcon = false; // Flag to show microphone icon
  bool _showResultContainer = false; // Flag to show result container
  bool _showGreetingContainer = true; // Flag to show greeting container
  bool _showElevatedButton = false; // Flag to show elevated button

  @override
  void initState() {
    super.initState();
    initSpeech();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(false); // Play only once
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            // Video finished playing
            setState(() {
              _showMicIcon = true; // Show microphone icon
              _showGreetingContainer = false; // Hide greeting container
            });
          }
        });
        setState(() {});
      });
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordSpoken = "${result.recognizedWords}";
      _showResultContainer = true; // Show result container
    });
    // Hide the microphone icon after 2 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showMicIcon = false; // Hide microphone icon
        _showElevatedButton = true; // Show elevated button
      });
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _restartVideo() {
    _controller.seekTo(Duration.zero); // Reset video to the beginning
    _controller.play(); // Play the video again
    setState(() {
      _showMicIcon = false; // Hide microphone icon
      _showElevatedButton = false; // Hide elevated button
      _showGreetingContainer = true; // Show greeting container again
      _showResultContainer = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Video
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(child: CircularProgressIndicator()),
          // UI Overlay
          SafeArea(
            // Add SafeArea to ensure content isn't hidden behind system UI
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_showGreetingContainer) // Show greeting container conditionally
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        // Add border to make container more visible
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Hi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Microphone Icon
          if (_showMicIcon) // Show microphone icon conditionally
            Positioned(
              bottom: 80, // Position at the bottom
              left: 20,
              right: 20,
              child: Text(
                _speechToText.isListening
                    ? "Listening..."
                    : _speechEnabled
                    ? "tap to microphone..."
                    : "speech not available",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          // Microphone Icon
          if (_showMicIcon) // Show microphone icon conditionally
            Positioned(
              bottom: 20, // Position at the bottom
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    _speechToText.isListening
                        ? _stopListening()
                        : _startListening();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child:
                    _speechToText.isNotListening
                        ? Icon( Icons.mic )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          // Restart Button
          if (_showMicIcon) // Show elevated button conditionally
            Positioned(
              bottom: 20, // Position at the bottom
              left: 20, // Adjust position to the left of the mic button
              child: GestureDetector(
                onTap: () {
                  _restartVideo();
                },
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      shape: BoxShape.circle,
                    ),
                    child:
                    Icon(Icons.restart_alt)
                ),
              ),
            ),
          // Elevated Button
          if (_showElevatedButton) // Show elevated button conditionally
            Positioned(
              bottom: 20, // Position at the bottom
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  // Define what happens when the elevated button is pressed
                  _restartVideo();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Continue"),
              ),
            ),
          // Result Container
          if (_showResultContainer) // Show result container at the bottom
            Positioned(
              bottom: 100, // Position above the mic icon
              left: 20,
              right: 20,
              child: Container(
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  // Add border to make container more visible
                  border: Border.all(color: Colors.green.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _wordSpoken.toLowerCase() == 'hi'
                              ? Icons.check_circle_outline
                              : Icons.cancel_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          _wordSpoken.toLowerCase() == 'hi'
                              ? ' perfect'
                              : ' ops',
                          style: TextStyle(
                            color:
                            _wordSpoken.toLowerCase() == 'hi'
                                ? Colors.green
                                : Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'You said: $_wordSpoken',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}