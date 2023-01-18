import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_state_button/multi_state_button.dart';

class CIA_MultiStateButton extends StatelessWidget {
  CIA_MultiStateButton(
      {Key? key,
      required this.currentState,
      required this.onChange,
      this.states})
      : super(key: key);
  static const String _planned = "Planned";
  static const String _progress = "In Progress";
  static const String _completed = "Completed";
  Function onChange;
  String currentState;
  List<MultiStateButtonCustomState>? states;

  late MultiStateButtonController multiStateButtonController;

  @override
  Widget build(BuildContext context) {
    if (states == null) {
      switch (currentState) {
        case "In Progress":
          multiStateButtonController =
              MultiStateButtonController(initialStateName: _progress);
          break;
        case "Planned":
          multiStateButtonController =
              MultiStateButtonController(initialStateName: _planned);
          break;
        case "Completed":
          multiStateButtonController =
              MultiStateButtonController(initialStateName: _completed);
          break;
        default:
          multiStateButtonController =
              MultiStateButtonController(initialStateName: _completed);
      }
      return MultiStateButton(
        multiStateButtonController: multiStateButtonController,
        buttonStates: [
          ButtonState(
              stateName: _planned,
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(48)),
              ),
              size: Size(30, 30),
              onPressed: () {
                multiStateButtonController.setButtonState = _progress;
                onChange(_progress);
              }),
          ButtonState(
            stateName: _progress,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            size: Size(30, 30),
            onPressed: () {
              multiStateButtonController.setButtonState = _completed;
              onChange(_completed);
            },
          ),
          ButtonState(
            stateName: _completed,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(48)),
            ),
            size: Size(30, 30),
          ),
        ],
      );
    } else {
      multiStateButtonController =
          MultiStateButtonController(initialStateName: states![0].name);
      List<ButtonState> _states = [];
      int i = 0;
      for (MultiStateButtonCustomState state in states!) {
        _states.add(ButtonState(
            stateName: state.name,
            alignment: Alignment.center,
            child: state.widget,
            onPressed: () {
              if (states![i + 1] != null) {
                multiStateButtonController.setButtonState = states![i + 1].name;
                onChange(state.onPressed);
              } else {
                multiStateButtonController.setButtonState = states![0].name;
                onChange(states![0].onPressed);
              }
            }));
        i++;
      }
      return MultiStateButton(
        multiStateButtonController: multiStateButtonController,
        buttonStates: _states,
      );
    }
  }
}

class MultiStateButtonCustomState {
  String name;
  Widget widget;
  Function onPressed;

  MultiStateButtonCustomState(
      {required this.name, required this.widget, required this.onPressed});
}
