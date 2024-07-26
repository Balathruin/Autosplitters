// Autosplitter and Load Remover by Balathruin & WillTreaty
state("shift2u", "EA")
{
	int loading : 0x17714, 0x400;
	
	bool Movie : 0xAB70A0, 0x19C;
	
	int State : 0x5AB14, 0X2E8;
	
	int Finish : 0x60D7DC, 0x450;
}

state("shift2u", "Steam")
{
	int loading : 0x17654, 0x400;
	
	bool Movie : 0xAB40A0, 0x19C;
	
	//int State : 0x5AB14, 0X2E8;
	
	int Finish : 0x4787AC, 0x3A0;
}

init 
{
	//EA App
	if (modules.First().ModuleMemorySize == 0xBF0000) {
		version = "EA";
	}
	//Steam or Disc
	else if (modules.First().ModuleMemorySize == 0x1E13000) {
		version = "Steam";
	}
}

startup
{
	settings.Add("finishsplit", true, "Finish Split");
	settings.SetToolTip("finishsplit", "Split when crossing the finish line.");
}

update 
{
	if (version == "") {
		return false;
	}
}

isLoading
{
	if(current.loading != 0 && !current.Movie) {
		return true;
	} else {
		return false;
	}
}

split
{
	if(current.Finish == 3 && old.Finish == 2 && settings["finishsplit"]) {
		return true;
	} else {
		return false;
	}
}

exit
{
	timer.IsGameTimePaused = false;
}