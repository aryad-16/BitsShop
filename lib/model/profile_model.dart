class Profile {
  String name;
  String bhawanName;
  int rommNo;
  int phoneNumber;
  String profileId;
  List<String> favouriteItemsId;
  List<String> theirAdIds;
  Profile({
    required this.name,
    required this.theirAdIds,
    required this.favouriteItemsId,
    required this.profileId,
    required this.bhawanName,
    required this.rommNo,
    required this.phoneNumber,
  });
}
