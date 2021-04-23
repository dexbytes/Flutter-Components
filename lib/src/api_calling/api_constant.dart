import 'package:flutter/cupertino.dart';

const domainC = 'http://api.ch:3001/'; //domain for image
const profileImageNotFoundC =
    'https://www.fulhamco.com/team_members/andrew-fulham/user-profile-not-found/#iLightbox[postimages]/0';
const imageNotFoundC =
    'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png';

const baseUrlDevC = 'http://tt-api.dexbytes.in:3002/app/';
const baseUrlProC = 'http://tt-api.dexbytes.in:3002/app/'; // Production API's

const sportradarApiKeyC = "udt64ay37e3qpnppymys9gcw";

const baseUrlDevSportradarC =
    'http://api.sportradar.com/tennis'; // Production API's
const baseUrlProdSportradarC =
    'http://api.sportradar.com/tennis'; // Production API's

const alumniListApiC = 'users/list';
const userLoginApiC = 'users/login';
const logoutApiC = 'users/logout';
const newsFeedPostLikeApiC = 'post-like';
const newsFeedPostCommentApiC = 'post-comment';
const newsFeedApiC = 'user-feeds';
const userActivityApiC = 'user-activity';
const tournamentsListApiC = 'tournaments-list';
const multiMatchListApiC = 'multiple-match-list';
const faqListApiC = 'faq-list';
const matchListApiC = 'match-list';
const aboutUsApiC = 'about-us';
const checkAppVersionC = 'version/check-app?';

const termsAndConditionsApiC = '';

class ConstantC {
  static bool isProduction = true;
  static String baseUrl = isProduction ? baseUrlProC : baseUrlDevC;

  static String baseUrlSportradar = isProduction
      ? baseUrlProdSportradarC
      : baseUrlDevSportradarC; // Production API's  //Here 2 = production and one = develop

  //Our server for development
  static String awsAccessKeyIdDev = 'AKIAVFLH7OMPYJGCFDFS';
  static String awsSecretKeyIdDev = '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';
  static String awsRegionDev = 'eu-north-1';
  static String awsS3EndpointDev = 'https://.s3.eu-north-1.amazonaws.com';
  static String awsBucketNameDev = 'events';
  static String awsDownloadImagePathBaseUrlDev =
      ' https://d2d0ufj1wslma.cloudfront.net/';
  static String fcmAuthKeyDev = 'AIzaSyA3XCU567swjEuV2tVGUWqy7WgyvcIfXRc';
  static String googleMapKeyDev = 'AIzaSyD9kC1IftJ961H9Yu0e4DlDCZl12OKIy-o';

  //Client server aws
  static String awsAccessKeyIdPro = 'AKIAJZQJOOOQIKM7gdgfgRPWQ';
  static String awsSecretKeyIdPro =
      '4mcLOf+SUMOzSXQiXgdfgdsfgajXB772evB+YSCe365/uzLo';
  static String awsRegionPro = 'eu-north-1';
  static String awsS3EndpointPro = 'https:s3.eu-north-1.amazonaws.com';
  static String awsBucketNamePro = '';
  static String awsDownloadImagePathBaseUrlPro =
      'https://d3npb633q01h9w.cloudfront.net/';
  static String fcmAuthKeyPro =
      'AIzaSyA3XCU567swjEuV2tVGUWqy7WgydsgvcIfXRc'; //it is use for send notification
  static String googleMapKeyPro = 'AIzaSygdfgD9kC1IftJ961H9Yu0e4DlDCZl12OKIy-o';

  static String awsAccessKeyId =
      isProduction ? awsAccessKeyIdPro : awsAccessKeyIdDev;
  static String awsSecretKeyId =
      isProduction ? awsSecretKeyIdPro : awsSecretKeyIdDev;
  static String awsRegion = isProduction ? awsRegionPro : awsRegionDev;
  static String awsS3Endpoint =
      isProduction ? awsS3EndpointPro : awsS3EndpointDev;
  static String awsBucketName =
      isProduction ? awsBucketNamePro : awsBucketNameDev;
  static String awsDownloadImagePathBaseUrl = isProduction
      ? awsDownloadImagePathBaseUrlPro
      : awsDownloadImagePathBaseUrlDev;
  static String fcmAuthKey = isProduction
      ? fcmAuthKeyPro
      : fcmAuthKeyDev; //it is use for send notification
  static String googleMapKey = isProduction
      ? googleMapKeyPro
      : googleMapKeyDev; //it is use for send notification

  static String getGoogleMapStaticImageUrl(
          {Key key,
          String address,
          var latitude,
          var longitude,
          String googleMapKey}) =>
      "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&"
      "zoom=6&"
      "size=600x300%20&"
      "markers=color:0xffc3f5%7Clabel:%7C$latitude,$longitude&"
      "style=feature:road%7Celement:geometry%7Cvisibility:simplified%7Ccolor:0xf5f5f5&"
      "style=feature:water|color:0xc9c9c9&"
      "key=%20$googleMapKey";
//      "style=element:geometry%7Cvisibility:simplified%7Ccolor:0xf5f5f5&"

  static int currentPlatform = -1;
  static bool isAndroidPlatform = false;
}
