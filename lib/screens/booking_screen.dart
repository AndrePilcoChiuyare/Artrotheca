import 'package:artrotheca/screens/booking_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:decorated_dropdownbutton/decorated_dropdownbutton.dart';


var logger = Logger();

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>{
  final termsAndConditions = """
1. Los menores de 15 años no pueden tomar el guiado sin compañía de un tutor (ambos deberán adquirir su guiado).

2. Los menores de edad no pueden estar sin supervisión de su tutor o padre. Cualquier daño, accidente o lesión ocasionado dentro del establecimiento por infringir las normas, el padre o tutor es el responsable directo.

3. La salud general de nuestros visitantes, animales y nuestro equipo es primordial. Si algún visitante atenta contra esta norma, no podrá realizar su visita o guiado.

4. Reservas y Cancelaciones:
    * Al realizar una reserva en nuestro local, se espera que los clientes respeten la hora acordada. En caso de no cumplir con la hora de reserva sin previo aviso, no se otorgará ningún reembolso.
    * Nuestro equipo se esforzará por encontrar una solución alternativa en caso de que se presente algún problema relacionado con la hora de reserva no respetada. Sin embargo, no podemos garantizar disponibilidad o reembolso en tales casos.

5. Si algún visitante no respeta nuestros reglamentos que nos permiten mantener el orden y bienestar, nos reservamos el derecho de retirarlo de nuestro establecimiento, así como si presenta una amenaza real o potencial contra la salud de los demás visitantes, animales residentes o del equipo de Artrotheca.

6. Para tomar la reserva realizada es necesario estar presente en nuestro establecimiento 30 minutos antes, de esta manera podremos agilizar nuestra logística para el inicio de su experiencia con nosotros.

7. Los grupos se formarán como máximo con 10 personas. En el caso de que nuestros visitantes sean un grupo de familia numeroso, se deberán repartir en 2 grupos, tomando como ejemplo 10-10.

8. Se debe mantener el silencio en todo momento, ya que algunos animalitos son propensos a asustarse con el ruido en exceso.

9. Está prohibido abrir las puertas de cada hábitat, golpear los vidrios o apoyarse en los mismos.

10. Los visitantes no pueden separarse del guía, quien estará a cargo de la experiencia vivencial con los animales exóticos.
""";
  TextEditingController dateInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _lastName = '';
  String _docType = 'DNI';
  String _docNumber = '';
  String _phoneNumber = '';
  String _email = '';
  int _adults = 1;
  int _children = 0;
  DateTime dateInit = DateTime.now();
  List<DateTime> dates = [];
  String _date = '';
  int docLen = 8;


  List<String> availableTimes = [];

  String _schedule = '';

  bool termsAccepted = false;

  List<DateTime> getNextTenDays() {
    var now = DateTime.now();
    return List<DateTime>.generate(10, (i) => now.add(Duration(days: i)));
  }

  @override
  void initState(){
    dateInput.text = "";
    dates = getNextTenDays();
    dateInit = dates[0];
    _date = DateFormat('dd-MM-yy').format(dateInit);
    logger.i(dateInit);
    logger.i(dates);
    availableTimes = getAvailableTimes();
    super.initState();
  }

  List<String> getAvailableTimes() {
    List<String> times = [
    '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM'
  ];
    DateTime now = DateTime.now();

    // Filter out past times
    List<String> filteredTimes = times.where((time) {
      var timeOfDay = TimeOfDay(
        hour: int.parse(time.split(':')[0]),
        minute: int.parse(time.split(':')[1].split(' ')[0]),
      );

      if (time.contains('PM') || time.contains('pm')) {
        if (timeOfDay.hour != 12) {
          timeOfDay = TimeOfDay(hour: timeOfDay.hour + 12, minute: timeOfDay.minute);
        }
      }

      DateTime selectedDateTime = DateTime(
        dateInit.year,
        dateInit.month,
        dateInit.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );

      return now.isBefore(selectedDateTime);
    }).toList();

    return filteredTimes;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A3006),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const Row(
                          children: [
                            Text(
                              'Haz tu ',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              )
                            ), 
                            Text(
                              'reserva ahora',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Nombres',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF0A3006)),
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              //change the height
                              contentPadding: EdgeInsets.all(10.0),
                            ),
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingresa tu(s) nombre(s)';
                            }
                            return null;
                            },
                            onSaved: (value) {
                              _name = value ?? '';
                            },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Apellidos',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF0A3006), width: 4.0),
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tus apellidos';
                          }
                          return null;
                          },
                          onSaved: (value) {
                            _lastName = value ?? '';
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF0A3006), width: 4.0),
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu correo electrónico';
                          }
                          return null;
                          },
                          onSaved: (value) {
                            _email = value ?? '';
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          maxLength: 9,
                          decoration: const InputDecoration(
                            counterText: '',
                            labelText: 'Teléfono',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF0A3006), width: 4.0),
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          textInputAction: TextInputAction.go,
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu número de teléfono';
                          }
                          return null;
                          },
                          onSaved: (value) {
                            _phoneNumber = value ?? '';
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DecoratedDropdownButton(
                                items: const [
                                  DropdownMenuItem(value: 'DNI', child: Text('DNI'),),
                                  DropdownMenuItem(value: 'RUC', child: Text('RUC'),),
                                  DropdownMenuItem(value: 'Carnet de extranjería', child: Text('Carnet de extranjería'),),
                                  DropdownMenuItem(value: 'Pasaporte', child: Text('Pasaporte'),),
                                ],
                                value: _docType,
                                border: Border.all(color: const Color(0xFF696969),width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                                style: const TextStyle( //text style
                                  color:Colors.black,
                                  fontSize: 18
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _docType = value.toString();
                                    switch(_docType){
                                      case 'DNI':
                                        docLen = 8;
                                        break;
                                      case 'RUC':
                                        docLen = 11;
                                        break;
                                      case 'Carnet de extranjería':
                                        docLen = 12;
                                        break;
                                      case 'Pasaporte':
                                        docLen = 12;
                                        break;
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                maxLength: docLen,
                                decoration: const InputDecoration(
                                  counterText: '',
                                  labelText: 'Documento',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xFF0A3006), width: 4.0),
                                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ingresa un número de documento';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _docNumber = value ?? '';
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_adults + _children > 10) const Text(
                              'El máximo por reserva es de 10 personas',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Color(0xFF0A3006),
                                  size: 30.0,
                                ),
                                Text(
                                  ' $_adults',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF0A3006),
                                    fontWeight: FontWeight.w500,
                                  )
                                ),
                                const Text(
                                  ' adulto(s) - S/ 33.00',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF0A3006),
                                    fontWeight: FontWeight.w500,
                                  )
                                ), 
                              ],
                            ),
                            Slider(
                              value: _adults.toDouble(),
                              min: 1,
                              max: 10,
                              divisions: 9,
                              onChanged: (double value) {
                                if(_children + value <= 10){
                                  setState(() {
                                    _adults = value.toInt();
                                  });
                                }
                                else{
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builderContext) {
                                      return Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'El máximo por reserva es 10 personas',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.child_care_sharp,
                                  color: Color(0xFF0A3006),
                                  size: 30.0,
                                ),
                                Text(
                                  ' $_children',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF0A3006),
                                    fontWeight: FontWeight.w500,
                                  )
                                ),
                                const Text(
                                  ' niño(s) (hasta 10 años) - S/ 21.00',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF0A3006),
                                    fontWeight: FontWeight.w500,
                                  )
                                ),
                              ],
                            ),
                            Slider(
                              value: _children.toDouble(),
                              min: 0,
                              max: 10,
                              divisions: 10,
                              onChanged: (double value) {
                                if(_adults + value <= 10){
                                  setState(() {
                                    _children = value.toInt();
                                  });
                                }
                                else{
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builderContext) {
                                      return Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'El máximo por reserva es 10 personas',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Horario de visita',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Color(0xFF0A3006),
                                fontWeight: FontWeight.w800,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          height: 40.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dates.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    dateInit = dates[index];
                                    _date = DateFormat('dd-MM-yy').format(dateInit);
                                    availableTimes = getAvailableTimes();
                                    _schedule = '';
                                    logger.i(_date);
                                    logger.i(availableTimes);
                                  });

                                  if(availableTimes.isEmpty){
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext builderContext) {
                                        return Container(
                                          padding: const EdgeInsets.all(16.0),
                                          child: const Text(
                                            'No hay horarios disponibles para esta fecha',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: dateInit == dates[index]
                                        ? const Color(0xFF0A3006)
                                        : const Color(0xFFC4DBA5),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    DateFormat('dd-MM-yy').format(dates[index]),
                                    style: TextStyle(
                                      color: dateInit == dates[index]
                                        ? Colors.white
                                        : const Color(0xFF0A3006),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          height: 40.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: availableTimes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _schedule = availableTimes[index];
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: _schedule == availableTimes[index]
                                        ? const Color(0xFF0A3006)
                                        : const Color(0xFFC4DBA5),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    availableTimes[index],
                                    style: TextStyle(
                                      color: _schedule == availableTimes[index]
                                        ? Colors.white
                                        : const Color(0xFF0A3006),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        //checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: termsAccepted,
                              onChanged: (bool? value) {
                                setState(() {
                                  termsAccepted = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              'Acepto los ',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF0A3006),
                              )
                            ),
                            GestureDetector(
                              onTap: () {
                                //popup showing the terms and conditions
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Términos y condiciones'),
                                    content: SingleChildScrollView(
                                      child: Text(
                                      termsAndConditions,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF0A3006),
                                      ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cerrar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                'términos y condiciones',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF0A3006),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                )
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60.0),
                      ]
                    ),
                  ),
                ),
              ],
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
                          fontWeight: FontWeight.w800,
                        )
                      ),
                      Text(
                        '${33 * _adults + 21 * _children}',
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w800,
                        )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true && _schedule.isNotEmpty && termsAccepted && _adults + _children <= 10) {
                            _formKey.currentState?.save();
                            final params = {
                              'name': _name,
                              'lastName': _lastName,
                              'docType': _docType,
                              'docNumber': _docNumber,
                              'phoneNumber': _phoneNumber,
                              'email': _email,
                              'adults': _adults.toString(),
                              'children': _children.toString(),
                              'date': _date,
                              'schedule': _schedule,
                              'total': '${33 * _adults + 21 * _children}',
                            };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingConfirmationScreen(data: params),
                              ),
                            );
                            // _showMessage(context, "Reserva realizada con éxito, revisa tu correo electrónico");
                            // sendEmail();
                          } else {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builderContext) {
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: const Text(
                                    'Completa correctamente todos los campos',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                );
                              },
                            );
                            logger.i(dates);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A3006), // Set the background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
                          ),
                        ),
                        child: const Text(
                          'Resumen',
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