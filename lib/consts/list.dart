import 'package:ebuuy/consts/consts.dart';
import 'package:ebuuy/home/cartScreen.dart';
import 'package:ebuuy/home/categoriesScreen.dart';
import 'package:ebuuy/home/homeScreen.dart';
import 'package:ebuuy/home/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const socialIconList = [
  icFacebookLogo,
  icGoogleLogo,
  icTwitterLogo
];

var navbarItem = [
  BottomNavigationBarItem(icon:Image.asset(icHome,width: 26,),label: home),
  BottomNavigationBarItem(icon:Image.asset(icCategories,width: 26,),label: categories),
  BottomNavigationBarItem(icon:Image.asset(icCart,width: 26,),label: cart),
  BottomNavigationBarItem(icon:Image.asset(icProfile,width: 26,),label: account),

];
var navBody = [
  HomeScreen(),
  CategoriesScreen(),
  CartScreen(),
  ProfileScreen()
];

const sliderList = [
  imgSlider1,
  imgSlider2,
  imgSlider3,
  imgSlider4,

];
const secondSlideList = [
  imgSs1,
  imgSs2,
  imgSs3,
  imgSs4,

];

const thirdSliderList =[
  mobileSilder1,
  mobileSilder2,
  mobileSilder3,
  mobileSilder4
];

const featureImages1 = [imgS1,imgS2,imgS3];
const featureImages2 = [imgS4,imgS5,imgS6];

const featureTitle1 = [womenDress,android,iphone];
const featureTitle2 = [watch,necklace,laptop];


const categoriesNameList = [
  menClothingFashion,
  autoMobile,
  womenClothing,
  comAccess,
  kidtoys,
  sports,
  jewelley,
  cellPhone,
  furniture,

];
const categoriesImageList = [
  imgFc1,
  imgFc3,
  imgFc8,
  imgFc2,
  imgFc4,
  imgFc5,
  imgFc7,
  imgFc6,
  imgFc9,

];

const insightsTitle = [
  inYourCart,
  inYourWishlist,
  youOrdered,
];

const insightsValue =[
  00,22,3037
];

const profileDataTitle = [
myWallet,myOrder,myWishList,earnPoint,repundRequest,message
];

const profileDataIcon = [
Icon(Icons.wallet),Icon(Icons.account_box),Icon(Icons.favorite),Icon(Icons.money),Icon(Icons.money_off_csred_outlined),Icon(Icons.message)
];
