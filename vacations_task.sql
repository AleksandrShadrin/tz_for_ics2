-- Вывод сотрудников, которые одновременно были в отпуске в 2020 году
select 
	e.code as КодСотрудника1
	,v.datebegin as НачалоОтпуска
	,v.dateend as КонецОтпуска
	,e_second.code as КодСотрудника2
	,v_second.datebegin as НачалоОтпуска
	,v_second.dateend as КонецОтпуска
from vacation v
	inner join vacation v_second on v_second.id_employee != v.id_employee
		and v_second.datebegin >= v.datebegin
        and v_second.datebegin <= v.dateend
		/*
			Когда интервалы начинаются с одинаковых дат, тогда id_employee
			первого сотрудника должен быть меньше, чем у второго
		*/
		and not (v_second.datebegin = v.datebegin and v_second.id_employee < v.id_employee)
	inner join employee as e on e.id = v.id_employee
	inner join employee as e_second on e_second.id = v_second.id_employee
where 2020 between extract(year from v.datebegin) and extract(year from v.dateend)
	and 2020 between extract(year from v_second.datebegin) and extract(year from v_second.dateend);