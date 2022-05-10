import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:pr3/modules/webview/webview_screan.dart';

Widget buildArticleItem(list, context) => InkWell(
      onTap: () {
        navigationTo(context, WebviewScrean(list['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    '${list['urlToImage']}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 19.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,

                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Text(
                        '${list['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${list['publishedAt']}',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildSparate() => Padding(
      padding: EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articalBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (BuildContext context, int index) => buildSparate(),
          itemCount: list.length,
        ),
    fallback: (context) =>
        isSearch ? Container() : Center(child: CircularProgressIndicator()));

void navigationTo(context, Widget) => Navigator.push(
    context, MaterialPageRoute(builder: (BuildContext context) => Widget));
