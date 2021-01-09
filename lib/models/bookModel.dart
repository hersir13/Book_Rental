import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String bookName;
  String imageUrl;
  String submitUserImage;
  String submitUserId;
  double bookPrice;
  Timestamp createdAt;
  Timestamp publishDate;
  String submitUserName;
  String bookId;
  bool isFavorite;

  Book({
    this.bookName,
    this.bookPrice,
    this.createdAt,
    this.imageUrl,
    this.publishDate,
    this.submitUserId,
    this.submitUserName,
    this.submitUserImage,
    this.bookId,
    this.isFavorite,
  });
}
