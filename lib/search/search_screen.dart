import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/core/blocs/user_bloc/user_bloc.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/router.dart';
import 'package:ut_social/profile/student_repository.dart';

import 'search_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBarController<Student> _searchBarController = SearchBarController();

  Future<List<Student>> _fetchStudents(String keyword) async {
    final students =
        await FirebaseStudentRepository().findStudentsByName(keyword);
    return students;
  }

  @override
  Widget build(BuildContext context) {
    final UserState blocState = BlocProvider.of<UserBloc>(context).state;
    return Scaffold(
      body: SafeArea(
        child: SearchBar<Student>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _fetchStudents,
          searchBarController: _searchBarController,
          iconActiveColor: Colors.orange,
          hintText: 'Search',
          cancellationWidget: Text("Cancel"),
          textStyle: TextStyle(color: Colors.white),
          searchBarStyle: SearchBarStyle(
            padding: EdgeInsets.symmetric(horizontal: 10),
          ),
          // emptyWidget: Center(child: Text("empty")),
          // indexedScaledTileBuilder: (int index) =>
          //     ScaledTile.count(1, index.isEven ? 2 : 1),
          // onCancelled: () {
          //   print("Cancelled triggered");
          // },
          onItemFound: (Student student, int index) {
            return SearchTile(
              margin: EdgeInsets.only(bottom: 3),
              padding: EdgeInsets.symmetric(vertical: 3),
              name: student.fullName,
              imageUrl: student.avatarUrl,
              onTap: () => (blocState is UserAuthenticated)
                  ? Navigator.of(context).pushNamed(Routes.profile,
                      arguments: ProfileArgs(
                        student.id,
                        isCurrentUser: student.id == blocState.currentUser.id,
                      ))
                  : null,
            );
          },
        ),
      ),
    );
  }
}
