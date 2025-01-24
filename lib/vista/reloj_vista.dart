import 'package:flutter/material.dart';
import '../controlador/reloj_controlador.dart';
import '../modelo/reloj_modelo.dart';

class WorldClockWidget extends StatefulWidget {
  final String city;

  const WorldClockWidget({Key? key, required this.city}) : super(key: key);

  @override
  _WorldClockWidgetState createState() => _WorldClockWidgetState();
}

class _WorldClockWidgetState extends State<WorldClockWidget> {
  late WorldTimeController _controller;
  WorldTime? _worldTime;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WorldTimeController();
    _fetchWorldTime();
  }

  Future<void> _fetchWorldTime() async {
    try {
      final worldTime = await _controller.fetchTime(widget.city);
      setState(() {
        _worldTime = worldTime;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch time: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _worldTime == null
        ? Center(child: Text('Failed to load time'))
        : Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _worldTime!.location,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _worldTime!.time,
              style: TextStyle(
                fontSize: 48,
                color: _worldTime!.isDaytime ? Colors.black : Colors.white,
                backgroundColor: _worldTime!.isDaytime ? Colors.yellow : Colors.blueGrey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Timezone: ${_worldTime!.timezone}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
