class Profile {
  String name;
  String bhawanName;
  int rommNo;
  int phoneNumber;
  String profileId;
  String profilePicUrl;
  List<String> favouriteItemsId;
  List<String> theirAdIds;
  final String email;
  Profile({
    required this.name,
    required this.email,
    required this.profilePicUrl,
    required this.theirAdIds,
    required this.favouriteItemsId,
    required this.profileId,
    required this.bhawanName,
    required this.rommNo,
    required this.phoneNumber,
  });
}
