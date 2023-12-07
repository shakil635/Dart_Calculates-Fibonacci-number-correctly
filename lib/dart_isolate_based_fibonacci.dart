/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:isolate';

export 'src/dart_isolate_based_fibonacci_base.dart';

// TODO: Export any libraries intended for clients of this package.

void fibonnaciNumber(List<Object> list) {
  SendPort senderport = list[0] as SendPort;
  int fibNum = list[1] as int;
  if (fibNum < 2) {
    senderport.send(fibNum);
  }
  int start = 0;
  int second = 1;
  int current = 0;

  for (var i = 2; i <= fibNum; i++) {
    current = start + second;
    start = second;
    second = current;
  }
  senderport.send(current);
}

Future<int> calculateFibonacciIsolate(int fibnum) async {
  final reciverPort = ReceivePort();

  final islet =
      await Isolate.spawn(fibonnaciNumber, [reciverPort.sendPort, fibnum]);

  final ans = (await reciverPort.first);
  reciverPort.close();
  islet.kill();
  return ans;
}








/*
Practice Question 1: Isolate-Based Fibonacci Calculation
Task:
Calculate the nth Fibonacci number in a separate isolate. 
Pass the value of n to the new isolate as an argument 
and return the result to the main isolate.
 */