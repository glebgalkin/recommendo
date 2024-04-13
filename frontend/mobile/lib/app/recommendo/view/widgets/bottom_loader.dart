import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendo/app/recommendo/view/bloc/recommendations_list_bloc.dart';

class BottomLoader extends StatefulWidget {
  const BottomLoader({super.key});

  @override
  State<BottomLoader> createState() => _BottomLoaderState();
}

class _BottomLoaderState extends State<BottomLoader> {
  @override
  void initState() {
    super.initState();
    context.read<RecommendationsListBloc>().add(const RecommendationsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
