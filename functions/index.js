const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.onCreateNotificationItem = functions.firestore
    .document('/students/{userId}/notifications/{notificationId}')
    .onCreate(async (snapshot, context) => {
        console.log('Notification Feed Item Created', snapshot.data());

        const userId = context.params.userId;

        const userRef = admin.firestore().doc(`students/${userId}`);
        const doc = await userRef.get();

        const notificationToken = doc.data().notificationToken;
        const createdNotificationFeedItem = snapshot.data();

        if (notificationToken) {
            sendNotification(notificationToken, createdNotificationFeedItem);
        } else {
            console.log('No token for user, cannot send notification');
        }

        function sendNotification(notificationToken, notificationFeedItem) {
            const body = notificationFeedItem.body;
            const imageUrl = notificationFeedItem.imageUrl;
            const originId = notificationFeedItem.originId;

            const message = {
                notification: {
                    body: body,
                    token: notificationToken,
                    data: {
                        recipient: userId,
                        imageUrl: imageUrl,
                        origin: originId,
                    }
                }
            }

            admin.messaging.send(message)
                .then(response => {
                    return console.log('Sent message', response);
                })
                .catch(error => {
                    return console.log('Error sending message', error);
                });
        }
    });
