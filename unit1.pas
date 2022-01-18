unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
   Arq:Tstringlist;
  public

  end;

var
  Form1: TForm1;

implementation
 uses strutils,RegExpr; //strutils
{$R *.lfm}

{ TForm1 }
{$i milisec.pas} //carrega funcao de temporizador
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
//libera conteudo do arquivo ao fechar.
  Arq.Clear;
  Arq.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,qtd:integer;
    Temporizador:Ttime;
    busca:string;
begin
busca := edit1.text;
qtd := 0;
memo1.Clear;

//inicia tempo
Temporizador := Ttime(now);
 for i:= 0 to Arq.Count-1 do
 begin
  if AnsiContainsStr(Arq.Strings[i],busca)=true then
  begin
    memo1.Lines.Add(Arq.Strings[i]);//memo recebe a linha na qual existe o dado
    inc(qtd);
  end;
 end;
memo2.lines.add('TIPO 1 - Tempo:'+elapsed(Temporizador) +' ms - '+inttostr(qtd)+' Encontrados' );
 showmessage('Teste terminado');
end;

procedure TForm1.Button2Click(Sender: TObject);
var busca,dado:string;
    i,j,qtd:integer;
    Temporizador:Ttime;
begin
busca:=edit1.text;
 qtd:=0;
 memo1.Clear;
 Temporizador:=Ttime(now);//inicio temporizador
  for i := 0 to Arq.Count-1 do
  begin
   for j:= 1 to length(Arq.Strings[i]) do
    begin
     dado :=copy(Arq.Strings[i] , j ,length(busca) );
      if dado = busca then
      begin
        memo1.Lines.add( Arq.Strings[i] );
        inc(qtd);
      end;
    end;
  end;
  memo2.lines.add('TIPO 2 - Tempo:'+elapsed(Temporizador) +' ms - '+inttostr(qtd)+' Encontrados' );
  showmessage('Teste terminado');
end;

procedure TForm1.Button3Click(Sender: TObject);
var busca:string;
    Temporizador:Ttime;
    qtd:integer;
begin
busca := edit1.text;
qtd:=0;
memo1.Clear;
Temporizador:=Ttime(now);
{se o dados existe (deve coincidir completamente).
Busca unica.Dados não podem ser repetidos.Caso seja repetido,ele busca o primeiro}
 if  Arq.IndexOf('Texto a ser buscado:' + busca )<>-1 then
 begin
 memo1.lines.add( Arq.strings[  Arq.IndexOf('Texto a ser buscado:' + busca ) ] );
 inc(qtd);
 end;
 memo2.lines.add('TIPO 3 - Tempo:'+elapsed(Temporizador) +' ms - '+inttostr(qtd)+' Encontrados' );
  showmessage('Teste terminado');
end;

procedure TForm1.Button4Click(Sender: TObject);
var busca:string;
    Temporizador:Ttime;
    i,qtd:integer;
    RegexObj: TRegExpr;
begin
 busca := edit1.text;
 memo1.Clear;
 Temporizador:=Ttime(now);
 RegexObj := TRegExpr.Create;
 RegexObj.Expression := busca.Replace('[','\[').Replace(']','\]');
 qtd:=0;
 for i:= 0 to Arq.Count-1 do
 begin
  if RegexObj.Exec(Arq.Strings[i]) then
  begin
    memo1.Lines.Add(Arq.Strings[i]);//memo recebe a linha na qual existe o dado
    inc(qtd);
  end;
 end;
 RegexObj.Free;
 memo2.lines.add('TIPO 4 - Tempo:'+elapsed(Temporizador) +' ms - '+inttostr(qtd)+' Encontrados' );
 showmessage('Teste terminado ');
end;

procedure TForm1.Button5Click(Sender: TObject);
var busca:string;
    Temporizador:Ttime;
    i,qtd:integer;
    RegexObj: TRegExpr;
begin
 busca := edit1.text;
 memo1.Clear;
 Temporizador:=Ttime(now);
 qtd:=0;
 for i:= 0 to Arq.Count-1 do
 begin
  if Arq.Strings[i].Contains(busca) then
  begin
    memo1.Lines.Add(Arq.Strings[i]);//memo recebe a linha na qual existe o dado
    inc(qtd);
  end;
 end;
 memo2.lines.add('TIPO 5 - Tempo:'+elapsed(Temporizador) +' ms - '+inttostr(qtd)+' Encontrados' );
 showmessage('Teste terminado');

end;

{gera arquivo}
procedure TForm1.FormCreate(Sender: TObject);
//var i:integer;
begin
{
Arq:=Tstringlist.create;
Arq.add('CABECALHO');
  for i := 0 to  1000000 do   // ate 1 milhao
  begin
  Arq.Add('Texto a ser buscado:[' + inttostr(i) +']');
  end;
Form1.Caption:='Carregado '+inttostr(Arq.Count);
Arq.SaveToFile('FileTest.txt');
 }
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 Arq:=Tstringlist.create;
  Arq.LoadFromFile('FileTest.txt');
end;

end.

