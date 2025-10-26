class OnBoradModel {
  final String image;
  final String title;
  final String description;

  OnBoradModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnBoradModel> onBoradList = [
    OnBoradModel(
      image: 'assets/image/Group 1.png',
      title: 'Only Books Can Help You',
      description:
          'Books can help you to increase your knowledge and become more successfully.',
    ),
    OnBoradModel(
      image: 'assets/image/Group 2.png',
      title: 'Learn Smartly',
      description:
          'It’s 2022 and it’s time to learn every quickly and smartly. All books are storage in cloud and you can access all of them from your laptop or PC. ',
    ),
    OnBoradModel(
      image: 'assets/image/Group 3.png',
      title: 'Book Has Power To Chnage Everything',
      description:
          'We have true friend in our life and the books is that. Book has power to chnage yourself and make you more valueable.',
    ),
  ];
}
