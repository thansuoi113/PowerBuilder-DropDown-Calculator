$PBExportHeader$w_calculator.srw
forward
global type w_calculator from window
end type
type cb_clear2 from commandbutton within w_calculator
end type
type cb_7 from commandbutton within w_calculator
end type
type cb_4 from commandbutton within w_calculator
end type
type cb_1 from commandbutton within w_calculator
end type
type cb_clear1 from commandbutton within w_calculator
end type
type cb_8 from commandbutton within w_calculator
end type
type cb_5 from commandbutton within w_calculator
end type
type cb_2 from commandbutton within w_calculator
end type
type cb_0 from commandbutton within w_calculator
end type
type cb_dec from commandbutton within w_calculator
end type
type cb_3 from commandbutton within w_calculator
end type
type cb_6 from commandbutton within w_calculator
end type
type cb_9 from commandbutton within w_calculator
end type
type cb_shift from commandbutton within w_calculator
end type
type cb_percent from commandbutton within w_calculator
end type
type cb_mult from commandbutton within w_calculator
end type
type cb_div from commandbutton within w_calculator
end type
type cb_minus from commandbutton within w_calculator
end type
type cb_plus from commandbutton within w_calculator
end type
type cb_enter from commandbutton within w_calculator
end type
type r_1 from rectangle within w_calculator
end type
type ln_1 from line within w_calculator
end type
type ln_2 from line within w_calculator
end type
end forward

global type w_calculator from window
integer x = 439
integer y = 456
integer width = 562
integer height = 736
windowtype windowtype = popup!
long backcolor = 12632256
cb_clear2 cb_clear2
cb_7 cb_7
cb_4 cb_4
cb_1 cb_1
cb_clear1 cb_clear1
cb_8 cb_8
cb_5 cb_5
cb_2 cb_2
cb_0 cb_0
cb_dec cb_dec
cb_3 cb_3
cb_6 cb_6
cb_9 cb_9
cb_shift cb_shift
cb_percent cb_percent
cb_mult cb_mult
cb_div cb_div
cb_minus cb_minus
cb_plus cb_plus
cb_enter cb_enter
r_1 r_1
ln_1 ln_1
ln_2 ln_2
end type
global w_calculator w_calculator

type variables
Private:
str_calculator istr_calc
String is_num
String is_prevnum
String is_sign

end variables

forward prototypes
public subroutine wf_numpress (string vs_digit)
public function boolean wf_numtoobig (string vs_num)
public subroutine wf_calc ()
public subroutine wf_trim (ref string rs_num)
end prototypes

public subroutine wf_numpress (string vs_digit);//====================================================================
// Function: w_calculator.wf_numpress()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	vs_digit	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/07/05
//--------------------------------------------------------------------
// Usage: w_calculator.wf_numpress ( string vs_digit )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Decimal	lc_null

If is_num = '' Then
	SetNull(lc_null)
	istr_calc.dw.SetItem(istr_calc.dw.GetRow(), istr_calc.column, lc_null)
End If

If wf_NumTooBig(is_num + vs_digit) Then Return

is_num = is_num + vs_digit
istr_calc.dw.SetText(is_num)

end subroutine

public function boolean wf_numtoobig (string vs_num);//====================================================================
// Function: w_calculator.wf_numtoobig()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	vs_num	
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/07/05
//--------------------------------------------------------------------
// Usage: w_calculator.wf_numtoobig ( string vs_num )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer	li_len

If LenA(vs_num) > 9 Then
	Beep(2)
	Return True
Else
	Return False
End If

end function

public subroutine wf_calc ();//====================================================================
// Function: w_calculator.wf_calc()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/07/05
//--------------------------------------------------------------------
// Usage: w_calculator.wf_calc ( )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_num

If Dec(is_prevnum) > 0 Then
	Choose Case is_sign
		Case '+'
			ls_num = String(Dec(is_prevnum) + Dec(is_num))
		Case '-'
			ls_num = String(Dec(is_prevnum) - Dec(is_num))
		Case '/'
			ls_num = String(Dec(is_prevnum) / Dec(is_num))
		Case '*'
			ls_num = String(Dec(is_prevnum) * Dec(is_num))
	End Choose
