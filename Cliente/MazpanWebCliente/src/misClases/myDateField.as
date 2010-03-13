package misClases
{
	import mx.controls.DateField;

	public class myDateField extends DateField
	{
		public function myDateField()
		{
			super();
			super.dayNames = ['D','L','M','M','J','V','S'];
			super.firstDayOfWeek = 1;
			super.monthNames = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
			super.formatString = "DD/MM/YYYY";
		}
	}
}