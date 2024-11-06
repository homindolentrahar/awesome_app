import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: const _GalleryLayout(),
    );
  }
}

class _GalleryLayout extends StatelessWidget {
  const _GalleryLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Gallery Page"),
      ),
    );
  }
}

