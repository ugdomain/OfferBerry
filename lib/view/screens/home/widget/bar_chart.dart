import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class EarningChart extends StatefulWidget {
  final List<double>? earnings;
  final double? max;
  const EarningChart({@required this.earnings, @required this.max});

  @override
  State<StatefulWidget> createState() => EarningChartState();
}

class EarningChartState extends State<EarningChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
            color: ColorResources.getBottomSheetColor(context),
          ),
          child: Column(
            children: [
              Text(
                getTranslated('monthly_earning', context),
                style: titilliumSemiBold.copyWith(
                    color: ColorResources.getPrimary(context),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              Expanded(
                child: SizedBox(
                  height: 350,
                  child: BarChart(
                    mainBarData(context),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = ColorResources.LIGHT_SKY_BLUE,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? ColorResources.getPrimary(context) : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: widget.max,
              color: ColorResources.getGrey(context).withOpacity(0.9)),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(
        12,
        (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, widget.earnings![0],
                  isTouched: i == touchedIndex);
            case 1:
              return makeGroupData(1, widget.earnings![1],
                  isTouched: i == touchedIndex);
            case 2:
              return makeGroupData(2, widget.earnings![2],
                  isTouched: i == touchedIndex);
            case 3:
              return makeGroupData(3, widget.earnings![3],
                  isTouched: i == touchedIndex);
            case 4:
              return makeGroupData(4, widget.earnings![4],
                  isTouched: i == touchedIndex);
            case 5:
              return makeGroupData(5, widget.earnings![5],
                  isTouched: i == touchedIndex);
            case 6:
              return makeGroupData(6, widget.earnings![6],
                  isTouched: i == touchedIndex);
            case 7:
              return makeGroupData(7, widget.earnings![7],
                  isTouched: i == touchedIndex);
            case 8:
              return makeGroupData(8, widget.earnings![8],
                  isTouched: i == touchedIndex);
            case 9:
              return makeGroupData(9, widget.earnings![9],
                  isTouched: i == touchedIndex);
            case 10:
              return makeGroupData(10, widget.earnings![10],
                  isTouched: i == touchedIndex);
            case 11:
              return makeGroupData(11, widget.earnings![11],
                  isTouched: i == touchedIndex);
            default:
              return null!;
          }
        },
      );

  BarChartData mainBarData(BuildContext context) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Theme.of(context).primaryColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String? month;
              switch (group.x.toInt()) {
                case 0:
                  month = 'January';
                  break;
                case 1:
                  month = 'February';
                  break;
                case 2:
                  month = 'March';
                  break;
                case 3:
                  month = 'April';
                  break;
                case 4:
                  month = 'May';
                  break;
                case 5:
                  month = 'June';
                  break;
                case 6:
                  month = 'July';
                  break;
                case 7:
                  month = 'August';
                  break;
                case 8:
                  month = 'September';
                  break;
                case 9:
                  month = 'October';
                  break;
                case 10:
                  month = 'November';
                  break;
                case 11:
                  month = 'December';
                  break;
              }
              return BarTooltipItem(
                '${month!}\n',
                TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                children: [
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback:
            (FlTouchEvent? touchEvent, BarTouchResponse? barTouchResponse) {
          setState(() {
            if (barTouchResponse != null) {
              if (barTouchResponse.spot != null &&
                  barTouchResponse.spot is! PointerUpEvent &&
                  barTouchResponse.spot is! PointerExitEvent) {
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              } else {
                touchedIndex = -1;
              }
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          //  getTextStyles: (value) => TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12.0),
          interval: 10,
          getTitlesWidget: (double value, t) {
            switch (value.toInt()) {
              case 0:
                return const Text('Jan');
              case 1:
                return const Text('Feb');
              case 2:
                return const Text('Mar');
              case 3:
                return const Text('Apr');
              case 4:
                return const Text('May');
              case 5:
                return const Text('Jun');
              case 6:
                return const Text('Jul');
              case 7:
                return const Text('Aug');
              case 8:
                return const Text('Sep');
              case 9:
                return const Text('Oct');
              case 10:
                return const Text('Nov');
              case 11:
                return const Text('Dec');
              default:
                return const Text('');
            }
          },
        )),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
    );
  }
}
