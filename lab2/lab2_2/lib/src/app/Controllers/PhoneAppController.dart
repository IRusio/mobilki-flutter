import 'package:flutter/material.dart';
import 'package:lab2_2/src/app/Models/PhoneData.dart';
import 'package:lab2_2/src/app/Models/PhoneModifyPage.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';

class PhoneAppController extends AppController {

  factory PhoneAppController([StateMVC state]) {
    _this ??= PhoneAppController._(state);
    return _this;
  }

  static PhoneAppController _this;

  PhoneAppController._([StateMVC state]) : super(state);

  @override
  void initState() {
    _state = stateMVC;
    _phoneData = PhoneData();
  }

  static AppView _state;
  static PhoneData get phoneData => _phoneData;
  static PhoneData _phoneData;

  static PhoneModifyPage phoneModifyPage(int id) =>
      PhoneModifyPage(id, _phoneData);

  //Todo kontroler do dodwania nowego telefonu, i edycji obecnego

  static bool get debugShowGrid => _state?.debugShowMaterialGrid;
  static set debugShowGrid(bool v) {
    _state?.debugShowMaterialGrid = v;
    _state?.refresh();
  }

  static bool get debugShowSizes => _state?.debugPaintSizeEnabled;
  static set debugShowSizes(bool v) {
    _state?.debugPaintSizeEnabled = v;
    _state?.refresh();
  }

  static bool get debugShowBaselines => _state?.debugPaintBaselinesEnabled;
  static set debugShowBaselines(bool v) {
    _state?.debugPaintBaselinesEnabled = v;
    _state?.refresh();
  }

  static bool get debugShowLayers => _state?.debugPaintLayerBordersEnabled;
  static set debugShowLayers(bool v) {
    _state?.debugPaintLayerBordersEnabled = v;
    _state?.refresh();
  }

  static bool get debugShowPointers => _state?.debugPaintPointersEnabled;
  static set debugShowPointers(bool v) {
    _state?.debugPaintPointersEnabled = v;
    _state?.refresh();
  }

  static bool get debugShowRainbow => _state?.debugRepaintRainbowEnabled;
  static set debugShowRainbow(bool v) {
    _state?.debugRepaintRainbowEnabled = v;
    _state?.refresh();
  }

  static bool get showPerformanceOverlay => _state?.showPerformanceOverlay;
  static set showPerformanceOverlay(bool v) {
    _state?.showPerformanceOverlay = v;
    _state?.refresh();
  }

  static bool get showSemanticsDebugger => _state?.showSemanticsDebugger;
  static set showSemanticsDebugger(bool v) {
    _state?.showSemanticsDebugger = v;
    _state?.refresh();
  }


  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
    );
  }

  static set theme(ThemeData v) {
    _state?.theme = v;
    _state?.refresh();
  }
}