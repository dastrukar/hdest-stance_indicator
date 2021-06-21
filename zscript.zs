version 4.6.0

class HDStanceHandler : StaticEventHandler {
	ui HUDFont mfont;

	override void RenderUnderlay(RenderEvent e) {
		if (AutomapActive || GameState != GS_LEVEL) {
			return;
		}

		StatusBar.FullScreenOffsets = true;
		Font fnt = "HDBIGSTANCEFONT";
		mfont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), Mono_CellLeft);

		HDPlayerPawn hdp = HDPlayerPawn(StatusBar.CPlayer.mo);
		if (hdp) {
			let c = hdp.player.crouchfactor;
			let n = (hdp.incapacitated)? "incap" : (c > 0.5)? "stand" : "croch";
			StatusBar.DrawImage(
				"hdp"..n,
				(60, -10),
				StatusBar.DI_SCREEN_CENTER_BOTTOM,
				0.75, (-1, -1),
				(0.5, 0.5)
			);
		}
	}
}
