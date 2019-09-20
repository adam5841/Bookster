class IntroItem {
  IntroItem({
    this.title,
    this.author,
    this.imageUrl,
    this.favorite
  });

  final String title;
  final String author;
  final String imageUrl;
  bool favorite;
}

final sampleItems = <IntroItem>[
  new IntroItem(favorite: false,author: 'Joe+Haldeman',title: 'Forever+War', imageUrl: 'https://images-na.ssl-images-amazon.com/images/S/cmx-images-prod/Item/483652/483652._SX1280_QL80_TTD_.jpg',),
  new IntroItem(favorite: false,author: 'Daniel+Suarez',title: 'Delta-V', imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/91Xr8C2DYML.jpg',),
   new IntroItem(favorite: false,author: 'Jason+Gurley',title: 'The+Colonists',imageUrl: 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRd5WuZVoSIdawF4YT8FuaFjsRhLk6DnHwmUiqMHmO8zCFaL2sVKRroatfjj27324ZiRC8-vjfIqom9A4Pkqkpmgaripqvd6OC4gsHXKCnbKKyV3zOiwhts&usqp=CAE',),
  new IntroItem(favorite: false,author: "Andrew+Sean+Greer",title: 'Less', imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/41MV%2BfoRGbL.jpg',),
   
];
/*
"https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRd5WuZVoSIdawF4YT8FuaFjsRhLk6DnHwmUiqMHmO8zCFaL2sVKRroatfjj27324ZiRC8-vjfIqom9A4Pkqkpmgaripqvd6OC4gsHXKCnbKKyV3zOiwhts&usqp=CAE",
  "https://images-na.ssl-images-amazon.com/images/I/91Xr8C2DYML.jpg",
  "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRqzZ4V_0UmzMS7hRJgXnkO8uKQ1mkKF3RY2umz3E-YwWgYh0h0UmMPI3VhOcOIg-nE8PUU1qKH1ZZIRFrKB1TaH2cZJMmmtg&usqp=CAY",
  "https://images-na.ssl-images-amazon.com/images/S/cmx-images-prod/Item/483652/483652._SX1280_QL80_TTD_.jpg",
  */