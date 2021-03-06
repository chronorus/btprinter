import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:streams_channel/streams_channel.dart';

class Btprinter {
  static const MethodChannel _channel = const MethodChannel('btprinter');
  static StreamsChannel _connectChannel = StreamsChannel('btprinter_stream');
  static StreamsChannel _zenpertConnectChannel =
      StreamsChannel('zenpert_btprinter_stream');

  static Future<List<String>> discoveryPariedDevices() async {
    final List<dynamic> BTList =
        await _channel.invokeMethod('discoveryPariedDevices');
    final List<String> BTStringList = List<String>.from(BTList);
    return BTStringList;
  }

  static Future<String> discoveryNewDevices() async {
    final String result = await _channel.invokeMethod('discoveryNewDevices');
    return result;
  }

  static Future<String> connectDevices(String address) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("address", () => address);
    final String connectResult =
        await _channel.invokeMethod('setAddress', args);
    return connectResult;
  }

  static Future<String> printString(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);
    final String printResult = await _channel.invokeMethod('printString', args);
    return printResult;
  }

  static Future<String> printBarcode(String barcodeString) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("barcodeString", () => barcodeString);
    final String printResult =
        await _channel.invokeMethod('printBarcode', args);
    return printResult;
  }

  static Future<String> printQrCode(String qrString) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("qrString", () => qrString);
    final String printResult = await _channel.invokeMethod('printQrCode', args);
    return printResult;
  }

  //=========================== Zenpert ========================================

  static Future<String> zenpertPrintString(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);
    final String printResult =
        await _channel.invokeMethod('zenpertPrintText', args);
    return printResult;
  }

  static Future<String> zenpertPrintBarcode(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);
    final String printResult =
        await _channel.invokeMethod('zenpertPrintBarcode', args);
    return printResult;
  }

  static Future<String> zenpertPrintQrCode(String msg) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("msg", () => msg);
    final String printResult =
        await _channel.invokeMethod('zenpertPrintQrCode', args);
    return printResult;
  }

  static Future<String> zenpertClosePort() async {
    final String printResult = await _channel.invokeMethod('zenpertClose');
    return printResult;
  }

  static Future<String> fujunClosePort() async {
    final String printResult = await _channel.invokeMethod('fujunClose');
    return printResult;
  }

  //=========================== Stream Connection ==============================

  static void getBtConnectStream(String argument) {
    print('begin:getBtPrinterStream');
    WidgetsFlutterBinding.ensureInitialized();
    _connectChannel.receiveBroadcastStream(argument).listen((i) {
      print('the stream said $i');
    });
    print('after listening');
  }

  static Stream<int> getBtPrinterStream_returnStream(String argument) {
    WidgetsFlutterBinding.ensureInitialized();
    return _connectChannel
        .receiveBroadcastStream(argument)
        .map<int>((v) => (v));
  }

  static void getZenpertBtConnectStream(String argument) {
    print('begin:getZenpertBtPrinterStream');
    WidgetsFlutterBinding.ensureInitialized();
    _zenpertConnectChannel.receiveBroadcastStream(argument).listen((i) {
      print('the stream said $i');
    });
    print('after listening');
  }

  static Stream<int> getZenpertBtPrinterStream_returnStream(String argument) {
    WidgetsFlutterBinding.ensureInitialized();
    return _zenpertConnectChannel
        .receiveBroadcastStream(argument)
        .map<int>((v) => (v));
  }
}
