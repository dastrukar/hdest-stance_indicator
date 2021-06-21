version 4.6.0

class HDStanceHandler : StaticEventHandler {
	ui HUDFont mfont;

	override void RenderUnderlay(RenderEvent e) {
		if (AutomapActive || GameState != GS_LEVEL) {
			return;
		}

		StatusBar.FullScreenOffsets = true;
		mfont = HUDFont.Create(NewSmallFont);

		HDPlayerPawn hdp = HDPlayerPawn(StatusBar.CPlayer.mo);
		if (hdp && hdp.health > 0) {
			let c = hdp.player.crouchfactor;
			let n = (hdp.incapacitated)? "incap" : (c > 0.5)? "stand" : "croch";
			StatusBar.DrawImage(
				"hdp"..n,
				(hdstance_posx, hdstance_posy),
				StatusBar.DI_SCREEN_CENTER_BOTTOM,
				hdstance_alpha, (-1, -1),
				(hdstance_scalex, hdstance_scaley)
			);

			if (hdstance_showspeed) {
				let h = NewSmallFont.GetHeight();
				let run = CVar.GetCVar("cl_run", StatusBar.CPlayer).GetBool();
				let arr = hdstance_speedtext;
				string s;
				if (hdp.runwalksprint > 0) {
					s = arr..arr..arr;
				} else if (!run || hdp.incapacitated) {
					s = arr;
				} else {
					s = arr..arr;
				}
				StatusBar.DrawString(
					mfont,
					s, (hdstance_posx + hdstance_offsetx, hdstance_posy + hdstance_offsety),
					StatusBar.DI_SCREEN_CENTER_BOTTOM | StatusBar.DI_TEXT_ALIGN_CENTER,
					Font.CR_WHITE,
					hdstance_alpha,
					scale:(hdstance_scalex, hdstance_scaley)
				);
			}
		}
	}
}
