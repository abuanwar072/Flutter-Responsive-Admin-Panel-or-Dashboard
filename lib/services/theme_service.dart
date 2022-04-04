
import 'dart:ui';

class ThemeService
{

    Color helpColor()
    {
        return const Color(0xFF48B3C9);
    }

    Color getColor(int theme)
    {
            switch(theme) {
                case 1: return const Color(0xFF0A9E56);
                case 2: return const Color(0xFF22AAC6);
                case 3: return const Color(0xFF4A66F9);
                case 4: return const Color(0xFF861ADB);
                case 5: return const Color(0xFFD740D1);
                case 6: return const Color(0xFFE64D5A);
                default: return const Color(0xFFAAAAAA);
            }
    }

}