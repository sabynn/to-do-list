import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_to_do_list/common/styles.dart';

import '../../common/utils.dart';
import '../../injection.dart';
import '../bloc/to_do_list_bloc.dart';
import '../widgets/settings_floating_button.dart';
import '../widgets/to_do_list_card.dart';

class FinishedPage extends StatelessWidget {
  static const ROUTE_NAME = '/finished-page';
  ToDoListBloc toDoListBloc = locator();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => toDoListBloc,
      child: SafeArea(
        child: ToDoListMainPage(),
      ),
    );
  }
}

class ToDoListMainPage extends StatefulWidget {
  @override
  _ToDoListMainPageState createState() => _ToDoListMainPageState();
}

class _ToDoListMainPageState extends State<ToDoListMainPage> with RouteAware {
  late ToDoListBloc toDoListBloc;
  final canHideWidget = false;

  @override
  void initState() {
    super.initState();
    toDoListBloc = BlocProvider.of<ToDoListBloc>(context);
    toDoListBloc.add(EventLoadToDoList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    toDoListBloc.add(EventLoadToDoList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: Text('Done'),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          !canHideWidget ? AnimatedFloatingButton() : Container(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder(
          bloc: toDoListBloc,
          builder: (context, state) {
            if (state is ToDoListStateInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if ((state is ToDoListStateLoaded || state is ToDoListStateSuccess) &&
                toDoListBloc.toDoList.isEmpty) {
              return const Center(
                key: Key('empty_message'),
                child: Text("Nothing Available"),
              );
            } else if ((state is ToDoListStateLoaded || state is ToDoListStateSuccess )&&
                toDoListBloc.toDoList.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final toDo = toDoListBloc.toDoList[index];
                  return toDo.taskStatus == 2
                      ? ToDoListCard(
                          toDo,
                          toDoListBloc,
                          finished: true,
                        )
                      : Container();
                },
                itemCount: toDoListBloc.toDoList.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(toDoListBloc.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
