$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type dw_1 from uo_ddcalc within w_main
end type
end forward

global type w_main from window
integer width = 1431
integer height = 544
boolean titlebar = true
string title = "Dropdown Calculator"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_main w_main

on w_main.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_main.destroy
destroy(this.dw_1)
end on

event open;dw_1.insertrow(0)
end event

type dw_1 from uo_ddcalc within w_main
integer x = 256
integer y = 96
integer width = 914
integer height = 208
integer taborder = 10
string dataobject = "d_numeric"
boolean border = false
end type

event ue_dropdown;call super::ue_dropdown;//call dropdown calculator
Choose Case This.GetColumnName()
	Case "cost", "qty"
		uf_show_ddcalc()
		Return 1
End Choose

end event