Else
	ls_num = is_num
End If

wf_Trim(ls_num)
If wf_NumTooBig(ls_num) Then Return

is_num = ls_num
istr_calc.dw.SetText(is_num)

end subroutine

public subroutine wf_trim (ref string rs_num);//====================================================================
// Function: w_calculator.wf_trim()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ref	string	rs_num	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/07/05
//--------------------------------------------------------------------
// Usage: w_calculator.wf_trim ( ref string rs_num )
//--------------------------------------------------------------------
//	Copyright (c) PB.BaoGa(TM), All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer	li_len, i, li_dec, li_round

If PosA(rs_num, '.') = 0 Then Return

li_len = LenA(rs_num)
For i = li_len To 1 Step -1
	Choose Case MidA(rs_num, i, 1)
		Case '0'
			rs_num = ReplaceA(rs_num, i, 1, ' ')
			
		Case '.'
			rs_num = ReplaceA(rs_num, i, 1, ' ')
			Exit
			
		Case Else
			Exit
	End Choose
Next

rs_num = RightTrim(rs_num)

If LenA(rs_num) < 9 Then Return

li_dec = PosA(rs_num, '.')
If li_dec = 0 Then Return

li_round = 9 - li_dec
rs_num = String(Round(Dec(rs_num), li_round))




end subroutine

event open;istr_calc = Message.PowerObjectParm
This.Y = istr_calc.Y
This.X = istr_calc.X
is_num = istr_calc.Value

end event

event deactivate;Close(This)

end event

on w_calculator.create
this.cb_clear2=create cb_clear2
this.cb_7=create cb_7
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_clear1=create cb_clear1
this.cb_8=create cb_8
this.cb_5=create cb_5
this.cb_2=create cb_2
this.cb_0=create cb_0
this.cb_dec=create cb_dec
this.cb_3=create cb_3
this.cb_6=create cb_6
this.cb_9=create cb_9
this.cb_shift=create cb_shift
this.cb_percent=create cb_percent
this.cb_mult=create cb_mult
this.cb_div=create cb_div
this.cb_minus=create cb_minus
this.cb_plus=create cb_plus
this.cb_enter=create cb_enter
this.r_1=create r_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.cb_clear2,&
this.cb_7,&
this.cb_4,&
this.cb_1,&
this.cb_clear1,&
this.cb_8,&
this.cb_5,&
this.cb_2,&
this.cb_0,&
this.cb_dec,&
this.cb_3,&
this.cb_6,&
this.cb_9,&
this.cb_shift,&
this.cb_percent,&
this.cb_mult,&
this.cb_div,&
this.cb_minus,&
this.cb_plus,&
this.cb_enter,&
this.r_1,&
this.ln_1,&
this.ln_2}
end on

