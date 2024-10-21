import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trello/export.dart';
import 'package:trello/pages/login.dart';
import 'package:trello/values/query.dart';
import 'package:trello/values/local.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var nw;
  var progres;
  var review;
  var done;
  ScrollController scr = ScrollController();
  String apptitle = 'Topshiriqlar';
  bool islist = true;
  int curind = 0;
  @override
  void initState() {
    getTask().then((value) {
      nw = (value as List)
          .where((element) => element['status'] == 'new')
          .toList();
      progres = (value)
          .where((element) => element['status'] == "in_progress")
          .toList();
      review =
          (value).where((element) => element['status'] == 'in_review').toList();
      done = (value).where((element) => element['status'] == 'done').toList();
    });
    super.initState();
  }

  saveState() async {
    List result = (nw + progres + review + done).toList();
    await setstring('tasks', jsonEncode(result).toString());
  }

  comDrag(List rece, dynamic details) async {
    if (details.data['status'] == "new") {
      var sts = rece[0]['status'];
      nw.removeWhere(
          (value) => value['task_id'] == (details.data as Map)['task_id']);
      rece.add(details.data);
      for (var i = 0; i < (rece).length; i++) {
        rece[i]['index'] = i;
        rece[i]['status'] = sts.toString();
      }
      if (sts == "in_progress") progres = rece;
      if (sts == "in_review") review = rece;
      if (sts == "done") done = rece;
      List result = (nw + progres + review + done).toList();
      await setstring('tasks', jsonEncode(result).toString());
    }
    if (details.data['status'] == "in_progress") {
      var sts = rece[0]['status'];
      progres.removeWhere(
          (value) => value['task_id'] == (details.data as Map)['task_id']);
      rece.add(details.data);
      for (var i = 0; i < (rece).length; i++) {
        rece[i]['index'] = i;
        rece[i]['status'] = sts.toString();
      }
      if (sts == "new") nw = rece;
      if (sts == "in_review") review = rece;
      if (sts == "done") done = rece;
      List result = (nw + progres + review + done).toList();
      await setstring('tasks', jsonEncode(result).toString());
    }
    if (details.data['status'] == "in_review") {
      var sts = rece[0]['status'];
      review.removeWhere(
          (value) => value['task_id'] == (details.data as Map)['task_id']);
      rece.add(details.data);
      for (var i = 0; i < (rece).length; i++) {
        rece[i]['index'] = i;
        rece[i]['status'] = sts.toString();
      }
      if (sts == "in_progress") progres = rece;
      if (sts == "new") nw = rece;
      if (sts == "done") done = rece;
      List result = (nw + progres + review + done).toList();
      await setstring('tasks', jsonEncode(result).toString());
    }
    if (details.data['status'] == "done") {
      var sts = rece[0]['status'];
      done.removeWhere(
          (value) => value['task_id'] == (details.data as Map)['task_id']);
      rece.add(details.data);
      for (var i = 0; i < (rece).length; i++) {
        rece[i]['index'] = i;
        rece[i]['status'] = sts.toString();
      }
      if (sts == "in_progress") progres = rece;
      if (sts == "in_review") review = rece;
      if (sts == "new") nw = rece;
      List result = (nw + progres + review + done).toList();
      await setstring('tasks', jsonEncode(result).toString());
    }
  }

  saveDrag(List send, List receiv, dynamic details, String status) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await removepref('tasks');
                  await removepref('log');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage()),
                      ModalRoute.withName('/'));
                },
                icon: const Icon(Icons.logout_outlined))
          ],
          title: Text(apptitle.toString()),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         setState(() {
          //           islist = !islist;
          //         });
          //       },
          //       icon: islist
          //           ? const Icon(Icons.list)
          //           : const Icon(Icons.grid_on)), // grid_on
          //   IconButton(
          //       onPressed: () {
          //         print(snapshot.toString());
          //         showMenu(
          //             context: context,
          //             position: const RelativeRect.fromLTRB(1, 50, -1, 1),
          //             items: [
          //               PopupMenuItem(
          //                 value: 1,
          //                 child: const Text('data'),
          //                 onTap: () {},
          //               ),
          //               PopupMenuItem(
          //                 child: const Text('data1'),
          //                 onTap: () {},
          //               ),
          //               PopupMenuItem(
          //                 child: const Text('data2'),
          //                 onTap: () {},
          //               ),
          //             ]);
          //       },
          //       icon: const Icon(Icons.more_vert))
          // ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //     onTap: (value) {
        //       setState(() {
        //         curind = value;
        //       });
        //     },
        //     currentIndex: curind,
        //     elevation: 5,
        //     backgroundColor: Colors.green.shade100,
        //     unselectedItemColor: Colors.black,
        //     selectedItemColor: Colors.black,
        //     type: BottomNavigationBarType.shifting,
        //     items: const <BottomNavigationBarItem>[
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home),
        //           label: "Home",
        //           activeIcon: Icon(Icons.ad_units)),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home), label: "Home"),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home), label: "Home"),
        //     ]),
        // drawer: Drawer(
        //   child: Column(
        //     children: [
        //       DrawerHeader(
        //           padding: const EdgeInsets.all(0),
        //           child: Container(
        //             decoration: const BoxDecoration(
        //               image: DecorationImage(
        //                   image: AssetImage('img/drawback.jpg'),
        //                   fit: BoxFit.fill),
        //             ),
        //             child: const Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               children: [
        //                 CircleAvatar(
        //                   child: Text('data'),
        //                 ),
        //                 Text('John Doe')
        //               ],
        //             ),
        //           )),
        //     ],
        //   ),
        // ),
        body: ListView(
          // controller: scr,
          scrollDirection: Axis.horizontal,
          children: [
            DragTarget(onAcceptWithDetails: (details) async {
              await comDrag(nw, details);
              setState(() {
                saveState();
              });
            }, builder: (context, accept, reject) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    width: 350,
                    child: ReorderableListView(
                        header: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [Text('New'), Divider()],
                            )),
                        onReorder: (oldIndex, newIndex) async {
                          // print((nw as List).length);
                          // print(oldIndex);
                          // print(newIndex);

                          setState(() {
                            newIndex =
                                newIndex > oldIndex ? newIndex -= 1 : newIndex;
                            var tem = nw[oldIndex];
                            nw.removeAt(oldIndex);
                            nw.insert(newIndex, tem);
                            for (var i = 0; i < (nw as List).length; i++) {
                              nw[i]['index'] = i;
                            }
                          });

                          saveState();
                        },
                        children: (nw as List).map((element) {
                          return Draggable(
                            data: element,
                            childWhenDragging: ListTile(
                              enabled: false,
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              tileColor: Colors.red,
                              //selected: active,
                              title: Text(element['project_name'].toString()),
                            ),
                            key: Key(element['task_id'].toString()),
                            feedback: const SizedBox(
                              width: 200,
                              height: 50,
                              child: Card(
                                child: Text('data'),
                              ),
                            ),
                            child: Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        element['owner_avatar'].toString()),
                                  ),
                                  isThreeLine: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  tileColor: Colors.red.shade100,
                                  //selected: active,
                                  title:
                                      Text(element['project_name'].toString()),
                                  subtitle: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  Details(
                                                    detail: element,
                                                  )));
                                    },
                                    child: Text(element['name'].toString()),
                                  )),
                            ),
                          );
                        }).toList())),
              );
            }),
            DragTarget(onAcceptWithDetails: (details) async {
              await comDrag(progres, details);
              setState(() {
                saveState();
              });
            }, builder: (context, accept, reject) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    width: 350,
                    child: ReorderableListView(
                        header: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [Text('In progress'), Divider()],
                            )),
                        onReorder: (oldIndex, newIndex) async {
                          setState(() {
                            newIndex =
                                newIndex > oldIndex ? newIndex -= 1 : newIndex;
                            var tem = progres[oldIndex];
                            progres.removeAt(oldIndex);
                            progres.insert(newIndex, tem);
                            for (var i = 0; i < (progres as List).length; i++) {
                              progres[i]['index'] = i;
                            }
                          });

                          saveState();
                        },
                        children: (progres as List).map((element) {
                          return Draggable(
                            data: element,
                            childWhenDragging: ListTile(
                              enabled: false,
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              tileColor: Colors.red,
                              //selected: active,
                              title: Text(element['project_name'].toString()),
                            ),
                            key: Key(element['task_id'].toString()),
                            feedback: const SizedBox(
                              width: 200,
                              height: 50,
                              child: Card(
                                child: Text('data'),
                              ),
                            ),
                            child: Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        element['owner_avatar'].toString()),
                                  ),
                                  isThreeLine: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  tileColor: Colors.red.shade100,
                                  //selected: active,
                                  title:
                                      Text(element['project_name'].toString()),
                                  subtitle: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  Details(
                                                    detail: element,
                                                  )));
                                    },
                                    child: Text(element['name'].toString()),
                                  )),
                            ),
                          );
                        }).toList())),
              );
            }),
            DragTarget(onAcceptWithDetails: (details) async {
              await comDrag(review, details);
              setState(() {
                saveState();
              });
            }, builder: (context, accept, reject) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    width: 350,
                    child: ReorderableListView(
                        header: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [Text('In Review'), Divider()],
                            )),
                        onReorder: (oldIndex, newIndex) async {
                          // print((nw as List).length);
                          // print(oldIndex);
                          // print(newIndex);

                          setState(() {
                            newIndex =
                                newIndex > oldIndex ? newIndex -= 1 : newIndex;
                            var tem = review[oldIndex];
                            review.removeAt(oldIndex);
                            review.insert(newIndex, tem);
                            for (var i = 0; i < (review as List).length; i++) {
                              review[i]['index'] = i;
                            }
                          });

                          saveState();
                        },
                        children: (review as List).map((element) {
                          return Draggable(
                            data: element,
                            childWhenDragging: ListTile(
                              enabled: false,
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              tileColor: Colors.red,
                              //selected: active,
                              title: Text(element['project_name'].toString()),
                            ),
                            key: Key(element['task_id'].toString()),
                            feedback: const SizedBox(
                              width: 200,
                              height: 50,
                              child: Card(
                                child: Text('data'),
                              ),
                            ),
                            child: Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        element['owner_avatar'].toString()),
                                  ),
                                  isThreeLine: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  tileColor: Colors.red.shade100,
                                  //selected: active,
                                  title:
                                      Text(element['project_name'].toString()),
                                  subtitle: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  Details(
                                                    detail: element,
                                                  )));
                                    },
                                    child: Text(element['name'].toString()),
                                  )),
                            ),
                          );
                        }).toList())),
              );
            }),
            DragTarget(onAcceptWithDetails: (details) async {
              await comDrag(done, details);
              setState(() {
                saveState();
              });
            }, builder: (context, accept, reject) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    width: 350,
                    child: ReorderableListView(
                        header: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [Text('Done'), Divider()],
                            )),
                        onReorder: (oldIndex, newIndex) async {
                          // print((nw as List).length);
                          // print(oldIndex);
                          // print(newIndex);

                          setState(() {
                            newIndex = newIndex > oldIndex && newIndex > 0
                                ? newIndex -= 1
                                : newIndex;
                            var tem = done[oldIndex];
                            done.removeAt(oldIndex);
                            done.insert(newIndex, tem);
                            for (var i = 0; i < (done as List).length; i++) {
                              done[i]['index'] = i;
                            }
                          });

                          saveState();
                        },
                        children: (done as List).map((element) {
                          return Draggable(
                            data: element,
                            childWhenDragging: ListTile(
                              enabled: false,
                              shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.green),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              tileColor: Colors.red,
                              //selected: active,
                              title: Text(element['project_name'].toString()),
                            ),
                            key: Key(element['task_id'].toString()),
                            feedback: const SizedBox(
                              width: 200,
                              height: 50,
                              child: Card(
                                child: Text('data'),
                              ),
                            ),
                            child: Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        element['owner_avatar'].toString()),
                                  ),
                                  isThreeLine: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  tileColor: Colors.red.shade100,
                                  //selected: active,
                                  title:
                                      Text(element['project_name'].toString()),
                                  subtitle: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  Details(
                                                    detail: element,
                                                  )));
                                    },
                                    child: Text(element['name'].toString()),
                                  )),
                            ),
                          );
                        }).toList())),
              );
            }),
          ],
        ));
  }
}
// ...(snapshot.data as List).map((element) {
//                                 return Dismissible(
//                                     key: Key(element['index'].toString()),
//                                     child: ListTile(
//                                       onTap: () {},
//                                       shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10))),
//                                       isThreeLine: true,
//                                       tileColor: Colors.grey.shade100,
//                                       leading: CircleAvatar(
//                                           radius: 35,
//                                           child: Image(
//                                             fit: BoxFit.fill,
//                                             image: NetworkImage(
//                                                 (element['owner_avatar'])),
//                                           )),
//                                       title: Text(
//                                           element['project_name'].toString()),
//                                       subtitle:
//                                           Text(element['name'].toString()),
//                                     ));
//                               })
