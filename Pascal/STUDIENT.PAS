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
(* ПРОЦЕДУРА ЗАПОЛНЕНИЯ РЕГИСТРОВ
---------------------------------*)
procedure setreg(var r2:reg);
var i:byte;c:char;
begin
clrscr;
write('Регистры32');
repeat
read(i);
if (i<1) or (i>32) then write('ОШИБКА 1-32')
else
begin
clrscr;
write('Регистр',i,':=');
read(r2[i]);
end;
write('меню - "q"');
c:=readkey;
until c='q';
end;
(* ПРОЦЕДУРА ВВОДА ТЕКСТА
-------------------------*)
procedure settext(var m2:mas);
var i:byte;c:char;
begin
clrscr;
write('Строки128');
repeat
read(i);
if (i<1) or (i>128) then write('ОШИБКА 1-128')
else
begin
write('Строка',i,'=');
write('Оператор');
read(m2[i].symb);
case m2[i].symb of
1,2,3,4:begin
		 write('1-й рег ');
		 read(m2[i].reg1);
		 write('2-й рег ');
		 read(m2[i].reg2);
		 write('результ ');
		 read(m2[i].reg3);
				end;
5,6:begin
		 write('1-й рег ');
		 read(m2[i].reg1);
		 write('2-й рег ');
		 read(m2[i].reg2);
		 write('иди стр№');
		 read(m2[i].reg3);
				end;
7:begin
		 write('иди стр№');
		 read(m2[i].reg1);
				end;
8,9:begin
		 if m2[i].symb=8 then write('ввод куда') else write('выв. oткуда');
		 read(m2[i].reg1);
				end;
0,10:begin
		 if m2[i].symb=10 then writeln('выход ') else writeln('пауза ');
				end;
11,12:begin
		 write('1-й рег ');
		 read(m2[i].reg1);
		 write('результ ');
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
(* ПРОЦЕДУРА ВЫПОЛНЕНИЯ
-----------------------*)
procedure doing(m2:mas;r2:reg);
var i:byte;c:char;
begin
i:=1;
repeat
   case m2[i].symb of
       0:begin      (* PAUSE *)
           write('любая кнопка');
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
write('Работа кончена');
end;
begin
(* НАЧАЛЬНЫЕ УСТАНОВКИ, ОФОРМЛЕНИЕ
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
(* ДВОЙНАЯ РАМКА
----------------*)
gotoxy(25,5);
write('╔');
for x:=26 to 48 do
  begin
    gotoxy(x,5);
    write('═');
  end;
gotoxy(49,5);
write('╗');
for y:=6 to 21 do
  begin
    gotoxy(49,y);
    write('║');
  end;
gotoxy(49,22);
write('╝');
for x:=26 to 48 do
  begin
    gotoxy(x,22);
    write('═');
  end;
gotoxy(25,22);
write('╚');
for y:=6 to 21 do
  begin
    gotoxy(25,y);
    write('║');
  end;
(* ВНУТРЕННЕЕ ТАБЛО
-------------------*)
gotoxy(28,6);
write('┌');
for x:=29 to 45 do
  begin
    gotoxy(x,6);
    write('─');
  end;
gotoxy(46,6);
write('┐');
for y:=7 to 10 do
  begin
    gotoxy(46,y);
    write('│');
  end;
gotoxy(46,11);
write('┘');
for x:=29 to 45 do
  begin
    gotoxy(x,11);
    write('─');
  end;
gotoxy(28,11);
write('└');
for y:=7 to 10 do
  begin
    gotoxy(28,y);
    write('│');
  end;
(* КЛАВИАТУРА
-------------*)
gotoxy(27,13);
write('меню:F1-рег,F2-см рег');
gotoxy(27,14);
write('F3-стр,F4(F6)-см стр');
gotoxy(27,15);
write('F5-запуск,F10-выход');
gotoxy(27,17);
write('Операторы:0-пауза');
gotoxy(27,18);
write('1(+),2(-),3(*),4(/)');
gotoxy(27,19);
write('5(если=)6(если>)7(иди)');
gotoxy(27,20);
write('8(ввод)9(вывод)10(Bсё)');
gotoxy(27,16);
write('s-сохр,l-восст');
gotoxy(27,21);
write('11(^2) 12(^1/2)');
(* ОКНО ПОЛЬЗОВАТЕЛЯ
--------------------*)
textbackground(7);
textcolor(1);
window(29,7,45,10);
(* НАЧАЛО РАБОТЫ
----------------*)
1:
clrscr;
write('Я Готов!');
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
    write('? Регистр:');
    read(k);
    write('Регистр',k,'=',r1[k]);
    ch:=readkey;
    goto 1;
    end;
'>':begin
    clrscr;
    write('? Строка:');
    read(k);
    clrscr;
    writeln('Строка',k);
    writeln('Оператор',m1[k].symb);
    writeln('1-й',m1[k].reg1);
    writeln('2-й',m1[k].reg2);
    write('3-й',m1[k].reg3);
    ch:=readkey;
    goto 1;
    end;
'@':begin
    clrscr;
    write('Пpосмотр');
    ch:=readkey;
    k:=1;
    repeat
    clrscr;
    writeln('Стр№',k,' Операт',m1[k].symb);
    writeln('1-й',m1[k].reg1);
    writeln('2-й',m1[k].reg2);
    write('3-й',m1[k].reg3,' меню-"q"');
    ch:=readkey;
    k:=k+1;
    until ch='q';
    goto 1;
    end;
's':
    begin
    clrscr;
    writeln('сохранить');
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
    writeln('Восстановить');
    readln(s3);
    s4:=s3+s1;
    {$I-}
    assign(f1,s4);
    reset(f1);
    s4:=s3+s2;
    {$I+}
    if ioresult<>0 then write('НЕТ ФАЙЛА *.r') else begin read(f1,r1);close(f1);end;
    {$I-}
    assign(f2,s4);
    reset(f2);
    {$I+}
    if ioresult<>0 then write('НЕТ ФАЙЛА *.s')else begin read(f2,m1);close(f2);end;
    ch:=readkey;
    goto 1;
    end;
'D':;
else
goto 1;
end;
clrscr;
write('ПОКА!');
ch:=readkey;
window(1,1,80,25);
textcolor(7);
textbackground(0);
clrscr;
end.