on w_calculator.destroy
destroy(this.cb_clear2)
destroy(this.cb_7)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_clear1)
destroy(this.cb_8)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.cb_0)
destroy(this.cb_dec)
destroy(this.cb_3)
destroy(this.cb_6)
destroy(this.cb_9)
destroy(this.cb_shift)
destroy(this.cb_percent)
destroy(this.cb_mult)
destroy(this.cb_div)
destroy(this.cb_minus)
destroy(this.cb_plus)
destroy(this.cb_enter)
destroy(this.r_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type cb_clear2 from commandbutton within w_calculator
integer x = 27
integer y = 20
integer width = 114
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C"
end type

event clicked;is_num = ''
is_prevnum = ''
is_sign = ''
istr_calc.dw.SetText(is_num)

end event

type cb_7 from commandbutton within w_calculator
integer x = 27
integer y = 136
integer width = 114
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "7"
end type

event clicked;wf_numpress(This.Text)

end event

type cb_4 from commandbutton within w_calculator
integer x = 27
integer y = 252
integer width = 114
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "4"
end type

on clicked;wf_numpress(this.text)
end on

type cb_1 from commandbutton within w_calculator
integer x = 27
integer y = 368
integer width = 114
integer height = 108
integer taborder = 150
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1"
end type

on clicked;wf_numpress(this.text)
end on

type cb_clear1 from commandbutton within w_calculator
integer x = 155
integer y = 20
integer width = 114
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CE"
end type

event clicked;is_num = ''
istr_calc.dw.SetText(is_num)

end event

type cb_8 from commandbutton within w_calculator
integer x = 155
integer y = 136
integer width = 114
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "8"
end type

on clicked;wf_numpress(this.text)
end on

type cb_5 from commandbutton within w_calculator
integer x = 155
integer y = 252
integer width = 114
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "5"
end type

on clicked;wf_numpress(this.text)
end on

type cb_2 from commandbutton within w_calculator
integer x = 155
integer y = 368
integer width = 114
integer height = 108
integer taborder = 140
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "2"
end type

on clicked;wf_numpress(this.text)
end on

type cb_0 from commandbutton within w_calculator
integer x = 27
integer y = 484
integer width = 242
integer height = 108
integer taborder = 180
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
end type

on clicked;wf_numpress(this.text)
end on

type cb_dec from commandbutton within w_calculator
integer x = 283
integer y = 484
integer width = 114
integer height = 108
integer taborder = 190
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "."
end type

on clicked;wf_numpress(this.text)
end on

type cb_3 from commandbutton within w_calculator
integer x = 283
integer y = 368
integer width = 114
integer height = 108
integer taborder = 160
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3"
end type

on clicked;wf_numpress(this.text)
end on

type cb_6 from commandbutton within w_calculator
integer x = 283
integer y = 252
integer width = 114
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "6"
end type

on clicked;wf_numpress(this.text)
end on

type cb_9 from commandbutton within w_calculator
integer x = 283
integer y = 136
integer width = 114
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "9"
end type

on clicked;wf_numpress(this.text)
end on

type cb_shift from commandbutton within w_calculator
integer x = 283
integer y = 20
integer width = 114
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;is_num = LeftA(is_num, LenA(is_num) - 1)
istr_calc.dw.SetText(is_num)

end event

type cb_percent from commandbutton within w_calculator
integer x = 411
integer y = 20
integer width = 114
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "%"
end type

on clicked;is_num = String(dec(is_num) / 100)
istr_calc.dw.SetText(is_num)
end on

type cb_mult from commandbutton within w_calculator
integer x = 411
integer y = 136
integer width = 114
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "x"
end type

event clicked;wf_Calc()
is_prevnum = String(Dec(is_num))

is_num = ''
is_sign = '*'
istr_calc.dw.SetText(is_prevnum)

end event

type cb_div from commandbutton within w_calculator
integer x = 411
integer y = 252
integer width = 114
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "/"
end type

on clicked;wf_Calc()
is_prevnum = String(Dec(is_num))

is_num = ''
is_sign = '/'
istr_calc.dw.SetText(is_prevnum)
end on

type cb_minus from commandbutton within w_calculator
integer x = 411
integer y = 368
integer width = 114
integer height = 108
integer taborder = 130
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "-"
end type

on clicked;wf_Calc()
is_prevnum = String(Dec(is_num))

is_num = ''
is_sign = '-'
istr_calc.dw.SetText(is_prevnum)
end on

type cb_plus from commandbutton within w_calculator
integer x = 411
integer y = 484
integer width = 114
integer height = 108
integer taborder = 170
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "+"
end type

on clicked;wf_Calc()
is_prevnum = String(Dec(is_num))

is_num = ''
is_sign = '+'
istr_calc.dw.SetText(is_prevnum)
end on

type cb_enter from commandbutton within w_calculator
integer x = 27
integer y = 600
integer width = 498
integer height = 108
integer taborder = 200
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "=    Enter"
end type

event clicked;wf_Calc()
Close(Parent)

end event

type r_1 from rectangle within w_calculator
long linecolor = 16777215
integer linethickness = 9
long fillcolor = 12632256
integer width = 553
integer height = 728
end type

type ln_1 from line within w_calculator
long linecolor = 8421504
integer linethickness = 9
integer beginx = 549
integer endx = 549
integer endy = 728
end type

type ln_2 from line within w_calculator
long linecolor = 8421504
integer linethickness = 9
integer beginy = 724
integer endx = 549
integer endy = 724
end type

