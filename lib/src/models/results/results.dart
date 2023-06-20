// import 'package:flutter/material.dart';
// import 'package:cers/src/utils/app_const.dart';
// import 'package:cers/src/widgets/app_base_screen.dart';
// import 'package:cers/src/widgets/app_text.dart';

// class results extends StatefulWidget {
//   const results({super.key});

//   @override
//   State<results> createState() => _resultsState();
// }

// class _resultsState extends State<results> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBaseScreen(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: AppConst.primary,
//           centerTitle: true,
//           title: AppText(
//             txt: 'Result of diagnosis',
//             size: 15,
//             color: AppConst.secondary,
//           ),
//         ),
//         bgcolor: AppConst.secondary,
//         child: Column(
//           children: [
//             AppText(
//               txt:
//                   'Please note that the result of this prediction is not a substitute for a professional medical diagnosis. The prediction made by this model is based on the input provided, but it may not be accurate 100% of the time. Any data entered during prediction is not saved or used for any purposes. If you are experiencing any symptoms or concerns, please consult a qualified medical professional immediately. The purpose of this prediction is to be used as a tool for informational purposes only.',
//               size: 15,
//               color: AppConst.primary,
//               weight: FontWeight.w900,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: AppConst.primary,
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 3,
//               child: Card(
//                 color: AppConst.primary,
//                 elevation: 4,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Icon(
//                       Icons.warning_rounded,
//                       color: AppConst.secondary,
//                       size: 60,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: AppText(
//                         txt:
//                             'The result of the prediction indicates that you are at risk of heart disease and should seek medical attention !',
//                         size: 15,
//                         color: AppConst.secondary,
//                         weight: FontWeight.w900,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }
