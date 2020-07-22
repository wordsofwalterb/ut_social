import 'package:flappy_search_bar/flappy_search_bar.dart';

import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

import 'package:ut_social/models/student.dart';

import 'package:ut_social/services/student_repository.dart';
import 'package:ut_social/util/router.dart';

import '../widgets/search_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBarController<Student> _searchBarController =
      SearchBarController();

  Future<List<Student>> _fetchStudents(String keyword) async {
    final students =
        await FirebaseStudentRepository().findStudentsByName(keyword);
    return students;
  }

  @override
  Widget build(BuildContext context) {
    final UserState blocState = BlocProvider.of<UserBloc>(context).state;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SearchBar<Student>(
            searchBarPadding: const EdgeInsets.symmetric(horizontal: 10),
            headerPadding: const EdgeInsets.symmetric(horizontal: 10),
            onSearch: _fetchStudents,
            searchBarController: _searchBarController,
            iconActiveColor: Colors.orange,
            hintText: 'Search',
            cancellationWidget: const Text('Cancel'),
            textStyle: TextStyle(color: Colors.white),
            searchBarStyle: const SearchBarStyle(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            header: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20, top: 12),
              child: Text(
                'Search Results',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color(0xffffffff),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            // emptyWidget: Center(child: Text("empty")),
            // indexedScaledTileBuilder: (int index) =>
            //     ScaledTile.count(1, index.isEven ? 2 : 1),
            // onCancelled: () {
            //   print("Cancelled triggered");
            // },
            onItemFound: (Student student, int index) {
              return SearchTile(
                margin: const EdgeInsets.only(bottom: 3),
                padding: const EdgeInsets.symmetric(vertical: 3),
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
      ),
    );
  }
}
