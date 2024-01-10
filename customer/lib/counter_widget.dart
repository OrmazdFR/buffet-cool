import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key, this.value, this.onChanged});

  final int? value;
  final Function(int)? onChanged;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _counter;

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
    if (widget.onChanged != null) {
	  if (_counter < 0) {
	    _counter = 0;
	  }
      widget.onChanged!(_counter);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _counter = widget.value!;
    } else {
      _counter = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: _decrementCounter, child: const Text('-')),
        Text(
          '$_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

