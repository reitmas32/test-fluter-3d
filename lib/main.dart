import 'package:flutter/material.dart';
import 'package:flutter_3d_objects/flutter_3d_objects.dart';
import 'package:flutter_3d_objects/src/material.dart' as tree_material;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Scene with Flutter Cube',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Scene _scene;
  double x = 0;
  double y = 3;
  double z = 8;
  double rotationX = 0;
  double rotationY = 0;
  Object? _p;

  double rotationX_1 = 0;
  double rotationY_1 = 0;
  Object? _p_1;

  @override
  void initState() {
    super.initState();
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.z = z;
    scene.camera.position.y = y;
    scene.camera.position.x = x;

    _p = Object(
        position: Vector3(0, 0, 0),
        scale: Vector3(10, 10, 10),
        fileName: 'assets/4.obj',);

    scene.world.add(_p!);
  }

    void _onSceneCreated_1(Scene scene) {
    _scene = scene;
    scene.camera.position.z = z;
    scene.camera.position.y = y;
    scene.camera.position.x = x;

    _p_1 = Object(
        position: Vector3(0.02, 0.02, 0.02),
        scale: Vector3(10, 10, 10),
        fileName: 'assets/4.obj',
      );

    scene.world.add(_p_1!);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final dx = details.delta.dx;
      final dy = details.delta.dy;

      rotationY += dx * 0.1; // Ajusta la sensibilidad del movimiento horizontal
      rotationX += dy * 0.1; // Ajusta la sensibilidad del movimiento vertical

      rotationY_1 +=
          dx * 0.1; // Ajusta la sensibilidad del movimiento horizontal
      rotationX_1 += dy * 0.1; // Ajusta la sensibilidad del movimiento vertical

      if (_p != null) {
        _p!.rotation.y = rotationY;
        _p!.rotation.x = rotationX;
        _p!.updateTransform();
        _scene.update();
      }

      if (_p_1 != null) {
        _p_1!.rotation.y = rotationY;
        _p_1!.rotation.x = rotationX;
        _p_1!.updateTransform();
        _scene.update();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 44, 71),
      appBar: AppBar(
        title: const Text('3D Object Viewer'),
      ),
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: Cube(
                interactive: false,
                zoom: false,
                onSceneCreated: _onSceneCreated,
              ),
            ),
            Opacity(
              opacity: 0.2,
              child: Cube(
                interactive: false,
                zoom: false,
                onSceneCreated: _onSceneCreated_1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
