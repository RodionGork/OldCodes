program superMachine;
uses crt;
label 1,2;
const s1='.r';s2='.s';
type str=record
       reg1,reg2,reg3:byte;
            symb:byte;
             end;
     reg=array[1..32] of real;
     mas=array[1..128] of str;
      fr=file of reg;
      fm=file of mas;
var x,y:word;
     f1:fr;
     f2:fm;
  s4,s3:string;
      z:real;
    k,l:byte;
     ch:char;
  r1,r2:reg;
  m1,m2:mas;
(*   
---------------------------------*)
procedure setreg(var r2:reg);
var i:byte;c:char;
begin
clrscr;
write('¥£¨áâàë32');
repeat
read(i);
if (i<1) or (i>32) then write(' 1-32')
else
begin
clrscr;
write('¥£¨áâà',i,':=');
read(r2[i]);
end;
write('¬¥­î - "q"');
c:=readkey;
until c='q';
end;
(*   
-------------------------*)
procedure settext(var m2:mas);
var i:byte;c:char;
begin
clrscr;
write('âà®ª¨128');
repeat
read(i);
if (i<1) or (i>128) then write(' 1-128')
else
begin
write('âà®ª ',i,'=');
write('¯¥à â®à');
read(m2[i].symb);
case m2[i].symb of
1,2,3,4:begin
		 write('1-© à¥£ ');
		 read(m2[i].reg1);
		 write('2-© à¥£ ');
		 read(m2[i].reg2);
		 write('à¥§ã«ìâ ');
		 read(m2[i].reg3);
				end;
5,6:begin
		 write('1-© à¥£ ');
		 read(m2[i].reg1);
		 write('2-© à¥£ ');
		 read(m2[i].reg2);
		 write('¨¤¨ áâàü');
		 read(m2[i].reg3);
				end;
7:begin
		 write('¨¤¨ áâàü');
		 read(m2[i].reg1);
				end;
8,9:begin
		 if m2[i].symb=8 then write('¢¢®¤ ªã¤ ') else write('¢ë¢. oâªã¤ ');
		 read(m2[i].reg1);
				end;
0,10:begin
		 if m2[i].symb=10 then writeln('¢ëå®¤ ') else writeln('¯ ã§  ');
				end;
11,12:begin
		 write('1-© à¥£ ');
		 read(m2[i].reg1);
		 write('à¥§ã«ìâ ');
		 read(m2[i].reg2);
				end;
end;
end;
write('q/n:');
repeat
read(c);
until c in['q','n'];
until c='q';
end;
(*  
-----------------------*)
procedure doing(m2:mas;r2:reg);
var i:byte;c:char;
begin
i:=1;
repeat
   case m2[i].symb of
       0:begin      (* PAUSE *)
           write('«î¡ ï ª­®¯ª ');
           c:=readkey;
           i:=i+1;
         end;
       1:begin      (* SUMMA *)
           r2[m2[i].reg3]:=r2[m2[i].reg1]+r2[m2[i].reg2];
           i:=i+1;
         end;
       2:begin      (* MINUS *)
           r2[m2[i].reg3]:=r2[m2[i].reg1]-r2[m2[i].reg2];
           i:=i+1;
         end;
       3:begin      (* MULT *)
           r2[m2[i].reg3]:=r2[m2[i].reg1]*r2[m2[i].reg2];
           i:=i+1;
         end;
       4:begin      (* DIVIDE *)
           r2[m2[i].reg3]:=r2[m2[i].reg1]/r2[m2[i].reg2];
           i:=i+1;
         end;
       5:begin      (* USLOVIE= *)
           if r2[m2[i].reg1]=r2[m2[i].reg2] then
           i:=byte(round(m2[i].reg3)) else
           i:=i+1;
         end;
       6:begin      (* USLOVIE> *)
           if r2[m2[i].reg1]>r2[m2[i].reg2] then
           i:=byte(round(m2[i].reg3)) else
           i:=i+1;
         end;
       7:begin      (* GOTO *)
           i:=byte(round(m2[i].reg1));
           write(i);
         end;
       8:begin      (* INPUT *)
           clrscr;
           write('?');
           read(r2[m2[i].reg1]);
           i:=i+1;
         end;
       9:begin      (* OUTPUT *)
           clrscr;
           write(r2[m2[i].reg1]);
           i:=i+1;
         end;
         11:begin      (* SQR *)
           r2[m2[i].reg2]:=sqr(r2[m2[i].reg1]);
           i:=i+1;
         end;
       12:begin      (* SQRT *)
           r2[m2[i].reg2]:=sqrt(r2[m2[i].reg1]);
           i:=i+1;
         end;
       else i:=i+1;
   end;
       
