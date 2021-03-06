$PBExportHeader$uo_ddcalc.sru
forward
global type uo_ddcalc from datawindow
end type
end forward

global type uo_ddcalc from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean livescroll = true
event ue_dropdown pbm_dwndropdown
end type
global uo_ddcalc uo_ddcalc

forward prototypes
public subroutine uf_show_ddcalc ()
end prototypes

public subroutine uf_show_ddcalc ();//====================================================================
// Function: uo_ddcalc.uf_show_ddcalc()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/07/05
//--------------------------------------------------------------------
// Usage: uo_ddcalc.uf_show_ddcalc ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

str_calculator	lstr_calc
Integer			li_pos, li_calc_height, li_x, li_y
String			ls_col
window			lw_parent
environment env

GetEnvironment(env)
SetPointer(HourGlass!)

li_calc_height = 737

ls_col = This.GetColumnName()
li_x   = This.X
li_y   = This.Y

lw_parent = Parent
lstr_calc.X = lw_parent.WorkSpaceX() + li_x + Integer(This.Describe(ls_col + ".X")) - 2
lstr_calc.Y = lw_parent.WorkSpaceY() + li_y + Integer(This.Describe(ls_col + ".Y")) &
	+ Integer(This.Describe(ls_col + ".Height")) + 12

/* Check for calculator off bottom of workspace */
If (lstr_calc.Y + li_calc_height) > (env.ScreenWidth + env.ScreenHeight	) Then
	lstr_calc.Y -= (Integer(This.Describe(ls_col + ".height")) + li_calc_height + 4)
End If

lstr_calc.window  = Parent
lstr_calc.dw 	   = This
lstr_calc.column  = ls_col
lstr_calc.Value	 = This.GetText()

OpenWithParm(w_calculator, lstr_calc)
This.SetColumn(ls_col)

end subroutine

on uo_ddcalc.create
end on

on uo_ddcalc.destroy
end on

