version 4.6.0

class HDStanceHandler : StaticEventHandler {
	ui HUDFont mfont;

	ui bool CompareLastDigit(int num, int expected) {
		return ((num % 10) == expected);
	}

	ui int GetScreenFlags() {
		// Screen position flags
		// Syntax: XYZ
		int s = hdstance_screenflags;
		int flags;

		// Can't use 0, else int does some weird things

		// - Z -
		// 1: NONE
		// 2: LEFT
		// 3: RIGHT
		if (CompareLastDigit(s, 2)) {
			flags |= StatusBar.DI_SCREEN_LEFT;
		} else if (CompareLastDigit(s, 3)) {
			flags |= StatusBar.DI_SCREEN_RIGHT;
		}

		s *= 0.1;

		// - Y -
		// 1: NONE
		// 2: CENTER
		// 3: VCENTER
		// 4: HCENTER
		if (CompareLastDigit(s, 2)) {
			flags |= StatusBar.DI_SCREEN_CENTER;
		} else if (CompareLastDigit(s, 3)) {
			flags |= StatusBar.DI_SCREEN_VCENTER;
		} else if (CompareLastDigit(s, 4)) {
			flags |= StatusBar.DI_SCREEN_HCENTER;
		}

		s *= 0.1;

		// - X -
		// 1: NONE
		// 2: BOTTOM
		// 3: TOP
		if (CompareLastDigit(s, 2)) {
			flags |= StatusBar.DI_SCREEN_BOTTOM;
		} else if (CompareLastDigit(s, 3)) {
			flags |= StatusBar.DI_SCREEN_TOP;
		}

		return flags;
	}

	override void RenderUnderlay(RenderEvent e) {
		if (AutomapActive || GameState != GS_LEVEL) {
			return;
		}

		StatusBar.FullScreenOffsets = true;
		mfont = HUDFont.Create(NewSmallFont);

		int s_flags = GetScreenFlags();

		if (hdstance_drawshadowbox) {
			Vector2 box_offset = (hdstance_boxoffsetx * hdstance_scalex, hdstance_boxoffsety * hdstance_scaley);
			StatusBar.DrawImage(
				"hdpboxa",
				(hdstance_posx + box_offset.x, hdstance_posy + box_offset.y),
				s_flags,
				hdstance_alpha * 0.5, (-1, -1),
				(hdstance_boxsizex * hdstance_scalex, hdstance_boxsizey * hdstance_scaley)
			);
		}

		HDPlayerPawn hdp = HDPlayerPawn(StatusBar.CPlayer.mo);
		if (hdp && hdp.health > 0) {
			Vector2 offset = (0, 0);
			let c = hdp.player.crouchfactor;
			let n = (hdp.incapacitated)? "incap" : (c > 0.5)? "stand" : "croch";

			// Show stance
			StatusBar.DrawImage(
				"hdp"..n,
				(hdstance_posx, hdstance_posy),
				s_flags,
				hdstance_alpha, (-1, -1),
				(hdstance_scalex, hdstance_scaley)
			);

			// Show speed indicator
			if (hdstance_showspeed) {
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

				if (hdstance_auto) {
					offset = (0, 0);
				} else {
					offset = (hdstance_speedoffsetx * hdstance_scalex, hdstance_speedoffsety * hdstance_scaley);
				}

				StatusBar.DrawString(
					mfont,
					s, (hdstance_posx + offset.x, hdstance_posy + offset.y),
					s_flags | StatusBar.DI_TEXT_ALIGN_CENTER,
					Font.CR_WHITE,
					hdstance_alpha,
					scale:(hdstance_scalex, hdstance_scaley)
				);
			}

			// Show if weapon is braced
			if (hdstance_showbraced) {
				string s;
				s = (hdp.gunbraced)? hdstance_bracedtext : "";

				if (hdstance_auto) {
					offset = (0, NewSmallFont.GetHeight() * hdstance_scaley);
				} else {
					offset = (hdstance_bracedoffsetx * hdstance_scalex, hdstance_bracedoffsety * hdstance_scaley);
				}

				StatusBar.DrawString(
					mfont,
					s, (hdstance_posx + offset.x, hdstance_posy + offset.y),
					s_flags | StatusBar.DI_TEXT_ALIGN_CENTER,
					Font.CR_WHITE,
					hdstance_alpha,
					scale:(hdstance_scalex, hdstance_scaley)
				);
			}
		}
	}
}
