import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/bloc/we_chat_region_page_bloc.dart';
import 'package:wechat_app/bloc/we_chat_register_page_bloc.dart';
import 'package:wechat_app/data/vos/country_code_vo/country_code_vo.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/resources/dimension.dart';
import 'package:wechat_app/resources/strings.dart';
import 'package:wechat_app/utils/extension.dart';
import 'package:wechat_app/view_items/we_chat_start_item_views/we_chat_register_item_views.dart';
import 'package:wechat_app/widgets/search_textfield_widget.dart';

class WeChatRegionPage extends StatelessWidget {
  const WeChatRegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeChatRegionPageBloc>(
      create: (context) => WeChatRegionPageBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kRegionBackGroundColor,
        appBar: AppBar(
          backgroundColor: kRegionBackGroundColor,
          leading: IconButton(
            onPressed: () => navigateBack(context),
            icon: const Icon(Icons.close),
          ),
          title: const Text(kRegionText),
        ),
        body: Selector<WeChatRegionPageBloc, List<CountryCodeVO>>(
          selector: (context, bloc) => bloc.getRegionList,
          builder: (context, regionList, child) =>
           Column(
            children: [
              SearchTextFieldWidget(
                textColor: Colors.white30,
                color: kStartUpColor,
                onChange: (string) {
                  WeChatRegionPageBloc weChatRegionPageBloc=context.read<WeChatRegionPageBloc>();
                  weChatRegionPageBloc.searchRegionList(string);
                },
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    color: kRegionBackGroundColor,
                    child: AzListView(
                              data: regionList,
                              itemCount: regionList.length,
                              indexBarOptions: const IndexBarOptions(
                                  indexHintAlignment: Alignment.centerRight,
                                  indexHintOffset: Offset(-kAtoZOffsetX, 0)),
                              indexBarMargin: const EdgeInsets.all(kPadSpace10x),
                              indexHintBuilder: (context, hintText) => Container(
                                    width: kAtoZHintWidthAndHeight,
                                    height: kAtoZHintWidthAndHeight,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryLightColor,
                                        shape: BoxShape.circle),
                                    child: Text(
                                      hintText,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                              itemBuilder: (context, index) {
                                return RegionListItemView(
                                  countryCodeVO: regionList[index],
                                  onTap: (countryCodeVO)=>
                                    navigateBack(context,countryCodeVO)
                                );
                              })


                  )),
            ],
          ),
        ),
      ),
    );
  }
}


