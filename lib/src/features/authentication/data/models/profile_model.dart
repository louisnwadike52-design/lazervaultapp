import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart'; // Assuming UserModel exists
import 'package:lazervault/src/features/authentication/data/models/session_model.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required UserModel super.user,
    required SessionModel super.session,
  });

  // Potentially add fromProto or fromJson if the backend returns a combined Profile object
  // factory ProfileModel.fromProto(pb.Profile proto) { ... }
} 