until m2[i].symb=10;
clrscr;
write(' ¡®â  ª®­ç¥­ ');
end;
begin
(*  , 
----------------------------------*)
textbackground(0);
textcolor(4);
clrscr;
delay(500);
gotoxy(28,1);
write('(c) 1997  Made by Rodion');
textcolor(8);
for k:=1 to 32 do
r1[k]:=0;
for l:=1 to 128 do
begin
m1[l].symb:=32;
m1[l].reg1:=32;
m1[l].reg2:=32;
m1[l].reg3:=32;
end;
(*  
----------------*)
gotoxy(25,5);
write('É');
for x:=26 to 48 do
  begin
    gotoxy(x,5);
    write('Í');
  end;
gotoxy(49,5);
write('»');
for y:=6 to 21 do
  begin
    gotoxy(49,y);
    write('º');
  end;
gotoxy(49,22);
write('¼');
for x:=26 to 48 do
  begin
    gotoxy(x,22);
    write('Í');
  end;
gotoxy(25,22);
write('È');
for y:=6 to 21 do
  begin
    gotoxy(25,y);
    write('º');
  end;
(*  
-------------------*)
gotoxy(28,6);
write('Ú');
for x:=29 to 45 do
  begin
    gotoxy(x,6);
    write('Ä');
  end;
gotoxy(46,6);
write('¿');
for y:=7 to 10 do
  begin
    gotoxy(46,y);
    write('³');
  end;
gotoxy(46,11);
write('Ù');
for x:=29 to 45 do
  begin
    gotoxy(x,11);
    write('Ä');
  end;
gotoxy(28,11);
write('À');
for y:=7 to 10 do
  begin
    gotoxy(28,y);
    write('³');
  end;
(* 
-------------*)
gotoxy(27,13);
write('¬¥­î:F1-à¥£,F2-á¬ à¥£');
gotoxy(27,14);
write('F3-áâà,F4(F6)-á¬ áâà');
gotoxy(27,15);
write('F5-§ ¯ãáª,F10-¢ëå®¤');
gotoxy(27,17);
write('¯¥à â®àë:0-¯ ã§ ');
gotoxy(27,18);
write('1(+),2(-),3(*),4(/)');
gotoxy(27,19);
write('5(¥á«¨=)6(¥á«¨>)7(¨¤¨)');
gotoxy(27,20);
write('8(¢¢®¤)9(¢ë¢®¤)10(Báñ)');
gotoxy(27,16);
write('s-á®åà,l-¢®ááâ');
gotoxy(27,21);
write('11(^2) 12(^1/2)');
(*  
--------------------*)
textbackground(7);
textcolor(1);
window(29,7,45,10);
(*  
----------------*)
1:
clrscr;
write(' ®â®¢!');
ch:=readkey;
case ch of
';':
    begin
    setreg(r1);
    goto 1;
    end;
'=':
    begin
    settext(m1);
    goto 1;
    end;
'?':begin
    doing(m1,r1);
    ch:=readkey;
    goto 1;
    end;
'<':begin
    clrscr;
    write('? ¥£¨áâà:');
    read(k);
    write('¥£¨áâà',k,'=',r1[k]);
    ch:=readkey;
    goto 1;
    end;
'>':begin
    clrscr;
    write('? âà®ª :');
    read(k);
    clrscr;
    writeln('âà®ª ',k);
    writeln('¯¥à â®à',m1[k].symb);
    writeln('1-©',m1[k].reg1);
    writeln('2-©',m1[k].reg2);
    write('3-©',m1[k].reg3);
    ch:=readkey;
    goto 1;
    end;
'@':begin
    clrscr;
    write('p®á¬®âà');
    ch:=readkey;
    k:=1;
    repeat
    clrscr;
    writeln('âàü',k,' ¯¥à â',m1[k].symb);
    writeln('1-©',m1[k].reg1);
    writeln('2-©',m1[k].reg2);
    write('3-©',m1[k].reg3,' ¬¥­î-"q"');
    ch:=readkey;
    k:=k+1;
    until ch='q';
    goto 1;
    end;
's':
    begin
    clrscr;
    writeln('á®åà ­¨âì');
    readln(s3);
    readln(s3);
    s4:=s3+s1;
    assign(f1,s4);
    rewrite(f1);
    write(f1,r1);
    s4:=s3+s2;
    assign(f2,s4);
    rewrite(f2);
    write(f2,m1);
    close(f1);
    close(f2);
    goto 1;
    end;
'l':
    begin
    clrscr;
    writeln('®ááâ ­®¢¨âì');
    readln(s3);
    s4:=s3+s1;
    {$I-}
    assign(f1,s4);
    reset(f1);
    s4:=s3+s2;
    {$I+}
    if ioresult<>0 then write('  *.r') else begin read(f1,r1);close(f1);end;
    {$I-}
    assign(f2,s4);
    reset(f2);
    {$I+}
    if ioresult<>0 then write('  *.s')else begin read(f2,m1);close(f2);end;
    ch:=readkey;
    goto 1;
    end;
'D':;
else
goto 1;
end;
clrscr;
write('!');
ch:=readkey;
window(1,1,80,25);
textcolor(7);
textbackground(0);
clrscr;
end.