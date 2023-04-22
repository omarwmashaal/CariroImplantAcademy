import 'package:cariro_implant_academy/Models/API_Response.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../Constants/Colors.dart';

class CIA_FutureBuilder extends StatefulWidget {
  CIA_FutureBuilder({Key? key, required this.loadFunction, required this.onSuccess, this.onFailed}) : super(key: key);
  Future<API_Response> loadFunction;
  Widget Function(dynamic data) onSuccess;
  Function? onFailed;
  @override
  State<CIA_FutureBuilder> createState() => _CIA_FutureBuilderState();
}

class _CIA_FutureBuilderState extends State<CIA_FutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<API_Response>(
        future: widget.loadFunction,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           if(snapshot.data!.statusCode == 200)
             {
               return widget.onSuccess(snapshot.data!.result);
             }
           else
             {
               if(widget.onFailed!=null) widget.onFailed!();
               return Center(
                 child: LoadingIndicator(
                   indicatorType: Indicator.ballClipRotateMultiple,
                   colors: [Color_Accent],
                 ),
               );
             }

          }
          else {
            return Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color_Accent],
              ),
            );
          }
        });
  }
}
