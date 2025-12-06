import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save User Profile
  Future<void> createUserProfile(AppUser user) async {
    print("Creating user profile for: ${user.uid}");
    print("User data: ${user.toMap()}");

    await _db.collection('users').doc(user.uid).set(user.toMap())
      .then((_) => print("User written to Firestore!"))
      .catchError((e) => print("Firestore write error: $e"));
  }


  // Get Current User
  Stream<AppUser> getUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map(
        (snapshot) => AppUser.fromMap(snapshot.data() as Map<String, dynamic>));
  }

  // Get Compatible Users (Logic: Exclude self, exclude connected, sort by overlap)
  Future<List<Map<String, dynamic>>> getCompatibleUsers(String currentUid, List<String> myInterests) async {
    // 1. Get all users
    QuerySnapshot snapshot = await _db.collection('users').get();
    
    // 2. Get my connections/requests to filter out (Simplified for demo)
    // In production, fetch 'connections' and 'sent_requests' collections here
    
    List<Map<String, dynamic>> scoredUsers = [];

    for (var doc in snapshot.docs) {
      if (doc.id == currentUid) continue; // Skip self

      AppUser otherUser = AppUser.fromMap(doc.data() as Map<String, dynamic>);
      
      // Calculate intersection of interests
      var common = otherUser.interests.toSet().intersection(myInterests.toSet());
      
      scoredUsers.add({
        'user': otherUser,
        'score': common.length, // Higher score = more compatible
        'common': common.toList(),
      });
    }

    // Sort by score descending
    scoredUsers.sort((a, b) => b['score'].compareTo(a['score']));
    
    return scoredUsers;
  }

  // Send Connection Request
  Future<void> sendConnectionRequest(String myUid, String targetUid) async {
    await _db.collection('connectionRequests').doc(targetUid).collection('incoming').doc(myUid).set({
      'from': myUid,
      'timestamp': FieldValue.serverTimestamp(),
    });
    await _db.collection('connectionRequests').doc(myUid).collection('outgoing').doc(targetUid).set({
      'to': targetUid,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  
  // Accept Connection
  Future<void> acceptConnection(String myUid, String otherUid) async {
    // Add to connections
    await _db.collection('connections').doc(myUid).collection('list').doc(otherUid).set({'connectedAt': FieldValue.serverTimestamp()});
    await _db.collection('connections').doc(otherUid).collection('list').doc(myUid).set({'connectedAt': FieldValue.serverTimestamp()});
    
    // Delete requests
    await _db.collection('connectionRequests').doc(myUid).collection('incoming').doc(otherUid).delete();
  }
}