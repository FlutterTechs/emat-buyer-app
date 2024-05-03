import 'package:ebuuy/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

String userCollection = "users";

const productCollection = "product";
const cartColllection = "cart";
const orderCollection = "Orders";
const chatCollection = "chats";
const messageCollection = "message";
const brandsCollection = "Brands";
const sellerCollection = "shop";