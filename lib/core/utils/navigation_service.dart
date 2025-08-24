import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  // Callback to navigate to specific tab
  Function(int)? _navigateToTabCallback;
  
  void setNavigateToTabCallback(Function(int) callback) {
    _navigateToTabCallback = callback;
  }
  
  void navigateToTab(int index) {
    if (_navigateToTabCallback != null) {
      _navigateToTabCallback!(index);
    }
  }
  
  void navigateToTradeList() {
    navigateToTab(2); // Trade List is at index 2
  }
  
  void navigateToHome() {
    navigateToTab(0); // Home is at index 0
  }
  
  void navigateToAddTrade() {
    navigateToTab(1); // Add Trade is at index 1
  }
  
  void navigateToTools() {
    navigateToTab(3); // Tools is at index 3
  }
}
