import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/profile/student_repository.dart';

import 'profile_info_bloc/profile_info_bloc.dart';
import 'widgets/top_profile_section.dart';

class ProfileScreen extends StatefulWidget {
  final bool isCurrentUser;

  const ProfileScreen({this.isCurrentUser = false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Student student;
  FirebaseStudentRepository repository = FirebaseStudentRepository();
  ProfileInfoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProfileInfoBloc>(context);
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<ProfileInfoBloc>(context).add(const LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          'Your Profile',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: const CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  TopProfileSection(
                    isCurrentUser: true,
                    name: 'Brandon',
                    bio: 'Bio' ??
                        'This is an example bio, showing what is supposed to be here',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
