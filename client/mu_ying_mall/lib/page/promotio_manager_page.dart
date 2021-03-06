import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:mu_ying_mall/utils/network.dart';
import 'package:mu_ying_mall/utils/jump.dart';

class PromotionManagerPage extends StatefulWidget {
  @override
  PromotionManagerState createState() {
    return new PromotionManagerState();
  }
}

class PromotionManagerState extends State<PromotionManagerPage> {
  var _newsAndPromotion = {};

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffoldView(context);
  }

  ///构建基础视图
  Widget _buildScaffoldView(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('活动管理'),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                    itemCount: _newsAndPromotion["promotionList"] == null
                        ? 0
                        : _newsAndPromotion["promotionList"].length,
                    itemBuilder: (context, index) => _buildItem(index)),
              ),
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                  alignment: AlignmentDirectional.center,
                  child: GestureDetector(
                    child: Text(
                      "增加活动",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () => _jumpToEdit(null),
                  )),
            ],
          ),
        ));
  }

  _jumpToEdit(data) {
    jumpToEdit(context, "promotion", data, _onBackFromEdit);
  }

  //从编辑页回来
  _onBackFromEdit(needRefresh) {
    refreshData();
  }

  refreshData() {
    get("queryAllHotPromotion", (newsAndPromotion) {
      setState(() {
        _newsAndPromotion = newsAndPromotion;
      });
    });
  }

  //buildItem
  _buildItem(int index) {
    var news = _newsAndPromotion["promotionList"][index];
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 10,
                  ),
                  Text(
                    news['title'],
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Icon(
                Icons.mode_edit,
                color: Colors.grey,
              ),
              onTap: () => _jumpToEdit(news),
            ),
            Container(
              width: 20,
            )
          ],
        ),
        Container(
          height: 0.1,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        )
      ],
    );
  }
}
