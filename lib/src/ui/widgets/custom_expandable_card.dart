import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants.dart';

class ExpandableCard extends StatefulWidget {
  /// A bottom card widget that can expand on user drag
  ///
  /// `content` attribute must not be null

  ExpandableCard({
    @required this.children,
    this.padding = const EdgeInsets.only(top: 5, left: 20, right: 20),
    this.minHeight = 100,
    this.maxHeight = 500,
    this.hasShadow = true,
    this.backgroundColor = Colors.blueGrey,
    this.hasRoundedCorners = false,
    this.hasHandle = true,
  });

  /// List of widgets that make the content of the card
  final List<Widget> children;

  /// Padding for the content inside the card
  final EdgeInsetsGeometry padding;

  /// Initial height of the card when it is not expanded
  final double minHeight;

  /// Height of the card when it's fully expanded
  final double maxHeight;

  /// Determines whether the card has shadow or not
  final bool hasShadow;

  /// Color of the card
  final Color backgroundColor;

  /// Determines whether the card has rounded corners or not
  final bool hasRoundedCorners;

  /// Determines wheter the card has a handle icon or not
  final bool hasHandle;

  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animationScrollPercent;
  bool _isAnimating = false;
  bool _cardIsExpanded = false;
  double _scrollPercent = 0;
  final _bounceOutCurve = Cubic(.04, .22, .1, 1.21);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  void _startCardDrag(DragStartDetails details) {
    setState(() {
      _isAnimating = false;
    });
    _animationController.reset();
  }

  void _expandCard(DragUpdateDetails details) {
    final drag = details.delta.dy;
    if (drag < -0.3 && _scrollPercent < 1) {
      setState(() {
        _scrollPercent -= drag / 500;
      });
    } else if (drag > 0.3 && _scrollPercent > 0) {
      setState(() {
        _scrollPercent -= drag / 500;
      });
    }
  }

  void _endCardDrag(DragEndDetails details) {
    setState(() => _isAnimating = true);
    // BottomCard will animate
    if (!_cardIsExpanded &&
        (details.primaryVelocity < -500 || _scrollPercent > 0.6)) {
      _animationScrollPercent =
          Tween<double>(begin: _scrollPercent, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: _bounceOutCurve),
      );
      _animationController.forward();
      setState(() {
        _scrollPercent = 1.0;
        _cardIsExpanded = true;
      });
    } else if (_cardIsExpanded &&
        (details.primaryVelocity > 200 || _scrollPercent < 0.6)) {
      _animationScrollPercent =
          Tween<double>(begin: _scrollPercent, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: _bounceOutCurve),
      );
      _animationController.forward();
      setState(() {
        _scrollPercent = 0.0;
        _cardIsExpanded = false;
      });
    }
    // Card Slider will not expand
    else {
      if (_cardIsExpanded) {
        _animationScrollPercent =
            Tween<double>(begin: _scrollPercent, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: _bounceOutCurve),
        );
        _animationController.forward();
        setState(() => _scrollPercent = 1.0);
      } else {
        _animationScrollPercent =
            Tween<double>(begin: _scrollPercent, end: 0.0).animate(
          CurvedAnimation(parent: _animationController, curve: _bounceOutCurve),
        );
        _animationController.forward();
        setState(() => _scrollPercent = 0.0);
      }
    }
  }

  Widget handle = Icon(
      Icons.remove,
      color: kColorGreen,
      size: 45,
    );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double factor =
            _isAnimating ? _animationScrollPercent.value : _scrollPercent;
        double top = MediaQuery.of(context).size.height -
            widget.minHeight -
            (widget.maxHeight - widget.minHeight) * factor;
        return Positioned(
          top: top,
          child: GestureDetector(
            onVerticalDragStart: _startCardDrag,
            onVerticalDragUpdate: _expandCard,
            onVerticalDragEnd: _endCardDrag,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: widget.maxHeight + 50,
                decoration: BoxDecoration(
                  color: _cardIsExpanded ? widget.backgroundColor : Colors.white,
                  borderRadius: widget.hasRoundedCorners
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        )
                      : null,
                  border: Border.all(
                    color: _cardIsExpanded ? Colors.grey: Colors.transparent
                  ),
                  boxShadow: [
                    if (widget.hasShadow)
                      BoxShadow(
                        blurRadius: 10.0,
                        spreadRadius: 10,
                        color: Colors.blueGrey[900].withOpacity(0.2),
                      )
                  ],
                ),
                child: Padding(
                  padding: widget.padding,
                  child: Column(
                    children: <Widget>[
                      handle,
                      ...widget.children
                    ],
                  ),
                  // child: positionDebugContent,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}



class ExpandableCardPage extends StatelessWidget {
  /// Page that supports a `ExpandableCard`. Usually used as a scaffold's body.
  ///
  ///`page` and `expandableCard` attributes must not be null
  ExpandableCardPage({@required this.page, @required this.expandableCard});

  /// Background page that will be overlayed by the card.
  final Widget page;

  /// Card widget that will expand on user drag, overlaying the `page`
  final ExpandableCard expandableCard;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [page, expandableCard],
    );
  }
}