set cut_paste_input [stack 0]
version 16.0 v4
push $cut_paste_input
NoOp {
 name BlurCirclesCalculator2
 tile_color 0xff00ff
 selected true
 xpos 227
 ypos 86
 hide_input true
 addUserKnob {20 User l BlurCirclesCalculator}
 addUserKnob {26 ""}
 addUserKnob {26 ""}
 addUserKnob {7 senzor_width_ref l "Senzor width ref (mm)" R 24 66.7}
 senzor_width_ref 24
 addUserKnob {7 focal_lens_ref l "Focal length ref (mm)" R 18 200}
 focal_lens_ref 18
 addUserKnob {7 fstop_ref l "Fstop ref" R 1 22}
 fstop_ref 4
 addUserKnob {26 ""}
 addUserKnob {7 aov_ref l "AoV ref" +DISABLED +INVISIBLE}
 aov_ref {{"2*(atan(senzor_width_ref/(2*focal_lens_ref)))*(180 / pi)"}}
 addUserKnob {7 _AoV_Ref_ t " angle of view" R 10 360}
 _AoV_Ref_ {{aov_ref}}
 addUserKnob {26 ""}
 addUserKnob {7 senzor_height_ref l "Senzor height ref (mm)" R 18 70}
 senzor_height_ref 18.66
 addUserKnob {7 coc_size_ref l "CoC size ref" t "sqrt(senzor_width_ref**2 + senzor_height_ref**2) / 1500" +DISABLED}
 coc_size_ref {{"sqrt(senzor_width_ref**2 + senzor_height_ref**2) / 1500"}}
 addUserKnob {7 hyperfocal_ref l "Hyperfocal ref (m)" t "focal_lens_ref**2 / (fstop_ref * coc_size_ref)" +DISABLED R 1 10}
 hyperfocal_ref {{"focal_lens_ref**2 / (fstop_ref * coc_size_ref)*0.001"}}
 addUserKnob {7 focus_distance_ref l "Focus distance (m)" R 1 100}
 focus_distance_ref 3.74
 addUserKnob {26 ""}
 addUserKnob {7 near_focus_ref l "Near focus (m)" t "((hyperfocal_ref * focus_distance_ref) / (hyperfocal_ref + (focus_distance_ref - (focal_lens_ref*0.001))))" +DISABLED R 1 100}
 near_focus_ref {{"((hyperfocal_ref * focus_distance_ref) / (hyperfocal_ref + (focus_distance_ref - (focal_lens_ref*0.001))))"}}
 addUserKnob {7 far_focus_ref l "Far focus ref (m)" t "((hyperfocal_ref* focus_distance_ref)/(hyperfocal_ref - (focus_distance_ref - (focal_lens_ref*0.001))))" +DISABLED R 1 100}
 far_focus_ref {{"((hyperfocal_ref * focus_distance_ref)/(hyperfocal_ref - (focus_distance_ref - (focal_lens_ref*0.001))))"}}
 addUserKnob {7 dof_ref l "DOF ref (m)"}
 dof_ref {{far_focus_ref-near_focus_ref}}
 addUserKnob {26 ""}
 addUserKnob {13 near_locator_ref l "Near locator ref (m)" t "-(focus_distance_ref - near_focus_ref)"}
 near_locator_ref {0 0 {near_focus_ref}}
 addUserKnob {13 far_locator_ref l "Far locator ref (m)" t "-(focus_distance_ref + far_focus_ref)"}
 far_locator_ref {0 0 {far_focus_ref}}
 addUserKnob {26 ""}
 addUserKnob {26 ""}
 addUserKnob {7 senzor_width l "Senzor width (mm)" R 24 66.7}
 senzor_width 66.7
 addUserKnob {7 focal_lens l "Focal length (mm)" R 18 200}
 focal_lens 50
 addUserKnob {7 fstop l Fstop +DISABLED +INVISIBLE R 1 22}
 fstop {{fstop_ref*(senzor_width/senzor_width_ref)}}
 addUserKnob {7 _fstop_ l _Fstop_ R 1 22}
 _fstop_ {{fstop}}
 addUserKnob {26 ""}
 addUserKnob {7 aov l AoV +DISABLED +INVISIBLE}
 aov {{"2*(atan(senzor_width/(2*focal_lens)))*(180 / pi)"}}
 addUserKnob {7 _AoV_ R 10 360}
 _AoV_ {{aov}}
 addUserKnob {26 ""}
 addUserKnob {7 senzor_height l "Senzor height (mm)" R 18 70}
 senzor_height 48.5
 addUserKnob {7 coc_size l "CoC size" t "sqrt(senzor_width**2 + senzor_height**2) / 1500" +DISABLED}
 coc_size {{"sqrt(senzor_width**2 + senzor_height**2) / 1500"}}
 addUserKnob {7 hyperfocal l "hyperfocal (m)" t "focal_lens**2 / (fstop * coc_size)*0.001" +DISABLED R 1 10}
 hyperfocal {{"focal_lens**2 / (fstop * coc_size)*0.001"}}
 addUserKnob {7 focus_distance l "Focus distance (m)" R 1 100}
 focus_distance 1
 addUserKnob {26 ""}
 addUserKnob {7 near_focus l "Near focus (m)" t "((hyperfocal * focus_distance) / (hyperfocal + (focus_distance - (focal_lens*0.001))))" +DISABLED R 1 100}
 near_focus {{"((hyperfocal * focus_distance) / (hyperfocal + (focus_distance - (focal_lens*0.001))))"}}
 addUserKnob {7 far_focus l "Far focus (m)" t "((hyperfocal* focus_distance)/(hyperfocal - (focus_distance - (focal_lens*0.001))))" +DISABLED}
 far_focus {{"((hyperfocal* focus_distance)/(hyperfocal - (focus_distance - (focal_lens*0.001))))"}}
 addUserKnob {7 dof l "DOF (m)"}
 dof {{far_focus-near_focus}}
 addUserKnob {26 ""}
 addUserKnob {13 near_locator l "Near locator (m)" t "-(focus_distance_ref - near_focus_ref)"}
 near_locator {0 0 {near_focus}}
 addUserKnob {13 far_locator l "Far locator (m)" t "-(focus_distance + far_focus)"}
 far_locator {0 0 {far_focus}}
 addUserKnob {26 ""}
 addUserKnob {26 ""}
}
