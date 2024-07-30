class ReviewsClass {
  String name, comment, date;
  ReviewsClass({required this.comment, required this.date, required this.name});
}

List<ReviewsClass> reviewsList = [
  ReviewsClass(
      comment: 'Very nice hotel, i will come again',
      date: '2023/5/21',
      name: 'farah'),
  ReviewsClass(
      comment: 'Very good services', date: '2024/6/10', name: 'tala'),
];
