import 'package:flutter/material.dart';
import 'package:hundredminute_seller/view/screens/transaction/widget/transaction_widget.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/theme_provider.dart';
import '../../../provider/transaction_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_screen.dart';

class TransactionScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).getTransactionList(context);
    Provider.of<TransactionProvider>(context, listen: false).initMonthTypeList();


    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('transaction_screen', context)),
      body: SafeArea(
        child: Consumer<TransactionProvider>(
          builder: (context, transactionProvider, child) => Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorResources.getBottomSheetColor(context),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
                  ),
                  child: DropdownButton<String>(
                    hint: Text('Select Month'),
                    dropdownColor: ColorResources.getHomeBg(context),
                    icon: Icon(Icons.arrow_drop_down,color: ColorResources.getTextColor(context), size: 30,),
                    isExpanded: true,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                    underline: SizedBox(),
                    value: transactionProvider.chooseMonth,
                    onChanged: (String? query) {
                      transactionProvider.filterProduct(transactionProvider.monthItemList.indexOf(query!), context);
                    },
                    items: transactionProvider.monthItemList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: titilliumRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Expanded(
                  child: transactionProvider.transactionList !=null ? transactionProvider.transactionList.isNotEmpty ? ListView.builder(
                    itemCount: transactionProvider.transactionList.length,
                    itemBuilder: (context, index) => TransactionWidget(transactionModel: transactionProvider.transactionList[index])
                ): NoDataScreen()
                      : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
