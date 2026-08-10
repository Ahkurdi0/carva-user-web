import 'package:flutter/material.dart';
import 'package:kcars/core/widget/loading_emoty_state.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircleLoading());
  }
}
