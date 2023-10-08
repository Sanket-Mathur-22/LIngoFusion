import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lingofusion/const/const.dart';


class TranscriptionScreen extends StatefulWidget {
  @override
  _TranscriptionScreenState createState() => _TranscriptionScreenState();
}

class _TranscriptionScreenState extends State<TranscriptionScreen> {
  TextEditingController _youtubeLinkController = TextEditingController();
  String _transcriptionResult = '';

  void transcribeVideo() async {
  final String youtubeLink = _youtubeLinkController.text;
  final response = await http.post(
    Uri.parse('$host/transcribe'),
    body: {'youtubeLink': youtubeLink},
  );

  if (response.statusCode == 200) {
    setState(() {
      _transcriptionResult = response.body;
    });
  } else {
    // Handle error
    print('Error: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LingoFusion',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _youtubeLinkController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  labelText: 'Enter YouTube Link'),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
            //Handle button press event
            onPressed: () =>transcribeVideo(),
            //Contents of the button
            style: ElevatedButton.styleFrom(
              //Change font size
              foregroundColor: Colors.black, backgroundColor: Colors.amber, textStyle: const TextStyle(
                  fontSize: 12,
              ),
              //Set the padding on all sides to 30px
              padding: const EdgeInsets.all(12.0),
            ),
            icon: const Icon(Icons.send_rounded,size: 20,), //Button icon
            label: const Text("Transcribe",style: TextStyle(fontSize: 20),)), //Button label
    
              SizedBox(height: 20),
              Text(
                'Transcription Result:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                child: Card(
                  margin: EdgeInsets.all(2),
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _transcriptionResult,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }
}

