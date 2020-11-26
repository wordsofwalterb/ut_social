import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/channel.dart';
import 'package:ut_social/models/failure.dart';
import 'package:ut_social/util/globals.dart';

class FirebaseChannelRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseChannelRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Retrieve documents based on list of Ids passed and
  /// add them a list of channels which is returned.
  /// If document.data is empty throw Failure with code 'CHANNEL_DOC_EMPTY'
  Future<List<Channel>> fetchUserChannels(List<String> channelIds) async {
    final List<Channel> channels = [];

    for (final id in channelIds) {
      final channelDocument = await Global.channelsRef.doc(id).get();
      if (channelDocument.data().isNotEmpty) {
        final channel = Channel.fromMap(channelDocument.data(), '123');
        channels.add(channel);
      } else {
        throw Failure(
            'There was an error retrieving channels', 'CHANNEL_DOC_EMPTY');
      }
    }

    return channels;
  }

  Future<Channel> createChannel({
    @required String channelName,
    @required int numParticipants,
    @required bool isPrivate,
    @required bool isDM,
    @required String ownerId,
    @required List<Map<String, dynamic>> participants, // Should this be class?
    String imageUrl,
  }) async {
    final docRef = await Global.channelsRef.add({
      'channelName': channelName,
      'numParticipants': numParticipants,
      'isPrivate': isPrivate,
      'ownerId': ownerId,
      'isDM': isDM,
      'imageUrl': imageUrl,
    });

    for (final participant in participants) {
      await addToChannel(
        channelId: docRef.documentID,
        participant: participant,
      );
    }

    final channel = Channel();

    return channel;
  }

  Future<void> addToChannel({
    @required String channelId,
    @required Map<String, dynamic> participant,
  }) async {
    // Add participant to subcollection of channel
    await Global.channelsRef
        .document(channelId)
        .collection('participants')
        .add(participant);

    // Update student document with new channel
    await Global.studentsRef.document(participant['id'] as String).updateData({
      'channels': FieldValue.arrayUnion([channelId]),
    });
  }

  Future<void> removeFromChannel({
    @required String channelId,
    @required Map<String, dynamic> participant,
  }) async {
    // Remove participant from subcollection of channel
    await Global.channelsRef
        .document(channelId)
        .collection('participants')
        .document(participant['id'] as String)
        .delete();

    // Update student document and remove channel
    await Global.studentsRef.document(participant['id'] as String).updateData({
      'channels': FieldValue.arrayRemove([channelId]),
    });
  }
}
