import 'package:fullter_main_app/src/all_file_import/app_utils_files_link.dart';
import 'appState.dart';
import '../helper/local_constant.dart';

class UserAuthState extends AppState {
  SharedPreferencesFile mSharedPreferencesFile = SharedPreferencesFile();
//  Data userProfileInfo;

  bool _isLoggedIn;
  bool isMobileVerified;
  bool numberEdited = false;
  int notificationUnreadCount = 0;
  List<dynamic> stateList = [];

  int get getNotificationUnreadCount => notificationUnreadCount;
  set setNotificationUnreadCount(value) {
    notificationUnreadCount = value;
    notifyListeners();
  }

  bool get getIsLoggedIn => _isLoggedIn;
  bool get getIsNumberEdited => numberEdited;
  bool get getIsMobileVerified => isMobileVerified;

  set setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool _isProfileUpdate = false;
  bool get getIsProfileUpdate => _isProfileUpdate;
  set setIsProfileUpdate(bool value) {
    _isProfileUpdate = value;
    notifyListeners();
  }

/*  set setUserProfileInfoImage(User userProfileData) {
    userProfileInfo = userProfileData;
    notifyListeners();
  }*/

  int matrimonyCurrentIndex = 0;
  int get getMatrimonyCurrentIndex => matrimonyCurrentIndex;
  set setMatrimonyCurrentIndex(value) {
    matrimonyCurrentIndex = value;
    notifyListeners();
  }

  //Update User information
/*  Future<void> setUserProfileInfo(
      {@required dynamic userProfileData,
      accessToken,
      matrimonyDetails,
      isUpdateProfile}) {
    if (userProfileInfo == null) {
      userProfileInfo = new User();
    }
    if (userAccessToken == null) {
      userAccessToken = new Access();
    }

    if (selfMatrimonyDetails == null) {
      selfMatrimonyDetails = new MatrimonyDetails();
    }

    //Store all data in shared preference
    sharedPreferencesFile.saveStr(communityId, userProfileData.cid ?? "");
    sharedPreferencesFile.saveStr(genderC, userProfileData.gender ?? "");
    sharedPreferencesFile.saveStr(addressC, userProfileData.address ?? "");
    sharedPreferencesFile.saveStr(
        fatherNameC, userProfileData.fatherName ?? "");
    sharedPreferencesFile.saveBool(loginStatus, userProfileData.status ?? "");
    sharedPreferencesFile.saveStr(
        referenceMemberName, userProfileData.referenceMemberName ?? "");
    sharedPreferencesFile.saveStr(referenceMemberMobileNumber,
        userProfileData.referenceMemberMobileNumber ?? "");
    sharedPreferencesFile.saveStr(
        userFullNameC, userProfileData.fullName ?? "");
    sharedPreferencesFile.saveStr(UserEmailC, userProfileData.email ?? "");
    sharedPreferencesFile.saveStr(
        UserMobileNumberC, userProfileData.mobileNumber ?? "");
    sharedPreferencesFile.saveStr(userCityC, userProfileData.city ?? "");
    sharedPreferencesFile.saveStr(userStateC, userProfileData.state ?? "");
    sharedPreferencesFile.saveStr(userIdC, userProfileData.id ?? "");
    sharedPreferencesFile.saveStr(
        userMaritalStatusC, userProfileData.maritalStatus ?? "");
    sharedPreferencesFile.saveStr(
        userBirthDateC, userProfileData.dateOfBirth ?? "");
    sharedPreferencesFile.saveStr(
        userAnniversaryDateC, userProfileData.marriageDate ?? "");

    sharedPreferencesFile.saveStr(chatUid, userProfileData.fcmUserId ?? "");

    if (matrimonyDetails != null) {
      sharedPreferencesFile.saveStr(matrimonyIdC, matrimonyDetails.id ?? "");
    }
    sharedPreferencesFile.saveInt(
        countryCodeC, userProfileData.countryCode ?? -1);
    sharedPreferencesFile.saveInt(gotraIdC, userProfileData.gotraId ?? -1);

    if (accessToken != null) {
      sharedPreferencesFile.saveStr(accessTokenC, accessToken ?? "");
    }

    if (matrimonyDetails != null) {
      sharedPreferencesFile.saveStr(matrimonyIdC, matrimonyDetails.id ?? "");
    }

    if (isUpdateProfile == null || !isUpdateProfile) {
      sharedPreferencesFile.saveStr(
          UserProfileImageC, userProfileData.profileImage ?? "");
    }

    //Set all data in userProfileInfo of common data provider
    userProfileInfo.cid = userProfileData.cid ?? "";
    userProfileInfo.gender = userProfileData.gender ?? "";
    userProfileInfo.address = userProfileData.address ?? "";
    sharedPreferencesFile.saveStr(
        fatherNameC, userProfileData.fatherName ?? "");
    userProfileInfo.isLoggedIn = userProfileData.isLoggedIn ?? "";
    userProfileInfo.loginTime = userProfileData.loginTime ?? "";
    userProfileInfo.status = userProfileData.status ?? "";
    userProfileInfo.referenceMemberName =
        userProfileData.referenceMemberName ?? "";
    userProfileInfo.referenceMemberMobileNumber =
        userProfileData.referenceMemberMobileNumber ?? "";
    userProfileInfo.fullName = userProfileData.fullName ?? "";
    userProfileInfo.maritalStatus = userProfileData.maritalStatus ?? "";
    userProfileInfo.dateOfBirth = userProfileData.dateOfBirth ?? "";
    userProfileInfo.marriageDate = userProfileData.marriageDate ?? "";
    userProfileInfo.fatherName = userProfileData.fatherName ?? "";
    userProfileInfo.email = userProfileData.email ?? "";
    userProfileInfo.mobileNumber = userProfileData.mobileNumber ?? "";
    userProfileInfo.city = userProfileData.city ?? "";
    userProfileInfo.state = userProfileData.state ?? "";
    userProfileInfo.id = userProfileData.id ?? -1;
    userProfileInfo.countryCode = userProfileData.countryCode ?? -1;
    userProfileInfo.gotraId = userProfileData.gotraId ?? -1;
    userProfileInfo.fcmUserId = userProfileData.fcmUserId ?? "";

    if (matrimonyDetails != null) {
      //selfMatrimonyDetails = matrimonyDetails;
      selfMatrimonyDetails.id = matrimonyDetails.id ?? "";
      //matrimonyIdC
    }

    if (accessToken != null) {
      userAccessToken.token = accessToken ?? "";
    }

    if (isUpdateProfile == null || !isUpdateProfile) {
      userProfileInfo.profileImage = userProfileData.profileImage ?? "";
    }

    notifyListeners();
    return null;
  }*/

