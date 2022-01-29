import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class JobsFirebaseUser {
  JobsFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

JobsFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<JobsFirebaseUser> jobsFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<JobsFirebaseUser>((user) => currentUser = JobsFirebaseUser(user));
