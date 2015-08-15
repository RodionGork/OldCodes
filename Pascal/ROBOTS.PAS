PROGRAM robots;
uses
  crt;
label
  1,2;
const
  warning='Такой ход невозможен.';
  bullets='Количество зарядов:';
type
  room = array[1..18,1..11] of char;
var
  x,y,i,bu,a,b,c,d,rob,x0,y0:byte;
  m:room;
  ex:boolean;
  ch:char;
procedure killed;
var c:char;
begin
gotoxy(1,24);write('К сожалению Роботы настигли вас!');
c:=readkey;
halt(1);
end;
procedure winner;
var c:char;
begin
gotoxy(1,24);write('Поздравляю вас с победой!');
c:=readkey;
halt(1);
end;
FUNCTION space(c,d:byte):char;
var
  xr,yr,u:byte;
begin
  xr:=WhereX;
  yr:=WhereY;
  GotoXY(c,d);
  asm
    mov ah,8
    mov bh,0
    int 10h
    mov u,al
  end;
  space:=chr(u);
  GotoXY(xr,yr);
end;
BEGIN
  (* init text mode 320x200 *)
  asm
    MOV AX,0000H
    INT 10H
    MOV AH,1
    MOV CX,0100H
    INT 10H
  end;
  TextBackGround(1);
  TextColor(10);
  ClrScr;
  Randomize;
1:
  (* room, holes, robots, player, exit*)
  FOR y:=1 to 11 do
    FOR x:=1 to 18 do
      begin GotoXY(x,y); Write('.'); m[x,y]:='.'; end;
  i:=0;
  WHILE i<30 do
    begin
      x:=Random(17)+2; y:=Random(11)+1;
      if m[x,y]='.' then
        begin i:=i+1; GotoXY(x,y); Write('='); m[x,y]:='='; end;
    end;
  i:=0;
  WHILE i<20 do
    begin
      x:=Random(16)+3; y:=Random(11)+1;
      if m[x,y]='.' then
        begin i:=i+1; GotoXY(x,y); Write('P'); m[x,y]:='P'; end;
    end;
  m[1,6]:='';GotoXY(1,6);Write('');
  i:=1;
  ex:=False;
  WHILE i<=11 do
    begin if m[18,i]='.' then
      begin m[18,i]:='E'; GotoXY(18,i); Write('E'); i:=12;
      ex:=True; end;
    i:=i+1;
    end;
  if ex<>True then goto 1;
  (* playing *)
  a:=1; b:=6;
  bu:=4;
  rob:=0;
  REPEAT
2:
  gotoxy(2,12);write(bullets,bu,'  ');
  (* player's move *)
    ch:=ReadKey;
    gotoxy(1,24);write('                                         ');gotoxy(1,24);
    case ch of
    '8':begin
          if b=1 then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a,b-1);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':b:=b-1;
          'P':killed;
          'E':winner;
          end;
        end;
    '4':begin
          if a=1 then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a-1,b);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':a:=a-1;
          'P':killed;
          'E':winner;
          end;
        end;
    '6':begin
          if a=18 then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a+1,b);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':a:=a+1;
          'P':killed;
          'E':winner;
          end;
        end;
    '2':begin
          if b=11 then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a,b+1);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':b:=b+1;
          'P':killed;
          'E':winner;
          end;
        end;
    '7':begin
          if (b=1)or(a=1) then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a-1,b-1);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':begin b:=b-1;a:=a-1;end;
          'P':killed;
          'E':winner;
          end;
        end;
    '9':begin
          if (b=1)or(a=18) then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a+1,b-1);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':begin a:=a+1;b:=b-1;end;
          'P':killed;
          'E':winner;
          end;
        end;
    '1':begin
          if (a=1)or(b=11) then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a-1,b+1);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':begin a:=a-1;b:=b+1;end;
          'P':killed;
          'E':winner;
          end;
        end;
    '3':begin
          if (b=11)or(a=18) then
            begin gotoxy(1,24);write(warning);goto 2;end;
          ch:=space(a+1,b+1);
          case ch of
          '=':begin write(warning);goto 2;end;
          '.':begin b:=b+1;a:=a+1;end;
          'P':killed;
          'E':winner;
          end;
        end;
    ' ':begin
          gotoxy(1,24);write('Уничтожить роботов на соседних позициях?');
          ch:=readkey;
          if ch<>#13 then goto 2;
          if bu>0 then
            begin bu:=bu-1;
              for x:=a-1 to a+1 do
                for y:=b-1 to b+1 do
                  if space(x,y)='P' then
                    begin gotoxy(x,y);write('.');m[x,y]:='.';end;
            end;
            goto 2;
        end;
    else
      gotoxy(1,24);write('Num Lock is on?');goto 2;
    end;
    for x:=a-1 to a+1 do
      for y:=b-1 to b+1 do
        if space(x,y)='' then
          begin gotoxy(x,y);write('.');m[x,y]:='.';end;
    gotoxy(a,b);write('');m[a,b]:='';
    (* robot's move*)
    for y:=1 to 11 do
      for x:=1 to 18 do
       if space(x,y)='P' then
         begin
           if x<a then x0:=x+1;
           if x=a then x0:=x;
           if x>a then x0:=x-1;
           if y<b then y0:=y+1;
           if y=b then y0:=y;
           if y>b then y0:=y-1;
           ch:=space(x0,y0);
           case ch of
           '.':begin m[x,y]:='.';m[x0,y0]:='P';end;
           '=':m[x,y]:='.';
           'E':m[x,y]:='.';
           '':killed;
           end;
         end;
    for y:=1 to 11 do
      for x:=1 to 18 do
        begin gotoxy(x,y);write(m[x,y]);end;
    if rob mod 2=1 then begin gotoxy(1,1);write('P');end
      else begin gotoxy(1,11);write('P');end;
    inc(rob);
  UNTIL ch=#27;
end.