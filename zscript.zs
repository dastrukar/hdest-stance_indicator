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
			let box_offset = NewSmallFont.GetHeight() * hdstance_scaley * 2;
			StatusBar.DrawImage(
				"hdp".."box",
				(hdstance_posx, hdstance_posy + box_offset),
				s_flags,
				hdstance_alpha * 0.5, (-1, -1),
				(hdstance_scalex, hdstance_scaley)
			);
		}

		HDPlayerPawn hdp = HDPlayerPawn(StatusBar.CPlayer.mo);
		if (hdp && hdp.health > 0) {
			int offset = 0;
			let c = hdp.player.crouchfactor;
			let n = (hdp.incapacitated)? "incap" : (c > 0.5)? "stand" : "croch";

			StatusBar.DrawImage(
				"hdp"..n,
				(hdstance_posx, hdstance_posy),
				s_flags,
				hdstance_alpha, (-1, -1),
				(hdstance_scalex, hdstance_scaley)
			);

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

				StatusBar.DrawString(
					mfont,
					s, (hdstance_posx + hdstance_offsetx, hdstance_posy + hdstance_offsety),
					s_flags | StatusBar.DI_TEXT_ALIGN_CENTER,
					Font.CR_WHITE,
					hdstance_alpha,
					scale:(hdstance_scalex, hdstance_scaley)
				);

				offset += NewSmallFont.GetHeight() * hdstance_scaley;
			}

			// Show if weapon is braced
			if (hdstance_showbraced) {
				string s;
				s = (hdp.gunbraced)? hdstance_bracedtext : "";

				StatusBar.DrawString(
					mfont,
					s, (hdstance_posx + hdstance_offsetx, hdstance_posy + hdstance_offsety + offset),
					s_flags | StatusBar.DI_TEXT_ALIGN_CENTER,
					Font.CR_WHITE,
					hdstance_alpha,
					scale:(hdstance_scalex, hdstance_scaley)
				);
			}
		}
	}
}
