import '../entities/post.dart';

List<Post> fakePosts = [
  Post(
      id: '1',
      authorId: '1',
      authorName: 'Brandon Walter',
      imageUrl:
          'https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',
      avatarUrl: '',
      body: 'This is an example post',
      commentCount: 3,
      postTime: DateTime.utc(2020, 4, 17, 15, 20),
      likeCount: 5),
  Post(
      id: '2',
      authorId: '2',
      authorName: 'Amerison Shresha',
      imageUrl:
          'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      avatarUrl:
          'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
      body: 'This is an example post showing long text and how it would look',
      commentCount: 2,
      postTime: DateTime.utc(2020, 4, 17, 12, 20),
      likeCount: 45),
  Post(
      id: '3',
      authorId: '3',
      authorName: 'Jakie Ramos',
      body: 'This is an example post showing long text and how it would look',
      commentCount: 20,
      postTime: DateTime.utc(2020, 4, 17, 10, 20),
      likeCount: 21),
  Post(
      id: '4',
      authorId: '4',
      authorName: 'Jackequalin Natalani',
      body:
          'This is an example post showing long text and how it would look and this is supposed to be a really long post, to see how the UI will react whenever there is really long content and we need to cut off the content.',
      commentCount: 20,
      postTime: DateTime.utc(2020, 3, 25, 10, 20),
      likeCount: 210),
];
