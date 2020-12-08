import 'package:app/widgets/swipe_pages_navigation.dart';
import 'package:flutter/widgets.dart';

class SwipePage {
  final String label;
  final Widget body;

  SwipePage(this.label, this.body);
}

class SwipePages extends StatefulWidget {
  final List<SwipePage> _pages;

  const SwipePages(this._pages, {Key key}) : super(key: key);

  @override
  _SwipePagesState createState() => _SwipePagesState();
}

class _SwipePagesState extends State<SwipePages> {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwipePagesNavigation(
              controller: _controller,
              labels: widget._pages.map((page) => page.label).toList(),
              onPageSelected: (int index) {
                _controller.animateToPage(
                  index,
                  duration: _kDuration,
                  curve: _kCurve,
                );
              },
            ),
            Expanded(
              child: PageView(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _controller,
                children: widget._pages.map((page) => page.body).toList(),
              ),
            )
          ],
        ));
  }
}
