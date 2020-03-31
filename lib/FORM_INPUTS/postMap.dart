import 'package:google_maps_flutter/google_maps_flutter.dart';

class Post {
  String name;
  String dayLost;
  String description;
  String image;
  LatLng locationCoords;

  Post(
      {this.name,
        this.dayLost,
        this.description,
        this.image,
        this.locationCoords});
}

final List<Post> Posts = [
  Post(
      name: 'محمد احمد',
      dayLost: '15/1/2020',
      description:
      'هذا الشخص موجود في هذا المكان  من يوم 21/11 ولو يتم الوصول الي اهله ',
      locationCoords: LatLng(30.5857619, 31.5076958),
      image: 'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/s960x960/82310982_2514986192104493_6697971579369816064_o.jpg?_nc_cat=103&_nc_sid=85a577&_nc_ohc=29LldPb6MF8AX_2Z8Qq&_nc_ht=scontent-hbe1-1.xx&_nc_tp=7&oh=c676d00e669c7ca3aa1ba8d08740902f&oe=5EFA4DFE'
  ),
  Post(
      name: 'احمد علي',
      dayLost: '10/10/214',
      description:
      'هذا الشخص موجود في هذا المكان  من يوم 21/11 ولو يتم الوصول الي اهله ',
      locationCoords: LatLng(30.4857619, 31.6076958),
      image: 'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/85226165_181663259913865_1193111064078712832_n.jpg?_nc_cat=105&_nc_sid=a61e81&_nc_ohc=zi-biOroIvsAX-x5hzV&_nc_ht=scontent-hbe1-1.xx&oh=0c7c0f0d158e464b124ddad8d20d9929&oe=5EBFC882'
  ),
  Post(
      name: 'محمود العدروسي',
      dayLost: '12/12/2019',
      description:
      ' الشخص ده موجود عند المسجد واللي يتعرف عليه ممكن يكامنا علي الرقم ده 01552344879.',
      locationCoords: LatLng(30.5257619, 31.5976958),
      image:"https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/p720x720/78235464_2443125705952187_3410169784954781696_o.jpg?_nc_cat=103&_nc_sid=a61e81&_nc_ohc=jQa_Y0SGoMEAX-Xpm5h&_nc_ht=scontent-hbe1-1.xx&_nc_tp=6&oh=ffe055324c4c8c6334702e3e15159d29&oe=5EFD104B"),
  Post(
      name: 'سلمي احمد ',
      dayLost: '25/10/2018',
      description:
      'متغيبه عن المنزل من حوالي شهر اللي يجده يرجي التواصل معنا 010589452',
      locationCoords: LatLng(30.4657619, 31.6176958),
      image: 'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/85218090_2512628719001885_387219386525548544_n.jpg?_nc_cat=108&_nc_sid=a61e81&_nc_ohc=ppn1I6EaCTMAX_oKZON&_nc_ht=scontent-hbe1-1.xx&oh=50f345a9828017889420b68538638bfd&oe=5EFB38C3'
  ),

];
