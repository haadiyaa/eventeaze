class OnBoard {
  final String title, desc;

  OnBoard({required this.title, required this.desc});
}

class OnBoardItems {
  List<OnBoard> data = [
    OnBoard(
        title: 'Welcome to EventEaze!',
        desc: 'Discover and join exciting events happening around you!'),
    OnBoard(
        title: 'Create Your Own Events with EventEaze',
        desc: 'Create, promote, and manage your own events effortlessly.'),
    OnBoard(
        title: 'Find your favourite events here',
        desc:
            'Browse a wide range of events including concerts, workshops, festivals, and more.'),
    OnBoard(
        title: 'Get Started!',
        desc:
            'Explore to find events near you, and make your event experience unforgettable!'),
  ];
}
