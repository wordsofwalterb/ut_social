import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  //   return Scaffold(
  //     body: CustomScrollView(
  //       slivers: [
  //         _sectionHeader(leading: Text()),
  //         _groupSection(),
  //         _sectionHeader(),
  //         _chatSection(),
  //       ],
  //     ),
  //   );
  // }

  // Widget _groupSection(List<GroupSnippet> groups) {
  //   return SliverList(
  //     delegate: SliverChildListDelegate([
  //       Container(
  //         width: double.infinity,
  //         height: 80,
  //         child: ListView.builder(
  //             scrollDirection: Axis.horizontal,
  //             itemCount: groups.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return GroupCard(group: groups[index]);
  //             }),
  //       )
  //     ]),
  //   );
  // }

  // Widget _chatSection(List<ChatSnippet> chats) {
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
  //       return ChatTile(chat: chats[index]);
  //       }
  //     ),
  //   );
  // }

  // Widget _sectionHeader({Widget trailing, Widget leading}) {
  //   return Row(children: [
  //     Container(
  //       child: leading ?? Container(),
  //     ),
  //     Spacer(),
  //     Container(child: trailing),
  //   ]);
  }
}
