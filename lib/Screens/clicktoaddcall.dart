import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:phone_state/phone_state.dart';
import 'package:call_log/call_log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CallTrackerPage(),
    );
  }
}

class CallTrackerPage extends StatefulWidget {
  const CallTrackerPage({super.key});

  @override
  State<CallTrackerPage> createState() => _CallTrackerPageState();
}

class _CallTrackerPageState extends State<CallTrackerPage> {
  StreamSubscription<PhoneState>? _phoneStateSubscription;

  String number = "+917675858269";
  bool isDisabled = false;

  List<String> callLogs = [];

  @override
  void initState() {
    super.initState();
    requestPermissions();
    listenCallState();
  }

  Future<void> requestPermissions() async {
    // Request phone permission
    var phoneStatus = await Permission.phone.request();

    var contactsStatus = await Permission.contacts.request();

    if (phoneStatus.isDenied || contactsStatus.isDenied) {
      print("Permissions denied");
    }

    if (phoneStatus.isPermanentlyDenied || contactsStatus.isPermanentlyDenied) {
      print("Permissions permanently denied, open settings");
      openAppSettings();
    }
  }

  void listenCallState() {
    _phoneStateSubscription = PhoneState.stream.listen((event) {
      switch (event.status) {
        case PhoneStateStatus.CALL_STARTED:
          print("Call started at: ${DateTime.now()}");
          setState(() {
            isDisabled = true;
          });
          break;
        case PhoneStateStatus.CALL_ENDED:
          print("Call ended at: ${DateTime.now()}");
          setState(() {
            isDisabled = false;
          });
          getRecentCalls(); 
          break;
        default:
          break;
      }
    });
  }

  Future<void> makeCall() async {
    if (isDisabled) return;

    setState(() {
      isDisabled = true;
    });

    final Uri phoneUri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(
        phoneUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> getRecentCalls() async {
    if (await Permission.phone.isGranted) {
      Iterable<CallLogEntry> entries = await CallLog.get();
      
      CallLogEntry? recentCall = entries.firstWhere(
        (entry) => entry.number == number || entry.number == number.replaceAll('+91', '0'),
        orElse: () => entries.first,
      );

      String type = recentCall.callType.toString().split('.').last;
      String log = "${recentCall.name ?? recentCall.number} - $type - ${DateTime.fromMillisecondsSinceEpoch(recentCall.timestamp ?? 0)} - Duration: ${recentCall.duration} sec";
      
      setState(() {
        callLogs = [log];
      });
    } else {
      print("Phone permission not granted for reading call logs");
    }
  }

  @override
  void dispose() {
    _phoneStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Tracker Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: isDisabled ? null : makeCall,
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 22,
                  color: isDisabled ? Colors.grey : Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Recent Call Logs:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: callLogs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(callLogs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}