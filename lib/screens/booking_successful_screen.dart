import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class BookingSuccessfulScreen extends StatefulWidget {
  const BookingSuccessfulScreen({Key? key}) : super(key: key);

  @override
  State<BookingSuccessfulScreen> createState() => _BookingSuccessfulScreenState();
}

class _BookingSuccessfulScreenState extends State<BookingSuccessfulScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A3006),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 85.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 20.0),
                          color: const Color(0xFF0A3006),
                          child: const Image(
                            image: AssetImage('lib/assets/img/logoMOI.png'),
                            height: 100.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 80.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage('lib/assets/img/successfulPayment.png'),
                              height: 300.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reserva exitosa',
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Revisa tu correo para más información',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF92CC7D),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomAppBar(
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //navigate to booking_screen but initializing everything again
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A3006), // Set the background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                          ),
                        ),
                        child: const Text(
                          'Listo',
                          style: TextStyle(color: Colors.white, fontSize: 18.0), // Set the text color to white
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}