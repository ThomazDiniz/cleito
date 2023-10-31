///@description 
global.night++;

ini_open("save.ini");
	ini_write_real("save","noite",global.night);
ini_close();
