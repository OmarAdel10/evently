import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyy/Models/event_model.dart';
import 'package:eventlyy/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<void> createEvent(EventModel event) async {
    CollectionReference<EventModel> eventsCollection = getEventCollection();
    DocumentReference<EventModel> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }


  static Future<void> forgetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
