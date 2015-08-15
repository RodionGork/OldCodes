program shadock_and_giby;
uses crt;
type pole=array[1..20,1..12] of char;
var x,y,i,xs,ys,x1,x2:integer;
     ch:char;
  m1,m2:pole;
tr1,trs,tr2:byte;
procedure transistor;
var xt,yt:integer;
       nt:byte;
    trans:boolean;
begin
  repeat
    xt:=random(20)+1; yt:=random(12)+1; nt:=random(9)+1;
    if m1[xt,yt]<>'.' then trans:=false else
      begin trans:=true; m1[xt,yt]:=chr(nt+48); gotoxy(xt+18,yt+1); write(nt); end;
  until trans=true;
end;
procedure shad_move(var m2:pole;var tr1:byte;var x1,y1:integer; x,y:integer);
begin
  if (x>0) and (x<21) and (y>0) and (y<13) then
    if m2[x,y]<>#1 then begin tr1:=tr1+ord(m2[x,y])-48; m2[x,y]:='.';end;
    if m2[x,y]='.' then begin m2[x,y]:='';gotoxy(x+18,y+1);write('');x1:=x;y1:=y;end;
end;
begin
  asm
    MOV AX,0000H
    INT 10H
    MOV AH,1
    MOV CX,0100H
    INT 10H
  end;
  textbackground(1);
  textcolor(10);
  clrscr;
  randomize;
  gotoxy(18,1); write('É');
  gotoxy(40,1); write('»');
  gotoxy(18,14); write('È');
  gotoxy(40,14); write('¼');
  for x:=19 to 39 do
    begin gotoxy(x,1); write('Í'); end;
  for x:=19 to 39 do
    begin gotoxy(x,14); write('Í'); end;
  for y:=2 to 13 do
    begin gotoxy(18,y); write('º'); end;
  for y:=2 to 13 do
    begin gotoxy(40,y); write('º'); end;
  for y:=2 to 13 do
    for x:=19 to 39 do
      begin gotoxy(x,y); write('.'); m1[x-18,y-1]:='.'; end;
  m2:=m1;
  for i:=1 to 17 do transistor;
  i:=0;
  while i<14 do
    begin
      x:=random(20)+1; y:=random(12)+1;
      if m1[x,y]='.' then
        begin i:=i+1; m1[x,y]:=#1; gotoxy(x+18,y+1); write(#1); end;
    end;
  i:=0;
  while i<1 do
    begin
      xs:=random(20)+1; ys:=random(12)+1;
      if m1[xs,ys]='.' then
        begin i:=i+1; m1[x,y]:=#1; gotoxy(x+18,y+1); write(#1); end;
    end;
  repeat
    tr2:=trs;
    ch:=readkey;
    m1[xs,ys]:='.';
    gotoxy(xs+18,ys+1);write('.');
    if ch='7' then shad_move(m1,trs,xs,ys,xs-1,ys-1);
    if ch='8' then shad_move(m1,trs,xs,ys,xs,ys-1);
    if ch='9' then shad_move(m1,trs,xs,ys,xs+1,ys-1);
    if ch='4' then shad_move(m1,trs,xs,ys,xs-1,ys);
    if ch='6' then shad_move(m1,trs,xs,ys,xs+1,ys);
    if ch='1' then shad_move(m1,trs,xs,ys,xs-1,ys+1);
    if ch='2' then shad_move(m1,trs,xs,ys,xs,ys+1);
    if ch='3' then shad_move(m1,trs,xs,ys,xs+1,ys+1);
  until ch=#27;
end.