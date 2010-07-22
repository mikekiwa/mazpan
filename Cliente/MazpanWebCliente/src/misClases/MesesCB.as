package misClases
{
	import mx.controls.ComboBox;

	public class MesesCB extends ComboBox
	{
		public function MesesCB()
		{
			super();
			dataProvider = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
		}
	}
}