package misClases
{
	import mx.formatters.NumberFormatter;
	
	public class Presupuesto
	{
		public var ene:String;
		public var feb:String;
		public var mar:String;
		public var abr:String;
		public var may:String;
		public var jun:String;
		public var jul:String;
		public var ago:String;
		public var sep:String;
		public var oct:String;
		public var nov:String;
		public var dic:String;
		public var total:String;
		public var itemName:String;
		public var acctName:String;
				
		public function Presupuesto(_itemName:String,_acctName:String,_ene:int,_feb:int,_mar:int,_abr:int,_may:int,_jun:int,_jul:int,_ago:int,_sep:int,_oct:int,_nov:int,_dic:int)
		{
			var formato:NumberFormatter = new NumberFormatter();
			formato.precision=0;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
			var totalAux:int = 0;
			
			itemName = _itemName;
			acctName = _acctName;
			ene = formato.format(_ene);
			feb = formato.format(_feb);
			mar = formato.format(_mar);
			abr = formato.format(_abr);
			may = formato.format(_may);
			jun = formato.format(_jun);
			jul = formato.format(_jul);
			ago = formato.format(_ago);
			sep = formato.format(_sep);
			oct = formato.format(_oct);
			nov = formato.format(_nov);
			dic = formato.format(_dic);
			totalAux += _ene+_feb+_mar+_abr+_may+_jun+_jul+_abr+_sep+_oct+_nov+_dic;
			total = formato.format(totalAux);
		}

	}
}