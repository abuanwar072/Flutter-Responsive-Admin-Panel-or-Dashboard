import 'package:flutter/material.dart';

typedef DataDidChangeCallback<T> = bool Function(T o, T n);

///Fades out the old data and back in with the new
class AnimatedFadeOutIn<T> extends StatefulWidget {
  ///If [initialData] is not null on first build it will be shown.
  ///Directly after that the animation changes the value to [data].
  final T? initialData;

  ///The data to show
  final T data;
  final Duration duration;
  final Widget Function(T data) builder;
  final VoidCallback? onFadeComplete;

  /// Compare the values to determine if the data has changed.
  /// If [null] the data is compared using `!=` expression
  final DataDidChangeCallback<T>? dataDidChange;

  const AnimatedFadeOutIn({
    Key? key,
    this.initialData,
    required this.data,
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.onFadeComplete,
    this.dataDidChange,
  }) : super(key: key);

  @override
  _AnimatedFadeOutInState<T> createState() => _AnimatedFadeOutInState<T>();
}

class _AnimatedFadeOutInState<T> extends State<AnimatedFadeOutIn<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late T dataToShow;

  @override
  void initState() {
    super.initState();
    dataToShow = widget.initialData ?? widget.data;
    controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          dataToShow = widget.data;
          controller.reverse(from: 1.0);
        } else if (status == AnimationStatus.dismissed) {
          widget.onFadeComplete?.call();
        }
      });

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    if (widget.dataDidChange?.call(dataToShow, widget.data) ??
        widget.data != dataToShow) {
      controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedFadeOutIn<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dataDidChange?.call(oldWidget.data, widget.data) ??
        widget.data != oldWidget.data) {
      dataToShow = oldWidget.data;
      controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: 1.0 - animation.value,
    child: widget.builder(dataToShow),
  );
}