import 'package:flutter/material.dart';
import 'package:wechat_app/resources/colors.dart';
import 'package:wechat_app/utils/extension.dart';


class WeChatPrivacyPolicyPage extends StatelessWidget {
  const WeChatPrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kStartUpColor,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: kRegionBackGroundColor,
        leading: IconButton(
          onPressed: () => navigateBack(context),
          icon: const Icon(
            Icons.close,
            color: Colors.white60,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

        ],
      ),
    );
  }
}


// WECHAT PRIVACY POLICY
// Last Updated: 2022-03-22
//
// SUMMARY
//
// Thank you for using WeChat! We respect your concerns about privacy and appreciate your trust and confidence in us.
//
// Here is a summary of the information contained in this privacy policy ("Privacy Policy"). This summary is to help you navigate the Privacy Policy and it is not a substitute for reading everything! You can use the hyperlinks below to jump directly to particular sections in the Privacy Policy.
//
// DOES THIS PRIVACY POLICY APPLY TO YOU?
//
// This Privacy Policy only applies to you if you are a WeChat user, meaning that you have registered by linking a mobile number that uses an international dialing code other than +86 ("non-Chinese Mainland mobile number").
//
// This Privacy Policy does not apply to you if you are a Weixin user. You are a Weixin user if you have either:
//
// registered by linking a mobile number that uses international dialing code +86 ("Chinese Mainland mobile number"); or
// contracted with 深圳市腾讯计算机系统有限公司(Shenzhen Tencent Computer Systems Company Limited) for Weixin.
// If you are a Weixin user, you are subject to the Weixin Agreement on Software License and Service of Tencent Weixin and Weixin Privacy Protection Guidelines and not this Privacy Policy.
//
// You can also check whether you are a WeChat or Weixin user by clicking "Me" > "Settings" > "About" and then clicking the link to the "Terms of Service". If you see the WeChat – Terms of Service then you are a WeChat user. If you see the Agreement on Software License and Service of Tencent Weixin then you are a Weixin user.
//
// If you subsequently change your phone number (either from a Chinese Mainland mobile number to a non-Chinese Mainland mobile number, or vice versa) you will be required to convert your account (to either a WeChat or Weixin account, depending on your new phone number). If you convert your Weixin account to a WeChat account, this Privacy Policy applies to you from the date our system records such conversion. If you convert your WeChat account to a Weixin account, this Privacy Policy ceases to apply to you from the date our system records such conversion.
//
// WHAT INFORMATION DO YOU NEED TO PROVIDE WECHAT?
//
// When you register for a WeChat account, we will need your mobile number and an alias. You can further refine and populate your profile with additional information. If you use certain functions available within WeChat (such as posting photos to your Moments), we will process your information to provide these functions. More Information
//
// HOW DO WE USE YOUR INFORMATION?
//
// We use your information to provide WeChat to you, allow you to communicate with other users, allow you to use the features available on WeChat, and to improve and support your WeChat experience. If you are a parent or guardian who has granted permission for your child to use WeChat then we retain the contact information you have provided to ensure we can validate any requests or queries you may have in relation to your child's WeChat account. More Information
//
// WHO DO WE SHARE YOUR DATA WITH?
//
// We do not share your information with third parties, except where we need to in order to provide the service (e.g., SMS, location and mapping service providers) or if we are instructed to by a court, authority or compelled by law. We use these third party services solely to process or store your information for the purposes described in this Privacy Policy . Any third party with whom we share user data is required to provide the same or equal protection of user data as stated in this Privacy Policy. More Information
//
// WHERE DO WE PROCESS YOUR DATA?
//
// Our servers are located in Singapore and the Hong Kong Special Administrative Region ("Hong Kong SAR"). We also have support, engineering and other teams that support the provision of WeChat to you, located around the world (including Singapore and the Netherlands), who will have access to your information. Rigorous internal control measures are in place to strictly limit access to your data by designated personnel. More Information
//
// HOW LONG DO WE KEEP HOLD OF YOUR DATA?
//
// How long we retain information for depends on the type of information – for example, log-in data is retained for up to 90 days from the date the data is collected. We do not retain your information for longer than the time period prescribed by law. More Information
//
// HOW CAN YOU EXERCISE YOUR RIGHTS OVER YOUR DATA?
//
// Depending on where you live, you may have special rights over your data and how we can use it. These include how you can access the data, erase the data, restrict how your data can be used, object to our use, and get a copy of your information. More Information
//
// JURISDICTION-SPECIFIC ADDENDA
//
// If you are a user located in Australia, Brazil, California, Canada, Hong Kong SAR, India, Indonesia, Japan, Macau SAR, Malaysia, Mexico, Philippines, Russia, Serbia, Singapore, South Korea, Sri Lanka, Taiwan (China), Thailand, Turkey, United Arab Emirates, United Kingdom or Vietnam, there are additional jurisdictional-specific terms that apply to you. You can see these by visiting this page.
//
// HOW WILL WE NOTIFY YOU OF CHANGES?
//
// If there are any significant changes to this Privacy Policy, we will update it here and notify you before the change becomes effective. More Information
//
// DATA CONTROLLER
//
// If you are a WeChat user located in the European Economic Area ("the EEA"), the United Kingdom of Great Britain and Northern Ireland ("the UK") or Switzerland: Tencent International Service Europe B.V., a Dutch company, located at Buitenveldertselaan 1-5, 1082 VA, Amsterdam, the Netherlands; and
// If you are a WeChat user located outside of the EEA, the UK, Switzerland or the Chinese Mainland: WeChat International Pte. Ltd., a Singaporean company located at 10 Anson Road, #21-07 International Plaza, Singapore 079903.
// CONTACT US
//
// If you have any questions or complaints regarding this Privacy Policy or the use of your Personal Information, please contact our Data Protection Officer via email at dataprotection@wechat.com or via postal mail at Buitenveldertselaan 1-5, 1082 VA, Amsterdam, the Netherlands (Attention: Data Protection Officer, Legal Department).
//
// Please note that if you are a resident in the EEA, the UK or Switzerland you have the right to lodge a complaint with your country's data protection authority.
//
// If you have an unresolved privacy or data use concern that we have not addressed satisfactorily, please contact our third party dispute resolution provider (free of charge) at https://feedback-form.truste.com/watchdog/request.
//
// INTEROPERABILITY WITH WEIXIN
//
// WeChat is interoperable with Weixin, such that you are able to communicate with Weixin users and view each and other's Moments and Status posts. You may also be able to use certain features operated by Weixin, in accordance with the applicable terms. You may view the list of features operated by Weixin here. When you interact with a Weixin user, or use or receive notifications from any feature operated by Weixin, (together “Interoperable Interaction”), we will share your information with Weixin to the extent necessary to facilitate your Interoperable Interaction. You will also be subject to the Weixin Privacy Protection Guidelines.
//
// 1. INTRODUCTION
// Welcome to WeChat!
//
// When you use the WeChat mobile app, desktop app, or the websites www.wechat.com or help.wechat.com (together, "WeChat"), certain of your Personal Information (defined below) will be collected and processed by us.
//
// This Privacy Policy explains the when, how and why when it comes to processing of your Personal Information in connection with WeChat, and sets out your choices and rights in relation to that Personal Information.
//
// In this Privacy Policy, "we", "our" or "us" refers to:
//
// if you are a WeChat user located in the EEA, the UK or Switzerland: Tencent International Service Europe B.V., a Dutch company, located at Buitenveldertselaan 1-5, 1082 VA, Amsterdam, the Netherlands; and
// if you are a WeChat user located outside of the EEA, the UK, Switzerland or the Chinese Mainland: WeChat International Pte. Ltd., a Singaporean company located at 10 Anson Road, #21-07 International Plaza, Singapore 079903.
// Each of the above entities is also the data controller for users located in the abovementioned jurisdictions.
//
// Any capitalised terms used in this Privacy Policy have the same meaning as the equivalent defined terms in the WeChat Terms of Service, unless they are defined otherwise in this Privacy Policy.
//
// CONTACT
//
// If you have any questions or complaints regarding this Privacy Policy or the use of your Personal Information, please contact our Data Protection Officer via email at dataprotection@wechat.com or via postal mail at Buitenveldertselaan 1-5, 1082 VA, Amsterdam, the Netherlands (Attention: Data Protection Officer, Legal Department).
//
// Please note that if you are a resident in the EEA, the UK or Switzerland you have the right to lodge a complaint with your country's data protection authority.
//
// By using WeChat you agree to the processing of your Personal Information in accordance with this Privacy Policy. If you do not agree to the processing of your Personal Information in the way this Privacy Policy describes, please do not provide your Personal Information when requested and stop using WeChat.
//
// 2. SCOPE AND APPLICATION
// This Privacy Policy only applies to you if you are a WeChat user.
//
// This Privacy Policy does not apply to you if you are a Weixin user. You are a Weixin user if you had either:
//
// registered by linking a Chinese Mainland mobile number; or
// contracted with 深圳市腾讯计算机系统有限公司 (Shenzhen Tencent Computer Systems Company Limited) for Weixin.
// If you are a Weixin user, you are subject to the Weixin Agreement on Software License and Service of Tencent Weixin and Weixin Privacy Protection Guidelines and not this Privacy Policy.
//
// You can also check whether you are a WeChat or Weixin user by clicking "Me" > "Settings" > "About" and then clicking the link to the "Terms of Service". If you see the WeChat – Terms of Service then you are a WeChat user. If you see the Agreement on Software License and Service of Tencent Weixin then you are a Weixin user.
//
// If you subsequently change your phone number (either from a Chinese Mainland mobile number to a non-Chinese Mainland mobile number, or vice versa) you will be required to convert your account (to either a WeChat or Weixin account, depending on your new phone number). If you convert your Weixin account to a WeChat account, this Privacy Policy applies to you from the date our system records such conversion. If you convert your WeChat account to a Weixin account, this Privacy Policy ceases to apply to you from the date our system records such conversion.
//
// This Privacy Policy does not apply to Personal Information collected by third party services that you may access through the WeChat platform (e.g., Official Accounts, Mini Programs, Weixin Pay, or WeChat Pay), and Personal Information that you choose to share with a Weixin user. Please refer to the privacy policy of the relevant third party service. For more information, please see the section entitled "Who do we share your data with?" below.
//
// If you are using WeChat on behalf of a company, partnership, association, government or other organisation (your "Organisation"), you agree to notify such persons in your Organisation whose Personal Information (defined below) we collect or you provide to us ("Connected Persons"), and you agree to obtain such Connected Persons' consent to the processing of their Personal Information in accordance with this Privacy Policy as required by applicable laws and regulations. When this Privacy Policy refers to "you"or "your", this includes you and any Connected Persons. If you or any Connected Persons would like to request for your Personal Information to be removed from our database, please contact us at dataprotection@wechat.com.
//
// 3. DEFINITIONS
// "Location Data" is information that is derived from your GPS (GPS coordinates), WiFi (approximate city location), IP address (country location), or public posts that contain location information (the location you geo-tag). Location Data will be disclosed (either to us, to other users, or both):
//
// when you use location-based features and when you share your location with other WeChat and/or Weixin users; and
// when you access WeChat, we automatically derive Location Data from your IP address, device, or internet service for security purposes including to prevent fraudulent log-ins and connections to your account.
// You may disable the collection and use of your location data through device-level settings.
//
// "Log Data" is information that is automatically collected when you use WeChat, including:
//
// device attributes, such as your mobile carrier and network-related information, your device version and resettable identifiers, configuration information made available by your WeChat mobile app or desktop or web browser, and your IP address;
// information about your viewing history on WeChat, such as social media profiles visited and details of other content accessed or requested by you;
// general information about your communications on WeChat, such as the user that you have communicated with, the time, date and duration of your communications (but not the content of such communications), statistics about your use of WeChat, and traffic data; and
// metadata, which means information related to items you have made available through WeChat, such as the date, time or location that a shared photograph or video was taken or posted.
// "Personal Information" is any information, or combination of information, that relates to you, that can be used (directly or indirectly) to identify you, which we process in connection with your use of WeChat. Please see the section entitled "How do we use your information?" below for examples.
//
// "Shared Information" is information that you include in your publicly-visible WeChat profile, information you make available to other users via WeChat (e.g., via your Moments and Status posts), information about you that is made available by another user via their use of WeChat or Weixin, and Location Data.
//
// 4. HOW DO WE USE YOUR INFORMATION?
// This section provides more detail on the types of Personal Information we collect from you, purpose of processing, and retention periods for each type of Personal Information.
//
// For users resident in a Relevant Jurisdiction, it also identifies the legal basis under which we process your data. For the purposes of this Privacy Policy, a "Relevant Jurisdiction" includes the EEA, UK, Switzerland, Brazil, Thailand, and Turkey.
//
// We do not retain Personal Information for longer than is necessary unless we are required to do so under applicable laws. For further details on how long we keep your data, please refer to the retention periods set out below. If we are required to retain your Personal Information beyond the retention periods set out below, for example to comply with applicable laws, we will store it separately from other types of Personal Information. Aggregated registration data (which does not contain Personal Information) is retained for spam prevention and system security purposes.