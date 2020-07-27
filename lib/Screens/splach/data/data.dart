import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("  لا يمكن لأي كلمات التعبير عن الألم الذي يشعر به الوالدان عند اختفاء طفل لهما ");
  sliderModel.setTitle(" ");
  sliderModel.setImageAssetPath("assets/images/sp1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("وفر مجهود ووقت في البحث عن  الشخص ");
  sliderModel.setTitle(" ");
  sliderModel.setImageAssetPath("assets/images/sp2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("تعرف وتواصل مع الشخص في اسرع وقت واقل مجهود ");
  sliderModel.setTitle(" ");
  sliderModel.setImageAssetPath("assets/images/sp3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}