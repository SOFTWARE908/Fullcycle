import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullcycle/core/cubit/base_cubit_state.dart';
import 'package:fullcycle/features/main/presentation/widgets/event_card.dart';
import 'package:fullcycle/shared/widgets/custom_loading_widget.dart';

import '../cubit/my_events_cubit.dart';

class JoinedEventsScreen extends StatefulWidget {
  const JoinedEventsScreen({super.key});

  @override
  State<JoinedEventsScreen> createState() => _JoinedEventsScreenState();
}

class _JoinedEventsScreenState extends State<JoinedEventsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyEventsCubit>().getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الفعاليات المنضم إليها'),
        centerTitle: true,
      ),
      body: BlocBuilder<MyEventsCubit, CubitState>(
        builder: (_, state) {
          if (state == CubitState.done) {
            final cubit = context.read<MyEventsCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (_, index) =>
                        EventCard(event: cubit.events[index], isJoined: true),
                    itemCount: cubit.events.length,
                  ),
                ),
              ],
            );
          } else if (state == CubitState.loading) {
            return const CustomLoadingWidget(padding: 50);
          } else if (state == CubitState.error) {
            return const Center(
              child: Text(
                "لا يوجد فعاليات",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
