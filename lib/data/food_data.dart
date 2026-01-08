import '../models/food_item.dart';

final List<FoodItem> savoryFoods = [
  FoodItem(
    name: "ข้าวผัด",
    image:
        "https://img.wongnai.com/p/1920x0/2019/12/19/d5537700a7274ac09964b6a51dd0a9f6.jpg",
    videoUrl: "https://www.youtube.com/watch?v=y7MNTG1ZW7I",
    ingredients: ["ข้าวสวย", "ไข่ไก่", "กระเทียม", "ซีอิ๊ว", "น้ำมัน"],
    steps: [
      "ตั้งกระทะใส่น้ำมัน",
      "ผัดกระเทียมให้หอม",
      "ใส่ไข่แล้วผัด",
      "ใส่ข้าวและปรุงรส",
    ],
    lat: 18.272996604133343,
    lng: 99.50164398951341,
    price: 50,
  ),
  FoodItem(
    name: "ส้มตำ",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRn0Ephjk-BnDHx4-P3P6p9-6dA5_ITdOshWQ&s",
    videoUrl: "https://www.youtube.com/watch?v=KoUrDJWDhx4",
    ingredients: ["มะละกอ", "พริก", "กระเทียม", "น้ำปลา", "น้ำมะนาว"],
    steps: ["โขลกพริกกับกระเทียม", "ใส่มะละกอ", "ปรุงรส", "คลุกเคล้า"],
    lat: 18.301842653929818,
    lng: 99.48300895701861,
    price: 40,
  ),
  FoodItem(
    name: "ต้มยำ",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjDwty1vWW00oTM7uGN6-uU3aNCKN9CN3ZHA&s",
    videoUrl: "https://www.facebook.com/watch/?v=1105637155000326",
    ingredients: ["กุ้ง", "ตะไคร้", "ใบมะกรูด", "พริก", "น้ำปลา"],
    steps: ["ต้มน้ำ", "ใส่สมุนไพร", "ใส่กุ้ง", "ปรุงรส"],
    lat: 18.295275463390254,
    lng: 99.49069469073318,
    price: 80,
  ),
  FoodItem(
    name: "ผัดไทย",
    image:
        "https://img.wongnai.com/p/1920x0/2025/05/15/58318e873c984c19a04b5bccd4728926.jpg",
    videoUrl: "https://www.youtube.com/watch?v=jpV2pmglE40",
    ingredients: ["เส้น", "ไข่", "กุ้ง", "ถั่วงอก", "ซอส"],
    steps: ["ผัดเส้น", "ใส่ไข่", "ใส่กุ้ง", "ใส่ถั่วงอก"],
    lat: 18.2899355345468,
    lng: 99.49665978312335,
    price: 60,
  ),
];

final List<FoodItem> sweetFoods = [
  FoodItem(
    name: "เค้ก",
    image:
        "https://w0.peakpx.com/wallpaper/935/595/HD-wallpaper-anime-girls-minato-aqua-virtual-youtuber-open-mouth-multi-colored-hair-braids-strawberries-cake.jpg",
    videoUrl: "https://www.youtube.com/watch?v=-3ogH0UdiUg",
    ingredients: ["แป้ง", "ไข่", "น้ำตาล", "เนย"],
    steps: ["ผสม", "เทพิมพ์", "อบ"],
    lat: 18.283927229361502,
    lng: 99.49679572427698,
    price: 45,
  ),
  FoodItem(
    name: "โดรายากิ",
    image:
        "https://mushroomtravelpage.b-cdn.net/wp-content/uploads/2016/06/pic_23.jpg",
    videoUrl: "https://www.youtube.com/watch?v=lGujHONOu0M",
    ingredients: ["แป้ง", "ไข่", "ถั่วแดง"],
    steps: ["ทำแป้ง", "ทอด", "ประกบไส้"],
    lat: 18.298594520791855,
    lng: 99.49534872320156,
    price: 35,
  ),
  FoodItem(
    name: "บราวนี่",
    image: "https://food.mthai.com/app/uploads/2017/06/brownies.jpg",
    videoUrl: "https://www.youtube.com/watch?v=sTsB-AxjiR4",
    ingredients: ["ช็อกโกแลต", "เนย", "แป้ง", "ไข่"],
    steps: ["ละลาย", "ผสม", "อบ"],
    lat: 18.282017317373754,
    lng: 99.49384267602551,
    price: 55,
  ),
];
