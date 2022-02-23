import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/category_name_container.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/row_button_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class InternetAdminUsersScreen extends StatelessWidget {
  const InternetAdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          _header(h, context, w),
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/internet/admin/users/details"),
                  child: RowContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jakob marušič".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              Divider(),
                              Row(children: [
                                Icon(FlutterRemix.building_line, size: 18,),
                                SizedBox(width: 5,),
                                Text("Soba 304, dom 5")
                              ],),
                              Row(children: [
                                Icon(FlutterRemix.passport_line, size: 18,),
                                SizedBox(width: 5,),
                                Text("jakmarusic@sd-lj.si")
                              ],),
                            ],
                          ),
                        ],
                      )),
                ),
              )
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BottomModal.showCustomModal(context,
            color: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "Filtri".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                      sliver: SliverToBoxAdapter(
                        child: Divider(
                          thickness: 1.5,
                          color: ThemeColors.jet.withOpacity(0.25),
                        ),
                      )),
                  RowSliver(
                    title: "Lokacija",
                    icon: FlutterRemix.building_line,
                    child: DropdownButton<int>(
                        focusColor: Colors.white,
                        isExpanded: true,
                        value: 0,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 3,
                          ),
                        ],
                        hint: Text(
                          "Lokacija",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (value) => null),
                  ),
                  RowSliver(
                    title: "Število zadetkov na stran",
                    icon: FlutterRemix.numbers_line,
                    child: DropdownButton<int>(
                        focusColor: Colors.white,
                        isExpanded: true,
                        value: 0,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              "hello",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: 3,
                          ),
                        ],
                        hint: Text(
                          "Lokacija",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (value) => null),
                  ),
                  RowButtonSliver(
                    title: "Filtriraj",
                    onPressed: () => null,
                    icon: FlutterRemix.filter_line,
                  )
                ],
              ),
            )),
        child: Icon(
          FlutterRemix.filter_3_line,
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: ThemeColors.primary,
      ),
    );
  }

  Stack _header(double h, BuildContext context, double w) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: h * 0.12,
          decoration: BoxDecoration(
            color: ThemeColors.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: h * 0.08),
          child: Padding(
            padding: EdgeInsets.only(right: w * 0.15),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h * 0.01),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: ThemeColors.jet.withOpacity(0.25),
                        offset: Offset(0, 5),
                        blurRadius: 10)
                  ],
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(20))),
              child: Padding(
                  padding: EdgeInsets.only(left: w * 0.04),
                  child: TextFormField(
                    obscureText: false,
                    decoration: InputDecoration(
                        label: Row(children: [
                          Icon(
                            FlutterRemix.search_2_line,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Iskanje")
                        ]),
                        border: InputBorder.none),
                    validator: (value) => null,
                    onChanged: (value) => null,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
