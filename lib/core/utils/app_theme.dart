import 'package:flutter/material.dart';

class AppTheme {
  // TradingView Dark Theme Colors
  static const Color primaryColor = Color(0xFF2962FF); // TradingView blue
  static const Color backgroundColor = Color(0xFF0D1421); // Dark navy background
  static const Color surfaceColor = Color(0xFF1E222D); // Card/surface color
  static const Color cardColor = Color(0xFF1E222D); // Card background
  static const Color borderColor = Color(0xFF2A2E39); // Border color
  static const Color dividerColor = Color(0xFF2A2E39); // Divider color
  
  // Text Colors
  static const Color textPrimaryColor = Color(0xFFD1D4DC); // Primary text (light gray)
  static const Color textSecondaryColor = Color(0xFF787B86); // Secondary text (gray)
  static const Color textTertiaryColor = Color(0xFF555967); // Tertiary text (darker gray)
  
  // Trading Colors
  static const Color bullishColor = Color(0xFF22C55E); // Green for long/buy
  static const Color bearishColor = Color(0xFFEF4444); // Red for short/sell
  static const Color successColor = Color(0xFF22C55E); // Success/profit color
  static const Color errorColor = Color(0xFFEF4444); // Error/loss color
  static const Color warningColor = Color(0xFFF59E0B); // Warning/caution color
  
  // Additional TradingView Colors
  static const Color accentColor = Color(0xFF00D4FF); // Accent/highlight color
  static const Color volumeColor = Color(0xFF363A45); // Volume bars color
  static const Color gridLineColor = Color(0xFF2A2E39); // Chart grid lines

  // Text Styles - TradingView Style
  static const TextStyle headingStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    letterSpacing: -0.5,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
    letterSpacing: -0.3,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textPrimaryColor,
    letterSpacing: -0.1,
  );

  static const TextStyle captionStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    letterSpacing: 0,
  );

  static const TextStyle numberStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
    letterSpacing: -0.2,
  );

  // Additional TradingView-specific text styles
  static const TextStyle priceStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    letterSpacing: -0.2,
  );

  static const TextStyle labelStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
    letterSpacing: 0.2,
  );

  // TradingView Card Decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardColor,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: borderColor,
      width: 1,
    ),
  );

  // TradingView Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.1,
    ),
  );

  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: textPrimaryColor,
    backgroundColor: surfaceColor,
    side: const BorderSide(color: borderColor),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.1,
    ),
  );

  // TradingView Success/Danger Button Styles
  static ButtonStyle successButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: bullishColor,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.1,
    ),
  );

  static ButtonStyle dangerButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: bearishColor,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.1,
    ),
  );

  // TradingView Input Decoration
  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: textSecondaryColor, size: 20) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: primaryColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: errorColor),
      ),
      filled: true,
      fillColor: surfaceColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      labelStyle: const TextStyle(
        color: textSecondaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: const TextStyle(
        color: textTertiaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: const TextStyle(
        color: primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // TradingView Dark Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentColor,
        onSecondary: Colors.white,
        surface: surfaceColor,
        onSurface: textPrimaryColor,
        surfaceContainerHighest: cardColor,
        outline: borderColor,
        error: errorColor,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cardColor,
        foregroundColor: textPrimaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimaryColor,
          letterSpacing: -0.2,
        ),
        iconTheme: IconThemeData(
          color: textPrimaryColor,
          size: 20,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: borderColor, width: 1),
        ),
        margin: const EdgeInsets.all(0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonStyle),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primaryColor, width: 1),
        ),
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textSecondaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
      ),
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(
        color: textSecondaryColor,
        size: 20,
      ),
    );
  }

  // Keep lightTheme for backward compatibility, but point to dark theme
  static ThemeData get lightTheme => darkTheme;
}
