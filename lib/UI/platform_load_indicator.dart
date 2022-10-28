import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Center Indicator() {
  return Platform.isAndroid
      ? const Center(child: CircularProgressIndicator())
      : const Center(child: CupertinoActivityIndicator());
}
