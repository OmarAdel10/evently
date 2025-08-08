import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore:
            (docSnapShot, _) => UserModel.fromJson(docSnapShot.data()!),
        toFirestore: (user, _) => user.toJSON(),
      );

  static CollectionReference<EventModel> getEventCollection() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter<EventModel>(
            fromFirestore:
                (docSnapShot, _) => EventModel.fromJSON(docSnapShot.data()!),
            toFirestore: (event, _) => event.toJSON(),
          );

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favouriteEventsIds: [],
    );
    CollectionReference<UserModel> usersCollection = getUserCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentSnapshot<UserModel> docSnapShot =
        await usersCollection.doc(credential.user!.uid).get();
    return docSnapShot.data()!;
  }

  static Future<void> logOut() => FirebaseAuth.instance.signOut();

  static Future<void> forgetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> createEvent(EventModel event) async {
    CollectionReference<EventModel> eventsCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventsCollection = getEventCollection();
    QuerySnapshot<EventModel> querySnapShot =
        await eventsCollection.orderBy('dateTime').get();
    return querySnapShot.docs.map((docSnapShot) => docSnapShot.data()).toList();
  }

  static Future<void> addEventToFavourites(String eventId) {
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = usersCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favouriteEventsIds' : FieldValue.arrayUnion([eventId])
    });
  }

  static Future<void> removeEventFromFavourites(String eventId) {
    CollectionReference<UserModel> usersCollection = getUserCollection();
    DocumentReference<UserModel> userDoc = usersCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favouriteEventsIds' : FieldValue.arrayRemove([eventId])
    });
  }

  // static Future<UserCredential?> googleSignInFunc() async {
  //   try {
  //     final GoogleSignInAccount? gUser = await GoogleSignIn(
  //       serverClientId: "187369570776-lkcjld6k99eq1jbftfppjuk9pnrvo09h.apps.googleusercontent.com",
  //     ).signIn();
  //     if (gUser == null) return null;
  //     final GoogleSignInAuthentication gAuth = gUser.authentication;
  //     final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken);
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(
  //       credential
  //     );
  //     final user = userCredential.user;
  //     if (user != null) {
  //       CollectionReference<UserModel> usersCollection = getUserCollection();
  //       final doc = await usersCollection.doc(user.uid).get();
  //       if (!doc.exists) {
  //         await usersCollection
  //             .doc(user.uid)
  //             .set(
  //               UserModel(
  //                 id: user.uid,
  //                 name: user.displayName!,
  //                 email: user.email!,
  //               ),
  //             );
  //       }
  //     }
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     return null;
  //   }
  // }
}
