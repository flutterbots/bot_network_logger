import 'package:flutter/material.dart';

class BotNetworkLogOverlay extends StatefulWidget {
  const BotNetworkLogOverlay({
    super.key,
    required this.child,
    this.size = 60,
    this.opacity = 0.6,
  });

  final Widget child;
  final double size;
  final double opacity;

  @override
  State<BotNetworkLogOverlay> createState() => _BotNetworkLogOverlayState();
}

class _BotNetworkLogOverlayState extends State<BotNetworkLogOverlay> {
  double _bottom = 0;
  double _right = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MediaQuery.fromWindow(
      child: Builder(builder: (context) {
        final queryData = MediaQuery.of(context);
        final size = queryData.size;
        final buttonSize = widget.size;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              widget.child,
              StatefulBuilder(
                builder: (context, setState) {
                  return Positioned(
                    bottom: _bottom,
                    right: _right,
                    child: Opacity(
                      opacity: widget.opacity,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _right -= details.delta.dx;
                            _bottom -= details.delta.dy;
                          });
                        },
                        onPanEnd: (_) {
                          setState(
                            () {
                              final mid = size.width / 2;
                              if (_right > mid) {
                                _right = size.width - buttonSize;
                              } else {
                                _right = 0;
                              }

                              final topInset = queryData.padding.top;
                              final bottomInset = queryData.padding.bottom;
                              if (_bottom >
                                  size.height - buttonSize - topInset) {
                                _bottom = size.height - buttonSize - topInset;
                              } else if (_bottom < bottomInset) {
                                _bottom = bottomInset;
                              }
                            },
                          );
                        },
                        child: Container(
                          width: buttonSize,
                          height: buttonSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.primaryContainer,
                          ),
                          child: const Icon(
                            Icons.integration_instructions_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
