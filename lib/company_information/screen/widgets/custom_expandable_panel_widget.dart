import 'package:flutter/material.dart';

import '../../../app/common_widgets/common_widgets.dart';
import '../../../app/theme/light_theme.dart';

class CustomExpandablePanel extends StatefulWidget {
  final String title;
  final String description;
  final Duration animationDuration;

  const CustomExpandablePanel({
    super.key,
    required this.title,
    required this.description,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomExpandablePanelState createState() => _CustomExpandablePanelState();
}

class _CustomExpandablePanelState extends State<CustomExpandablePanel> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFDF0E8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: _toggleExpanded,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft:
                      _isExpanded ? Radius.zero : const Radius.circular(10),
                  bottomRight:
                      _isExpanded ? Radius.zero : const Radius.circular(10),
                ),
              ),
              child: Center(
                child: ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    ),
                    onPressed: _toggleExpanded,
                  ),
                ),
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              return AnimatedContainer(
                duration: widget.animationDuration,
                padding: const EdgeInsets.all(16.0),
                curve: Curves.easeInOut,
                height: _isExpanded
                    ? calculateHeight(
                        widget.description,
                        Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16, height: 1.3),
                        constraints.maxWidth - 32,
                      )
                    : 0,
                child: Text(
                  widget.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.3, fontSize: 16),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