  getUserProfile() {
    /*userProfileInfo = new User();

    sharedPreferencesFile
        .readStr(communityId)
        .then((value) => userProfileInfo.cid = value ?? "");

    sharedPreferencesFile
        .readStr(genderC)
        .then((value) => userProfileInfo.gender = value ?? "");

    sharedPreferencesFile
        .readStr(addressC)
        .then((value) => userProfileInfo.address = value ?? "");

    sharedPreferencesFile
        .readBool(isUserLoggedInC)
        .then((value) => userProfileInfo.isLoggedIn = (value ?? ""));

    sharedPreferencesFile
        .readStr(loggedInTimeC)
        .then((value) => userProfileInfo.loginTime = value ?? "");

    sharedPreferencesFile
        .readBool(loginStatus)
        .then((value) => userProfileInfo.status = (value ?? ""));

    sharedPreferencesFile
        .readStr(chatUid)
        .then((value) => userProfileInfo.fcmUserId = (value ?? ""));

    sharedPreferencesFile
        .readStr(referenceMemberName)
        .then((value) => userProfileInfo.referenceMemberName = value ?? "");

    sharedPreferencesFile.readStr(referenceMemberMobileNumber).then(
        (value) => userProfileInfo.referenceMemberMobileNumber = value ?? "");

    sharedPreferencesFile
        .readStr(fatherNameC)
        .then((value) => userProfileInfo.fatherName = value ?? "");

    sharedPreferencesFile
        .readStr(userBirthDateC)
        .then((value) => userProfileInfo.dateOfBirth = value ?? "");

    sharedPreferencesFile
        .readStr(userAnniversaryDateC)
        .then((value) => userProfileInfo.marriageDate = value ?? "");

    sharedPreferencesFile
        .readStr(userMaritalStatusC)
        .then((value) => userProfileInfo.maritalStatus = value ?? "");

    sharedPreferencesFile
        .readStr(userFullNameC)
        .then((value) => userProfileInfo.fullName = value ?? "");
    sharedPreferencesFile
        .readStr(UserEmailC)
        .then((value) => userProfileInfo.email = value ?? "");
    sharedPreferencesFile
        .readStr(UserMobileNumberC)
        .then((value) => userProfileInfo.mobileNumber = value ?? "");
    sharedPreferencesFile
        .readStr(userCityC)
        .then((value) => userProfileInfo.city = value ?? "");

    sharedPreferencesFile
        .readStr(userStateC)
        .then((value) => userProfileInfo.state = value ?? "");
    sharedPreferencesFile
        .readStr(UserProfileImageC)
        .then((value) => userProfileInfo.profileImage = value ?? "");

    sharedPreferencesFile
        .readStr(userIdC)
        .then((value) => userProfileInfo.id = (value ?? -1));

    sharedPreferencesFile
        .readInt(countryCodeC)
        .then((value) => userProfileInfo.countryCode = (value ?? -1));

    sharedPreferencesFile
        .readInt(gotraIdC)
        .then((value) => userProfileInfo.gotraId = (value ?? -1));

    sharedPreferencesFile
        .readStr(accessTokenC)
        .then((value) => userAccessToken.token = (value ?? ""));

    sharedPreferencesFile
        .readStr(matrimonyIdC)
        .then((value) => selfMatrimonyDetails.id = (value ?? ""));*/
  }

  //Update profile image
  Future<void> updateProfileImage(userProfileImage) {
    sharedPreferencesFile.saveStr(UserProfileImageC, userProfileImage ?? "");
    //userProfileInfo.profileImage = userProfileImage ?? "";
    return null;
  }

  //Get user information
  /// get getUserProfileInfo => userProfileInfo ?? getUserProfile();

  get getStateList => stateList;
  set setStateList(value) {
    stateList = value;
    notifyListeners();
  }
}
