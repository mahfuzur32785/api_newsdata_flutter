import 'package:api_project_news_api/enum_data.dart';
import 'package:api_project_news_api/modal/api_modal_class.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../conts/const_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Articles> apiDataList = [];
  int currentIndex = 1;

  String sortBy = NewsEnum.popularity.name;

  /*@override
  void didChangeDependencies() async {
    apiDataList = await ApiModalClass().fetchNewsData();
    setState(() {});
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0xFFF6F6F6),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
        title:
            Text('NewsApi', style: myStyle(color: Colors.black, fontSize: 18)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                color: Colors.white,
                child: Text(
                  'All News',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 35,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (currentIndex > 1) {
                          setState(() {
                            currentIndex = currentIndex - 1;
                          });
                        }
                      },
                      child: Text('Prev'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = index + 1;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 25,
                              alignment: Alignment.center,
                              color: currentIndex == index + 1
                                  ? Colors.blue
                                  : Colors.white,
                              child: Text('${index + 1}'),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (currentIndex < 5) {
                          setState(() {
                            currentIndex = currentIndex + 1;
                          });
                        }
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: DropdownButton(items: [
                    DropdownMenuItem(
                      child: Text('sdf'),
                    )
                  ], onChanged: (value) {})),
              FutureBuilder(
                future: ApiModalClass.fetchNewsData(page: currentIndex),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        child: Text('Something is wrong'),
                      ),
                    );
                  }
                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            height: 130,
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    child: Image(
                                      image: NetworkImage(
                                          '${snapshot.data![index].urlToImage}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 80,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      height: 40,
                                      child: AutoSizeText(
                                        '${snapshot.data![index].title}',
                                        maxLines: 2,
                                        minFontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          '3000',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        //Icon(Icons.timer,color: Colors.grey,),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          height: 30,
                                          child: AutoSizeText(
                                            '${snapshot.data![index].publishedAt}',
                                            style: TextStyle(fontSize: 12),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Container(
                              height: 50,
                              width: 10,
                              color: Colors.grey,
                            ),
                            top: 0,
                            left: 0,
                          ),
                          Positioned(
                            child: Container(
                              height: 50,
                              width: 10,
                              color: Colors.grey,
                            ),
                            right: 0,
                            bottom: 0,
                          ),
                          Positioned(
                            child: Container(
                              height: 10,
                              width: 50,
                              color: Colors.grey,
                            ),
                            top: 0,
                            left: 0,
                          ),
                          Positioned(
                            child: Container(
                              height: 10,
                              width: 50,
                              color: Colors.grey,
                            ),
                            bottom: 0,
                            right: 0,
                          ),
                        ],
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
