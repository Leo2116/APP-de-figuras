import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppFiguras());
}

class MyAppFiguras extends StatelessWidget {
  const MyAppFiguras({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cuadrado y Triángulo',
            style: TextStyle(color: Colors.purple),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: const Cuerpo(),
      ),
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({Key? key});

  @override
  State<Cuerpo> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Cuerpo> {
  String _figure = '';
  String _currentFigure =
      ''; // Variable para almacenar la figura actualmente seleccionada

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            '¿Qué figura deseas ver?',
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              setState(() {
                _figure =
                    value; // Actualiza la variable _figure pero no cambia la figura dibujada aún
              });
            },
            decoration: InputDecoration(
              hintText: 'Escribe el nombre de la figura',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentFigure =
                    _figure; // Cambia la figura actualmente seleccionada cuando se presiona el botón
              });
            },
            child: const Text('Aceptar'),
          ),
          const SizedBox(height: 20),
          CustomPaint(
            size: Size(300, 300), // Tamaño del área de dibujo
            painter: _FigurePainter(
                figure:
                    _currentFigure), // Usa _currentFigure para decidir qué pintar
          ),
        ],
      ),
    );
  }
}

class _FigurePainter extends CustomPainter {
  final String figure;

  _FigurePainter({required this.figure});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 14, 215, 233)
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    switch (figure.toLowerCase()) {
      case 'triángulo':
        _drawTriangle(canvas, paint, center, size.width / 3);
        break;
      case 'cuadrado':
        _drawSquare(canvas, paint, center, size.width / 3);
        break;
      default:
        _drawText(canvas, paint, center, 'La figura no fue encontrada');
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _drawTriangle(Canvas canvas, Paint paint, Offset center, double side) {
    final path = Path();
    path.moveTo(center.dx, center.dy - side / 2);
    path.lineTo(center.dx + side / 2, center.dy + side / 2);
    path.lineTo(center.dx - side / 2, center.dy + side / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSquare(Canvas canvas, Paint paint, Offset center, double side) {
    final rect = Rect.fromCenter(center: center, width: side, height: side);
    canvas.drawRect(rect, paint);
  }

  void _drawText(Canvas canvas, Paint paint, Offset center, String text) {
    final textStyle = TextStyle(
      color: Color.fromARGB(255, 233, 11, 11),
      fontSize: 16,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    final textOffset = Offset(
        center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }
}
