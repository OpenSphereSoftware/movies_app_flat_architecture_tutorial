import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerWithLoading extends ConsumerWidget {
  const ContainerWithLoading(
      {Key? key, required this.child, required this.isLoading})
      : super(key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isLoading
        ? const Padding(
            padding: EdgeInsets.all(32.0),
            child: CircularProgressIndicator(),
          )
        : child;
  }
}
