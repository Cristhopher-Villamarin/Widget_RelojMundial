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

  // Método para obtener la hora desde el controlador.
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
      _showErrorDialog(e.toString());
    }
  }

  // Muestra un diálogo en caso de error.
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _worldTime == null
        ? const Center(child: Text('Failed to load time'))
        : Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _worldTime!.location,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _worldTime!.time,
              style: TextStyle(
                fontSize: 48,
                color: _worldTime!.isDaytime
                    ? Colors.black
                    : Colors.white,
                backgroundColor: _worldTime!.isDaytime
                    ? Colors.yellow
                    : Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Timezone: ${_worldTime!.timezone}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
