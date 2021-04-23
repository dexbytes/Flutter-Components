import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/app_utility/app_localizations.dart';



class AppString {
  static BuildContext context;

  //appString.trans(context,appString.basicInfo);
  trans(BuildContext context, String key) {
    if (key != null && key.trim() != "" && context != null) {
      var data = AppLocalizations.of(context).translate(key);
      if (data == null) {
        return "";
      }
      return data;
    } else {
      return "";
    }
  }

  String selectCountry = '';
  String appName = 'Highlight App';
  String companyWideText = 'Company Wide';

  String getStartedText1 = 'getStartedText1';
  String signUpToday = 'signUpToday';
  String noPaymentRequired = 'noPaymentRequired';
  String email = 'email';
  String pleaseEnterEmail = 'pleaseEnterEmail';
  String getStartedButton = 'getStartedButton';
  String alreadyHaveAccount = 'alreadyHaveAccount';
  String continueButton = 'continueButton';
  String byTappingText = 'byTappingText';
  String termsAndServices = 'termsAndServices';
  String privacyPolicy = 'privacyPolicy';
  String andText = 'andText';
  String step1 = 'step1';
  String step2 = 'step2';
  String step3 = 'step3';
  String step4 = 'step4';
  String step1of2 = 'step1of2';
  String step2of2 = 'step1of2';
  String register = 'register';
  String forgotPassword = 'forgotPassword';
  String enterSecretCode = 'enterSecretCode';
  String verifyAccount = 'verifyAccount';
  String codeExpires = 'codeExpires';
  String junkFoldersText = 'junkFoldersText';
  String newCode = 'newCode';
  String verify = 'verify';
  String createProfile = 'createProfile';
  String firstName = 'firstName';
  String workEmail = 'workEmail';
  String newWorkEmail = 'newWorkEmail';
  String confirmWorkEmail = 'confirmWorkEmail';
  String newWorkEmailNotBlank = 'newWorkEmailNotBlank';
  String confirmWorkEmailNotBlank = 'confirmWorkEmailNotBlank';
  String lastName = 'lastName';
  String password = 'password';
  String confirmPassword = 'confirmPassword';
  String enterFirstName = 'enterFirstName';
  String enterLastName = 'enterLastName';
  String enterPassword = 'enterPassword';
  String enterConfirmPassword = 'enterConfirmPassword';
  String createCompanySpace = 'createCompanySpace';
  String companyName = 'companyName';
  String howManyEmployees = 'howManyEmployees';
  String createPassword = 'createPassword';
  String passwordWith7Char = 'passwordWith7Char';
  String mustContain1LetterAndNumber = 'mustContain1LetterAndNumber';
  String completeSetUPButton = 'completeSetUPButton';
  String validName = 'validName';
  String inviteColleagues = 'inviteColleagues';
  String continueToApp = 'continueToApp';
  String joinTeam = 'joinTeam';
  String signIn = 'signIn';

