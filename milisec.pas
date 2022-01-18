{
Yehovah é o Nome do Santo
Função para medir tempos em processos com precisão de 1 milisegundo
Criação:02/12/2016
Autor:Almir Bispo
Ribeirão das Neves
}
function milisegundo(tempo_inicio:Ttime):string;
var meut:Ttimestamp;
begin 
meut:=DateTimeToTimeStamp(now - tempo_inicio);
result:= copy(Variant(TimeStampToMSecs(  Ttimestamp(meut)  ) *10),   length(Variant(TimeStampToMSecs(  Ttimestamp(meut)  )*10 ) )-4   ,4)   ;  
end;


{Com base na funcao milisec um tempo é mostrado}
function elapsed(init:Ttime):string;
var final:Ttime;
begin 
final  := Ttime(now-init);
result := copy(timetostr(final),1,8)+':'+copy(milisegundo(init),2,3 );

end;


