import 'package:flutter/material.dart';

// Theme configuration
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.yellow),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.blue[600]),
        shadowColor: WidgetStateProperty.all(Colors.blue[600]),
        elevation: const WidgetStatePropertyAll(10),
        overlayColor: const WidgetStatePropertyAll(Colors.blue),
      )),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.yellow),
            foregroundColor: WidgetStateProperty.all(Colors.blue[600])),
      ),
      listTileTheme: ListTileThemeData(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          textColor: Colors.white,
          tileColor: Colors.blue[600],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          style: ListTileStyle.drawer),
      cardTheme: CardThemeData(
        color: Colors.yellow,
        elevation: 10,
        surfaceTintColor: Colors.yellow[600],
        shadowColor: Colors.blue[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(Colors.yellow),
        elevation: WidgetStateProperty.all(10),
        shadowColor: WidgetStateProperty.all(Colors.blue[600]),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      extensions: [
        ListTileColorTheme(tileColor1: Colors.blue, tileColor2: Colors.yellow)
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        color: Colors.blue[600],
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue[600]),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        foregroundColor: WidgetStateProperty.all(Colors.yellow),
        shadowColor: const WidgetStatePropertyAll(Colors.yellow),
        elevation: const WidgetStatePropertyAll(10),
        overlayColor: const WidgetStatePropertyAll(Colors.yellow),
      )),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(Colors.yellow),
            backgroundColor: WidgetStateProperty.all(Colors.blue[600])),
      ),
      listTileTheme: ListTileThemeData(
          shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          textColor: Colors.black,
          tileColor: Colors.blue[600],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          style: ListTileStyle.drawer),
      cardTheme: CardThemeData(
        color: Colors.blue[600],
        surfaceTintColor: Colors.blue[800],
        elevation: 10,
        shadowColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(Colors.blue[600]),
        elevation: WidgetStateProperty.all(10),
        shadowColor: WidgetStateProperty.all(Colors.yellow),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      extensions: [
        ListTileColorTheme(tileColor1: Colors.yellow, tileColor2: Colors.blue)
      ],
      // buttonTheme: const ButtonThemeData(
      //   shape: CircleBorder(),
      //   buttonColor: Colors.blue[600]
      // )
    );
  }
}

// class ListTileColorTheme extends ThemeExtension<ListTileColorTheme> {
//   final List<Color> tileColors;

//   ListTileColorTheme({required this.tileColors});

//   @override
//   ListTileColorTheme copyWith({List<Color>? tileColors}) {
//     return ListTileColorTheme(tileColors: tileColors ?? this.tileColors);
//   }

//   @override
//   ListTileColorTheme lerp(ListTileColorTheme? other, double t) {
//     if (other == null) return this;
//     return ListTileColorTheme(
//       tileColors: List.generate(
//         tileColors.length,
//         (index) =>
//             Color.lerp(tileColors[index], other.tileColors[index], t) ??
//             tileColors[index],
//       ),

//     );
//   }
// }

class ListTileColorTheme extends ThemeExtension<ListTileColorTheme> {
  final Color tileColor1; // Primo colore per la tile (per esempio, blu)
  final Color tileColor2; // Secondo colore per la tile (per esempio, giallo)

  ListTileColorTheme({required this.tileColor1, required this.tileColor2});

  @override
  ListTileColorTheme copyWith({Color? tileColor1, Color? tileColor2}) {
    return ListTileColorTheme(
      tileColor1: tileColor1 ?? this.tileColor1,
      tileColor2: tileColor2 ?? this.tileColor2,
    );
  }

  @override
  ListTileColorTheme lerp(ListTileColorTheme? other, double t) {
    if (other == null) return this;
    return ListTileColorTheme(
      tileColor1: Color.lerp(tileColor1, other.tileColor1, t) ?? tileColor1,
      tileColor2: Color.lerp(tileColor2, other.tileColor2, t) ?? tileColor2,
    );
  }
}

class MyTileList extends StatelessWidget {
  final List<String> items; // La lista che contiene i contenuti delle tile

  const MyTileList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final tileColor1 =
        Theme.of(context).extension<ListTileColorTheme>()?.tileColor1 ??
            Colors.blue;
    final tileColor2 =
        Theme.of(context).extension<ListTileColorTheme>()?.tileColor2 ??
            Colors.yellow;

    return ListView.builder(
      itemCount:
          items.length, // Usa la lunghezza della lista di oggetti passati
      itemBuilder: (context, index) {
        final Color tileColor = index % 2 == 0 ? tileColor1 : tileColor2;
        final Color textColor = index % 2 == 0 ? tileColor2 : tileColor1;

        return ListTile(
          tileColor: tileColor,
          title: Text(
            items[index], // Passa il contenuto dinamico della tile
            style: TextStyle(color: textColor), // Colore del testo alternato
          ),
        );
      },
    );
  }
}
