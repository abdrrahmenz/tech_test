import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_test/data/model/topic.dart';

class CustomWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final Topic topic;
  final VoidCallback onSelect;

  const CustomWidget({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.topic,
    required this.onSelect,
  }) : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: widget.isSelected ? Border.all(
            color: Colors.white,
            width: 3,
          ) : null,
          image: DecorationImage(
            image: NetworkImage(widget.topic.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.topic.name,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
