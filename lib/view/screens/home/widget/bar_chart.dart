import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/styles.dart';

class EarningChart extends StatefulWidget {
  final List<double> earnings;
  final double max;
  EarningChart({@required this.earnings, @required this.max});

  @override
  State<StatefulWidget> createState() => EarningChartState();
}

class EarningChartState extends State<EarningChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_DEFAULT),
          color: ColorResources.getBottomSheetColor(context),
        ),
        child: Column(children: [
          Text(getTranslated('monthly_earning', context), style: titilliumSemiBold.copyWith(
              color: ColorResources.getPrimary(context),
              fontSize: Dimensions.FONT_SIZE_DEFAULT),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
          Expanded(
            child: SizedBox(
              height: 350,
              child: BarChart(
                mainBarData(context),
              ),
            ),
          ),
        ],),
      )
    );
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
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [ColorResources.getPrimary(context)] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: widget.max,
            colors: [ColorResources.getGrey(context).withOpacity(0.9)]
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, widget.earnings[0], isTouched: i == touchedIndex);
      case 1:
        return makeGroupData(1, widget.earnings[1], isTouched: i == touchedIndex);
      case 2:
        return makeGroupData(2, widget.earnings[2], isTouched: i == touchedIndex);
      case 3:
        return makeGroupData(3, widget.earnings[3], isTouched: i == touchedIndex);
      case 4:
        return makeGroupData(4, widget.earnings[4], isTouched: i == touchedIndex);
      case 5:
        return makeGroupData(5, widget.earnings[5], isTouched: i == touchedIndex);
      case 6:
        return makeGroupData(6, widget.earnings[6], isTouched: i == touchedIndex);
      case 7:
        return makeGroupData(7, widget.earnings[7], isTouched: i == touchedIndex);
      case 8:
        return makeGroupData(8, widget.earnings[8], isTouched: i == touchedIndex);
      case 9:
        return makeGroupData(9, widget.earnings[9], isTouched: i == touchedIndex);
      case 10:
        return makeGroupData(10, widget.earnings[10], isTouched: i == touchedIndex);
      case 11:
        return makeGroupData(11, widget.earnings[11], isTouched: i == touchedIndex);
      default:
        return null;
    }
  });

  BarChartData mainBarData(BuildContext context) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Theme.of(context).primaryColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String month;
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
                month + '\n',
                TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold, fontSize: 18),
                children: [
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          rotateAngle: 45,
        //  getTextStyles: (value) => TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12.0),
          margin: 10,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Jan';
              case 1:
                return 'Feb';
              case 2:
                return 'Mar';
              case 3:
                return 'Apr';
              case 4:
                return 'May';
              case 5:
                return 'Jun';
              case 6:
                return 'Jul';
              case 7:
                return 'Aug';
              case 8:
                return 'Sep';
              case 9:
                return 'Oct';
              case 10:
                return 'Nov';
              case 11:
                return 'Dec';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
    );
  }
}