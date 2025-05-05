// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class LineChartSample extends StatelessWidget {
//   const LineChartSample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: const Color(0xffe7e8ec),
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: const Color(0xffe7e8ec),
//               strokeWidth: 1,
//             );
//           },
//         ),
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 const style = TextStyle(
//                   color: Color(0xff67727d),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 );
//                 String text;
//                 switch (value.toInt()) {
//                   case 2:
//                     text = 'MAR';
//                     break;
//                   case 5:
//                     text = 'JUN';
//                     break;
//                   case 8:
//                     text = 'SEP';
//                     break;
//                   default:
//                     return Container();
//                 }
//                 return SideTitleWidget(
//                   axisSide: meta.axisSide,
//                   space: 8.0,
//                   child: Text(text, style: style),
//                 );
//               },
//               reservedSize: 32,
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 const style = TextStyle(
//                   color: Color(0xff67727d),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 );
//                 String text;
//                 switch (value.toInt()) {
//                   case 1:
//                     text = '10k';
//                     break;
//                   case 3:
//                     text = '30k';
//                     break;
//                   case 5:
//                     text = '50k';
//                     break;
//                   default:
//                     return Container();
//                 }
//                 return Text(text, style: style, textAlign: TextAlign.left);
//               },
//               reservedSize: 40,
//             ),
//           ),
//           topTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           rightTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(color: const Color(0xffe7e8ec), width: 1),
//         ),
//         minX: 0,
//         maxX: 11,
//         minY: 0,
//         maxY: 6,
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 3),
//               FlSpot(2.6, 2),
//               FlSpot(4.9, 5),
//               FlSpot(6.8, 3.1),
//               FlSpot(8, 4),
//               FlSpot(9.5, 3),
//               FlSpot(11, 4),
//             ],
//             isCurved: true,
//             // colors: [Colors.blue],
//             barWidth: 4,
//             isStrokeCapRound: true,
//             dotData: FlDotData(
//               show: false,
//             ),
//             belowBarData: BarAreaData(
//               show: true,
//               // colors: [Colors.blue.withOpacity(0.3)],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
