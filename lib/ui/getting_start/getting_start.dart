import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_test/ui/topic/topic_screen.dart';
import 'package:tech_test/utils/app_colors.dart';

class GettingStart extends StatelessWidget {
  const GettingStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Swipe.',
                      style: TextStyle(
                        fontSize: 52,
                        color: colorSecondary,
                      ),
                    ),
                    Text(
                      'Read.',
                      style: TextStyle(
                        fontSize: 52,
                        color: colorSecondary,
                      ),
                    ),
                    Text(
                      'Learn.',
                      style: TextStyle(fontSize: 52, color: colorSecondary),
                    ),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  backgroundColor: colorSecondary,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopicScreen()),
                  );
                },
                child: Text(
                  'Start Reading',
                  style: GoogleFonts.roboto(
                    color: colorButton,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(
                  text: 'Already have an account?',
                  style: GoogleFonts.roboto(color: colorGrey),
                  children: [
                    TextSpan(
                      text: ' Log In',
                      style: GoogleFonts.roboto(color: colorSecondary),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
