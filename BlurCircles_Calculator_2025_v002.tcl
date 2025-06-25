set cut_paste_input [stack 0]
version 16.0 v4
push $cut_paste_input
NoOp {
 name BlurCirclesCalculator_PM_N1
 tile_color 0xff00ff
 selected true
 xpos 1670
 ypos 244
 hide_input true
 addUserKnob {20 User l BlurCirclesCalculator}
 addUserKnob {26 _5 l "Blur size px"}
 addUserKnob {3 resolution_width l "Resolution width"}
 resolution_width 2048
 addUserKnob {26 ""}
 addUserKnob {7 size_coc_ref l "Size CoC ref"}
 size_coc_ref {{((resolution_width/senzor_width_ref)*coc_size_ref)}}
 addUserKnob {7 size_coc_real_ref l "Size CoC real ref" -STARTLINE}
 size_coc_real_ref {{((resolution_width/senzor_width_ref)*coc_real_ref)}}
 addUserKnob {26 ""}
 addUserKnob {7 size_coc l "Size CoC"}
 size_coc {{((resolution_width/senzor_width)*coc_size)}}
 addUserKnob {7 size_coc_real l "Size CoC real" t ((resolution_width/senzor_width)*coc_real) -STARTLINE}
 size_coc_real {{((resolution_width/senzor_width)*coc_real)}}
 addUserKnob {26 "" +STARTLINE}
 addUserKnob {26 ""}
 addUserKnob {7 senzor_width_ref l "Senzor width ref (mm)" R 24 66.7}
 senzor_width_ref {36}
 addUserKnob {7 senzor_height_ref l "Senzor height ref (mm)" R 18 70}
 senzor_height_ref {24}
 addUserKnob {7 focal_lens_ref l "Focal length ref (mm)" R 18 200}
 focal_lens_ref {85}
 addUserKnob {7 fstop_ref l "Fstop ref" R 1 22}
 fstop_ref {2.8}
 addUserKnob {26 ""}
 addUserKnob {7 aov_ref l "AoV ref" +DISABLED +INVISIBLE}
 aov_ref {{"2*(atan(senzor_width_ref/(2*focal_lens_ref)))*(180 / pi)"}}
 addUserKnob {7 _AoV_Ref_ t " angle of view" R 10 360}
 _AoV_Ref_ {{aov_ref}}
 addUserKnob {26 ""}
 addUserKnob {7 coc_size_ref l "CoC size ref" t "sqrt(senzor_width_ref**2 + senzor_height_ref**2) / 1500" +DISABLED}
 coc_size_ref {{"sqrt(senzor_width_ref**2 + senzor_height_ref**2) / 1500"}}
 addUserKnob {7 hyperfocal_ref l "Hyperfocal ref (m)" t "focal_lens_ref**2 / (fstop_ref * coc_size_ref)" +DISABLED R 1 10}
 hyperfocal_ref {{"focal_lens_ref**2 / (fstop_ref * coc_size_ref)*0.001"}}
 addUserKnob {7 focus_distance_ref l "Focus distance (m)" R 1 100}
 focus_distance_ref {1.5}
 addUserKnob {26 ""}
 addUserKnob {7 near_focus_ref l "Near focus (m)" t "((hyperfocal_ref * focus_distance_ref) / (hyperfocal_ref + (focus_distance_ref - (focal_lens_ref*0.001))))" +DISABLED R 1 100}
 near_focus_ref {{"((hyperfocal_ref * focus_distance_ref) / (hyperfocal_ref + (focus_distance_ref - (focal_lens_ref*0.001))))"}}
 addUserKnob {7 far_focus_ref l "Far focus ref (m)" t "((hyperfocal_ref* focus_distance_ref)/(hyperfocal_ref - (focus_distance_ref - (focal_lens_ref*0.001))))" +DISABLED R 1 100}
 far_focus_ref {{"((hyperfocal_ref * focus_distance_ref)/(hyperfocal_ref - (focus_distance_ref - (focal_lens_ref*0.001))))"}}
 addUserKnob {7 dof_ref l "DOF ref (m)"}
 dof_ref {{far_focus_ref-near_focus_ref}}
 addUserKnob {26 _3 l "" +STARTLINE +INVISIBLE}
 addUserKnob {13 near_locator_ref l "Near locator ref (m)" t "-(focus_distance_ref - near_focus_ref)" +INVISIBLE}
 near_locator_ref {0 0 {near_focus_ref}}
 addUserKnob {13 far_locator_ref l "Far locator ref (m)" t "-(focus_distance_ref + far_focus_ref)" +INVISIBLE}
 far_locator_ref {0 0 {far_focus_ref}}
 addUserKnob {26 _1 l "" +STARTLINE}
 addUserKnob {26 _2 l "" +STARTLINE}
 addUserKnob {7 object_distance_ref l "object distance ref" R 1 10}
 object_distance_ref {1}
 addUserKnob {7 coc_real_ref l "CoC real life ref" t "((focal_lens_ref * focal_lens_ref) / (fstop_ref * ((focus_distance_ref * 1000) - focal_lens_ref))) * abs((object_distance_ref * 1000) - (focus_distance_ref * 1000)) / (object_distance_ref * 1000)\n" +DISABLED}
 coc_real_ref {{"((focal_lens_ref * focal_lens_ref) / (fstop_ref * ((focus_distance_ref * 1000) - focal_lens_ref))) * abs((object_distance_ref * 1000) - (focus_distance_ref * 1000)) / (object_distance_ref * 1000)"}}
 addUserKnob {7 hyperfocal_ref_2 l "Hyperfocal ref (m)" t "focal_lens_ref**2 / (fstop_ref * coc_real_ref)*0.001" +DISABLED R 1 10}
 hyperfocal_ref_2 {{"focal_lens_ref**2 / (fstop_ref * coc_real_ref)*0.001"}}
 addUserKnob {7 near_focus_ref_2 l "Near focus (m)" +DISABLED R 1 100}
 near_focus_ref_2 {{"(focus_distance_ref*1000 * (hyperfocal_ref_2*1000-fstop_ref) / (hyperfocal_ref_2*1000 + focus_distance_ref*1000 - fstop_ref*2))/1000"}}
 addUserKnob {7 far_focus_ref_2 l "Far focus (m)" t "((hyperfocal_ref_2* focus_distance_ref)/(hyperfocal_ref_2 - (focus_distance_ref - (focal_lens_ref*0.001))))" +DISABLED R 1 100}
 far_focus_ref_2 {{"focus_distance_ref > hyperfocal_ref_2 ? 100000 : (focus_distance_ref*1000 * (hyperfocal_ref_2*1000-fstop_ref) / (hyperfocal_ref_2*1000 - focus_distance_ref*1000))/1000"}}
 addUserKnob {7 dof_ref_2 l "DOF ref (m)"}
 dof_ref_2 {{far_focus_ref_2-near_focus_ref_2}}
 addUserKnob {26 ""}
 addUserKnob {26 ""}
 addUserKnob {26 "" +STARTLINE}
 addUserKnob {26 "" +STARTLINE}
 addUserKnob {7 senzor_width l "Senzor width (mm)" R 24 66.7}
 senzor_width {66.7}
 addUserKnob {7 senzor_height l "Senzor height (mm)" R 18 70}
 senzor_height {48.5}
 addUserKnob {7 focal_lens l "Focal length (mm)" R 18 200}
 focal_lens {160}
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
 addUserKnob {7 coc_size l "CoC size" t "sqrt(senzor_width**2 + senzor_height**2) / 1500" +DISABLED}
 coc_size {{"sqrt(senzor_width**2 + senzor_height**2) / 1500"}}
 addUserKnob {7 hyperfocal l "hyperfocal (m)" t "focal_lens**2 / (fstop * coc_size)*0.001" +DISABLED R 1 10}
 hyperfocal {{"focal_lens**2 / (fstop * coc_size)*0.001"}}
 addUserKnob {7 focus_distance l "Focus distance (m)" R 1 100}
 focus_distance {1.5}
 addUserKnob {26 ""}
 addUserKnob {7 near_focus l "Near focus (m)" t "((hyperfocal * focus_distance) / (hyperfocal + (focus_distance - (focal_lens*0.001))))" +DISABLED R 1 100}
 near_focus {{"((hyperfocal * focus_distance) / (hyperfocal + (focus_distance - (focal_lens*0.001))))"}}
 addUserKnob {7 far_focus l "Far focus (m)" t "((hyperfocal* focus_distance)/(hyperfocal - (focus_distance - (focal_lens*0.001))))" +DISABLED}
 far_focus {{"((hyperfocal* focus_distance)/(hyperfocal - (focus_distance - (focal_lens*0.001))))"}}
 addUserKnob {7 dof l "DOF (m)"}
 dof {{far_focus-near_focus}}
 addUserKnob {26 _4 l "" +STARTLINE +INVISIBLE}
 addUserKnob {13 near_locator l "Near locator (m)" t "-(focus_distance_ref - near_focus_ref)" +INVISIBLE}
 near_locator {0 0 {near_focus}}
 addUserKnob {13 far_locator l "Far locator (m)" t "-(focus_distance + far_focus)" +INVISIBLE}
 far_locator {0 0 {far_focus}}
 addUserKnob {26 ""}
 addUserKnob {26 ""}
 addUserKnob {7 object_distance l "object distance" R 1 10}
 object_distance {1}
 addUserKnob {7 coc_real l "CoC real life" +DISABLED}
 coc_real {{"((focal_lens * focal_lens) / (fstop * ((focus_distance * 1000) - focal_lens))) * abs((object_distance * 1000) - (focus_distance * 1000)) / (object_distance * 1000)"}}
 addUserKnob {7 hyperfocal_2 l "Hyperfocal (m)" t "focal_lens**2 / (fstop * coc_real)*0.001" +DISABLED R 1 10}
 hyperfocal_2 {{"focal_lens**2 / (fstop * coc_real)*0.001"}}
 addUserKnob {7 near_focus_2 l "Near focus (m)" t "(focus_distance*1000 * (hyperfocal_2*1000-fstop) / (hyperfocal_2*1000 + focus_distance*1000 - fstop*2))/1000" +DISABLED R 1 100}
 near_focus_2 {{"(focus_distance*1000 * (hyperfocal_2*1000-fstop) / (hyperfocal_2*1000 + focus_distance*1000 - fstop*2))/1000"}}
 addUserKnob {7 far_focus_2 l "Far focus (m)" t "focus_distance > hyperfocal_2 ? 100000 : (focus_distance*1000 * (hyperfocal_2*1000-fstop) / (hyperfocal_2*1000 - focus_distance*1000))/1000" +DISABLED R 1 100}
 far_focus_2 {{"focus_distance > hyperfocal_2 ? 100000 : (focus_distance*1000 * (hyperfocal_2*1000-fstop) / (hyperfocal_2*1000 - focus_distance*1000))/1000"}}
 addUserKnob {7 dof_2 l "DOF (m)"}
 dof_2 {{far_focus_2-near_focus_2}}
}
