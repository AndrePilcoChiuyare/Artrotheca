import 'package:artrotheca/screens/booking_successful_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:snack/snack.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class BookingConfirmationScreen extends StatefulWidget {
  final Map<String, String> data;

  const BookingConfirmationScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  late Map<String, String> _params;

  @override
  void initState() {
    super.initState();
    _params = widget.data;
    logger.i(_params);
  }

  Future<bool> sendEmail() async {
    const emailJsUserId = 'pxgyNbxu7C4X8yZ7t';
    const emailJsTemplateId = 'template_3jf2g2j';

    final response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin':'http://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': 'service_n12nnsl', // Puedes cambiar esto según tu configuración en EmailJS
        'template_id': emailJsTemplateId,
        'user_id': emailJsUserId,
        'template_params': _params,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  
  Future<void> sendEmailAndNavigate(BuildContext context) async {
    bool emailSent = await sendEmail();
    if(!context.mounted) return;
    if (emailSent) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BookingSuccessfulScreen(),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext builderContext) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'El correo electrónico es incorrecto',
              style: TextStyle(fontSize: 18.0),
            ),
          );
        },
      );
    }
  }

  // void _showMessage(BuildContext context, String message) {
  //   SnackBar(content: Text(message)).show(context);
  // }

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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Resumen de la ',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              )
                            ), 
                            Text(
                              'reserva',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Correo: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['email']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Nombres: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['name']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Apellidos: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['lastName']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Documento: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['docNumber']} (${_params['docType']})',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Teléfono: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['phoneNumber']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Número de adultos: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['adults']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Número de niños: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['children']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w500,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          children: [
                            const Text(
                              'Horario de visita: ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                            Text(
                              '${_params['date']} / ${_params['schedule']}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF0A3006),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'S/. ',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xFF0A3006),
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      Text(
                        '${_params['total']}',
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          sendEmailAndNavigate(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A3006), // Set the background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                          ),
                        ),
                        child: const Text(
                          'Reservar',
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
