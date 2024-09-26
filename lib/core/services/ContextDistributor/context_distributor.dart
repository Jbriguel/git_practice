import 'package:flutter/material.dart';

class ContextDistributor {
  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  BuildContext? get context => _context;
}
