import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<List<T>> stream;
  final Widget loadingWidget;
  final Widget errorWidget;
  final Widget Function(T item) customListTileBuilder;
  final bool verbose;

  const CustomStreamBuilder({
    super.key,
    required this.stream,
    required this.customListTileBuilder,
    this.verbose = false,
    this.loadingWidget = const CircularProgressIndicator(),
    this.errorWidget = const Icon(Icons.error),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingWidget);
          }

          if (snapshot.hasError) {
            debugPrint('Error: ${snapshot.error}');
            return Center(child: errorWidget);
          }

          if (verbose) {
            debugPrint(
                'items: ${snapshot.data?.map((e) => (e as dynamic)?.toMap())}');
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text('No item found.'));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return customListTileBuilder(item);
            },
          );
        },
      ),
    );
  }
}
