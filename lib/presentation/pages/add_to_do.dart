import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_to_do_list/data/models/to_do_table.dart';
import 'package:sm_to_do_list/presentation/bloc/to_do_list_bloc.dart';

import '../../common/styles.dart';
import '../../injection.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class AddToDoPage extends StatelessWidget {
  static const ROUTE_NAME = '/add-to-do';
  final ToDoListBloc toDoDetailLocator = locator();

  AddToDoPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => toDoDetailLocator,
      child: Scaffold(
        body: AddToDoMain(),
      ),
    );
  }
}

class AddToDoMain extends StatefulWidget {
  AddToDoMain({Key? key}) : super(key: key);

  @override
  State<AddToDoMain> createState() => _AddToDoMainState();
}

class _AddToDoMainState extends State<AddToDoMain> {
  late ToDoListBloc toDoListBloc;
  final TextEditingController titleController = TextEditingController(text: '');

  final TextEditingController typeController = TextEditingController(text: '');

  final TextEditingController dateController = TextEditingController(text: '');

  final TextEditingController timeController = TextEditingController(text: '');

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    toDoListBloc = BlocProvider.of<ToDoListBloc>(
      context,
    );
    toDoListBloc.add(EventLoadToDoList());
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990, 1),
      lastDate: DateTime(2023),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.blue, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kDarkColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeController.text = '$picked'.substring(10, 15);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dateController.text = selectedDate.toString().substring(0, 10);
    timeController.text = selectedTime.toString().substring(10, 15);

    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          'Add your new to do',
          style: darkTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget titleInput() {
        return CustomTextFormField(
          title: 'Title',
          hintText: 'Enter the title of to do',
          controller: titleController,
        );
      }

      Widget notesInput() {
        return CustomTextFormField(
          title: 'Type',
          hintText: 'Enter to do type',
          controller: typeController,
        );
      }

      Widget dateInput(
        String text,
        TextEditingController controller,
        String hintText,
      ) {
        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
              ),
              const SizedBox(
                height: 3,
              ),
              TextFormField(
                cursorColor: const Color(0xffa9bbea),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    borderSide: const BorderSide(
                      color: Color(0xff456ed9),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      text == "Date"
                          ? Icons.calendar_today_rounded
                          : Icons.access_alarm,
                    ),
                    onPressed: () {
                      text == "Date"
                          ? _selectDate(context)
                          : _selectTime(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }

      Widget submitButton() {
        return CustomButton(
          title: 'Add',
          onPressed: () {
            toDoListBloc.add(
              EventAddToDoList(
                toDoListTable: ToDoList(
                  UniqueKey().hashCode,
                  titleController.text,
                  typeController.text,
                  0,
                  "0%",
                  dateController.text,
                  timeController.text,
                ),
              ),
            );

            Navigator.pop(context);
          },
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(
            defaultRadius,
          ),
        ),
        child: Column(
          children: [
            titleInput(),
            notesInput(),
            dateInput("Date", dateController, "Input date"),
            dateInput("Time", timeController, "Input time"),
            submitButton(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            title(),
            inputSection(),
          ],
        ),
      ),
    );
  }
}
