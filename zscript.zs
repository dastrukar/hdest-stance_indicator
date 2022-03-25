version 4.6.0


class HDStanceHandler : StaticEventHandler {
	ui HUDFont mfont;
	ui int speenAngle;
	ui int speenCount;

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

	ui int, bool GetTextFlags(int s) {
		// Speed text flags
		// Syntax: XY
		int flags;
		bool vertical_mode = false;

		// - Y -
		// 1: LEFT
		// 2: CENTER
		// 3: RIGHT
		//
		// (if X = VERTICAL)
		// 1: TOP
		// 2: CENTER
		// 3: BOTTOM
		if (CompareLastDigit(s, 1)) {
			flags |= StatusBar.DI_TEXT_ALIGN_LEFT;
		} else if (CompareLastDigit(s, 2)) {
			flags |= StatusBar.DI_TEXT_ALIGN_CENTER;
		} else if (CompareLastDigit(s, 3)) {
			flags |= StatusBar.DI_TEXT_ALIGN_RIGHT;
		}

		s *= 0.1;

		// - X -
		// 1: HORIZONTAL
		// 2: VERTICAL
		if (CompareLastDigit(s, 2)) {
			vertical_mode = true;
		}

		return flags, vertical_mode;
	}

	ui void DrawIndicator(
		string text,
		Vector2 offset,
		bool vertical,
		int repeat,
		int flags
	) {
		// If vertical, repeat the given string X times
		if (vertical) {
			int vertical_offset = 0;
			int center_offset = 0;
			if (flags | StatusBar.DI_TEXT_ALIGN_CENTER) {
				for (int i = 0; i < repeat - 1; i++) {
					center_offset -= (NewSmallFont.GetHeight() / 2) * hdstance_scaley;
				}
			}

			for (int i = 0; i < repeat; i++) {
				StatusBar.DrawString(
					mfont,
					text, (hdstance_posx + offset.x, hdstance_posy + offset.y + vertical_offset + center_offset),
					flags,
					Font.CR_WHITE,
					hdstance_alpha,
					scale:(hdstance_scalex, hdstance_scaley)
				);

				// Go up or down, or center?
				if (flags | StatusBar.DI_TEXT_ALIGN_RIGHT) {
					vertical_offset += NewSmallFont.GetHeight() * hdstance_scaley;
				} else {
					vertical_offset -= NewSmallFont.GetHeight() * hdstance_scaley;
				}
			}
		} else {
			string s = "";
			for (int i = 0; i < repeat; i++) {
				s = s..text;
			}

			StatusBar.DrawString(
				mfont,
				s, (hdstance_posx + offset.x, hdstance_posy + offset.y),
				flags,
				Font.CR_WHITE,
				hdstance_alpha,
				scale:(hdstance_scalex, hdstance_scaley)
			);
		}
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
				hdstance_boxalpha, (-1, -1),
				(hdstance_boxsizex * hdstance_scalex, hdstance_boxsizey * hdstance_scaley)
			);
		}
	}

	override void RenderOverlay(RenderEvent e) {
		if (AutomapActive || GameState != GS_LEVEL) {
			return;
		}

		StatusBar.FullScreenOffsets = true;
		mfont = HUDFont.Create(NewSmallFont);

		int s_flags = GetScreenFlags();

		HDPlayerPawn hdp = HDPlayerPawn(StatusBar.CPlayer.mo);
		if (hdp && hdp.health > 0) {
			Vector2 offset = (0, 0);
			string stanceImage;
			bool mirror;
			if (hdstance_skinned) {
				// SPEEN
				if (hdstance_speen) {
					speenCount++;
					if (speenCount >= hdstance_speenrate) {
						speenAngle += (speenAngle + 1 >= 9)? -7 : 1;
						speenCount = 0;
					}
				}

				string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
				string spriteName = ""..hdp.Sprite;
				string frameChar = (hdstance_animate)? alphabet.Mid(hdp.Frame, 1) : (hdp.Incapacitated)? "N" : "E";
				int spriteAngle = (hdstance_speen)? speenAngle : hdstance_angle;

				// Check if image is valid
				while (true) {
					stanceImage = spriteName..frameChar..spriteAngle;
					if (TexMan.GetName(TexMan.CheckForTexture(stanceImage))) break;

					stanceImage = spriteName..frameChar..spriteAngle..frameChar..10 - spriteAngle;
					if (TexMan.GetName(TexMan.CheckForTexture(stanceImage))) break;

					stanceImage = spriteName..frameChar..10 - spriteAngle..frameChar..spriteAngle;
					if (TexMan.GetName(TexMan.CheckForTexture(stanceImage))) {
						mirror = true;
						break;
					}

					stanceImage = spriteName..frameChar..0;
					break;
				}
			} else {
				float c = hdp.player.crouchfactor;
				string suffix = (hdp.Incapacitated)? "incap" : (c > 0.5)? "stand" : "croch";
				stanceImage = "hdp"..suffix;
			}

			int iconFlags = StatusBar.DI_TRANSLATABLE;
			if (mirror) iconFlags |= StatusBar.DI_MIRROR;
			// Show stance
			StatusBar.DrawImage(
				stanceImage,
				(hdstance_posx, hdstance_posy),
				s_flags | iconFlags,
				hdstance_alpha, (-1, -1),
				(hdstance_scalex, hdstance_scaley)
			);

			// Show speed indicator
			if (hdstance_showspeed) {
				int sp_flags;
				bool v_mode;
				[sp_flags, v_mode] = GetTextFlags(hdstance_speedtextalign);

				let run = CVar.GetCVar("cl_run", StatusBar.CPlayer).GetBool();
				let arr = hdstance_speedtext;

				if (hdstance_auto) {
					offset = (0, 0);
				} else {
					offset = (hdstance_speedoffsetx * hdstance_scalex, hdstance_speedoffsety * hdstance_scaley);
				}

				int r;
				if (hdp.runwalksprint > 0) {
					r = 3;
				} else if (!run || hdp.incapacitated) {
					r = 1;
				} else {
					r = 2;
				}

				DrawIndicator(arr, offset, v_mode, r, s_flags | sp_flags);
			}

			// Show if weapon is braced
			if (hdstance_showbraced) {
				int b_flags;
				bool v_mode;
				[b_flags, v_mode] = GetTextFlags(hdstance_bracedtextalign);

				string s = (hdp.gunbraced)? hdstance_bracedtext : "";

				if (hdstance_auto) {
					int tmp_y = 0;
					if (hdstance_showspeed) {
						tmp_y = NewSmallFont.GetHeight() * hdstance_scaley;
					}

					offset = (0, tmp_y);
				} else {
					offset = (hdstance_bracedoffsetx * hdstance_scalex, hdstance_bracedoffsety * hdstance_scaley);
				}

				DrawIndicator(s, offset, v_mode, hdstance_bracedtextrepeat, s_flags | b_flags);
			}
		}
	}
}