  String alreadyOnHighlight = 'alreadyOnHighlight';
  String passwordAndConfirmPasswordSame = 'passwordAndConfirmPasswordSame';
  String emailAndConfirmEmailSame = 'emailAndConfirmEmailSame';
  String correctEmail = 'correctEmail';
  String correctName = 'correctName';
  String companyNamePlease = 'companyNamePlease';
  String selectEmployeeCount = 'selectEmployeeCount';
  String correctOtp = 'correctOtp';
  String enterOtp = 'enterOtp';
  String welcomeHighlight = 'welcomeHighlight';
  String welcomeTo = 'welcomeTo';
  String takeAMoment = 'takeAMoment';
  String takeAMomentToWelcome = 'takeAMomentToWelcome';
  String primary = 'primary';
  String companyWide = 'companyWide';
  String highlights = 'highlights';
  String invite = 'invite';
  String help = 'help';
  String helpSuccessMsg = 'helpSuccessMsg';
  String reportSuccessMsg = 'reportSuccessMsg';
  String needHelp = 'needHelp';
  String contactUs = 'contactUs';
  String createdBy = 'createdBy';
  String superAdmin = 'superAdmin';
  String like = 'like';
  String step1of3 = 'step1of3';
  String createNewPass = 'createNewPass';
  String createNewEmail = 'createNewEmail';
  String verifyEmail = 'verifyEmail';
  String reEnterNewPass = 'reEnterNewPass';
  String enterNewPass = 'enterNewPass';
  String cancelButton = 'cancelButton';
  String discardPost = 'discardPost';
  String discardSpotlight = 'discardSpotlight';
  String captionPlease = 'captionPlease';
  String anImagePlease = 'anImagePlease';
  String sharePost = 'sharePost';
  String cancelCaps = 'cancelCaps';
  String post = 'post';
  String report = 'report';
  String selectMediaType = 'selectMediaType';
  String yourQuestion = 'yourQuestion';
  String option1 = 'option1';
  String option2 = 'option2';
  String pollDuration = 'pollDuration';
  String settings = 'settings';
  String createPoll = 'createPoll';
  String daysPerWeek = 'daysPerWeek';
  String yourQuestionHint = 'yourQuestionHint';
  String mustAskError = 'mustAskError';
  String pollDurationError = 'pollDurationError';
  String addAnOption = 'addAnOption';
  String cantEditPost = 'cantEditPost';
  String searchColleagues = 'searchColleagues';
  String searchChannel = 'searchChannel';
  String searchAdmin = 'searchAdmin';
  String adminSectionText1 = 'adminSectionText1';
  String noNotification = 'noNotification';
  String adminSectionText2 = 'adminSectionText2';
  String searchChannelText1 = 'searchChannelText1';
  String searchChannelText2 = 'searchChannelText2';
  String searchColleaguesText1 = 'searchColleaguesText1';
  String searchColleaguesText2 = 'searchColleaguesText2';
  String follow = 'follow';
  String following = 'following';
  String join = 'join';
  String joined = 'joined';
  String edit = 'edit';
  String remove = 'remove';
  String leave = 'leave';
  String colleagues = 'colleagues';
  String channels = 'channels';
  String admins = 'admins';
  String create = 'create';
  String createChannel = 'createChannel';
  String channelName = 'channelName';
  String channelNamePlease = 'channelNamePlease';
  String channelNameHint = 'channelNameHint';
  String provideNote = 'provideNote';
  String provideNoteHint = 'provideNoteHint';
  String adminRequest = 'adminRequest';
  String send = 'send';
  String signOut = 'signOut';
  String typeCancel = 'typeCancel';
  String cancelMyAccount = 'cancelMyAccount';
  String trialEndsMessage = 'trialEndsMessage';
  String gotIt = 'gotIt';
  String notificaionsDrawer = 'notificaionsDrawer';
  String passwordDrawer = 'passwordDrawer';
  String emailDrawer = 'emailDrawer';
  String accountDrawer = 'accountDrawer';
  String helpDrawer = 'helpDrawer';
  String aboutDrawer = 'aboutDrawer';
  String editProfile = 'editProfile';
  String comments = 'comments';
  String viewProfile = 'viewProfile';
  String titleText = 'titleText';
  String departmentText = 'departmentText';
  String save = 'save';
  String writeMsgHere = 'writeMsgHere';
  String writeCaption = 'writeCaption';
  String selectImageOrText = 'selectImageOrText';
  String enterTitle = 'enterTitle';
  String enterDepartment = 'enterDepartment';
  String createSpotlight = 'createSpotlight';
  String editSpotlight = 'editSpotlight';
  String viewSpotlight = 'viewSpotlight';
  String createSpotlightT1 = 'createSpotlightT1';
  String selectColleagueText = 'selectColleagueText';
  String gratitudeMessage = 'gratitudeMessage';
  String inTheSpotlight = 'inTheSpotlight';
  String helpLabelText = 'helpLabelText';
  String reportReason = 'reportReason';
  String reportReasonHint = 'reportReasonHint';



