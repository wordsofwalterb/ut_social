import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/blocs/profile_info_bloc/profile_info_bloc.dart';

import 'package:ut_social/models/student.dart';
import 'package:ut_social/services/student_repository.dart';
import 'package:ut_social/util/router.dart';
import 'package:ut_social/widgets/top_profile_section.dart';

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
    //BlocProvider.of<ProfileInfoBloc>(context).add(const LoadProfile());
    bloc.add(const LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
          builder: (BuildContext context, ProfileInfoState state) {
        if (state is ProfileInfoInitial || state is ProfileInfoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileInfoFailure) {
          return const Center(
            child: Text('Failed to fetch profile'),
          );
        }
        if (state is ProfileInfoLoaded) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                (widget.isCurrentUser)
                    ? 'Your Profile'
                    : state.student.fullName,
              ),
              actions: <Widget>[
                if (widget.isCurrentUser)
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(Routes.settingsOverview),
                  )
                else
                  Container(),
              ],
            ),
            body: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _topSection(),
              ],
            ),
          );
        }
        return const Scaffold();
      }),
    );
  }

  Widget _topSection() {
    return BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
      builder: (BuildContext context, ProfileInfoState state) {
        if (state is ProfileInfoInitial || state is ProfileInfoLoading) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
        if (state is ProfileInfoFailure) {
          return SliverList(
              delegate: SliverChildListDelegate([
            const Center(
              child: Text('Failed to fetch profile'),
            ),
          ]));
        }
        if (state is ProfileInfoLoaded) {
          return SliverList(
            delegate: SliverChildListDelegate([
              TopProfileSection(
                avatarUrl: state.student.avatarUrl,
                coverPhotoUrl: state.student.coverPhotoUrl,
                isCurrentUser: widget.isCurrentUser,
                name: state.student.fullName,
                bio: state.student.bio,
              ),
            ]),
          );
        }
        return const SliverPadding(padding: EdgeInsets.all(0));
      },
    );
  }
}
