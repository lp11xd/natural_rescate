import 'package:flutter/material.dart';

class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    @required this.imagePath,
    @required this.price,
    @required this.photographer,
    @required this.title,
    @required this.details,
  });
}

List<ImageDetails> images = [
  ImageDetails(
    imagePath: 'https://thumbor.granitemedia.com/img/thQ-49rj-9pgRcgxFKrKvklS7k4=/874x404/filters:quality(80)/granite-web-prod/6a/67/6a673647c1324d018e963e006073a0d5.jpeg',
    price: '\$20.00',
    photographer: 'Martin Andres',
    title: 'New Year',
    details:
        'This image was taken during a party in New York on new years eve. Quite a colorful shot.',
  ),
  ImageDetails(
    imagePath: 'https://thumbor.granitemedia.com/img/thQ-49rj-9pgRcgxFKrKvklS7k4=/874x404/filters:quality(80)/granite-web-prod/6a/67/6a673647c1324d018e963e006073a0d5.jpeg',
    price: '\$10.00',
    photographer: 'Abraham Costa',
    title: 'Spring',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'https://thumbor.granitemedia.com/img/thQ-49rj-9pgRcgxFKrKvklS7k4=/874x404/filters:quality(80)/granite-web-prod/6a/67/6a673647c1324d018e963e006073a0d5.jpeg',
    price: '\$30.00',
    photographer: 'Jamie Bryan',
    title: 'Casual Look',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  )
];