set cut_paste_input [stack 0]
version 16.0 v1
push $cut_paste_input
NoOp {
 name Blur_Calculator_PM
 tile_color 0xffff00ff
 selected true
 xpos -184
 ypos -57
 hide_input true
 addUserKnob {20 User l Blur_Calculator_PM}
 addUserKnob {26 "" +STARTLINE}
 addUserKnob {7 blursize l size}
 blursize 21
 addUserKnob {3 refwidth l "Ref Width"}
 refwidth 2048
 addUserKnob {3 refheight l "Ref Height" -STARTLINE}
 refheight 1556
 addUserKnob {7 basepar l "Pixel Ratio"}
 basepar 1
 addUserKnob {26 "" +STARTLINE}
 addUserKnob {3 newwidth l Width}
 newwidth 2458
 addUserKnob {3 newheight l Height -STARTLINE}
 newheight 1867
 addUserKnob {7 par l "Pixel Ratio"}
 par 2
 addUserKnob {26 "" +STARTLINE}
 addUserKnob {7 calblur l "Calculated Blur"}
 calblur {{"blursize * sqrt((newwidth * newheight * par) / (refwidth * refheight * basepar))"}}
 addUserKnob {26 _1 l "Anamoprh separated"}
 addUserKnob {7 par2 l "Pixel Ratio" +INVISIBLE}
 par2 2
 addUserKnob {7 anaX l X}
 anaX {{"blursize * sqrt((newwidth * par) / (refwidth * basepar))"}}
 addUserKnob {7 anaY l Y}
 anaY {{"blursize * sqrt(newheight / refheight)"}}
}
