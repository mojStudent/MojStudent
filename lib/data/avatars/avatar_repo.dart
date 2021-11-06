class AvatarRepo {

  static String getImgUrlForSeed(String seed, {String sprites = "personas"}) {
    return "https://avatars.dicebear.com/api/$sprites/$seed.svg";
  }
}