  String loginWith = 'loginWith';
  String subject = 'subject';
  String subjectPlease = 'subjectPlease';
  String messagePlease = 'messagePlease';
  String reportReasonPlease = 'reportReasonPlease';
  String alreadyActiveSpotlight = 'alreadyActiveSpotlight';
  String message = 'message';
  String tabHome = 'tabHome';
  String languageChanged = 'languageChanged';
  String questionAnswer = 'questionAnswer';
  String productDetail = 'productDetail';
  String reviews = 'reviews';
  String submitBtnTitle = 'submitBtnTitle';
  String askQuestion = 'askQuestion';
  String tabNotification = 'tabNotification';
  String tabFavourites = 'tabFavourites';
  String back = 'back';
  String appLoginCompilableMessage = 'appLoginCompilableMessage';
  String skipForNow = 'skipForNow';
  String selectLanguage = 'selectLanguage';
  String selectCurrency = 'selectCurrency';
  String country = 'country';
  String searchCountry = 'searchCountry';
  String language = 'language';
  String currency = 'currency';
  String searchCurrency = 'searchCurrency';
  String continueBtnTitle = 'continueBtnTitle';
  String updateBtnTitle = 'updateBtnTitle';
  String selectCategory = 'selectCategory';
  String selectSubCategory = 'selectSubCategory';
  String categories = 'categories';
  String termsAndCondition = 'termsAndCondition';
  String aboutUs = 'aboutUs';
  String setting = 'setting';
  String notifications = 'notifications';
  String login = 'login';
  String logout = 'logout';
  String pleaseLogin = 'pleaseLogin';
  String pleaseSelectCategory = 'pleaseSelectCategory';
  String share = 'share';

  String tryAgain = 'Something went wrong please try again';
  //Button text
  String buttonSave = "Save";
  String buttonCancel = "Cancel";
  String buttonApply = "Apply";
  String buttonConfirm = "Confirm";
  String buttonGallery = "Media";
  String buttonCamera = "Photo";

  //Alert message
  String logoutConfirmation = "Are you sure you want to logout";
  String deletePostMessage = "Are you sure to delete this post?";
  String deleteGroupChannelMessage =
      "Are you sure to delete this Group Channel?";
  String leftGroupMessage = "Are you sure to left this group?";
  String noInternetConnection =
      "No internet connection available. Please check your network!";
  String noText = "No";
  String yesText = "Yes";

  //error messages
  String passwordNotBlank = 'Please enter the password.';
  String passwordLength = '*Minimum password length is 6 charactors';
  String screenTermsAndConditions = "Terms and conditions";

  //Login screen strings
  String contactText =
      "If you have problems to login, please get in contact at ";
  String acceptTermsAndConditions =
      'Check here to indicate that you have read and agree to the "';
  String termsAndConditions = 'terms of the main flutter app';

  //Contact email id
  String contactEmail = "dexbytes@gmail.com";

  String emailNotBlank = 'Please enter your number';
  String validEmail = 'Please enter a valid mobile number.';
  //confirmation message
  String confirmationMessage =
      "Are you sure you want to delete this notification?";
  String confirmationLogoutMessage =
      "Are you sure you want to sign out?";

  String confirmationDeleteAccountMessage =
      "Are you sure you want to delete your account from this company?";

  String confirmationChangePasswordOTPMessage =
      "It will send an OTP to your email, Do you want to change your password?";

  String confirmationChangeEmailOTPMessage =
      "It will send an OTP to your email, Do you want to change your email?";
  String confirmationExitMessage =
      "Are you sure you want to exit from the app?";
  String confirmationDeletePostMessage =
      "Are you sure you want to delete this post?";
  String confirmationDeleteGroupMessage =
      "Are you sure you want to delete this group?";
  String confirmationLeftGroupMessage =
      "Are you sure you want to leave this group?";
}

AppString appString = AppString();
