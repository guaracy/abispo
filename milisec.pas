{
Yehovah � o Nome do Santo
Fun��o para medir tempos em processos com precis�o de 1 milisegundo
Cria��o:02/12/2016
Autor:Almir Bispo
Ribeir�o das Neves
}
function milisegundo(tempo_inicio:Ttime):string;
var meut:Ttimestamp;
begin 
meut:=DateTimeToTimeStamp(now - tempo_inicio);
result:= copy(Variant(TimeStampToMSecs(  Ttimestamp(meut)  ) *10),   length(Variant(TimeStampToMSecs(  Ttimestamp(meut)  )*10 ) )-4   ,4)   ;  
end;


{Com base na funcao milisec um tempo � mostrado}
function elapsed(init:Ttime):string;
var final:Ttime;
begin 
final  := Ttime(now-init);
result := copy(timetostr(final),1,8)+':'+copy(milisegundo(init),2,3 );

end;


