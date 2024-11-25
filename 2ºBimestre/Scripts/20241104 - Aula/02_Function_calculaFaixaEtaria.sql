use DW_2017208552;
go

create function calculaFaixaEtaria(@Nascimento date)
returns integer
as
begin
	declare @dataAtual date
	declare @idade integer
	declare @faixa integer
	set @dataAtual = (select getdate())
	set @idade = DATEDIFF(yyyy, @Nascimento, getdate())
	set @faixa = (select 
		case  
			when @idade < 21 then  1
			when @idade > 20 and @idade < 31 Then 2
			when @idade > 30 and @idade < 51 Then 3
			when @idade > 50 and @idade < 71 Then 4
			else 5
		end as faixaEtaria)
	return @faixa
end

select dbo.calculaFaixaEtaria('1950-10-24')
select DATEDIFF(yyyy, '2000-10-24', getdate())